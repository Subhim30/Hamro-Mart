<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!-- Footer Section -->
    <footer class="footer">
        <div class="container">
            <div class="footer-grid">
                <div class="footer-col">
                    <div class="footer-logo">
                        <i class="fas fa-shopping-basket"></i> Hamro<span>Mart</span>
                    </div>
                    <p style="margin-bottom: 24px; line-height: 1.8;">
                        Your neighborhood premium grocery partner delivering fresh organic vegetables, farm-sourced dairy, rich meat, and crispy bakery items straight to your doorstep.
                    </p>
                    <div style="display: flex; gap: 16px;">
                        <a href="#" class="btn btn-icon" style="background-color: #1e293b; border-color: #334155; color: #ffffff;"><i class="fab fa-facebook-f"></i></a>
                        <a href="#" class="btn btn-icon" style="background-color: #1e293b; border-color: #334155; color: #ffffff;"><i class="fab fa-twitter"></i></a>
                        <a href="#" class="btn btn-icon" style="background-color: #1e293b; border-color: #334155; color: #ffffff;"><i class="fab fa-instagram"></i></a>
                    </div>
                </div>
                
                <div class="footer-col">
                    <h4>Quick Links</h4>
                    <ul class="footer-links">
                        <li><a href="${pageContext.request.contextPath}/index.jsp">Home</a></li>
                        <li><a href="${pageContext.request.contextPath}/products">Shop Catalog</a></li>
                        <li><a href="${pageContext.request.contextPath}/about.jsp">About Us</a></li>
                        <li><a href="${pageContext.request.contextPath}/contact.jsp">Get in Touch</a></li>
                    </ul>
                </div>
                
                <div class="footer-col">
                    <h4>Popular Categories</h4>
                    <ul class="footer-links">
                        <li><a href="${pageContext.request.contextPath}/products?category=1">Fruits & Vegetables</a></li>
                        <li><a href="${pageContext.request.contextPath}/products?category=2">Dairy & Eggs</a></li>
                        <li><a href="${pageContext.request.contextPath}/products?category=3">Bakery & Bread</a></li>
                        <li><a href="${pageContext.request.contextPath}/products?category=5">Meat & Seafood</a></li>
                    </ul>
                </div>
                
                <div class="footer-col">
                    <h4>Contact Info</h4>
                    <ul class="footer-links" style="color: #94a3b8;">
                        <li style="display: flex; gap: 10px; align-items: flex-start; margin-bottom: 12px;">
                            <i class="fas fa-map-marker-alt" style="color: var(--primary); margin-top: 4px;"></i>
                            <span>Kathmandu, Nepal</span>
                        </li>
                        <li style="display: flex; gap: 10px; align-items: flex-start; margin-bottom: 12px;">
                            <i class="fas fa-phone-alt" style="color: var(--primary); margin-top: 4px;"></i>
                            <span>+977-9801234567</span>
                        </li>
                        <li style="display: flex; gap: 10px; align-items: flex-start; margin-bottom: 12px;">
                            <i class="fas fa-envelope" style="color: var(--primary); margin-top: 4px;"></i>
                            <span>support@hamromart.com</span>
                        </li>
                    </ul>
                </div>
            </div>
            
            <div class="footer-bottom">
                <p>&copy; 2026 Hamromart Grocery. Developed with premium details.</p>
                <div style="display: flex; gap: 20px;">
                    <a href="#" style="font-size: 13px;">Privacy Policy</a>
                    <a href="#" style="font-size: 13px;">Terms of Service</a>
                </div>
            </div>
        </div>
    </footer>

    <!-- Custom JavaScript -->
    <script src="${pageContext.request.contextPath}/static/js/main.js"></script>
</body>
</html>
