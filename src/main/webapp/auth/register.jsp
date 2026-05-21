<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<jsp:include page="../layout/header.jsp"/>

<div class="auth-wrapper" style="min-height: calc(100vh - 120px);">
    <div class="auth-card" style="max-width: 500px;">
        <div class="auth-header">
            <h2 class="auth-title">Create Account</h2>
            <p style="color: var(--text-muted); font-size: 14px;">Register to enjoy fresh organic home delivery</p>
        </div>

        <!-- Success & Error Alert Messages -->
        <c:if test="${not empty sessionScope.error}">
            <div class="alert alert-danger">
                <c:out value="${sessionScope.error}"/>
            </div>
            <% session.removeAttribute("error"); %>
        </c:if>

        <form action="${pageContext.request.contextPath}/auth/register" method="POST">
            <div class="form-group">
                <label class="form-label" for="reg-name">Full Name</label>
                <input type="text" id="reg-name" name="name" class="form-control" placeholder="e.g. Rubina Gurung" required>
            </div>
            
            <div class="form-group">
                <label class="form-label" for="reg-email">Email Address</label>
                <input type="email" id="reg-email" name="email" class="form-control" placeholder="e.g. rubina@gmail.com" required>
            </div>
            
            <div class="form-group">
                <label class="form-label" for="reg-password">Password</label>
                <input type="password" id="reg-password" name="password" class="form-control" placeholder="Create a strong password" required>
            </div>
            
            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
                <div class="form-group">
                    <label class="form-label" for="reg-phone">Phone Number</label>
                    <input type="text" id="reg-phone" name="phone" class="form-control" placeholder="e.g. 9812345678">
                </div>
                <div class="form-group">
                    <label class="form-label" for="reg-address">Delivery Address</label>
                    <input type="text" id="reg-address" name="address" class="form-control" placeholder="e.g. Lalitpur, Nepal">
                </div>
            </div>
            
            <button type="submit" class="btn btn-primary" style="width: 100%; padding: 12px; margin-top: 10px;">
                <i class="fas fa-user-plus"></i> Register
            </button>
        </form>
        
        <div style="text-align: center; margin-top: 24px; font-size: 14px; color: var(--text-muted);">
            Already have an account? 
            <a href="login.jsp" style="color: var(--primary); font-weight: 700;">Sign In</a>
        </div>
    </div>
</div>

<jsp:include page="../layout/footer.jsp"/>
