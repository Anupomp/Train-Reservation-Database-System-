<%@ page import="java.sql.*" %>
<%@ page import="com.cs336.pkg.*" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    ApplicationDB db = new ApplicationDB();
    Connection conn = db.getConnection();
    PreparedStatement stmt = conn.prepareStatement("UPDATE users SET username=?, password=? WHERE id=?");
    stmt.setString(1, username);
    stmt.setString(2, password);
    stmt.setInt(3, id);
    stmt.executeUpdate();

    stmt.close();
    db.closeConnection(conn);
    response.sendRedirect("manageReps.jsp");
%>
