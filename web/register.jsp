<%-- 
    Document   : register
    Created on : 6 Apr, 2024, 8:51:15 PM
    Author     : indumathi_20
--%>

<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%-- JSP scriptlet to process form data --%>
<%
    Class.forName("oracle.jdbc.driver.OracleDriver");
    String yourName = request.getParameter("yourname");
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    String rePassword = request.getParameter("repassword");

    // Check if the password and re-entered password match
    if (!password.equals(rePassword)) {
        out.print("Passwords do not match");
    } else {
        // If passwords match, proceed with database operations
        Connection con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "system", "welcome");
        PreparedStatement ps = con.prepareStatement("INSERT INTO register VALUES (?, ?, ?, ?)");
        ps.setString(1, yourName);
        ps.setString(2, email);
        ps.setString(3, password);
        ps.setString(4, rePassword);
        
        // Execute the query
        int rowsAffected = ps.executeUpdate();
        
        // Check if the registration was successful
        if (rowsAffected > 0) {
            // If registration is successful, redirect to login page
            response.sendRedirect("login.html");
        } else {
            // If registration fails, display an error message
            out.print("Error: Registration failed");
        }
        
        // Close resources
        ps.close();
        con.close();
    }
%>
