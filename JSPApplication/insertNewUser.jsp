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

<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Insert User</title>
</head>
<body>
	<!-- This page allows user to create a new user. To do so, user must input a screen name, username, category, sub-category, number of followers, number of following, and their location. After hitting submit, moves to resultInsertUser.jsp for verification before creating the new user. -->
	<h3>This query will insert a new user into the database.</h3>
	<form method="post" action="resultInsertUser.jsp">
		<input type = "text" class="param" name="screenName" placeholder= "Screen Name">
		<input type = "text" class="param" name="name" placeholder= "Name">
		<input type = "text" class="param" name="category" placeholder= "Category">
		<input type = "text" class="param" name="sub_category" placeholder= "Sub-Category">
		<input type = "number" class="param" name="numFollowers" placeholder= "Number of followers">
		<input type = "number" class="param" name="numFollowing" placeholder= "Number of following">
		<input type = "text" class="param" name="ofState" placeholder= "State">
	<input type="submit" value="Submit">
	</form>
</body>
</html>