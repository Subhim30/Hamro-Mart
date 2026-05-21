<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.hamromart.entity.User" %>
<%@ page import="com.hamromart.utils.DatabaseConnection" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<%
    User currentUser = (User) session.getAttribute("currentUser");
    if (currentUser == null) {
        session.setAttribute("authError", "Please log in to view your orders.");
        response.sendRedirect(request.getContextPath() + "/auth/login.jsp");
        return;
    }

    List<Map<String, Object>> ordersList = new ArrayList<Map<String, Object>>();
    String sql = "SELECT * FROM orders WHERE user_id = ? ORDER BY id DESC";
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    try {
        conn = DatabaseConnection.getConnection();
        ps = conn.prepareStatement(sql);
        ps.setInt(1, currentUser.getId());
        rs = ps.executeQuery();
        while (rs.next()) {
            Map<String, Object> order = new HashMap<String, Object>();
            order.put("id", rs.getInt("id"));
            order.put("totalAmount", rs.getDouble("total_amount"));
            order.put("status", rs.getString("status"));
            order.put("paymentMethod", rs.getString("payment_method"));
            order.put("createdAt", rs.getTimestamp("created_at"));
            ordersList.add(order);
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) { try { rs.close(); } catch (Exception e) {} }
        if (ps != null) { try { ps.close(); } catch (Exception e) {} }
        if (conn != null) { try { conn.close(); } catch (Exception e) {} }
    }
    request.setAttribute("ordersList", ordersList);
%>

<jsp:include page="../layout/header.jsp"/>

<!-- Clear Cart script on checkoutSuccess -->
<c:if test="${param.checkoutSuccess == 'true'}">
    <script>
        // Clear shopping cart on successful DB check out placement
        localStorage.removeItem('hamromart_cart');
    </script>
</c:if>

<section style="padding: 40px 0;">
    <div class="container" style="max-width: 900px;">
        
        <div style="margin-bottom: 30px;">
            <span style="color: var(--primary); font-weight: 700; font-size: 14px; text-transform: uppercase;">Order History</span>
            <h2 style="font-size: 32px;">Your Grocery Orders</h2>
        </div>

        <c:if test="${not empty sessionScope.success}">
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i> <c:out value="${sessionScope.success}"/>
            </div>
            <% session.removeAttribute("success"); %>
        </c:if>

        <c:choose>
            <c:when test="${empty ordersList}">
                <div style="text-align: center; padding: 60px 24px; background-color: var(--card-bg); border: 1px solid var(--border); border-radius: var(--radius);">
                    <i class="fas fa-receipt" style="font-size: 48px; color: var(--text-muted); margin-bottom: 20px;"></i>
                    <h3>No Orders Yet</h3>
                    <p style="color: var(--text-muted); margin-top: 8px;">You have not placed any orders yet. Visit the shop to purchase organic items!</p>
                    <a href="${pageContext.request.contextPath}/products" class="btn btn-primary" style="margin-top: 24px;">Browse Groceries</a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="table-card">
                    <div class="table-responsive">
                        <table class="admin-table">
                            <thead>
                                <tr>
                                    <th>Order ID</th>
                                    <th>Date Placed</th>
                                    <th>Total Amount</th>
                                    <th>Payment Mode</th>
                                    <th>Status</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="ord" items="${ordersList}">
                                    <tr>
                                        <td style="font-weight: 700; color: var(--primary);">HM-ORD-${ord.id}</td>
                                        <td><c:out value="${ord.createdAt}"/></td>
                                        <td style="font-weight: 700;">Rs. <c:out value="${ord.totalAmount}"/></td>
                                        <td><c:out value="${ord.paymentMethod}"/></td>
                                        <td>
                                            <span class="badge badge-${ord.status.toLowerCase()}">
                                                <c:out value="${ord.status}"/>
                                            </span>
                                        </td>
                                        <td>
                                            <a href="detail.jsp?id=${ord.id}" class="btn btn-secondary" style="padding: 6px 12px; font-size: 12px; border-radius: 8px;">
                                                <i class="fas fa-eye"></i> Details
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</section>

<jsp:include page="../layout/footer.jsp"/>
