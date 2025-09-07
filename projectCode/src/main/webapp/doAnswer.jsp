<%@ page import="java.sql.*, java.time.LocalDateTime" %>
<%
    int q_id = Integer.parseInt(request.getParameter("q_id"));
    String answer_text = request.getParameter("answer_text");
    String rep_username = (String) session.getAttribute("username");
    com.cs336.pkg.ApplicationDB db = new com.cs336.pkg.ApplicationDB();
    Connection conn = db.getConnection();
    PreparedStatement ps = conn.prepareStatement("SELECT id FROM users WHERE username=?");
    ps.setString(1, rep_username);
    ResultSet rs = ps.executeQuery();
    int rep_id = -1;
    if (rs.next()) rep_id = rs.getInt("id");
    rs.close(); ps.close();

    ps = conn.prepareStatement("UPDATE questions SET answer_text=?, answered_by=?, answered_at=? WHERE q_id=?");
    ps.setString(1, answer_text);
    ps.setInt(2, rep_id);
    ps.setTimestamp(3, java.sql.Timestamp.valueOf(LocalDateTime.now()));
    ps.setInt(4, q_id);
    ps.executeUpdate();
    ps.close(); conn.close();
    response.sendRedirect("answerQuestions.jsp");
%>
