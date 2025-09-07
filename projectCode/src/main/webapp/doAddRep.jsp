<%@ page import="java.sql.*" %>
<%@ page import="com.cs336.pkg.*" %>
<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String role = "rep"; 

    ApplicationDB db = new ApplicationDB();
    Connection conn = db.getConnection();

    PreparedStatement stmt = conn.prepareStatement("INSERT INTO users (username, password, role) VALUES (?, ?, ?)");
    stmt.setString(1, username);
    stmt.setString(2, password);
    stmt.setString(3, role);
    stmt.executeUpdate();

    stmt.close();
    db.closeConnection(conn);
    response.sendRedirect("manageReps.jsp");
%>
