<%@ page import="java.sql.*" %>
<%@ page import="com.cs336.pkg.*" %>
<%
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String keyword = request.getParameter("keyword");
%>
<h2>Search Questions</h2>
<form method="get" action="searchQuestions.jsp">
    Search for: <input type="text" name="keyword" value="<%= (keyword!=null ? keyword : "") %>">
    <input type="submit" value="Search">
</form>

<%
    if (keyword != null && !keyword.trim().isEmpty()) {
        ApplicationDB db = new ApplicationDB();
        Connection conn = db.getConnection();
        PreparedStatement ps = conn.prepareStatement(
            "SELECT q.question_text, q.answer_text, u.username FROM questions q JOIN users u ON q.user_id = u.id WHERE q.question_text LIKE ?"
        );
        ps.setString(1, "%" + keyword + "%");
        ResultSet rs = ps.executeQuery();
%>
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
<%
        rs.close(); ps.close(); db.closeConnection(conn);
    }
%>
<a href="home.jsp">Back to Home</a>
