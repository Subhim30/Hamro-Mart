package com.hamromart.filter;

import com.hamromart.entity.User;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter(urlPatterns = {"/admin/*", "/cart/checkout", "/orders/*"})
public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization code if needed
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        User currentUser = (session != null) ? (User) session.getAttribute("currentUser") : null;
        String requestURI = httpRequest.getRequestURI();

        // If trying to access admin panel, must be logged in and be an ADMIN
        if (requestURI.contains("/admin/")) {
            if (currentUser == null) {
                session = httpRequest.getSession(true);
                session.setAttribute("authError", "Please log in to access this page.");
                httpResponse.sendRedirect(httpRequest.getContextPath() + "/auth/login.jsp");
                return;
            } else if (!"ADMIN".equals(currentUser.getRole())) {
                httpResponse.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied: Admin role required.");
                return;
            }
        }

        // Standard user actions (orders, checkout, etc.) require active login
        if (requestURI.contains("/orders/") || requestURI.contains("/cart/checkout")) {
            if (currentUser == null) {
                session = httpRequest.getSession(true);
                session.setAttribute("authError", "Please log in to view orders or checkout.");
                httpResponse.sendRedirect(httpRequest.getContextPath() + "/auth/login.jsp");
                return;
            }
        }

        // Proceed to next filter or JSP/Servlet
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // Cleanup resources if needed
    }
}
