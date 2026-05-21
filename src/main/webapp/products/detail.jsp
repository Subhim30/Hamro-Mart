<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<jsp:include page="../layout/header.jsp"/>

<section style="padding: 60px 0;">
    <div class="container">
        
        <!-- Breadcrumb links -->
        <div style="display: flex; gap: 8px; font-size: 14px; font-weight: 600; color: var(--text-muted); margin-bottom: 30px;">
            <a href="${pageContext.request.contextPath}/index.jsp" style="color: var(--text);"><i class="fas fa-home"></i> Home</a>
            <span>/</span>
            <a href="${pageContext.request.contextPath}/products" style="color: var(--text);">Shop</a>
            <span>/</span>
            <a href="${pageContext.request.contextPath}/products?category=${category.id}" style="color: var(--text);"><c:out value="${category.name}"/></a>
            <span>/</span>
            <span><c:out value="${product.name}"/></span>
        </div>

        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 60px; align-items: flex-start;">
            <!-- Left: Product Image -->
            <div>
                <img src="<c:out value="${product.imageUrl}"/>" alt="<c:out value="${product.name}"/>" 
                     style="width: 100%; max-height: 480px; object-fit: cover; border-radius: 20px; border: 1px solid var(--border); box-shadow: var(--shadow-md);">
            </div>
            
            <!-- Right: Product Information -->
            <div style="display: flex; flex-direction: column; gap: 20px;">
                <div>
                    <span style="color: var(--primary); font-weight: 700; text-transform: uppercase; font-size: 13px; background-color: var(--primary-light); padding: 4px 10px; border-radius: 20px;">
                        <i class="fas ${category.icon}"></i> <c:out value="${category.name}"/>
                    </span>
                    <h1 style="font-size: 38px; margin: 12px 0 8px 0; line-height: 1.2;"><c:out value="${product.name}"/></h1>
                    <p style="font-size: 14px; color: var(--text-muted); font-weight: 600;">
                        Product ID: HM-<c:out value="${product.id}"/> | Sourced Locally
                    </p>
                </div>
                
                <div style="border-top: 1px solid var(--border); border-bottom: 1px solid var(--border); padding: 20px 0;">
                    <div style="font-size: 32px; font-weight: 800; color: var(--primary); display: flex; align-items: flex-end; gap: 8px;">
                        Rs. <c:out value="${product.price}"/>
                        <span style="font-size: 15px; color: var(--text-muted); font-weight: 500; margin-bottom: 6px;">/ <c:out value="${product.unit}"/></span>
                    </div>
                </div>
                
                <div>
                    <h4 style="font-size: 16px; margin-bottom: 8px;">Product Description</h4>
                    <p style="color: var(--text-muted); line-height: 1.8;"><c:out value="${product.description}"/></p>
                </div>
                
                <div style="display: flex; flex-direction: column; gap: 8px; font-size: 14px; font-weight: 600;">
                    <p>
                        Availability: 
                        <c:choose>
                            <c:when test="${product.stock > 0}">
                                <span style="color: #059669;"><i class="fas fa-check-circle"></i> In Stock (<c:out value="${product.stock}"/> <c:out value="${product.unit}"/> left)</span>
                            </c:when>
                            <c:otherwise>
                                <span style="color: #dc2626;"><i class="fas fa-times-circle"></i> Out of Stock</span>
                            </c:otherwise>
                        </c:choose>
                    </p>
                    <p>Delivery: <span style="color: var(--text-muted);">Standard (Same day inside Ring Road)</span></p>
                </div>
                
                <div style="margin-top: 10px;">
                    <c:choose>
                        <c:when test="${product.stock > 0}">
                            <button class="btn btn-primary btn-add-to-cart" 
                                    data-id="${product.id}"
                                    data-name="${product.name}"
                                    data-price="${product.price}"
                                    data-image="${product.imageUrl}"
                                    data-unit="${product.unit}"
                                    style="padding: 14px 40px; font-size: 16px; border-radius: var(--radius);">
                                <i class="fas fa-shopping-cart"></i> Add to Basket
                            </button>
                        </c:when>
                        <c:otherwise>
                            <button class="btn btn-secondary" style="padding: 14px 40px; font-size: 16px; border-radius: var(--radius); cursor: not-allowed;" disabled>
                                <i class="fas fa-ban"></i> Out of Stock
                            </button>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>
</section>

<jsp:include page="../layout/header.jsp"/>
