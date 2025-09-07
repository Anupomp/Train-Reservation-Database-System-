<%@ page import="java.sql.*" %>
<%@ page import="com.cs336.pkg.*" %>

<form method="get">
    Station: <input type="text" name="station" required>
    <select name="type">
        <option value="origin">Origin</option>
        <option value="destination">Destination</option>
    </select>
    <input type="submit" value="Search">
</form>
<%
    String station = request.getParameter("station");
    String type = request.getParameter("type");
    if (station != null && type != null) {
        com.cs336.pkg.ApplicationDB db = new com.cs336.pkg.ApplicationDB();
        Connection conn = db.getConnection();
        String sql = "SELECT t.train_number, s.departure_time, s.arrival_time FROM schedules s JOIN trains t ON s.train_id=t.train_id WHERE t." + type + "=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, station);
        ResultSet rs = ps.executeQuery();
%>
<table border="1">
<tr><th>Train #</th><th>Departure</th><th>Arrival</th></tr>
<%
        while(rs.next()) {
            out.println("<tr><td>"+rs.getString("train_number")+"</td><td>"+rs.getString("departure_time")+"</td><td>"+rs.getString("arrival_time")+"</td></tr>");
        }
        rs.close(); ps.close(); conn.close();
    }
%>
</table>
