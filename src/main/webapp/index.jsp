<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.hamromart.dao.CategoryDAO" %>
<%@ page import="com.hamromart.dao.impl.CategoryDAOImpl" %>
<%@ page import="com.hamromart.entity.Category" %>
<%@ page import="java.util.List" %>

<%
    CategoryDAO categoryDAO = new CategoryDAOImpl();
    List<Category> categories = categoryDAO.getAll();
    request.setAttribute("categories", categories);
%>

<jsp:include page="layout/header.jsp"/>

<!-- Hero Banner -->
<section class="hero">
    <div class="container hero-grid">
        <div class="hero-content">
            <span style="font-weight: 700; color: var(--primary); text-transform: uppercase; letter-spacing: 1px; font-size: 14px; display: inline-block; margin-bottom: 12px; background-color: var(--primary-light); padding: 4px 12px; border-radius: 20px;">
                <i class="fas fa-leaf"></i> 100% Organic & Fresh
            </span>
            <h1 class="hero-title">
                Fresh & Healthy Grocery <span>Delivered To Your Home</span>
            </h1>
            <p class="hero-subtitle">
                Skip the lines and shop premium organic vegetables, dairy, bakery products, and fresh meats at unbeatable local prices.
            </p>
            <div style="display: flex; gap: 16px;">
                <a href="${pageContext.request.contextPath}/products" class="btn btn-primary" style="padding: 14px 28px; font-size: 16px;">
                    <i class="fas fa-shopping-bag"></i> Shop Catalog
                </a>
                <a href="${pageContext.request.contextPath}/about.jsp" class="btn btn-secondary" style="padding: 14px 28px; font-size: 16px;">
                    Learn More
                </a>
            </div>
        </div>
        
        <div class="hero-image">
            <img src="https://images.unsplash.com/photo-1542838132-92c53300491e?w=800&q=80" alt="Fresh Grocery Harvest">
        </div>
    </div>
</section>

<!-- Promotional Grid -->
<section style="padding: 60px 0;">
    <div class="container">
        <div style="display: grid; grid-template-columns: 1fr 1fr 1fr; gap: 24px;">
            <!-- Feature 1 -->
            <div style="background-color: var(--card-bg); border: 1px solid var(--border); padding: 30px; border-radius: var(--radius); display: flex; gap: 20px; align-items: flex-start; box-shadow: var(--shadow-sm);">
                <div style="background-color: #d1fae5; color: #059669; width: 48px; height: 48px; border-radius: 12px; display: flex; align-items: center; justify-content: center; font-size: 20px; flex-shrink: 0;">
                    <i class="fas fa-shipping-fast"></i>
                </div>
                <div>
                    <h4 style="font-size: 18px; margin-bottom: 8px;">Free Delivery</h4>
                    <p style="color: var(--text-muted); font-size: 14px;">On all orders over Rs. 1000 within Kathmandu valley.</p>
                </div>
            </div>
            
            <!-- Feature 2 -->
            <div style="background-color: var(--card-bg); border: 1px solid var(--border); padding: 30px; border-radius: var(--radius); display: flex; gap: 20px; align-items: flex-start; box-shadow: var(--shadow-sm);">
                <div style="background-color: #fef3c7; color: #d97706; width: 48px; height: 48px; border-radius: 12px; display: flex; align-items: center; justify-content: center; font-size: 20px; flex-shrink: 0;">
                    <i class="fas fa-hand-holding-heart"></i>
                </div>
                <div>
                    <h4 style="font-size: 18px; margin-bottom: 8px;">100% Organic</h4>
                    <p style="color: var(--text-muted); font-size: 14px;">Sourced directly from certified chemical-free farms in Nepal.</p>
                </div>
            </div>
            
            <!-- Feature 3 -->
            <div style="background-color: var(--card-bg); border: 1px solid var(--border); padding: 30px; border-radius: var(--radius); display: flex; gap: 20px; align-items: flex-start; box-shadow: var(--shadow-sm);">
                <div style="background-color: #e0f2fe; color: #0284c7; width: 48px; height: 48px; border-radius: 12px; display: flex; align-items: center; justify-content: center; font-size: 20px; flex-shrink: 0;">
                    <i class="fas fa-wallet"></i>
                </div>
                <div>
                    <h4 style="font-size: 18px; margin-bottom: 8px;">Secure Payments</h4>
                    <p style="color: var(--text-muted); font-size: 14px;">Multiple payment modes including COD, Cards, and eSewa.</p>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Categories Section -->
<section class="categories-sec" style="background-color: var(--card-bg); border-top: 1px solid var(--border); border-bottom: 1px solid var(--border);">
    <div class="container">
        <div class="section-header">
            <div>
                <span style="color: var(--primary); font-weight: 700; font-size: 14px; text-transform: uppercase;">Browse Store</span>
                <h2 class="section-title">Shop by Category</h2>
            </div>
            <a href="${pageContext.request.contextPath}/products" class="btn btn-secondary">
                View All <i class="fas fa-arrow-right"></i>
            </a>
        </div>
        
        <div class="cat-grid">
            <c:forEach var="cat" items="${categories}">
                <a href="${pageContext.request.contextPath}/products?category=${cat.id}" class="cat-card">
                    <div class="cat-icon-container">
                        <i class="fas ${cat.icon}"></i>
                    </div>
                    <h3 style="font-size: 16px; margin-bottom: 8px;"><c:out value="${cat.name}"/></h3>
                    <p style="color: var(--text-muted); font-size: 12px;"><c:out value="${cat.description}"/></p>
                </a>
            </c:forEach>
        </div>
    </div>
</section>

<!-- Promotional Banner -->
<section style="padding: 80px 0; background: linear-gradient(rgba(15,23,42,0.85), rgba(15,23,42,0.85)), url('https://images.unsplash.com/photo-1578916171728-46686eac8d58?w=1200&q=80'); background-size: cover; background-position: center; color: #ffffff; text-align: center;">
    <div class="container" style="max-width: 800px;">
        <span style="color: var(--primary); font-weight: 800; font-size: 15px; text-transform: uppercase; letter-spacing: 1px;">Weekly Deals</span>
        <h2 style="font-size: 40px; margin: 16px 0 24px 0; color: #ffffff; line-height: 1.2;">Get Up To 30% Off On Farm Fresh Fruits & Greens</h2>
        <p style="font-size: 16px; color: #94a3b8; margin-bottom: 32px;">Every Wednesday we bring exclusive flash sales with extra discounts on local agricultural items. Keep your cart ready!</p>
        <a href="${pageContext.request.contextPath}/products?category=1" class="btn btn-primary" style="padding: 14px 30px;">
            Shop Fresh items Now
        </a>
    </div>
</section>

<jsp:include page="layout/footer.jsp"/>
