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
	<title>Q15 Result</title>
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
	String subCat = request.getParameter("subCat");
	int givenMonth = Integer.parseInt( request.getParameter("givenMonth"));
	int givenYear = Integer.parseInt( request.getParameter("givenYear"));
	//Check for valid info
	if((givenMonth > 12) || (givenMonth < 1)) {
		%>
			<h4>Invalid query, please enter a month between 1 and 12</h4>
			<a href="selector.jsp">Proceed back to queries</a>
		<%
	} else {
		try{
			//Run Statement
	 		Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
			stmt = conn.createStatement();
			conn.setAutoCommit(false);
			String q15 = "CALL Q15opt(?,?,?)";
			query = conn.prepareStatement(q15);
			//Add parameters to SQL Statement
			query.setString(1, subCat);
			query.setInt(2, givenMonth);
			query.setInt(3, givenYear);
			//Execute Query
			rs = query.executeQuery();
			//Format results for table in HTML
			result = "Result: <br><tr><td>Screen Name</td><td>Location</td><td>All Links</td></tr>";
			//Parse results
			while (rs.next()) {
				result += "<tr>";
				for (i = 0; i < 3; i++) {
					result += "<td>" + rs.getString(i+1) + "</td>";
				}
				result += "</tr>";
			}
			//Commit Queries
			conn.commit();
			//Close Connections
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