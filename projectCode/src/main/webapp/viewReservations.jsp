<%@ page import="java.sql.*" %>
<%
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    String username = (String) session.getAttribute("username");
    com.cs336.pkg.ApplicationDB db = new com.cs336.pkg.ApplicationDB();
    Connection conn = db.getConnection();
    PreparedStatement ps = conn.prepareStatement("SELECT id FROM users WHERE username=?");
    ps.setString(1, username);
    ResultSet rs = ps.executeQuery();
    int user_id = -1;
    if (rs.next()) user_id = rs.getInt("id");
    rs.close(); ps.close();


    ps = conn.prepareStatement(
        "SELECT r.reservation_id, s.departure_time, s.arrival_time, r.fare_paid, r.status " +
        "FROM reservations r JOIN schedules s ON r.schedule_id=s.schedule_id " +
        "WHERE r.user_id=? ORDER BY s.departure_time DESC");
    ps.setInt(1, user_id);
    rs = ps.executeQuery();

    out.println("<h2>Your Reservations</h2><table border='1'><tr><th>Departs</th><th>Arrives</th><th>Fare</th><th>Status</th><th>Action</th></tr>");
    while(rs.next()) {
        out.println("<tr>");
        out.println("<td>" + rs.getString("departure_time") + "</td>");
        out.println("<td>" + rs.getString("arrival_time") + "</td>");
        out.println("<td>" + rs.getString("fare_paid") + "</td>");
        out.println("<td>" + rs.getString("status") + "</td>");
        if ("active".equals(rs.getString("status"))) {
            out.println("<td><form action='cancelReservation.jsp' method='post'>" +
                        "<input type='hidden' name='reservation_id' value='" + rs.getInt("reservation_id") + "'>" +
                        "<input type='submit' value='Cancel'></form></td>");
        } else {
            out.println("<td>--</td>");
        }
        out.println("</tr>");
    }
    out.println("</table>");
    rs.close(); ps.close(); conn.close();
%>
<a href="home.jsp">Back to Home</a>
