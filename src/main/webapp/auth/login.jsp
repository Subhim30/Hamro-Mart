<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<jsp:include page="../layout/header.jsp"/>

<div class="auth-wrapper">
    <div class="auth-card">
        <div class="auth-header">
            <h2 class="auth-title">Welcome Back</h2>
            <p style="color: var(--text-muted); font-size: 14px;">Sign in to access your Hamromart fresh items</p>
        </div>

        <!-- Success & Error Alert Messages -->
        <c:if test="${not empty sessionScope.success}">
            <div class="alert alert-success">
                <c:out value="${sessionScope.success}"/>
            </div>
            <% session.removeAttribute("success"); %>
        </c:if>
        <c:if test="${not empty sessionScope.error}">
            <div class="alert alert-danger">
                <c:out value="${sessionScope.error}"/>
            </div>
            <% session.removeAttribute("error"); %>
        </c:if>
        <c:if test="${not empty sessionScope.authError}">
            <div class="alert alert-danger">
                <c:out value="${sessionScope.authError}"/>
            </div>
            <% session.removeAttribute("authError"); %>
        </c:if>

        <form action="${pageContext.request.contextPath}/auth/login" method="POST">
            <div class="form-group">
                <label class="form-label" for="login-email">Email Address</label>
                <input type="email" id="login-email" name="email" class="form-control" placeholder="e.g. rubina@gmail.com" required>
            </div>
            
            <div class="form-group">
                <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 8px;">
                    <label class="form-label" for="login-password" style="margin-bottom: 0;">Password</label>
                    <a href="#" style="color: var(--primary); font-size: 13px; font-weight: 600;">Forgot?</a>
                </div>
                <input type="password" id="login-password" name="password" class="form-control" placeholder="Enter your password" required>
            </div>
            
            <button type="submit" class="btn btn-primary" style="width: 100%; padding: 12px; margin-top: 10px;">
                <i class="fas fa-sign-in-alt"></i> Sign In
            </button>
        </form>
        
        <div style="text-align: center; margin-top: 24px; font-size: 14px; color: var(--text-muted);">
            Don't have an account? 
            <a href="register.jsp" style="color: var(--primary); font-weight: 700;">Register Now</a>
        </div>
        
    </div>
</div>

<jsp:include page="../layout/footer.jsp"/>
