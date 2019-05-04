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
	<title>Insert User Result</title>
</head>
<body>
	<!-- Include DB Info File -->
	<%@ include file="./DBInfo.jsp"%>
	<%
	//Initialize Connections
	Connection conn=null;
	Statement stmt=null;
	ResultSet rs=null;
	PreparedStatement query = null;
	int i = 0;
	String result = "";
	//Get data from previous page
	String screenName = request.getParameter("screenName");
	String name = request.getParameter("name");
	String category = request.getParameter("category");
	String sub_category = request.getParameter("sub_category");
	int numFollowers = Integer.parseInt( request.getParameter("numFollowers"));
	int numFollowing = Integer.parseInt( request.getParameter("numFollowing"));
	String ofState = request.getParameter("ofState");

	try{
		//Run Statement
 		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
		stmt = conn.createStatement();
		conn.setAutoCommit(false);
		String insert = "CALL insertUser(?,?,?,?,?,?,?)";
		query = conn.prepareStatement(insert);
		//Set parameters in SQL statement
		query.setString(1, screenName);
		query.setString(2, name);
		query.setString(3, ofState);
		query.setString(4, sub_category);
		query.setInt(5, numFollowing);
		query.setInt(6, numFollowers);
		query.setString(7, category);
		//Execute Query
		rs = query.executeQuery();
		//Format results for table in HTML
		result = "<tr><td>Screen Name</td><td>Username</td><td>Category</td><td>Sub-category</td><td>Number of Followers</td><td>Number of Following</td><td>Location</td></tr><tr><td>" + screenName + "</td><td>" + name + "</td><td>" + category + "</td><td>" + sub_category + "</td><td>" + numFollowers + "</td><td>" + numFollowing + "</td><td>" + ofState + "</td></tr>";
		//Commit Query
		conn.commit();
		//Close connections
		rs.close();
		stmt.close();
		conn.close();
	//Exceptions
	}catch (SQLException e) {

	} catch(NullPointerException e) {

	}

	%>
	<h4>User added successfully</h4>
	<table style="width:100%" border="1"><%=result%></table>

	<form action="selector.jsp">
		<input type="submit" value="BACK" />
	</form>
</body>
</html>