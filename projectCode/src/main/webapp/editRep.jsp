<%@ page import="java.sql.*" %>
<%@ page import="com.cs336.pkg.*" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    ApplicationDB db = new ApplicationDB();
    Connection conn = db.getConnection();

    PreparedStatement stmt = conn.prepareStatement("SELECT username, password FROM users WHERE id=?");
    stmt.setInt(1, id);
    ResultSet rs = stmt.executeQuery();
    rs.next();
    String username = rs.getString("username");
    String password = rs.getString("password");
    rs.close(); stmt.close(); db.closeConnection(conn);
%>
<form method="post" action="doEditRep.jsp">
    <input type="hidden" name="id" value="<%=id%>">
    Username: <input type="text" name="username" value="<%=username%>"><br>
    Password: <input type="password" name="password" value="<%=password%>"><br>
    <input type="submit" value="Update Rep">
</form>
