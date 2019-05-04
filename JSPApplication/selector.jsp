<!-- @author Matthew Martin
     @author Travis Stanger
-->

<!DOCTYPE html>
<html>
<head>
	<title>Query Selector</title>
</head>
<body>
<!-- Get session attribute for the role of logged in user -->
<% String role = (String)session.getAttribute("role"); %>
	<ul>
<!-- Display Queries available for all users -->
	<li><a href="findQ1.jsp">Find Query 1</a></li>
	<li><a href="findQ2.jsp">Find Query 2</a></li>
	<li><a href="findQ3.jsp">Find Query 3</a></li>
	<li><a href="findQ6.jsp">Find Query 6</a></li>
	<li><a href="findQ10.jsp">Find Query 10</a></li>
	<li><a href="findQ15.jsp">Find Query 15</a></li>
	<li><a href="findQ23.jsp">Find Query 23</a></li>
	<li><a href="findQ27.jsp">Find Query 27</a></li>
<!-- Check if user is admin and display 2 additional queries if so -->
	<% if (role.equals("Administrator")) { %>
	<li><a href="insertNewUser.jsp">Insert User</a></li>
	<li><a href="deleteUser.jsp">Delete User</a></li>
	<% } %>
	</ul>
</body>
</html>