package com.hamromart.controller;

import com.hamromart.dao.impl.ProductDAOImpl;
import com.hamromart.entity.Product;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/product")
public class ProductServlet extends HttpServlet {

    ProductDAOImpl dao = new ProductDAOImpl();

    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

        String action = req.getParameter("action");

        if(action == null) action = "list";

        if(action.equals("list")) {
            List<Product> list = dao.getAllProducts();
            req.setAttribute("list", list);
            req.getRequestDispatcher("/WEB-INF/views/products.jsp").forward(req, res);
        }

        else if(action.equals("delete")) {
            int id = Integer.parseInt(req.getParameter("id"));
            dao.deleteProduct(id);
            res.sendRedirect("product");
        }

        else if(action.equals("edit")) {
            int id = Integer.parseInt(req.getParameter("id"));
            Product p = dao.getProductById(id);
            req.setAttribute("product", p);
            req.getRequestDispatcher("WEB-INF/views/admin-products.jsp").forward(req, res);
        }
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

        String id = req.getParameter("productId");
        String name = req.getParameter("name");
        double price = Double.parseDouble(req.getParameter("price"));
        String image = req.getParameter("image");
        int categoryId = Integer.parseInt(req.getParameter("categoryId"));

        Product p = new Product();

        p.setName(name);
        p.setPrice(price);
        p.setProductImage(image);
        p.setCategoryId(categoryId);

        if(id == null || id.equals("")) {
            dao.insertProduct(p);
        } else {
            p.setProductId(Integer.parseInt(id));
            dao.updateProduct(p);
        }

        res.sendRedirect("product");
    }
}