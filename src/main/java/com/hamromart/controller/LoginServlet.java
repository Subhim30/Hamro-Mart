package com.hamromart.controller;

import com.hamromart.dao.UserDAO;
import com.hamromart.dao.impl.UserDAOImpl;
import com.hamromart.entity.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(urlPatterns = {"/auth/login", "/auth/register", "/auth/logout"})
public class LoginServlet extends HttpServlet {
    private final UserDAO userDAO = new UserDAOImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();

        if ("/auth/login".equals(path)) {
            handleLogin(req, resp);
        } else if ("/auth/register".equals(path)) {
            handleRegister(req, resp);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();

        if ("/auth/logout".equals(path)) {
            handleLogout(req, resp);
        } else {
            resp.sendRedirect(req.getContextPath() + "/auth/login.jsp");
        }
    }

    private void handleLogin(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        HttpSession session = req.getSession();

        if (email == null || password == null || email.trim().isEmpty() || password.trim().isEmpty()) {
            session.setAttribute("error", "Email and Password cannot be empty.");
            resp.sendRedirect(req.getContextPath() + "/auth/login.jsp");
            return;
        }

        User user = userDAO.authenticate(email.trim(), password.trim());
        if (user != null) {
            session.setAttribute("currentUser", user);
            session.removeAttribute("error");
            
            // Redirect based on role
            if ("ADMIN".equals(user.getRole())) {
                resp.sendRedirect(req.getContextPath() + "/admin/dashboard.jsp");
            } else {
                resp.sendRedirect(req.getContextPath() + "/index.jsp");
            }
        } else {
            session.setAttribute("error", "Invalid email or password.");
            resp.sendRedirect(req.getContextPath() + "/auth/login.jsp");
        }
    }

    private void handleRegister(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String phone = req.getParameter("phone");
        String address = req.getParameter("address");
        HttpSession session = req.getSession();

        if (name == null || email == null || password == null || name.trim().isEmpty() || email.trim().isEmpty() || password.trim().isEmpty()) {
            session.setAttribute("error", "Name, Email, and Password are required fields.");
            resp.sendRedirect(req.getContextPath() + "/auth/register.jsp");
            return;
        }

        if (userDAO.findByEmail(email.trim()) != null) {
            session.setAttribute("error", "Email is already registered.");
            resp.sendRedirect(req.getContextPath() + "/auth/register.jsp");
            return;
        }

        User newUser = new User();
        newUser.setName(name.trim());
        newUser.setEmail(email.trim());
        newUser.setPassword(password.trim());
        newUser.setPhone(phone != null ? phone.trim() : "");
        newUser.setAddress(address != null ? address.trim() : "");
        newUser.setRole("CUSTOMER"); // default role

        if (userDAO.register(newUser)) {
            session.setAttribute("success", "Registration successful! Please log in.");
            session.removeAttribute("error");
            resp.sendRedirect(req.getContextPath() + "/auth/login.jsp");
        } else {
            session.setAttribute("error", "Registration failed. Please try again.");
            resp.sendRedirect(req.getContextPath() + "/auth/register.jsp");
        }
    }

    private void handleLogout(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        resp.sendRedirect(req.getContextPath() + "/index.jsp");
    }
}
