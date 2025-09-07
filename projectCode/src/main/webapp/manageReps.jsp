<%@ page import="java.sql.*" %>
<%@ page import="com.cs336.pkg.*" %>
<%
    
    if (!"admin".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Manage Customer Representatives</title>
</head>
<body>
    <h2>Manage Customer Representatives</h2>

    <h3>Add New Customer Rep</h3>
    <form method="post" action="doAddRep.jsp">
        Username: <input type="text" name="username" required><br>
        Password: <input type="password" name="password" required><br>
        <input type="submit" value="Add Rep">
    </form>

    <h3>Existing Customer Representatives</h3>
    <table border="1" cellpadding="4" cellspacing="0">
        <tr><th>Username</th><th>Actions</th></tr>
        <%
            ApplicationDB db = new ApplicationDB();
            Connection conn = db.getConnection();
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT id, username FROM users WHERE role='rep'");

            while (rs.next()) {
        %>
            <tr>
                <td><%= rs.getString("username") %></td>
                <td>
                    <a href="editRep.jsp?id=<%= rs.getInt("id") %>">Edit</a>
                    <a href="doDeleteRep.jsp?id=<%= rs.getInt("id") %>" onclick="return confirm('Are you sure you want to delete this rep?');">Delete</a>
                </td>
            </tr>
        <%
            }
            rs.close();
            stmt.close();
            db.closeConnection(conn);
        %>
    </table>

    <br>
    <a href="adminDashboard.jsp">Back to Admin Dashboard</a>
</body>
</html>
