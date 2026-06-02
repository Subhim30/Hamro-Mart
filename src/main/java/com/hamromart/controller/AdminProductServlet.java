package com.hamromart.controller;

import com.hamromart.dao.ProductDAO;
import com.hamromart.dao.impl.ProductDAOImpl;
import com.hamromart.entity.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;

@WebServlet(urlPatterns = {"/admin/products/save", "/admin/products/delete"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 10 * 1024 * 1024,
        maxRequestSize = 50 * 1024 * 1024
)
public class AdminProductServlet extends HttpServlet {

    private final ProductDAO productDAO = new ProductDAOImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String path = req.getServletPath();

        if ("/admin/products/save".equals(path)) {
            saveProduct(req, resp);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String path = req.getServletPath();

        if ("/admin/products/delete".equals(path)) {
            deleteProduct(req, resp);
        }
    }

    private void saveProduct(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();

        String idStr = req.getParameter("id");
        String name = req.getParameter("name");
        String description = req.getParameter("description");
        String priceStr = req.getParameter("price");
        String stockStr = req.getParameter("stock");
        String unit = req.getParameter("unit");
        String categoryIdStr = req.getParameter("categoryId");

        if (name == null || name.trim().isEmpty()
                || priceStr == null || priceStr.trim().isEmpty()
                || stockStr == null || stockStr.trim().isEmpty()) {

            session.setAttribute("error",
                    "Name, Price and Stock are required.");

            resp.sendRedirect(req.getContextPath() + "/admin/products.jsp");
            return;
        }

        try {

            double price = Double.parseDouble(priceStr);
            int stock = Integer.parseInt(stockStr);
            int categoryId = Integer.parseInt(categoryIdStr);

            String imageUrl =
                    "https://images.unsplash.com/photo-1542838132-92c53300491e?w=400&q=80";

            Part imagePart = req.getPart("imageUrl");

            if (imagePart != null
                    && imagePart.getSubmittedFileName() != null
                    && !imagePart.getSubmittedFileName().isEmpty()) {

                String fileName = Paths.get(
                                imagePart.getSubmittedFileName())
                        .getFileName()
                        .toString();

                String uploadPath =
                        System.getProperty("user.home")
                        + File.separator
                        + "HamroMartUploads";

                File uploadDir = new File(uploadPath);

                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                imagePart.write(
                        uploadPath + File.separator + fileName);

                imageUrl = fileName;
            }

            Product product = new Product();

            product.setName(name.trim());
            product.setDescription(
                    description != null ? description.trim() : "");

            product.setPrice(price);
            product.setStock(stock);
            product.setUnit(
                    unit != null && !unit.trim().isEmpty()
                            ? unit.trim()
                            : "pcs");

            product.setCategoryId(categoryId);
            product.setImageUrl(imageUrl);

            boolean success;

            if (idStr != null && !idStr.trim().isEmpty()) {

                int id = Integer.parseInt(idStr);

                product.setId(id);

                success = productDAO.update(product);

                if (success) {
                    session.setAttribute(
                            "success",
                            "Product updated successfully!");
                }

            } else {

                success = productDAO.save(product);

                if (success) {
                    session.setAttribute(
                            "success",
                            "Product added successfully!");
                }
            }

            if (!success) {
                session.setAttribute(
                        "error",
                        "Failed to save product.");
            }

        } catch (NumberFormatException e) {

            session.setAttribute(
                    "error",
                    "Invalid numeric values.");

        } catch (Exception e) {

            e.printStackTrace();

            session.setAttribute(
                    "error",
                    "Error: " + e.getMessage());
        }

        resp.sendRedirect(req.getContextPath() + "/admin/products.jsp");
    }

    private void deleteProduct(HttpServletRequest req,
                               HttpServletResponse resp)
            throws IOException {

        HttpSession session = req.getSession();

        String idStr = req.getParameter("id");

        if (idStr != null && !idStr.trim().isEmpty()) {

            try {

                int id = Integer.parseInt(idStr);

                if (productDAO.delete(id)) {

                    session.setAttribute(
                            "success",
                            "Product deleted successfully!");

                } else {

                    session.setAttribute(
                            "error",
                            "Failed to delete product.");
                }

            } catch (NumberFormatException e) {

                session.setAttribute(
                        "error",
                        "Invalid product ID.");
            }
        }

        resp.sendRedirect(req.getContextPath() + "/admin/products.jsp");
    }
}