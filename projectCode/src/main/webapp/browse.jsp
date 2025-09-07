<%@ page import="java.sql.*" %>
<%
    String origin = request.getParameter("origin");
    String destination = request.getParameter("destination");
    String date = request.getParameter("date");

    out.println("<h2>Available Train Schedules</h2>");
    if (origin != null && destination != null && date != null) {
        com.cs336.pkg.ApplicationDB db = new com.cs336.pkg.ApplicationDB();
        Connection conn = db.getConnection();
        String sql = "SELECT s.schedule_id, t.train_number, s.departure_time, s.arrival_time, s.fare " +
                     "FROM schedules s JOIN trains t ON s.train_id = t.train_id " +
                     "WHERE t.origin=? AND t.destination=? AND DATE(s.departure_time)=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, origin);
        ps.setString(2, destination);
        ps.setString(3, date);
        ResultSet rs = ps.executeQuery();

        out.println("<table border='1'><tr><th>Train</th><th>Departs</th><th>Arrives</th><th>Fare</th><th>Action</th></tr>");
        while(rs.next()) {
            out.println("<tr>");
            out.println("<td>" + rs.getString("train_number") + "</td>");
            out.println("<td>" + rs.getString("departure_time") + "</td>");
            out.println("<td>" + rs.getString("arrival_time") + "</td>");
            out.println("<td>" + rs.getString("fare") + "</td>");
            out.println("<td><form action='makeReservation.jsp' method='get'>" +
                        "<input type='hidden' name='schedule_id' value='" + rs.getInt("schedule_id") + "'>" +
                        "<input type='submit' value='Reserve'></form></td>");
            out.println("</tr>");
        }
        out.println("</table>");
        rs.close(); ps.close(); conn.close();
    } else {
        out.println("Please provide search details.");
    }
%>
