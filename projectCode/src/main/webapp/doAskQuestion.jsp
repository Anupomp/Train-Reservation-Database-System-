<%@ page import="java.sql.*" %>
<%@ page import="com.cs336.pkg.*" %>
<%
    String question = request.getParameter("question_text");
    int user_id = (Integer) session.getAttribute("userId");

    ApplicationDB db = new ApplicationDB();
    Connection conn = db.getConnection();
    PreparedStatement ps = conn.prepareStatement(
        "INSERT INTO questions (user_id, question_text, asked_at) VALUES (?, ?, NOW())"
    );
    ps.setInt(1, user_id);
    ps.setString(2, question);
    ps.executeUpdate();

    ps.close(); db.closeConnection(conn);

    response.sendRedirect("browseQuestions.jsp");
%>
