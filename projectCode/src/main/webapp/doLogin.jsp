<%@ page import="java.sql.*" %>
<%@ page import="com.cs336.pkg.*" %>
<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    ApplicationDB db = new ApplicationDB();
    Connection conn = db.getConnection();

    PreparedStatement stmt = conn.prepareStatement(
        "SELECT * FROM users WHERE username=? AND password=?"
    );
    stmt.setString(1, username);
    stmt.setString(2, password);

    ResultSet rs = stmt.executeQuery();

    if (rs.next()) {
        
        String role = rs.getString("role"); 
        int userId = rs.getInt("id");       

        session.setAttribute("username", username);
        session.setAttribute("userId", userId);
        session.setAttribute("role", role);

        if ("admin".equalsIgnoreCase(role)) {
            response.sendRedirect("adminDashboard.jsp");
        } else if ("rep".equalsIgnoreCase(role)) {
            response.sendRedirect("repDashboard.jsp"); 
        } else {
            response.sendRedirect("home.jsp");
        }
    } else {
%>
        <p>Invalid username or password. <a href="login.jsp">Try again</a></p>
<%
    }
    rs.close();
    stmt.close();
    db.closeConnection(conn);
%>
