<%@ page import="java.sql.*" %>
<%
    int reservation_id = Integer.parseInt(request.getParameter("reservation_id"));
    com.cs336.pkg.ApplicationDB db = new com.cs336.pkg.ApplicationDB();
    Connection conn = db.getConnection();
    PreparedStatement ps = conn.prepareStatement("UPDATE reservations SET status='cancelled' WHERE reservation_id=?");
    ps.setInt(1, reservation_id);
    ps.executeUpdate();
    ps.close(); conn.close();
    response.sendRedirect("viewReservations.jsp");
%>
