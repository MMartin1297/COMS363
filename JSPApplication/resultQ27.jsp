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
	<title>Q27 Result</title>
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
	//Get data from previous page
	int k = Integer.parseInt( request.getParameter("kValue"));
	int givenMonth1 = Integer.parseInt( request.getParameter("givenMonth1"));
	int givenMonth2 = Integer.parseInt( request.getParameter("givenMonth2"));
	int givenYear = Integer.parseInt( request.getParameter("givenYear"));
	//Check for valid infor
	if((k > 100) || (k < 1) || (givenMonth1 > 12) || (givenMonth1 < 1) || (givenMonth2 > 12) || (givenMonth2 < 1)) {
		%>
			<h4>Invalid query, please enter a K value between 1 and 100 and a month between 1 and 12</h4>
			<a href="selector.jsp">Proceed back to queries</a>
		<%
	} else {
		try{
			//Run Statement
	 		Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
			stmt = conn.createStatement();
			conn.setAutoCommit(false);
			String q27 = "CALL Q27opt(?,?,?,?)";
			query = conn.prepareStatement(q27);
			//Set parameters in SQL statement
			query.setInt(1, k);
			query.setInt(2, givenYear);
			query.setInt(3, givenMonth1);
			query.setInt(4, givenMonth2);
			//Execute Query
			rs = query.executeQuery();
			//Format results for table in HTML
			result = "Result: <br><tr><td>Screen Name</td></tr>";
			//Parse results
			while (rs.next()) {
				result += "<tr><td>" + rs.getString(1) + "</td></tr>";
			}
			//Commit queries
			conn.commit();
			//Close connections
			rs.close();
			stmt.close();
			conn.close();
		//Exceptions
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