<%@ page import="com.tech.blog.entities.User" %>
<%@ page import="com.tech.blog.entities.Message" %>
<%@ page import="com.tech.blog.dao.PostDao" %>
<%@ page import="com.tech.blog.helper.ConnectionProvider" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="com.tech.blog.entities.Category" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page errorPage="error_page.jsp" %>

<%
    User user = (User) session.getAttribute("currentUser");
    if (user == null) {
        response.sendRedirect("login.jsp");
    }
%>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Profile Page</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css"
          integrity="sha512-Kc323vGBEqzTmouAECnVceyQqyqdsSiqLQISBL29aUW4U/M7pSPA/gEUZQqv1cwx4OnYxTxve5UMg5GT6L4JJg=="
          crossorigin="anonymous" referrerpolicy="no-referrer"/>
    <link href="css/style.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<nav class="navbar navbar-expand-lg bg-body-tertiary navbar-primary">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">Navbar</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
                aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="#">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#" data-bs-toggle="modal"
                       data-bs-target="#addPostModal"><span class="fa fa-plus-circle"></span> Do Post</a>
                </li>
                <%--                <li class="nav-item dropdown">--%>
                <%--                    <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown"--%>
                <%--                       aria-expanded="false">--%>
                <%--                        Dropdown--%>
                <%--                    </a>--%>
                <%--                    <ul class="dropdown-menu">--%>
                <%--                        <li><a class="dropdown-item" href="#">Action</a></li>--%>
                <%--                        <li><a class="dropdown-item" href="#">Another action</a></li>--%>
                <%--                        <li>--%>
                <%--                            <hr class="dropdown-divider">--%>
                <%--                        </li>--%>
                <%--                        <li><a class="dropdown-item" href="#">Something else here</a></li>--%>
                <%--                    </ul>--%>
                <%--                </li>--%>
            </ul>
            <ul class="navbar-nav mr-right">
                <li class="nav-item">
                    <a href="#" class="nav-link" data-bs-toggle="modal"
                       data-bs-target="#profileModal">
                        <span class="fa fa-user-circle"></span> <%= user.getName() %>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="logout" class="nav-link"><span class="fa fa-sign-out"></span> Logout</a>
                </li>
            </ul>
        </div>
    </div>
</nav>


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


<%
    PostDao postDao = new PostDao(ConnectionProvider.getConnection());
    ArrayList<Category> categoryList = postDao.getAllCategories();
%>
<%--MAIN PAGE--%>

<main>
    <div class="container">
        <div class="row mt-5">
            <div class="col-md-4">
                <div class="list-group">
                    <a href="#" onclick="getPosts(0)" class="list-group-item list-group-item-action active"
                       aria-current="true">
                        All Posts
                    </a>
                    <% for (Category category : categoryList) { %>
                    <a href="#" onclick="getPosts(<%= category.getId() %>)"
                       class="list-group-item list-group-item-action"><%= category.getName() %>
                    </a>
                    <% } %>
                </div>
            </div>
            <div class="col-md-8">
                <div class="container text-center" id="loader">
                    <span class="fa fa-refresh fa-3x fa-spin"></span>
                    <h3 class="mt-3">Loading.....</h3>
                </div>
                <div class="container" id="post-container">
                </div>
            </div>
        </div>
    </div>
</main>

<!-- Profile Edit Modal -->
<div class="modal fade" id="profileModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="exampleModalLabel">Profile Details</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body text-center">
                <img src="profile-picture/<%= user.getProfilePicture() %>" alt="" class="img-fluid img-thumbnail"
                     style="border-radius: 50%; max-width: 150px">
                <h1 class="modal-title fs-5 mt-3"><%= user.getName() %>
                </h1>
                <div id="profile-details">
                    <table class="table table-bordered">
                        <tbody>
                        <tr>
                            <th scope="row">ID</th>
                            <td><%= user.getId() %>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">Email</th>
                            <td><%= user.getEmail() %>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">Gender</th>
                            <td><%= user.getGender() %>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">About</th>
                            <td><%= user.getAbout() %>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">Reg Date</th>
                            <td><%= user.getReg_date().toString() %>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <div id="profile-edit" style="display: none">

                    <form action="edit-profile" method="post" enctype="multipart/form-data">
                        <table class="table table-bordered">
                            <tbody>
                            <tr>
                                <th scope="row">ID</th>
                                <td><%= user.getId() %>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">Name</th>
                                <td>
                                    <input type="text" name="name" value="<%= user.getName() %>" class="form-control">
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">Email</th>
                                <td>
                                    <input type="email" name="email" value="<%= user.getEmail() %>"
                                           class="form-control">
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">Password</th>
                                <td>
                                    <input type="password" name="password" value="<%= user.getPassword() %>"
                                           class="form-control">
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">Gender</th>
                                <td>
                                    <%= user.getGender().toUpperCase() %>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">About</th>
                                <td>
                                    <textarea name="about" rows="3"
                                              class="form-control"><%= user.getAbout() %></textarea>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">Profile Picture</th>
                                <td>
                                    <input type="file" name="profile_picture" class="form-control">
                                </td>
                            </tr>
                            </tbody>
                        </table>
                        <div class="container">
                            <button type="submit" class="btn btn-outline-primary">Update</button>
                        </div>
                    </form>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button id="edit-profile-btn" type="button" class="btn btn-primary">Edit</button>
            </div>
        </div>
    </div>
