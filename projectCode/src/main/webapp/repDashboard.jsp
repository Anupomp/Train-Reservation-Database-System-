<%@ page import="com.cs336.pkg.*" %>
<%
    
    if (!"rep".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Customer Rep Dashboard</title>
</head>
<body>
    <h2>Customer Representative Dashboard</h2>
    <p>Welcome, <%= session.getAttribute("username") %>!</p>
    <ul>
        <li><a href="answerQuestions.jsp">Answer Customer Questions</a></li>
        <li><a href="editSchedule.jsp">Edit Train Schedules</a></li>
        <li><a href="stationSchedules.jsp">View Train Schedules by Station</a></li>
        <li><a href="customersOnLine.jsp">List Customers on Transit Line by Date</a></li>
        <li><a href="logout.jsp">Logout</a></li>
    </ul>
</body>
</html>
