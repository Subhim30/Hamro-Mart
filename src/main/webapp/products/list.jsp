<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<jsp:include page="../layout/header.jsp"/>

<!-- Catalog Layout -->
<section style="padding: 40px 0;">
    <div class="container" style="display: grid; grid-template-columns: 280px 1fr; gap: 40px;">
        
        <!-- Sidebar Filter Column -->
        <aside>
            <!-- Search Widget -->
            <div style="background-color: var(--card-bg); border: 1px solid var(--border); border-radius: var(--radius); padding: 24px; box-shadow: var(--shadow-sm); margin-bottom: 24px;">
                <h4 style="font-size: 16px; margin-bottom: 16px;"><i class="fas fa-search" style="color: var(--primary);"></i> Search Products</h4>
                <form action="${pageContext.request.contextPath}/products/search" method="GET" style="display: flex; gap: 8px;">
                    <input type="text" name="q" class="form-control" placeholder="Search..." value="<c:out value="${searchQuery}"/>" style="padding: 10px 14px;" required>
                    <button type="submit" class="btn btn-primary" style="padding: 10px 14px;"><i class="fas fa-search"></i></button>
                </form>
            </div>

            <!-- Categories Widget -->
            <div style="background-color: var(--card-bg); border: 1px solid var(--border); border-radius: var(--radius); padding: 24px; box-shadow: var(--shadow-sm);">
                <h4 style="font-size: 16px; margin-bottom: 16px;"><i class="fas fa-filter" style="color: var(--primary);"></i> Category Filter</h4>
                <div style="display: flex; flex-direction: column; gap: 8px;">
                    <a href="${pageContext.request.contextPath}/products" class="btn btn-secondary ${empty selectedCategory ? 'active' : ''}" style="justify-content: flex-start; text-align: left; padding: 12px 16px;">
                        <i class="fas fa-th-large"></i> All Categories
                    </a>
                    <c:forEach var="cat" items="${categories}">
                        <a href="${pageContext.request.contextPath}/products?category=${cat.id}" class="btn btn-secondary ${selectedCategory.id == cat.id ? 'active' : ''}" style="justify-content: flex-start; text-align: left; padding: 12px 16px;">
                            <i class="fas ${cat.icon}"></i> <c:out value="${cat.name}"/>
                        </a>
                    </c:forEach>
                </div>
            </div>
        </aside>

        <!-- Product Grid Column -->
        <main>
            <!-- Title Bar -->
            <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px;">
                <div>
                    <span style="color: var(--primary); font-weight: 700; font-size: 14px; text-transform: uppercase;">Fresh Products</span>
                    <h2 style="font-size: 32px;">
                        <c:choose>
                            <c:when test="${not empty searchQuery}">
                                Search Results for "<c:out value="${searchQuery}"/>"
                            </c:when>
                            <c:when test="${not empty selectedCategory}">
                                <c:out value="${selectedCategory.name}"/>
                            </c:when>
                            <c:otherwise>
                                Shop All Groceries
                            </c:otherwise>
                        </c:choose>
                    </h2>
                </div>
                <p style="color: var(--text-muted); font-size: 14px; font-weight: 600;">
                    Showing <c:out value="${products.size()}"/> items
                </p>
            </div>

            <!-- Products Grid -->
            <c:choose>
                <c:when test="${empty products}">
                    <div style="text-align: center; padding: 80px 24px; background-color: var(--card-bg); border: 1px solid var(--border); border-radius: var(--radius);">
                        <i class="fas fa-search" style="font-size: 48px; color: var(--text-muted); margin-bottom: 20px;"></i>
                        <h3>No Products Found</h3>
                        <p style="color: var(--text-muted); margin-top: 8px;">Try searching for another keyword or select a different category.</p>
                        <a href="${pageContext.request.contextPath}/products" class="btn btn-primary" style="margin-top: 24px;">Clear Filters</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="product-grid">
                        <c:forEach var="prod" items="${products}">
                            <div class="product-card">
                                <div class="product-img-wrapper">
                                    <img src="${pageContext.request.contextPath}/images/${prod.imageUrl}"
                                         alt="<c:out value="${prod.name}"/>">
                                    <span class="product-badge">
                                        <c:choose>
                                            <c:when test="${prod.stock > 0}">In Stock</c:when>
                                            <c:otherwise>Out of Stock</c:otherwise>
                                        </c:choose>
                                    </span>
                                </div>
                                <div class="product-info">
                                    <h3 class="product-name">
                                        <a href="${pageContext.request.contextPath}/products/detail?id=${prod.id}">
                                            <c:out value="${prod.name}"/>
                                        </a>
                                    </h3>
                                    <p class="product-desc"><c:out value="${prod.description}"/></p>
                                    <div class="product-meta">
                                        <div class="product-price">
                                            Rs. <c:out value="${prod.price}"/> <span>/ <c:out value="${prod.unit}"/></span>
                                        </div>
                                        <c:choose>
                                            <c:when test="${prod.stock > 0}">
                                                <button class="btn btn-primary btn-add-to-cart" 
                                                        data-id="${prod.id}"
                                                        data-name="${prod.name}"
                                                        data-price="${prod.price}"
                                                        data-image="${pageContext.request.contextPath}/images/${product.imageUrl}"
                                                        data-unit="${prod.unit}"
                                                        style="width: 40px; height: 40px; padding: 0; border-radius: 50%;">
                                                    <i class="fas fa-shopping-cart"></i>
                                                </button>
                                            </c:when>
                                            <c:otherwise>
                                                <button class="btn btn-secondary" style="width: 40px; height: 40px; padding: 0; border-radius: 50%; cursor: not-allowed;" disabled>
                                                    <i class="fas fa-ban"></i>
                                                </button>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </main>
    </div>
</section>

<jsp:include page="../layout/footer.jsp"/>
