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
	<title>Find Q27</title>
</head>
<body>
	<!-- Instructions on what to input for this query. Below the instructions, creates a form that allows user to input a k value, two months, and a year, then hit submit to go to verify the input/run the query. -->
	<h3>This query will take in two given months and a selected year, and will report the screen names of influential users (based on top k retweet counts in those 2 months in the selected year).</h3>
	<form method="post" action="resultQ27.jsp">
	<input type = "number" class="param" name="kValue" placeholder= "K value">
	<input type = "number" class="param" name="givenMonth1" placeholder="Month1">
	<input type = "number" class="param" name="givenMonth2" placeholder="Month2">
	<input type = "number" class="param" name="givenYear" placeholder="Year">
	<input type="submit" value="Submit">
	</form>
</body>
</html>