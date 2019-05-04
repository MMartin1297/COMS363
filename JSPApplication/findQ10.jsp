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
	<title>Find Q10</title>
</head>
<body>
	<!-- Instructions on what to input for this query. Below the instructions, creates a form that allows user to input a list of comma-separated states, a month, and a year, then hit submit to go to verify the input/run the query. -->
	<h3>This query will find the list of distinct hashtags that appeared in one of the states in a given list in a given month of a given year. The data shown will be the list of the hashtags and the names of the states in which they appeared.</h3>
	<form method="post" action="resultQ10.jsp">
	<input type = "text" class="param" name="states" placeholder="States(Comma separated)">
	<input type = "number" class="param" name="givenMonth" placeholder="Month">
	<input type = "number" class="param" name="givenYear" placeholder="Year">
	<input type="submit" value="Submit">
	</form>
</body>
</html>