<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.hamromart.entity.User" %>
<%@ page import="com.hamromart.utils.DatabaseConnection" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<%
    // Security check: Must be ADMIN
    User currentUser = (User) session.getAttribute("currentUser");
    if (currentUser == null || !"ADMIN".equals(currentUser.getRole())) {
        session.setAttribute("authError", "Access denied. Admin privileges required.");
        response.sendRedirect(request.getContextPath() + "/auth/login.jsp");
        return;
    }

    List<Map<String, Object>> ordersList = new ArrayList<Map<String, Object>>();

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        conn = DatabaseConnection.getConnection();
        String orderSql = "SELECT o.*, u.name AS customer_name FROM orders o " +
                          "LEFT JOIN users u ON o.user_id = u.id " +
                          "ORDER BY o.id DESC";
        ps = conn.prepareStatement(orderSql);
        rs = ps.executeQuery();
        while (rs.next()) {
            Map<String, Object> ord = new HashMap<String, Object>();
            ord.put("id", rs.getInt("id"));
            ord.put("customerName", rs.getString("customer_name"));
            ord.put("totalAmount", rs.getDouble("total_amount"));
            ord.put("status", rs.getString("status"));
            ord.put("paymentMethod", rs.getString("payment_method"));
            ord.put("phone", rs.getString("phone"));
            ord.put("address", rs.getString("address"));
            ord.put("createdAt", rs.getTimestamp("created_at"));
            ordersList.add(ord);
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) { try { rs.close(); } catch (SQLException e) {} }
        if (ps != null) { try { ps.close(); } catch (SQLException e) {} }
        if (conn != null) { try { conn.close(); } catch (SQLException e) {} }
    }

    request.setAttribute("orders", ordersList);
%>

<jsp:include page="../layout/header.jsp"/>

<div class="admin-layout">
    <!-- Sidebar -->
    <aside class="sidebar">
        <div style="margin-bottom: 30px; text-align: center;">
            <div style="width: 70px; height: 70px; border-radius: 50%; background-color: var(--primary-light); color: var(--primary); display: flex; align-items: center; justify-content: center; font-size: 32px; margin: 0 auto 12px auto; border: 2px solid var(--primary);">
                <i class="fas fa-user-shield"></i>
            </div>
            <h4 style="font-size: 16px;"><c:out value="${sessionScope.currentUser.name}"/></h4>
            <span class="badge badge-admin" style="margin-top: 6px;">Administrator</span>
        </div>
        
        <ul class="sidebar-menu">
            <li class="sidebar-item">
                <a href="${pageContext.request.contextPath}/admin/dashboard.jsp"><i class="fas fa-chart-pie"></i> Overview</a>
            </li>
            <li class="sidebar-item">
                <a href="${pageContext.request.contextPath}/admin/products.jsp"><i class="fas fa-boxes"></i> Products</a>
            </li>
            <li class="sidebar-item active">
                <a href="${pageContext.request.contextPath}/admin/orders.jsp"><i class="fas fa-shopping-bag"></i> Orders</a>
            </li>
            <li class="sidebar-item">
                <a href="${pageContext.request.contextPath}/admin/users.jsp"><i class="fas fa-users"></i> Customers</a>
            </li>
            <li class="sidebar-item">
                <a href="${pageContext.request.contextPath}/admin/messages.jsp"><i class="fas fa-envelope-open-text"></i> Messages</a>
            </li>
        </ul>
    </aside>

    <!-- Main Content -->
    <main class="admin-main">
        
        <div class="admin-header">
            <div>
                <h2 style="font-size: 32px;">Manage Customer Purchases</h2>
                <p style="color: var(--text-muted);">View details, approve shipments, or process delivery updates</p>
            </div>
        </div>

        <!-- Alerts -->
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

        <!-- Orders Table -->
        <div class="table-card">
            <div class="table-responsive">
                <table class="admin-table">
                    <thead>
                        <tr>
                            <th>Order ID</th>
                            <th>Customer</th>
                            <th>Bill Total</th>
                            <th>Address / Phone</th>
                            <th>Payment</th>
                            <th>Status</th>
                            <th>Date Placed</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="ord" items="${orders}">
                            <tr>
                                <td style="font-weight: 700; color: var(--primary);">HM-ORD-${ord.id}</td>
                                <td style="font-weight: 700;"><c:out value="${ord.customerName}"/></td>
                                <td style="font-weight: 800; color: var(--secondary);">Rs. <c:out value="${ord.totalAmount}"/></td>
                                <td style="font-size: 13px;">
                                    <div><c:out value="${ord.address}"/></div>
                                    <div style="color: var(--text-muted); font-weight: 600; margin-top: 4px;"><i class="fas fa-phone-alt"></i> <c:out value="${ord.phone}"/></div>
                                </td>
                                <td><span class="badge badge-admin"><c:out value="${ord.paymentMethod}"/></span></td>
                                <td>
                                    <span class="badge badge-${ord.status.toLowerCase()}">
                                        <c:out value="${ord.status}"/>
                                    </span>
                                </td>
                                <td style="font-size: 12px; color: var(--text-muted);"><c:out value="${ord.createdAt}"/></td>
                                <td>
                                    <div style="display: flex; gap: 6px;">
                                        <c:if test="${ord.status == 'PENDING'}">
                                            <a href="${pageContext.request.contextPath}/admin/orders/status?id=${ord.id}&status=DELIVERED" class="btn btn-secondary" style="padding: 6px 10px; font-size: 12px; border-radius: 8px; color: #059669; border-color: rgba(5, 150, 105, 0.2);">
                                                <i class="fas fa-check"></i> Deliver
                                            </a>
                                            <a href="${pageContext.request.contextPath}/admin/orders/status?id=${ord.id}&status=CANCELLED" class="btn btn-secondary" style="padding: 6px 10px; font-size: 12px; border-radius: 8px; color: #ef4444; border-color: rgba(239, 68, 68, 0.2);">
                                                <i class="fas fa-times"></i> Cancel
                                            </a>
                                        </c:if>
                                        <c:if test="${ord.status != 'PENDING'}">
                                            <span style="font-size: 12px; font-weight: 600; color: var(--text-muted);"><i class="fas fa-lock"></i> Processed</span>
                                        </c:if>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </main>
</div>

<jsp:include page="../layout/footer.jsp"/>
