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
	<title>Q2 Result</title>
</head>
<body>
	<!-- Include DB Info File -->
	<%@ include file="./DBInfo.jsp"%>
	<%
	//Initialize connections
	Connection conn=null;
	Statement stmt=null;
	ResultSet rs=null;
	PreparedStatement query = null;
	int i = 0;
	String result = "";

	//Get input value from previous page
	int k = Integer.parseInt( request.getParameter("kValue"));
	String hashtag = request.getParameter("hashtag");
	int givenMonth = Integer.parseInt( request.getParameter("givenMonth"));
	int givenYear = Integer.parseInt( request.getParameter("givenYear"));

	//Check for valid entries
	if((k > 100) || (k < 1) || (givenMonth > 12) || (givenMonth < 1)) {
		%>
			<h4>Invalid query, please enter a K value between 1 and 100 and a month between 1 and 12</h4>
			<a href="selector.jsp">Proceed back to queries</a>
		<%
	//Entries are valid
	} else {
		try{
			//Run Statement
	 		Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
			stmt = conn.createStatement();
			conn.setAutoCommit(false);
			String q2 = "CALL Q2opt(?,?,?,?)";
			query = conn.prepareStatement(q2);
			//Add parameters to SQL statement
			query.setInt(1, k);
			query.setString(2, hashtag);
			query.setInt(3, givenMonth);
			query.setInt(4, givenYear);
			//Execute the Query
			rs = query.executeQuery();
			//Format result for table in HTML
			result = "Result: <br><tr><td>Screen Name</td><td>Category</td><td>Tweet Text</td><td>Retweet Count</td></tr>";
			//Parse through results
			while (rs.next()) {
				result += "<tr>";
				for (i = 0; i < 4; i++) {
					result += "<td>" + rs.getString(i+1) + "</td>";
				}
				result += "</tr>";
			}
			//Commit the queries
			conn.commit();
			//Close connections
			rs.close();
			stmt.close();
			conn.close();
		//Connections
		}catch (SQLException e) {
			out.println("An exception occurred: " + e.getMessage());
		} catch(NullPointerException e) {
			out.println("An exception occurred: " + e.getMessage());
		}

		%>
		<table style="width:100%" border="1"><%=result%></table>

		<form action="selector.jsp">
			<input type="submit" value="BACK" />
		</form>
	<%
	}
	%>
</body>
</html>