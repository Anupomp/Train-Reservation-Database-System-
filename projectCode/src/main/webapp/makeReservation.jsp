<%@ page import="java.sql.*, javax.servlet.http.*" %>
<%
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String schedule_id = request.getParameter("schedule_id");
    String username = (String) session.getAttribute("username");

    com.cs336.pkg.ApplicationDB db = new com.cs336.pkg.ApplicationDB();
    Connection conn = db.getConnection();
    PreparedStatement ps = conn.prepareStatement("SELECT id FROM users WHERE username=?");
    ps.setString(1, username);
    ResultSet rs = ps.executeQuery();
    int user_id = -1;
    if (rs.next()) user_id = rs.getInt("id");
    rs.close(); ps.close();

%>
<html>
<head><title>Book Reservation</title></head>
<body>
    <h2>Confirm Reservation</h2>
    <form method="post" action="confirmReservation.jsp">
        <input type="hidden" name="user_id" value="<%=user_id%>">
        <input type="hidden" name="schedule_id" value="<%=schedule_id%>">
        Passenger Type:
        <select name="passenger_type" required>
            <option value="adult">Adult</option>
            <option value="child">Child</option>
            <option value="senior">Senior</option>
            <option value="disabled">Disabled</option>
        </select>
        <input type="submit" value="Book">
    </form>
    <a href="browse.jsp">Back to Search</a>
</body>
</html>
<%
    conn.close();
%>
