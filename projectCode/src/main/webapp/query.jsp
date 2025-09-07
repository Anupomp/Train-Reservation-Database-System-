<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
		List<String> list = new ArrayList<String>();
		try {
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			Statement stmt = con.createStatement();
			String entity = request.getParameter("price");
			String str = "SELECT * FROM sells WHERE price <= " + entity;
			ResultSet result = stmt.executeQuery(str);

			out.print("<table>");
			out.print("<tr>");
			out.print("<td>");
			out.print("bar");
			out.print("</td>");
			out.print("<td>");
			out.print("beer");
			out.print("</td>");
			out.print("<td>");
			out.print("price");
			out.print("</td>");
			out.print("</tr>");

			while (result.next()) {
				out.print("<tr>");
				out.print("<td>");
				out.print(result.getString("bar"));
				out.print("</td>");
				out.print("<td>");
				out.print(result.getString("beer"));
				out.print("</td>");
				out.print("<td>");
				out.print(result.getString("price"));
				out.print("</td>");
				out.print("</tr>");
			}
			out.print("</table>");
			con.close();
		} catch (Exception e) {
		}
	%>
</body>
</html>
