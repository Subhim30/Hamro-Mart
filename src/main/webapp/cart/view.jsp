<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<jsp:include page="../layout/header.jsp"/>

<section style="padding: 40px 0;">
    <div class="container">
        
        <div>
            <span style="color: var(--primary); font-weight: 700; font-size: 14px; text-transform: uppercase;">Shopping Basket</span>
            <h2 style="font-size: 32px; margin-bottom: 20px;">Your Grocery Cart</h2>
        </div>

        <c:if test="${not empty sessionScope.error}">
            <div class="alert alert-danger">
                <c:out value="${sessionScope.error}"/>
            </div>
            <% session.removeAttribute("error"); %>
        </c:if>

        <div class="cart-grid">
            <!-- Left: Cart Items container (populated dynamically by main.js) -->
            <div id="cart-items-container" class="cart-items-card">
                <!-- Fallback/Loading -->
                <div style="text-align: center; padding: 40px;">
                    <i class="fas fa-spinner fa-spin" style="font-size: 32px; color: var(--primary); margin-bottom: 16px;"></i>
                    <p>Loading your fresh basket...</p>
                </div>
            </div>
            
            <!-- Right: Order Summary & Checkout Form -->
            <div id="cart-summary-container" style="display: none;">
                <div style="background-color: var(--card-bg); border: 1px solid var(--border); border-radius: var(--radius); padding: 30px; box-shadow: var(--shadow-md); position: sticky; top: 100px;">
                    <h3 style="font-size: 20px; border-bottom: 1px solid var(--border); padding-bottom: 16px; margin-bottom: 20px;">Order Summary</h3>
                    
                    <div style="display: flex; flex-direction: column; gap: 14px; margin-bottom: 20px; font-size: 14px; font-weight: 600;">
                        <div style="display: flex; justify-content: space-between;">
                            <span style="color: var(--text-muted);">Basket Subtotal</span>
                            <span id="summary-subtotal">Rs. 0.00</span>
                        </div>
                        <div style="display: flex; justify-content: space-between;">
                            <span style="color: var(--text-muted);">Delivery Charge</span>
                            <span id="summary-delivery">Rs. 0.00</span>
                        </div>
                        <div style="font-size: 12px; color: var(--text-muted); margin-top: -6px;">
                            (FREE delivery on orders above Rs. 1000)
                        </div>
                        <div style="display: flex; justify-content: space-between; border-top: 1px dashed var(--border); padding-top: 14px; font-size: 18px; font-weight: 800; color: var(--secondary);">
                            <span>Total Amount</span>
                            <span id="summary-total" style="color: var(--primary);">Rs. 0.00</span>
                        </div>
                    </div>
                    
                    <!-- Checkout details form -->
                    <form action="${pageContext.request.contextPath}/cart/checkout" method="POST" style="display: flex; flex-direction: column; gap: 16px;">
                        <!-- Hidden inputs for LocalStorage payload sync -->
                        <input type="hidden" id="checkout-items-json" name="itemsJson">
                        <input type="hidden" id="checkout-total" name="totalAmount">

                        <h4 style="font-size: 14px; font-weight: 700; text-transform: uppercase; border-top: 1px solid var(--border); padding-top: 20px; margin-bottom: 4px;">Delivery details</h4>
                        
                        <c:choose>
                            <c:when test="${not empty sessionScope.currentUser}">
                                <c:choose>
                                    <c:when test="${sessionScope.currentUser.role == 'ADMIN'}">
                                        <div style="background-color: #fee2e2; color: #b91c1c; padding: 20px; border-radius: var(--radius); font-size: 14px; font-weight: 600; text-align: center; border: 1px solid rgba(185, 28, 28, 0.2); line-height: 1.6;">
                                            <i class="fas fa-exclamation-triangle" style="font-size: 24px; color: #ef4444; margin-bottom: 10px; display: block;"></i>
                                            You are signed in as an <strong>Administrator</strong>.<br>
                                            Admins cannot place grocery orders. Please <a href="${pageContext.request.contextPath}/auth/login.jsp" style="text-decoration: underline; font-weight: 800; color: #b91c1c;">Log In as Customer</a>.
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="form-group" style="margin-bottom: 0;">
                                            <label class="form-label" for="chk-phone">Contact Phone</label>
                                            <input type="text" id="chk-phone" name="phone" class="form-control" value="<c:out value="${sessionScope.currentUser.phone}"/>" placeholder="e.g. 9812345678" required>
                                        </div>
                                        <div class="form-group" style="margin-bottom: 0;">
                                            <label class="form-label" for="chk-address">Shipping Address</label>
                                            <input type="text" id="chk-address" name="address" class="form-control" value="<c:out value="${sessionScope.currentUser.address}"/>" placeholder="e.g. Lalitpur, Nepal" required>
                                        </div>
                                        <div class="form-group" style="margin-bottom: 0;">
                                            <label class="form-label" for="chk-payment">Payment Method</label>
                                            <select id="chk-payment" name="paymentMethod" class="form-control" style="cursor: pointer;">
                                                <option value="COD">Cash on Delivery (COD)</option>
                                                <option value="CARD">Debit / Credit Card</option>
                                                <option value="ESEWA">eSewa Mobile Wallet</option>
                                            </select>
                                        </div>
                                        
                                        <button type="submit" class="btn btn-primary" style="width: 100%; padding: 14px; margin-top: 10px;">
                                            <i class="fas fa-shopping-basket"></i> Place Order
                                        </button>
                                    </c:otherwise>
                                </c:choose>
                            </c:when>
                            <c:otherwise>
                                <div style="background-color: var(--primary-light); color: var(--primary); padding: 16px; border-radius: var(--radius); font-size: 13px; font-weight: 600; text-align: center;">
                                    Please <a href="../auth/login.jsp" style="text-decoration: underline; font-weight: 800;">Log In</a> to checkout and place your grocery order.
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </form>
                </div>
            </div>
        </div>
    </div>
</section>

<jsp:include page="../layout/footer.jsp"/>
