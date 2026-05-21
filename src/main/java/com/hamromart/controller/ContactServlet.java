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

@WebServlet("/contact/submit")
public class ContactServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String subject = req.getParameter("subject");
        String message = req.getParameter("message");
        HttpSession session = req.getSession();

        if (name == null || email == null || message == null || name.trim().isEmpty() || email.trim().isEmpty() || message.trim().isEmpty()) {
            session.setAttribute("error", "Name, email, and message details are required.");
            resp.sendRedirect(req.getContextPath() + "/contact.jsp");
            return;
        }

        String sql = "INSERT INTO messages (name, email, subject, message) VALUES (?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, name.trim());
            ps.setString(2, email.trim());
            ps.setString(3, subject != null ? subject.trim() : "No Subject");
            ps.setString(4, message.trim());

            if (ps.executeUpdate() > 0) {
                session.setAttribute("success", "Your message has been sent successfully! We'll reply soon.");
                session.removeAttribute("error");
            } else {
                session.setAttribute("error", "Failed to save your message. Please try again.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            session.setAttribute("error", "Database connection error. Failed to send message.");
        }

        resp.sendRedirect(req.getContextPath() + "/contact.jsp");
    }
}
