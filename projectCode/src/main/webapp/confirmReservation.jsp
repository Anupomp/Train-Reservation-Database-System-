<%@ page import="java.sql.*, java.time.LocalDate" %>
<%
    int user_id = Integer.parseInt(request.getParameter("user_id"));
    int schedule_id = Integer.parseInt(request.getParameter("schedule_id"));
    String passenger_type = request.getParameter("passenger_type");

    com.cs336.pkg.ApplicationDB db = new com.cs336.pkg.ApplicationDB();
    Connection conn = db.getConnection();

    
    PreparedStatement ps = conn.prepareStatement("SELECT fare FROM schedules WHERE schedule_id=?");
    ps.setInt(1, schedule_id);
    ResultSet rs = ps.executeQuery();
    double fare = 0;
    if (rs.next()) fare = rs.getDouble("fare");
    rs.close(); ps.close();

    
    double finalFare = fare;
    if ("child".equals(passenger_type)) finalFare = fare * 0.5;
    if ("senior".equals(passenger_type) || "disabled".equals(passenger_type)) finalFare = fare * 0.7;

    
    ps = conn.prepareStatement("INSERT INTO reservations (user_id, schedule_id, reservation_date, fare_paid, passenger_type, status) VALUES (?, ?, ?, ?, ?, ?)");
    ps.setInt(1, user_id);
    ps.setInt(2, schedule_id);
    ps.setDate(3, java.sql.Date.valueOf(LocalDate.now()));
    ps.setDouble(4, finalFare);
    ps.setString(5, passenger_type);
    ps.setString(6, "active");
    ps.executeUpdate();
    ps.close(); conn.close();
%>
Reservation successful! <a href="home.jsp">Back to Home</a>
