package com.hamromart.controller;

import com.hamromart.dao.impl.CategoryDAOImpl;
import com.hamromart.entity.Category;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/category")
public class CategoryServlet extends HttpServlet {

    CategoryDAOImpl dao = new CategoryDAOImpl();

    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

        String action = req.getParameter("action");

        if(action == null) action = "list";

        if(action.equals("list")) {
            List<Category> list = dao.getAllCategories();
            req.setAttribute("list", list);
            req.getRequestDispatcher("WEB-INF/views/admin-category.jsp").forward(req, res);
        }

        else if(action.equals("delete")) {
            int id = Integer.parseInt(req.getParameter("id"));
            dao.deleteCategory(id);
            res.sendRedirect("category");
        }

        else if(action.equals("edit")) {
            int id = Integer.parseInt(req.getParameter("id"));
            Category c = dao.getCategoryById(id);
            req.setAttribute("category", c);

            List<Category> list = dao.getAllCategories();
            req.setAttribute("list", list);

            req.getRequestDispatcher("WEB-INF/views/admin-category.jsp").forward(req, res);
        }
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

        String id = req.getParameter("categoryId");
        String name = req.getParameter("name");

        Category c = new Category();
        c.setName(name);

        if(id == null || id.equals("")) {
            dao.insertCategory(c);
        } else {
            c.setCategoryId(Integer.parseInt(id));
            dao.updateCategory(c);
        }

        res.sendRedirect("category");
    }
}