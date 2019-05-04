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
	<title>Find Q2</title>
</head>
<body>
	<!-- Instructions on what to input for this query. Below the instructions, creates a form that allows user to input a k value, hashtag, month, and year, then hit submit to go to verify the input/run the query. -->
	<h3>This query will find k users who used a given hashtag in a tweet with the most number of retweets in a given month of a given year. The data shown will be the user's screen name, user's category, tweet text, and retweet count in descending order of the retweet count.</h3>
	<form method="post" action="resultQ2.jsp">
	<input type = "number" class="param" name="kValue" placeholder= "K value">
	<input type = "text" class="param" name="hashtag" placeholder="Hashtag">
	<input type = "number" class="param" name="givenMonth" placeholder="Month">
	<input type = "number" class="param" name="givenYear" placeholder="Year">
	<input type="submit" value="Submit">
	</form>
</body>
</html>