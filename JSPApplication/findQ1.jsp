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
	<title>Find Q1</title>
</head>
<body>
	<!-- Instructions on what to input for this query. Below the instructions, creates a form that allows user to input a k value, month, and year, then hit submit to go to verify the input/run the query. -->
	<h3>This Query will list the k most retweeted tweets in a given month and a given year. The data shows will be the retweet count, the tweet text, the posting user's screen name, the posting user's category, the posting user's sub-category. Additonally, it will be in descending order of the retweet count.</h3>
	<form method="post" action="resultQ1.jsp">
	<input type = "number" class="param" name="kValue" placeholder= "K value">
	<input type = "number" class="param" name="givenMonth" placeholder="Month">
	<input type = "number" class="param" name="givenYear" placeholder="Year">
	<input type="submit" value="Submit">
	</form>
</body>
</html>