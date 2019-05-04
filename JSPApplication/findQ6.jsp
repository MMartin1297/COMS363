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
	<title>Find Q6</title>
</head>
<body>
	<!-- Instructions on what to input for this query. Below the instructions, creates a form that allows user to input a k value and list of comma-separated hashtags, then hit submit to go to verify the input/run the query. -->
	<h3>This query will find k users who used a certain set of hashtags in their tweets. The data shown is the user's screen name and the state to which the user belongs in. It will be shown in descending order of the number of followers.</h3>
	<form method="post" action="resultQ6.jsp">
	<input type = "number" class="param" name="kValue" placeholder= "K value">
	<input type = "text" class="param" name="hashtags" placeholder="List of hashtags(Comma Separated)">
	<input type="submit" value="Submit">
	</form>
</body>
</html>