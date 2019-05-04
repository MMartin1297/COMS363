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
	<title>Find Q3</title>
</head>
<body>
	<!-- Instructions on what to input for this query. Below the instructions, creates a form that allows user to input a k value and year, then hit submit to go to verify the input/run the query. -->
	<h3>This query will find k hashtags that appeared in the most number of states in a given year. The data shown will consist of a list of the total number of states the hashtag appeared, the list of the distinct states it appeared, and the hashtag itself shown in descending order of the number of states the hashtag appeared.</h3>
	<form method="post" action="resultQ3.jsp">
	<input type = "number" class="param" name="kValue" placeholder= "K value">
	<input type = "number" class="param" name="givenYear" placeholder="Year">
	<input type="submit" value="Submit">
	</form>
</body>
</html>