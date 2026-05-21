<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hamromart - Fresh Grocery Store</title>
    <!-- Tailwind CSS (Optional but using Vanilla CSS via style.css) -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
    <!-- FontAwesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>

    <!-- Header / Navigation Bar -->
    <header class="navbar">
        <div class="container nav-container">
            <a href="${pageContext.request.contextPath}/index.jsp" class="logo">
                <i class="fas fa-shopping-basket"></i> Hamro<span>Mart</span>
            </a>

            <nav class="nav-links">
                <a href="${pageContext.request.contextPath}/index.jsp" class="nav-link">Home</a>
                <a href="${pageContext.request.contextPath}/products" class="nav-link">Shop</a>
                <a href="${pageContext.request.contextPath}/about.jsp" class="nav-link">About</a>
                <a href="${pageContext.request.contextPath}/contact.jsp" class="nav-link">Contact</a>
            </nav>

            <div class="nav-actions">
                <!-- Theme Toggle Button -->
                <button id="theme-toggle" class="btn btn-icon" title="Toggle Theme">
                    <i class="fas fa-moon"></i>
                </button>

                <!-- Cart Button with Dynamic Badge -->
                <a href="${pageContext.request.contextPath}/cart/view.jsp" class="btn btn-icon" title="View Cart">
                    <i class="fas fa-shopping-cart"></i>
                    <span class="badge-count cart-badge" style="display: none;">0</span>
                </a>

                <!-- Account Actions -->
                <c:choose>
                    <c:when test="${not empty sessionScope.currentUser}">
                        <div style="display: flex; align-items: center; gap: 14px;">
                            <span style="font-size: 14px; font-weight: 600;">
                                Hi, <c:out value="${sessionScope.currentUser.name}"/>
                            </span>
                            <c:if test="${sessionScope.currentUser.role == 'ADMIN'}">
                                <a href="${pageContext.request.contextPath}/admin/dashboard.jsp" class="btn btn-secondary" style="padding: 8px 16px;">
                                    <i class="fas fa-chart-line"></i> Dashboard
                                </a>
                            </c:if>
                            <a href="${pageContext.request.contextPath}/auth/logout" class="btn btn-primary" style="padding: 8px 16px; background-color: #ef4444; box-shadow: 0 4px 14px 0 rgba(239, 68, 68, 0.4);">
                                <i class="fas fa-sign-out-alt"></i> Logout
                            </a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/auth/login.jsp" class="btn btn-secondary">Login</a>
                        <a href="${pageContext.request.contextPath}/auth/register.jsp" class="btn btn-primary">Register</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </header>
