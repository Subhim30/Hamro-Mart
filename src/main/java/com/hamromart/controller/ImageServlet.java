package com.hamromart.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;

@WebServlet("/images/*")
public class ImageServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req,
                         HttpServletResponse resp)
            throws ServletException, IOException {

        String fileName = req.getPathInfo().substring(1);

        String uploadPath =
                System.getProperty("user.home")
                        + File.separator
                        + "HamroMartUploads";

        System.out.println("Requested file: " + fileName);
        System.out.println("Upload path: " + uploadPath);

        File file = new File(uploadPath, fileName);

        System.out.println("Full file path: " + file.getAbsolutePath());
        System.out.println("Exists: " + file.exists());

        if (!file.exists()) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        String contentType =
                getServletContext().getMimeType(file.getName());

        if (contentType == null) {
            contentType = "application/octet-stream";
        }

        resp.setContentType(contentType);

        Files.copy(file.toPath(), resp.getOutputStream());
    }
}