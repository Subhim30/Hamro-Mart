package com.hamromart.controller;

import com.hamromart.dao.ProductDAO;
import com.hamromart.dao.impl.ProductDAOImpl;
import com.hamromart.entity.Product;
import com.hamromart.entity.User;
import com.hamromart.utils.DatabaseConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@WebServlet("/cart/checkout")
public class CheckoutServlet extends HttpServlet {
    private final ProductDAO productDAO = new ProductDAOImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User currentUser = (session != null) ? (User) session.getAttribute("currentUser") : null;

        if (currentUser == null) {
            session.setAttribute("authError", "Please log in to checkout.");
            resp.sendRedirect(req.getContextPath() + "/auth/login.jsp");
            return;
        }

        if ("ADMIN".equals(currentUser.getRole())) {
            session.setAttribute("error", "Administrators are not allowed to place orders. Please log in as a customer.");
            resp.sendRedirect(req.getContextPath() + "/cart/view.jsp");
            return;
        }

        String itemsJson = req.getParameter("itemsJson");
        String totalAmountStr = req.getParameter("totalAmount");
        String phone = req.getParameter("phone");
        String address = req.getParameter("address");
        String paymentMethod = req.getParameter("paymentMethod");

        if (itemsJson == null || totalAmountStr == null || phone == null || address == null || itemsJson.trim().isEmpty()) {
            session.setAttribute("error", "Checkout details are incomplete.");
            resp.sendRedirect(req.getContextPath() + "/cart/view.jsp");
            return;
        }

        double totalAmount = 0.0;
        try {
            totalAmount = Double.parseDouble(totalAmountStr);
        } catch (NumberFormatException e) {
            session.setAttribute("error", "Invalid total amount.");
            resp.sendRedirect(req.getContextPath() + "/cart/view.jsp");
            return;
        }

        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            conn.setAutoCommit(false); // Enable transactional processing!

            // 1. Create main Order record
            String orderSql = "INSERT INTO orders (user_id, total_amount, payment_method, address, phone, status) VALUES (?, ?, ?, ?, ?, 'PENDING')";
            int orderId = -1;
            
            try (PreparedStatement psOrder = conn.prepareStatement(orderSql, Statement.RETURN_GENERATED_KEYS)) {
                psOrder.setInt(1, currentUser.getId());
                psOrder.setDouble(2, totalAmount);
                psOrder.setString(3, paymentMethod);
                psOrder.setString(4, address.trim());
                psOrder.setString(5, phone.trim());
                
                psOrder.executeUpdate();
                
                try (ResultSet generatedKeys = psOrder.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        orderId = generatedKeys.getInt(1);
                    }
                }
            }

            if (orderId == -1) {
                throw new SQLException("Creating order record failed.");
            }

            // 2. Parse Items JSON using Regex and insert Order Items
            // JSON format: [{"id":1,"name":"Organic...","price":250,"image":"...","unit":"kg","quantity":2}]
            Pattern pattern = Pattern.compile("\\{\"id\":(\\d+),\"name\":\"[^\"]*\",\"price\":([\\d\\.]+),\"image\":\"[^\"]*\",\"unit\":\"[^\"]*\",\"quantity\":(\\d+)\\}");
            Matcher matcher = pattern.matcher(itemsJson);

            String itemSql = "INSERT INTO order_items (order_id, product_id, quantity, price) VALUES (?, ?, ?, ?)";
            try (PreparedStatement psItem = conn.prepareStatement(itemSql)) {
                while (matcher.find()) {
                    int productId = Integer.parseInt(matcher.group(1));
                    double price = Double.parseDouble(matcher.group(2));
                    int quantity = Integer.parseInt(matcher.group(3));

                    // Verify stock and update it
                    Product product = productDAO.getById(productId);
                    if (product == null) {
                        throw new SQLException("Product with ID " + productId + " does not exist.");
                    }
                    if (product.getStock() < quantity) {
                        throw new SQLException("Insufficient stock for product: " + product.getName());
                    }

                    // Update local stock in DB
                    productDAO.updateStock(productId, product.getStock() - quantity);

                    // Insert to order_items
                    psItem.setInt(1, orderId);
                    psItem.setInt(2, productId);
                    psItem.setInt(3, quantity);
                    psItem.setDouble(4, price);
                    psItem.addBatch();
                }
                psItem.executeBatch();
            }

            // Commit transaction!
            conn.commit();
            
            // Redirect with flag to clear cart in client
            session.setAttribute("success", "Thank you! Your grocery order has been successfully placed.");
            resp.sendRedirect(req.getContextPath() + "/orders/list.jsp?checkoutSuccess=true");

        } catch (Exception e) {
            if (conn != null) {
                try {
                    conn.rollback(); // Rollback on error!
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            e.printStackTrace();
            session.setAttribute("error", "Order placement failed: " + e.getMessage());
            resp.sendRedirect(req.getContextPath() + "/cart/view.jsp");
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
