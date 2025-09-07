<%@ page import="java.sql.*" %>
<%
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<h2>Ask a Question</h2>
<form method="post" action="doAskQuestion.jsp">
    Your Question: <input type="text" name="question_text" required size="60"><br>
    <input type="submit" value="Submit Question">
</form>
<a href="home.jsp">Back to Home</a>
