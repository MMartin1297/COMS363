<!-- @author Matthew Martin
     @author Travis Stanger
-->

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Arrays"%>
<%@ page import="java.util.List"%>

<!DOCTYPE html>
<html>
<head>
	<title>Add Web App User</title>
</head>
<body>
	<%@ include file="./DBInfo.jsp"%>
	<%
	// Initialization
	Connection conn=null;
	Statement stmt=null;
	ResultSet rs=null;
	ResultSet rs2=null;
	PreparedStatement query1 = null;
	PreparedStatement query2 = null;
	String result = "";

	// Get username, password, and role
	String uname = request.getParameter("uname");
	String pass = request.getParameter("pass");
	String role =request.getParameter("role");

	//Check for password complexity
	List<String> commonPassword = Arrays.asList("123456", "password", "123456789", "12345678", "12345", "111111", "1234567", "sunshine", "qwerty", "iloveyou", "princess", "admin", "welcome", "666666", "abc123", "football", "123123", "monkey", "654321", "!@#$%^&*", "charlie", "aa123456", "donald", "password1", "qwerty123");
	if(commonPassword.contains(pass)){ %>
		<h4>Password is very weak and one of the top 25 most used. Please enter a different password.</h4>
		<a href="createUser.jsp">Create a User</a><br>
		<a href="index.jsp">Login</a>
		<%
	}
	else{
		// Run query
		try{
			// Run statement
	 		Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
			stmt = conn.createStatement();
			conn.setAutoCommit(false);

			String checkUName = "SELECT username FROM group25.webappusers WHERE username = ?";
			String createUser = "CALL createWebAppUser(?,SHA(?),?)";
			// Add parameters
			query1 = conn.prepareStatement(checkUName);
			query1.setString(1, uname);
			// Execute query
			rs = query1.executeQuery();
			
			// Store results in the result string
			while (rs.next()) {
				result += rs.getString(1);
			}
			
			// Validation; checks to see if username is empty, if not, it aready exists, and new user could not be created
			if(result.equals("") == false){ %>
				<h4>UserName has already been used. Please enter a new UserName.</h4>
				<a href="createUser.jsp">Create a User</a><br>
				<a href="index.jsp">Login</a>
		<%  }
			// Validation successful
			else{
				// Add parameters
				query2 = conn.prepareStatement(createUser);
				query2.setString(1, uname);
				query2.setString(2, pass);
				query2.setString(3, role);
				// Execute query
				rs2 = query2.executeQuery();
				conn.commit(); %>
				<h4>Successfully Created a User. Please Login.</h4>
				<a href="index.jsp">Login</a>
		<%  }
			rs.close();
			stmt.close();
			conn.close();
		} catch (SQLException e) {
			out.println("An exception occurred: " + e.getMessage());
		} catch(NullPointerException e) {
			out.println("An exception occurred: " + e.getMessage());
		}
	} %>
</body>
</html>