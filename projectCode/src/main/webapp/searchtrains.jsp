<%@ page import="java.sql.*" %>
<%@ page import="com.cs336.pkg.*" %>
<%
    ApplicationDB db = new ApplicationDB();
    Connection conn = db.getConnection();

    Statement stmtOrigin = conn.createStatement();
    ResultSet origins = stmtOrigin.executeQuery("SELECT DISTINCT origin FROM trains");

    Statement stmtDest = conn.createStatement();
    ResultSet destinations = stmtDest.executeQuery("SELECT DISTINCT destination FROM trains");
%>

<form method="get" action="searchResults.jsp">
    Origin:
    <select name="origin">
        <%
        boolean hasOrigin = false;
        while (origins.next()) {
            hasOrigin = true;
            String origin = origins.getString("origin");
        %>
            <option value="<%=origin%>"><%=origin%></option>
        <%
        }
        if (!hasOrigin) {
        %>
            <option value="">No origins available</option>
        <%
        }
        %>
    </select>

    Destination:
    <select name="destination">
        <%
        boolean hasDest = false;
        while (destinations.next()) {
            hasDest = true;
            String dest = destinations.getString("destination");
        %>
            <option value="<%=dest%>"><%=dest%></option>
        <%
        }
        if (!hasDest) {
        %>
            <option value="">No destinations available</option>
        <%
        }
        %>
    </select>

    <input type="submit" value="Search">
</form>

<%
    origins.close();
    stmtOrigin.close();
    destinations.close();
    stmtDest.close();
    db.closeConnection(conn);
%>
