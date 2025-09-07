<%@ page import="java.sql.*" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    com.cs336.pkg.ApplicationDB db = new com.cs336.pkg.ApplicationDB();
    Connection conn = db.getConnection();
    PreparedStatement ps = conn.prepareStatement("DELETE FROM users WHERE id=? AND role='rep'");
    ps.setInt(1, id);
    ps.executeUpdate();
    ps.close(); conn.close();
    response.sendRedirect("manageReps.jsp");
%>
