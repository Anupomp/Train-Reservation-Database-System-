<%@ page import="java.sql.*" %>
<%@ page import="com.cs336.pkg.*" %>
<%
   
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    ApplicationDB db = new ApplicationDB();
    Connection conn = db.getConnection();
    Statement stmt = conn.createStatement();
    ResultSet rs = stmt.executeQuery("SELECT q.question_text, q.answer_text, u.username FROM questions q JOIN users u ON q.user_id = u.id");

%>
<h2>Browse Questions &amp; Answers</h2>
<table border="1">
    <tr><th>Asked By</th><th>Question</th><th>Answer</th></tr>
    <% while(rs.next()) { %>
        <tr>
            <td><%= rs.getString("username") %></td>
            <td><%= rs.getString("question_text") %></td>
            <td><%= (rs.getString("answer_text") == null) ? "<i>Not answered yet</i>" : rs.getString("answer_text") %></td>
        </tr>
    <% } %>
</table>
<a href="home.jsp">Back to Home</a>
<%
    rs.close();
    stmt.close();
    db.closeConnection(conn);
%>
