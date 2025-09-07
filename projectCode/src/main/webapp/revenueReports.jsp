<%@ page import="java.sql.*" %>
<%
    if (!"admin".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }
    com.cs336.pkg.ApplicationDB db = new com.cs336.pkg.ApplicationDB();
    Connection conn = db.getConnection();

    String sqlLine = "SELECT t.train_number, SUM(r.fare_paid) AS total_revenue FROM reservations r JOIN schedules s ON r.schedule_id=s.schedule_id JOIN trains t ON s.train_id=t.train_id WHERE r.status='active' GROUP BY t.train_number";
    ResultSet rsLine = conn.createStatement().executeQuery(sqlLine);

    String sqlCust = "SELECT u.username, SUM(r.fare_paid) AS total_revenue FROM reservations r JOIN users u ON r.user_id=u.id WHERE r.status='active' GROUP BY u.username";
    ResultSet rsCust = conn.createStatement().executeQuery(sqlCust);

    String sqlBestCustomer = "SELECT u.username, SUM(r.fare_paid) AS total_revenue FROM reservations r JOIN users u ON r.user_id=u.id WHERE r.status='active' GROUP BY u.username ORDER BY total_revenue DESC LIMIT 1";
    ResultSet rsBest = conn.createStatement().executeQuery(sqlBestCustomer);

    String sqlTop5Lines = "SELECT t.train_number, COUNT(r.reservation_id) AS reservation_count FROM reservations r JOIN schedules s ON r.schedule_id=s.schedule_id JOIN trains t ON s.train_id=t.train_id WHERE r.status='active' GROUP BY t.train_number ORDER BY reservation_count DESC LIMIT 5";
    ResultSet rsTop = conn.createStatement().executeQuery(sqlTop5Lines);
%>
<h2>Revenue per Transit Line</h2>
<table border="1">
<tr><th>Train Number</th><th>Total Revenue</th></tr>
<% while(rsLine.next()) { %>
<tr>
    <td><%=rsLine.getString("train_number")%></td>
    <td><%=rsLine.getDouble("total_revenue")%></td>
</tr>
<% } %>
</table>
<h2>Revenue per Customer Name</h2>
<table border="1">
<tr><th>Username</th><th>Total Revenue</th></tr>
<% while(rsCust.next()) { %>
<tr>
    <td><%=rsCust.getString("username")%></td>
    <td><%=rsCust.getDouble("total_revenue")%></td>
</tr>
<% } %>
</table>
<h2>Best Customer</h2>
<table border="1">
<tr><th>Username</th><th>Total Revenue</th></tr>
<% if(rsBest.next()) { %>
<tr>
    <td><%=rsBest.getString("username")%></td>
    <td><%=rsBest.getDouble("total_revenue")%></td>
</tr>
<% } %>
</table>
<h2>Top 5 Most Active Transit Lines</h2>
<table border="1">
<tr><th>Train Number</th><th># Reservations</th></tr>
<% while(rsTop.next()) { %>
<tr>
    <td><%=rsTop.getString("train_number")%></td>
    <td><%=rsTop.getInt("reservation_count")%></td>
</tr>
<% } %>
</table>
<a href="adminDashboard.jsp">Back to Admin Dashboard</a>
<%
    rsLine.close(); rsCust.close(); rsBest.close(); rsTop.close(); conn.close();
%>
