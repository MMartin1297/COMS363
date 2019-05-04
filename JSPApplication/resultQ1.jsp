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
	<title>Q1 Result</title>
</head>
<body>
<!-- Include DB Info File -->
	<%@ include file="./DBInfo.jsp"%>
	<%
	//Initialize Connections
	Connection conn=null;
	Statement stmt=null;
	ResultSet rs=null;
	PreparedStatement query = null;
	int i = 0;
	String result = "";
	
	//Get input value from previous page
	int k = Integer.parseInt( request.getParameter("kValue"));
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
			String q1 = "CALL Q1opt(?,?,?)";
			query = conn.prepareStatement(q1);
			//Add parameters to SQL Statement
			query.setInt(1, k);
			query.setInt(2, givenMonth);
			query.setInt(3, givenYear);
			//Execute Query
			rs = query.executeQuery();
			//Format result for a table in HTML
			result = "Result: <br><tr><td>Retweet Count</td><td>Tweet Text</td><td>Posting User</td><td>Category</td><td>Sub-category</td></tr>";
			//Parse out results
			while (rs.next()) {
				result += "<tr>";
				for (i = 0; i < 5; i++) {
					result += "<td>" + rs.getString(i+1) + "</td>";
				}
				result += "</tr>";
			}
			//Commit Queries
			conn.commit();

			//Close prepared resultsSet, preparedStatements, and Connection
			rs.close();
			stmt.close();
			conn.close();
		//Exceptions
		}catch (SQLException e) {
			out.println("An exception occurred: " + e.getMessage());
		} catch(NullPointerException e) {
			out.println("An exception occurred: " + e.getMessage());
		}
			//Display result
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