<%
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head><title>Home</title></head>
<body>
    <h2>Welcome, <%= session.getAttribute("username") %>!</h2>
    <p>Your role: <%= session.getAttribute("role") %></p>
    <a href="search.jsp">Search Trains</a><br>
    <a href="viewReservations.jsp">View Reservations</a><br>
	<a href="browseQuestions.jsp">Browse Questions &amp; Answers</a><br>
	<a href="searchQuestions.jsp">Search Questions</a><br>
	<a href="askQuestion.jsp">Ask a Question</a><br>
    
    <a href="logout.jsp">Logout</a>
</body>
</html>
