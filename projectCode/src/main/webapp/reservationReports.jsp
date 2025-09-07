<%@ page import="java.sql.*" %>
<%
    if (!"admin".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }
    com.cs336.pkg.ApplicationDB db = new com.cs336.pkg.ApplicationDB();
    Connection conn = db.getConnection();

    String sqlLine = "SELECT t.train_number, COUNT(r.reservation_id) AS reservation_count " +
        "FROM reservations r " +
        "JOIN schedules s ON r.schedule_id=s.schedule_id " +
        "JOIN trains t ON s.train_id=t.train_id " +
        "WHERE r.status = 'active' " +
        "GROUP BY t.train_number";
    ResultSet rsLine = conn.createStatement().executeQuery(sqlLine);

    String sqlCust = "SELECT u.username, COUNT(r.reservation_id) AS reservation_count " +
        "FROM reservations r " +
        "JOIN users u ON r.user_id=u.id " +
        "WHERE r.status = 'active' " +
        "GROUP BY u.username";
    ResultSet rsCust = conn.createStatement().executeQuery(sqlCust);
%>
<h2>Reservations by Transit Line</h2>
<table border="1">
<tr><th>Train Number</th><th># Reservations</th></tr>
<% while(rsLine.next()) { %>
<tr>
    <td><%=rsLine.getString("train_number")%></td>
    <td><%=rsLine.getInt("reservation_count")%></td>
</tr>
<% } %>
</table>
<h2>Reservations by Customer Name</h2>
<table border="1">
<tr><th>Username</th><th># Reservations</th></tr>
<% while(rsCust.next()) { %>
<tr>
    <td><%=rsCust.getString("username")%></td>
    <td><%=rsCust.getInt("reservation_count")%></td>
</tr>
<% } %>
</table>
<a href="adminDashboard.jsp">Back to Admin Dashboard</a>
<%
    rsLine.close(); rsCust.close(); conn.close();
%>
