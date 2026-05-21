package com.hamromart.controller;

import com.hamromart.dao.ProductDAO;
import com.hamromart.dao.impl.ProductDAOImpl;
import com.hamromart.entity.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(urlPatterns = {"/admin/products/save", "/admin/products/delete"})
public class AdminProductServlet extends HttpServlet {
    private final ProductDAO productDAO = new ProductDAOImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();

        if ("/admin/products/save".equals(path)) {
            saveProduct(req, resp);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();

        if ("/admin/products/delete".equals(path)) {
            deleteProduct(req, resp);
        }
    }

    private void saveProduct(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String idStr = req.getParameter("id");
        String name = req.getParameter("name");
        String description = req.getParameter("description");
        String priceStr = req.getParameter("price");
        String stockStr = req.getParameter("stock");
        String unit = req.getParameter("unit");
        String categoryIdStr = req.getParameter("categoryId");
        String imageUrl = req.getParameter("imageUrl");
        
        HttpSession session = req.getSession();


        if (name == null || priceStr == null || stockStr == null || name.trim().isEmpty()) {
            session.setAttribute("error", "Name, Price, and Stock are required fields.");
            resp.sendRedirect(req.getContextPath() + "/admin/products.jsp");
            return;
        }

        try {
            double price = Double.parseDouble(priceStr);
            int stock = Integer.parseInt(stockStr);
            int categoryId = Integer.parseInt(categoryIdStr);

            Product product = new Product();
            product.setName(name.trim());
            product.setDescription(description != null ? description.trim() : "");
            product.setPrice(price);
            product.setStock(stock);
            product.setUnit(unit != null ? unit.trim() : "pcs");
            product.setCategoryId(categoryId);
            product.setImageUrl(imageUrl != null && !imageUrl.trim().isEmpty() ? imageUrl.trim() : "https://images.unsplash.com/photo-1542838132-92c53300491e?w=400&q=80");

            boolean success;
            if (idStr != null && !idStr.trim().isEmpty()) {
                // Update operation
                int id = Integer.parseInt(idStr.trim());
                product.setId(id);
                success = productDAO.update(product);
                if (success) session.setAttribute("success", "Product updated successfully!");
            } else {
                // Create operation
                success = productDAO.save(product);
                if (success) session.setAttribute("success", "Product added successfully!");
            }

            if (!success) {
                session.setAttribute("error", "Failed to save product.");
            }

        } catch (NumberFormatException e) {
            session.setAttribute("error", "Invalid numeric values for price, stock, or category.");
        }

        resp.sendRedirect(req.getContextPath() + "/admin/products.jsp");
    }

    private void deleteProduct(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String idStr = req.getParameter("id");
        HttpSession session = req.getSession();

        if (idStr != null && !idStr.trim().isEmpty()) {
            try {
                int id = Integer.parseInt(idStr.trim());
                if (productDAO.delete(id)) {
                    session.setAttribute("success", "Product deleted successfully!");
                } else {
                    session.setAttribute("error", "Failed to delete product. It may be part of an existing customer order.");
                }
            } catch (NumberFormatException e) {
                session.setAttribute("error", "Invalid product ID.");
            }
        }

        resp.sendRedirect(req.getContextPath() + "/admin/products.jsp");
    }
}
