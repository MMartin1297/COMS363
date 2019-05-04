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
	<title>Find Q23</title>
</head>
<body>
	<!-- Instructions on what to input for this query. Below the instructions, creates a form that allows user to input a k value, a sub-category, a comma-separated list of months, and a year, then hit submit to go to verify the input/run the query. -->
	<h3>This query will find the k most used hashtags with the count of tweets it appeared posted by a given sub-category of users in a list of months. The data will show the hashtag name and the count in descending order of the count.</h3>
	<form method="post" action="resultQ23.jsp">
	<input type = "number" class="param" name="kValue" placeholder= "K value">
	<input type = "text" class="param" name="subCategory" placeholder="Sub-category">
	<input type = "text" class="param" name="months" placeholder="List of Months(Comma Separated)">
	<input type = "number" class="param" name="givenYear" placeholder="Year">
	<input type="submit" value="Submit">
	</form>
</body>
</html>