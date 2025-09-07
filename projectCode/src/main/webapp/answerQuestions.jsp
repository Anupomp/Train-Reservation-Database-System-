
<%@ page import="java.sql.*" %>
<%@ page import="com.cs336.pkg.*" %>

<%
    if (!"rep".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<h2>Answer Customer Questions</h2>
<table border="1">
<tr><th>Question</th><th>Your Answer</th></tr>
<%
    com.cs336.pkg.ApplicationDB db = new com.cs336.pkg.ApplicationDB();
    Connection conn = db.getConnection();
    ResultSet rs = conn.createStatement().executeQuery("SELECT q_id, question_text FROM questions WHERE answer_text IS NULL");
    while(rs.next()) {
%>
<tr>
    <td><%=rs.getString("question_text")%></td>
    <td>
        <form action="doAnswer.jsp" method="post">
            <input type="hidden" name="q_id" value="<%=rs.getInt("q_id")%>">
            <input type="text" name="answer_text" required>
            <input type="submit" value="Submit Answer">
        </form>
    </td>
</tr>
<%
    }
    rs.close(); conn.close();
%>
</table>
