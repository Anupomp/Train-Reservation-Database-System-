<%@ page import="java.sql.*" %>
<%@ page import="com.cs336.pkg.*" %>

<form method="get">
    Train Number: <input type="text" name="train_number" required>
    Date: <input type="date" name="date" required>
    <input type="submit" value="Search">
</form>
<%
    String train_number = request.getParameter("train_number");
    String date = request.getParameter("date");
    if (train_number != null && date != null) {
        com.cs336.pkg.ApplicationDB db = new com.cs336.pkg.ApplicationDB();
        Connection conn = db.getConnection();
        String sql = "SELECT DISTINCT u.username FROM reservations r JOIN schedules s ON r.schedule_id=s.schedule_id JOIN trains t ON s.train_id=t.train_id JOIN users u ON r.user_id=u.id WHERE t.train_number=? AND DATE(s.departure_time)=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, train_number);
        ps.setString(2, date);
        ResultSet rs = ps.executeQuery();
%>
<h3>Customers on <%=train_number%> for <%=date%></h3>
<ul>
<%
        while(rs.next()) {
            out.println("<li>"+rs.getString("username")+"</li>");
        }
        rs.close(); ps.close(); conn.close();
    }
%>
</ul>
