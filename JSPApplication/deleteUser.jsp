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
	<title>Delete User</title>
</head>
<body>
	<!-- Instructions on what to input for this query. Below the instructions, creates a form that allows user to input a screenName to try to delete. Then, after hitting the submit button, moves to resultDeleteUser.jsp to verify that this user exists, and delete if so. -->
	<h3>This query will delete a user from the database.</h3>
	<h4>Enter a valid screen name to delete:</h4>
	<form method="post" action="resultDeleteUser.jsp">
	<input type = "text" class="param" name="screenName" placeholder= "Screen Name">
	<input type="submit" value="Submit">
	</form>
</body>
</html>