<!-- @author Matthew Martin
     @author Travis Stanger
-->

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
	<title>Login Page</title>
</head>
<body>
	<!-- Main page. This page allows user to input login credentials and attempt to log in by pressing submit, or to click on Create A User to create a new user. By attempting to log in, moves to confirmLogin.jsp and verifies login info before logging user in. -->
	<h3>Welcome! Please Login to the Application.</h3>
	<form method="post" action="confirmLogin.jsp">
		<table>
			<tr>
				<td>User Name</td>
				<td><input type="text" name="uname"></td>
			</tr>
			<tr><td>Password</td>
				<td><input type="password" name="pass"></td>
			</tr>
			<tr><td></td>
				<td><input type="submit" name="Login"</td>
			</tr>
		</table>
	</form>
	<form action="createUser.jsp">
    	<input type="submit" value="Create A User" />
	</form>
</body>
</html>