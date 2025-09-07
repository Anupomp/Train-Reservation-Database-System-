<%@ page import="java.sql.*" %>
<%@ page import="com.cs336.pkg.*" %>
<%
    
    String role = (String) session.getAttribute("role");
    if (role == null || (!"rep".equals(role) && !"admin".equals(role))) {
        response.sendRedirect("login.jsp");
        return;
    }

    int schedule_id = Integer.parseInt(request.getParameter("schedule_id"));
    int train_id = Integer.parseInt(request.getParameter("train_id"));
    String departure_time = request.getParameter("departure_time");
    String arrival_time = request.getParameter("arrival_time");
    double fare = Double.parseDouble(request.getParameter("fare"));

    ApplicationDB db = new ApplicationDB();
    Connection conn = db.getConnection();
    PreparedStatement ps = conn.prepareStatement(
        "UPDATE schedules SET train_id=?, departure_time=?, arrival_time=?, fare=? WHERE schedule_id=?"
    );
    ps.setInt(1, train_id);
    ps.setString(2, departure_time);
    ps.setString(3, arrival_time);
    ps.setDouble(4, fare);
    ps.setInt(5, schedule_id);
    ps.executeUpdate();
    ps.close();
    db.closeConnection(conn);

    response.sendRedirect("manageSchedules.jsp");
%>
