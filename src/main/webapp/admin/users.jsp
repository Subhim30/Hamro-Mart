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

    List<Map<String, Object>> usersList = new ArrayList<Map<String, Object>>();

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        conn = DatabaseConnection.getConnection();
        String userSql = "SELECT * FROM users ORDER BY id DESC";
        ps = conn.prepareStatement(userSql);
        rs = ps.executeQuery();
        while (rs.next()) {
            Map<String, Object> userRec = new HashMap<String, Object>();
            userRec.put("id", rs.getInt("id"));
            userRec.put("name", rs.getString("name"));
            userRec.put("email", rs.getString("email"));
            userRec.put("role", rs.getString("role"));
            userRec.put("phone", rs.getString("phone"));
            userRec.put("address", rs.getString("address"));
            userRec.put("createdAt", rs.getTimestamp("created_at"));
            usersList.add(userRec);
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) { try { rs.close(); } catch (SQLException e) {} }
        if (ps != null) { try { ps.close(); } catch (SQLException e) {} }
        if (conn != null) { try { conn.close(); } catch (SQLException e) {} }
    }

    request.setAttribute("users", usersList);
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
            <li class="sidebar-item">
                <a href="${pageContext.request.contextPath}/admin/orders.jsp"><i class="fas fa-shopping-bag"></i> Orders</a>
            </li>
            <li class="sidebar-item active">
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
                <h2 style="font-size: 32px;">Registered Accounts</h2>
                <p style="color: var(--text-muted);">Overview of registered customers and administrators</p>
            </div>
        </div>

        <!-- Users Table -->
        <div class="table-card">
            <div class="table-responsive">
                <table class="admin-table">
                    <thead>
                        <tr>
                            <th>User ID</th>
                            <th>Name</th>
                            <th>Email Address</th>
                            <th>Role</th>
                            <th>Phone</th>
                            <th>Delivery Address</th>
                            <th>Registration Date</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="usr" items="${users}">
                            <tr>
                                <td style="font-weight: 700; color: var(--primary);">HM-USR-${usr.id}</td>
                                <td style="font-weight: 700;"><c:out value="${usr.name}"/></td>
                                <td><c:out value="${usr.email}"/></td>
                                <td>
                                    <span class="badge badge-${usr.role.toLowerCase()}">
                                        <c:out value="${usr.role}"/>
                                    </span>
                                </td>
                                <td><c:out value="${usr.phone}"/></td>
                                <td><c:out value="${usr.address}"/></td>
                                <td style="font-size: 13px; color: var(--text-muted);"><c:out value="${usr.createdAt}"/></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </main>
</div>

<jsp:include page="../layout/footer.jsp"/>
