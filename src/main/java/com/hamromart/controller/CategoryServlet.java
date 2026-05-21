package com.hamromart.controller;

import com.hamromart.dao.CategoryDAO;
import com.hamromart.dao.impl.CategoryDAOImpl;
import com.hamromart.entity.Category;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(urlPatterns = {"/admin/categories", "/admin/categories/add", "/admin/categories/delete"})
public class CategoryServlet extends HttpServlet {
    private final CategoryDAO categoryDAO = new CategoryDAOImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();

        if ("/admin/categories/add".equals(path)) {
            addCategory(req, resp);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();

        if ("/admin/categories/delete".equals(path)) {
            deleteCategory(req, resp);
        } else {
            resp.sendRedirect(req.getContextPath() + "/admin/dashboard.jsp");
        }
    }

    private void addCategory(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String name = req.getParameter("name");
        String description = req.getParameter("description");
        String icon = req.getParameter("icon");
        HttpSession session = req.getSession();

        if (name == null || name.trim().isEmpty()) {
            session.setAttribute("error", "Category name is required.");
            resp.sendRedirect(req.getContextPath() + "/admin/dashboard.jsp");
            return;
        }

        Category category = new Category();
        category.setName(name.trim());
        category.setDescription(description != null ? description.trim() : "");
        category.setIcon(icon != null && !icon.trim().isEmpty() ? icon.trim() : "fa-box");

        if (categoryDAO.save(category)) {
            session.setAttribute("success", "Category added successfully!");
        } else {
            session.setAttribute("error", "Failed to add category.");
        }
        resp.sendRedirect(req.getContextPath() + "/admin/dashboard.jsp");
    }

    private void deleteCategory(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String idStr = req.getParameter("id");
        HttpSession session = req.getSession();

        if (idStr != null && !idStr.trim().isEmpty()) {
            try {
                int id = Integer.parseInt(idStr.trim());
                if (categoryDAO.delete(id)) {
                    session.setAttribute("success", "Category deleted successfully!");
                } else {
                    session.setAttribute("error", "Failed to delete category (it may contain active products).");
                }
            } catch (NumberFormatException e) {
                session.setAttribute("error", "Invalid category ID.");
            }
        }
        resp.sendRedirect(req.getContextPath() + "/admin/dashboard.jsp");
    }
}
