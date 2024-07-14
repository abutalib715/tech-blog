<%@ page import="com.tech.blog.entities.Message" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Register Page</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <link href="css/style.css" rel="stylesheet" type="text/css"/>

</head>
<body>

<%@include file="navbar.jsp" %>
<main class="d-flex align-items-center" style="height: 100vh;">

    <div class="container">
        <div class="row mb-2">
            <div class="col-md-4 offset-md-4">
                <div class="card" style="width: 18rem;">

                    <div class="card-header">
                        Login Form
                    </div>

                    <%
                        Message message = (Message) session.getAttribute("msg");
                        if (message != null) {
                    %>
                    <div class="alert <%= message.getCssClass()%>>" role="alert">
                        <%= message.getMessage() %>
                    </div>
                    <%
                            session.removeAttribute("msg");
                        }
                    %>

                    <div class="card-body">
                        <form action="login" method="post">
                            <div class="mb-3">
                                <label for="exampleInputEmail1" class="form-label">Email address</label>
                                <input type="email" name="email" class="form-control" id="exampleInputEmail1"
                                       aria-describedby="emailHelp">
                            </div>
                            <div class="mb-3">
                                <label for="exampleInputPassword1" class="form-label">Password</label>
                                <input type="password" name="password" class="form-control" id="exampleInputPassword1">
                            </div>
                            <button type="submit" class="btn btn-primary">Submit</button>
                            <a href="register.jsp">Register</a>
                        </form>
                    </div>

                </div>
            </div>
        </div>
    </div>
</main>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
        crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"
        integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
</body>
</html>
