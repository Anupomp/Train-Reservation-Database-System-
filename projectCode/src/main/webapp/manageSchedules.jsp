<%
    if (!"rep".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head><title>Manage Train Schedules</title></head>
<body>
<h2>Manage Train Schedules</h2>
<table border="1">
<tr>
    <th>Schedule ID</th><th>Train #</th><th>Departure</th><th>Arrival</th><th>Fare</th><th>Actions</th>
</tr>
<%
    com.cs336.pkg.ApplicationDB db = new com.cs336.pkg.ApplicationDB();
    java.sql.Connection conn = db.getConnection();
    String sql = "SELECT s.schedule_id, t.train_number, s.departure_time, s.arrival_time, s.fare FROM schedules s JOIN trains t ON s.train_id = t.train_id";
    java.sql.PreparedStatement ps = conn.prepareStatement(sql);
    java.sql.ResultSet rs = ps.executeQuery();
    while(rs.next()) {
%>
<tr>
    <td><%=rs.getInt("schedule_id")%></td>
    <td><%=rs.getString("train_number")%></td>
    <td><%=rs.getString("departure_time")%></td>
    <td><%=rs.getString("arrival_time")%></td>
    <td><%=rs.getDouble("fare")%></td>
    <td>
        <form style="display:inline" action="editSchedule.jsp" method="get">
            <input type="hidden" name="schedule_id" value="<%=rs.getInt("schedule_id")%>">
            <input type="submit" value="Edit">
        </form>
        <form style="display:inline" action="doDeleteSchedule.jsp" method="post">
            <input type="hidden" name="schedule_id" value="<%=rs.getInt("schedule_id")%>">
            <input type="submit" value="Delete">
        </form>
    </td>
</tr>
<%
    }
    rs.close(); ps.close(); conn.close();
%>
</table>
<a href="repDashboard.jsp">Back to Rep Dashboard</a>
</body>
</html>
