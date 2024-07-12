<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page isErrorPage="true" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Error Page</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <link href="css/style.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <div class="container text-center">
        <img src="img/error.png" width="256" alt="" class="img-fluid mt-3">
        <h3 class="display-3">Something went wrong, please try again!</h3>
        <%= exception %> <br>
        <a href="index.jsp" class="btn btn-primary mt-3">Go to homepage</a>
    </div>
</body>
</html>
