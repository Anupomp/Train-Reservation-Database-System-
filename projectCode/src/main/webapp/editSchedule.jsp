<%@ page import="java.sql.*" %>
<%@ page import="com.cs336.pkg.*" %>
<%
    
    String role = (String) session.getAttribute("role");
    if (role == null || (!"rep".equals(role) && !"admin".equals(role))) {
        response.sendRedirect("login.jsp");
        return;
    }

    String scheduleParam = request.getParameter("schedule_id");
    if (scheduleParam == null || scheduleParam.isEmpty()) {
        response.sendRedirect("manageSchedules.jsp");
        return;
    }

    int schedule_id = Integer.parseInt(scheduleParam);

   
    ApplicationDB db = new ApplicationDB();
    Connection conn = db.getConnection();
    PreparedStatement ps = conn.prepareStatement(
        "SELECT * FROM schedules WHERE schedule_id=?"
    );
    ps.setInt(1, schedule_id);
    ResultSet rs = ps.executeQuery();

    if (!rs.next()) {
%>
        <p>Error: Schedule not found. <a href="manageSchedules.jsp">Go back</a></p>
<%
        rs.close(); ps.close(); db.closeConnection(conn);
        return;
    }

    int train_id = rs.getInt("train_id");
    String departure_time = rs.getString("departure_time");
    String arrival_time = rs.getString("arrival_time");
    double fare = rs.getDouble("fare");

    rs.close(); ps.close();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Train Schedule</title>
</head>
<body>
    <h2>Edit Train Schedule</h2>
    <form method="post" action="doEditSchedule.jsp">
        <input type="hidden" name="schedule_id" value="<%=schedule_id%>">
        Train ID: <input type="text" name="train_id" value="<%=train_id%>" required><br>
        Departure Time: <input type="text" name="departure_time" value="<%=departure_time%>" required><br>
        Arrival Time: <input type="text" name="arrival_time" value="<%=arrival_time%>" required><br>
        Fare: <input type="number" name="fare" value="<%=fare%>" step="0.01" required><br>
        <input type="submit" value="Update Schedule">
    </form>
    <br>
    <a href="manageSchedules.jsp">Back to Manage Schedules</a>
</body>
</html>

<%
    db.closeConnection(conn);
%>
