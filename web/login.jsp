<%-- 
    Document   : login
    Created on : 6 Apr, 2024, 11:50:05 PM
    Author     : indumathi_20
--%>

<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%-- JSP scriptlet to process form data --%>
<%
    Class.forName("oracle.jdbc.driver.OracleDriver");
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "system", "welcome");
    PreparedStatement ps = con.prepareStatement("SELECT * FROM register WHERE email = ? AND password = ?");
    ps.setString(1, email);
    ps.setString(2, password);
    ResultSet rs = ps.executeQuery();
    if (rs.next()) {
        // If a record is found with the provided email and password, login is successful
        response.sendRedirect("welcome.html");
    } else {
        // If no matching record is found, login fails
        out.print("Invalid email or password");
    }
    // Close ResultSet, PreparedStatement, and Connection
    rs.close();
    ps.close();
    con.close();
%>
