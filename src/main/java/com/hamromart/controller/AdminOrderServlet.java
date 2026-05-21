package com.hamromart.controller;

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
import java.sql.SQLException;

@WebServlet("/admin/orders/status")
public class AdminOrderServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("id");
        String status = req.getParameter("status");
        HttpSession session = req.getSession();

        if (idStr == null || status == null || idStr.trim().isEmpty() || status.trim().isEmpty()) {
            session.setAttribute("error", "Order status update requests require valid parameters.");
            resp.sendRedirect(req.getContextPath() + "/admin/orders.jsp");
            return;
        }

        String sql = "UPDATE orders SET status = ? WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, status.toUpperCase().trim());
            ps.setInt(2, Integer.parseInt(idStr.trim()));

            if (ps.executeUpdate() > 0) {
                session.setAttribute("success", "Order status updated to " + status + " successfully!");
            } else {
                session.setAttribute("error", "Failed to update order status.");
            }
        } catch (SQLException | NumberFormatException e) {
            e.printStackTrace();
            session.setAttribute("error", "Error processing order status update.");
        }

        resp.sendRedirect(req.getContextPath() + "/admin/orders.jsp");
    }
}
