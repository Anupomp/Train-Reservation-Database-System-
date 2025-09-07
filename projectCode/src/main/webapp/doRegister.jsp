<%@ page import="java.sql.*" %>
<%
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String role = request.getParameter("role");

    com.cs336.pkg.ApplicationDB db = new com.cs336.pkg.ApplicationDB();
    Connection conn = db.getConnection();

    PreparedStatement check = conn.prepareStatement("SELECT * FROM users WHERE username=?");
    check.setString(1, username);
    ResultSet rs = check.executeQuery();

    if (rs.next()) {
        out.println("Username already exists. <a href='register.jsp'>Try again</a>");
    } else {
        PreparedStatement ps = conn.prepareStatement(
            "INSERT INTO users (username, password, role) VALUES (?, ?, ?)"
        );
        ps.setString(1, username);
        ps.setString(2, password);
        ps.setString(3, role);
        ps.executeUpdate();
        out.println("Registration successful! <a href='login.jsp'>Login</a>");
        ps.close();
    }
    rs.close();
    check.close();
    conn.close();
%>
