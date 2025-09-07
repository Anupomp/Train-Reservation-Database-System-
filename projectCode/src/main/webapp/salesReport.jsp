<%@ page import="java.sql.*" %>
<%
    if (!"admin".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }
    com.cs336.pkg.ApplicationDB db = new com.cs336.pkg.ApplicationDB();
    Connection conn = db.getConnection();
    String sql = "SELECT YEAR(reservation_date) AS year, MONTH(reservation_date) AS month, SUM(fare_paid) AS total_sales FROM reservations WHERE status='active' GROUP BY year, month ORDER BY year DESC, month DESC";
    PreparedStatement ps = conn.prepareStatement(sql);
    ResultSet rs = ps.executeQuery();
%>
<h2>Sales Reports Per Month</h2>
<table border="1">
    <tr><th>Year</th><th>Month</th><th>Total Sales</th></tr>
    <% while(rs.next()) { %>
    <tr>
        <td><%=rs.getInt("year")%></td>
        <td><%=rs.getInt("month")%></td>
        <td><%=rs.getDouble("total_sales")%></td>
    </tr>
    <% } %>
</table>
<a href="adminDashboard.jsp">Back to Admin Dashboard</a>
<%
    rs.close(); ps.close(); conn.close();
%>
