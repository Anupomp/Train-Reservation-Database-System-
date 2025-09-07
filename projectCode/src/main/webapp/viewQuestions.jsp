String sql = "SELECT question_text, answer_text FROM questions";
String keyword = request.getParameter("keyword");
if (keyword != null && !keyword.isEmpty()) {
    sql += " WHERE question_text LIKE ?";
    PreparedStatement ps = conn.prepareStatement(sql);
    ps.setString(1, "%" + keyword + "%");
    rs = ps.executeQuery();
} else {
    rs = conn.createStatement().executeQuery(sql);
}
