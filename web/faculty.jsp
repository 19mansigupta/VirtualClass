
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%
    if (!session.getAttribute("user").equals("faculty")) {
        response.sendRedirect("index.jsp");
    }

%>

<html>
    <head>
        <title>Buy Phones Online</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <link rel="stylesheet" href="extensions/bootstrap.min.css" />
        <script src="extensions/bootstrap.min.js"></script>
        <script src="extensions/jquery-1.12.1.min.js"></script>
    </head>
    <body>
        <jsp:include page="_header.jsp"></jsp:include>
        <jsp:include page="faculty_body.jsp"></jsp:include>
    </body>
</html>
