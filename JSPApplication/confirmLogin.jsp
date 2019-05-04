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

<!DOCTYPE html>
<html>
<head>
	<title>Confirm Login</title>
</head>
<body>
	<%@ include file="./DBInfo.jsp"%>
	<%
	// Initialization
	Connection conn=null;
	Statement stmt=null;
	ResultSet rs=null;
	PreparedStatement query1 = null;
	String result = "";
	String dUname = "";
	String dPass = "";
	String dRole = "";
	
	// Run query
	try {
		// Run statement
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
		stmt = conn.createStatement();
		// Get usename and password
		String uname = request.getParameter("uname");
		String pass = request.getParameter("pass");
		String role = "";
		conn.setAutoCommit(false);
		String checkUName = "SELECT * FROM group25.webappusers WHERE username = ? AND password = SHA(?)";
		// Add parameters
		query1 = conn.prepareStatement(checkUName);
		query1.setString(1, uname);
		query1.setString(2, pass);
		// Execute query
		rs = query1.executeQuery();
		// Get results and store in new variables
		while(rs.next()){
			dUname = rs.getString(1);
			dPass = rs.getString(2);
			dRole = rs.getString(3);
		}
		// Validation; if empty, not a valid user, could not log in
		if(dPass.equals("") || dUname.equals("") || dRole.equals("") ){ %>
			<h4>Invalid Login, Please try again</h4>
			<a href="index.jsp">Login</a>
	<%  }
		// Validation successful
		else{
			// Set role to enable/disable write privileges
			session.setAttribute("role", dRole);
			conn.commit(); %>	
			<h4>Successfully Logged In</h4>
			<a href="selector.jsp">Click here to view available queries</a>
	<%  }
		rs.close();
		stmt.close();
		conn.close();
	} catch (SQLException e) {
		out.println("An exception occurred: " + e.getMessage());
	} catch(NullPointerException e) {
		out.println("An exception occurred: " + e.getMessage());
	} %>
</body>
</html>