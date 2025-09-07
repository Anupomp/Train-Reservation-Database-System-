<%@ page import="java.sql.*" %>
<%@ page import="com.cs336.pkg.*" %>
<%
    int schedule_id = Integer.parseInt(request.getParameter("schedule_id"));
    ApplicationDB db = new ApplicationDB();
    Connection conn = db.getConnection();

    
    PreparedStatement ps1 = conn.prepareStatement("DELETE FROM stops WHERE schedule_id=?");
    ps1.setInt(1, schedule_id);
    ps1.executeUpdate();
    ps1.close();

   
    PreparedStatement ps2 = conn.prepareStatement("DELETE FROM schedules WHERE schedule_id=?");
    ps2.setInt(1, schedule_id);
    ps2.executeUpdate();
    ps2.close();

    conn.close();
    response.sendRedirect("manageSchedules.jsp");
%>
