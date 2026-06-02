package com.hamromart.controller;

import com.hamromart.dao.CategoryDAO;
import com.hamromart.dao.ProductDAO;
import com.hamromart.dao.impl.CategoryDAOImpl;
import com.hamromart.dao.impl.ProductDAOImpl;
import com.hamromart.entity.Category;
import com.hamromart.entity.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/products","/product", "/products/detail", "/products/search"})
public class ProductServlet extends HttpServlet {
    private final ProductDAO productDAO = new ProductDAOImpl();
    private final CategoryDAO categoryDAO = new CategoryDAOImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getServletPath();

        if ("/products/detail".equals(path)) {
            showProductDetail(req, resp);
        } else if ("/products/search".equals(path)) {
            searchProducts(req, resp);
        } else {
            listProducts(req, resp);
        }
    }

    private void listProducts(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String categoryIdStr = req.getParameter("category");
        List<Product> products;
        Category selectedCategory = null;

        if (categoryIdStr != null && !categoryIdStr.trim().isEmpty()) {
            try {
                int categoryId = Integer.parseInt(categoryIdStr.trim());
                products = productDAO.getByCategory(categoryId);
                selectedCategory = categoryDAO.getById(categoryId);
            } catch (NumberFormatException e) {
                products = productDAO.getAll();
            }
        } else {
            products = productDAO.getAll();
        }

        List<Category> categories = categoryDAO.getAll();

        req.setAttribute("products", products);
        req.setAttribute("categories", categories);
        req.setAttribute("selectedCategory", selectedCategory);

        req.getRequestDispatcher("/products/list.jsp").forward(req, resp);
    }

    private void showProductDetail(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("id");
        if (idStr == null || idStr.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/products");
            return;
        }

        try {
            int id = Integer.parseInt(idStr.trim());
            Product product = productDAO.getById(id);
            if (product != null) {
                Category category = categoryDAO.getById(product.getCategoryId());
                req.setAttribute("product", product);
                req.setAttribute("category", category);
                req.getRequestDispatcher("/products/detail.jsp").forward(req, resp);
                return;
            }
        } catch (NumberFormatException e) {
            // Handled below
        }

        resp.sendRedirect(req.getContextPath() + "/products");
    }

    private void searchProducts(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String query = req.getParameter("q");
        List<Product> products;

        if (query != null && !query.trim().isEmpty()) {
            products = productDAO.searchByName(query.trim());
            req.setAttribute("searchQuery", query);
        } else {
            products = productDAO.getAll();
        }

        List<Category> categories = categoryDAO.getAll();

        req.setAttribute("products", products);
        req.setAttribute("categories", categories);
        req.getRequestDispatcher("/products/list.jsp").forward(req, resp);
    }
}
