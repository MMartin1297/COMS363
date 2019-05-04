<!-- @author Matthew Martin
     @author Travis Stanger
-->

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
	<title>Create a User</title>
</head>
<body>
	<!-- Creates a form that allows user to input a username, password, and select a role in order to create a new user. On pressing the submit button, moves to addWebAppUser.jsp for verification before creating a new user. -->
	<form method="post" action="addWebAppUser.jsp">
		<table>
			<tr>
				<td>User Name</td>
				<td><input type="text" name="uname"></td>
			</tr>
			<tr><td>Password</td>
				<td><input type="password" name="pass"></td>
			</tr>
			<tr><td>Role</td>
				<td><select name="role"><option value="Read-Only">"Read-Only"</option><option value="Administrator">"Administrator"</option></select></td>
			</tr>
			<tr><td></td>
				<td><input type="submit" name="Submit"</td>
			</tr>
		</table>
	</form>
</body>
</html>