</div>


<!-- Add Post Modal -->
<div class="modal fade" id="addPostModal" tabindex="-1" aria-labelledby="addPostModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h1 class="modal-title fs-5" id="addPostModalLabel">Add New Post</h1>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="add-post" method="post" id="addPostForm" enctype="multipart/form-data" class="form">
                    <div class="form-group mb-2">
                        <select name="categoryId" id="categoryId" class="form-control">
                            <option selected disabled>--- Select Category ---</option>
                            <% for (Category category : categoryList) { %>
                            <option value="<%= category.getId() %>"><%= category.getName() %>
                            </option>
                            <% } %>
                        </select>
                    </div>
                    <div class="form-group mb-2">
                        <input type="text" name="title" placeholder="Enter Post Title" class="form-control">
                    </div>
                    <div class="form-group mb-2">
                        <textarea name="content" id="content" rows="3" class="form-control"
                                  placeholder="Enter post content here"></textarea>
                    </div>
                    <div class="form-group mb-2">
                        <textarea name="content" id="code" rows="3" class="form-control"
                                  placeholder="Enter your program code here(if any)"></textarea>
                    </div>
                    <div class="form-group mb-2">
                        <label for="image">Select Image File</label>
                        <input type="file" id="image" name="image" class="form-control">
                    </div>
                    <div class="container text-center">
                        <button type="submit" class="btn btn-outline-primary">Save</button>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <%--                <button id="edit-profile-btn" type="button" class="btn btn-primary">Edit</button>--%>
            </div>
        </div>
    </div>
</div>


<script src="https://code.jquery.com/jquery-3.7.1.min.js"
        integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL"
        crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"
        integrity="sha512-AA1Bzp5Q0K1KanKKmvN/4d3IRKVlv9PYgwFPvm32nPO6QS8yH1HO7LbgB1pgiOxPtfeg5zEn2ba64MUcqJx6CA=="
        crossorigin="anonymous" referrerpolicy="no-referrer"></script>

<%--EDIT PROFILE SCRIPT--%>
<script>
    $(document).ready(function (e) {
        let editStatus = false;
        $("#edit-profile-btn").click(function () {
            if (editStatus == false) {
                $("#profile-details").hide()
                $("#profile-edit").show()
                editStatus = true;
                $(this).text("Back")
            } else {
                $("#profile-details").show()
                $("#profile-edit").hide()
                editStatus = false;
                $(this).text("Edit")
            }
        })
    })
</script>

<%--ADD POST SCRIPT--%>
<script>
    $(document).ready(function (e) {
        $("#addPostForm").on("submit", function (event) {
            event.preventDefault();

            let formData = new FormData(this);

            console.log(formData);

            $.ajax({
                url: "add-post",
                method: "post",
                data: formData,
                success: function (data, textStatus, jqXRH) {
                    if (data.trim() == "done") {
                        swal("Success!", "Data saved successfully!!", "success")
                            .then((value) => {
                                $('#addPostModal').modal('hide');
                            });
                    } else {
                        swal("Failed to save data!", data, "error")
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    swal("Error!", "Something went wrong. please try again!", "error")
                },
                processData: false,
                contentType: false
            })
        })
    })
</script>

<%--LOAD POSTS--%>
<script>
    function getPosts(catId) {
        $.ajax({
            url: "load_post.jsp",
            data: {categoryId: catId},
            success: function (data, textStatus, jqXRH) {
                $("#loader").hide();
                $("#post-container").html(data);
            }
        })
    }

    $(document).ready(function (e) {
        getPosts(0);
    })
</script>
</body>
</html>
