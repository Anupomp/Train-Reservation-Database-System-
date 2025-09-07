<%
    if (!"admin".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head><title>Admin Dashboard</title></head>
<body>
    <h2>Admin Dashboard</h2>
    <a href="manageReps.jsp">Manage Customer Representatives</a><br>
    <a href="salesReport.jsp">Sales Reports</a><br>
    <a href="reservationReports.jsp">Reservation Reports</a><br>
    <a href="revenueReports.jsp">Revenue Reports</a><br>
    <a href="logout.jsp">Logout</a>
</body>
</html>
