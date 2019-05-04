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
	<title>Delete User Result</title>
</head>
<body>
	<!-- Include DB Info File -->
	<%@ include file="./DBInfo.jsp"%>
	<%
	//Initialize Connections
	Connection conn=null;
	Statement stmt=null;
	ResultSet rs=null;
	ResultSet rs2=null;
	PreparedStatement query = null;
	PreparedStatement query2 = null;
	int i = 0;
	String result = "";
	String result2 = "";
	//Get data from previous page
	String screenName = request.getParameter("screenName");
	try{
		//Run Statement
 		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);
		stmt = conn.createStatement();
		conn.setAutoCommit(false);
		String delete = "CALL deleteUser(?)";
		String validation = "SELECT screen_name FROM group25.users WHERE screen_name = ?";
		query2 = conn.prepareStatement(validation);
		query2.setString(1, screenName);
		rs2 = query2.executeQuery();
		while (rs2.next()) {
			result2 += rs2.getString(1);
		}
		if (result2.equals("") == true) { %>
		<h4>Error: User does not exist</h4>
		<form action="selector.jsp">
			<input type="submit" value="BACK" />
		</form><br>
		<%
		}
		else {
			query = conn.prepareStatement(delete);
			//Set parameters in SQL statement
			query.setString(1, screenName);
			//Execute Query
			rs = query.executeQuery();
			//Format result
			result += "Successfully deleted user " + screenName + ".";
			//Commit Query
			conn.commit();
			// Display results %>
			<h4><%=result%></h4>
			<form action="selector.jsp">
				<input type="submit" value="BACK" />
			</form> <%
		}
		//Close connections
		rs.close();
		stmt.close();
		conn.close();
	//Exceptions
	}catch (SQLException e) {
		
	} catch(NullPointerException e) {
		
	}
	%>
</body>
</html>