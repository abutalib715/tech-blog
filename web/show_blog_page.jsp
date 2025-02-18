<%@ page import="com.tech.blog.dao.PostDao" %>
<%@ page import="com.tech.blog.helper.ConnectionProvider" %>
<%@ page import="com.tech.blog.entities.User" %>
<%@ page import="com.tech.blog.entities.Message" %>
<%@ page import="com.tech.blog.entities.Post" %>
<%@ page import="com.tech.blog.entities.Category" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.tech.blog.dao.UserDao" %>
<%@ page import="com.tech.blog.dao.LikeDao" %>
<%@page errorPage="error_page.jsp" %>

<%--
  Created by IntelliJ IDEA.
  User: HP
  Date: 7/26/2024
  Time: 6:48 PM
  To change this template use File | Settings | File Templates.
--%>

<%
    User loggedInUser = (User) session.getAttribute("currentUser");
    if (loggedInUser == null) {
        response.sendRedirect("login.jsp");
    }
%>


<%
    int postId = Integer.parseInt(request.getParameter("post_id"));
    PostDao postDao = new PostDao(ConnectionProvider.getConnection());

    Post post = postDao.getPostById(postId);

%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title><%=post.getTitle()%> || Tech Blog</title>
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
                    <a class="nav-link active" aria-current="page" href="profile.jsp">Home</a>
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
                        <span class="fa fa-user-circle"></span> <%= loggedInUser.getName() %>
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
    ArrayList<Category> categoryList = postDao.getAllCategories();
%>

<%--MAIN CONTENT HERE--%>
<main>
    <div class="container">
        <div class="row my-4">
            <div class="col-md-8 offset-md-2">
                <div class="card">
                    <div class="card-header">
                        <h4 class="post-title"><%=post.getTitle()%>
                        </h4>
                    </div>
                    <div class="card-body">
                        <img class="card-img-top mb-2" src="blog-images/<%= post.getImage() %>" alt="">
                        <div class="row mt-2">
                            <div class="col-md-8">

                                <%
                                    UserDao userDao = new UserDao(ConnectionProvider.getConnection());

                                    User authorInfo = userDao.getUserById(post.getUserId());

                                %>
                                <p><i class="fa fa-user"></i> Published By: <%=authorInfo.getName()%>
                                </p>
                            </div>
                            <div class="col-md-4 text-end">
                                <i class="fa fa-calendar-days"></i> <%=post.getCreatedOn().toLocaleString()%>
                            </div>
                        </div>
                        <hr>
                        <p class="post-content"><%=post.getContent()%>
                        </p>
                        <br><br>
                        <div class="post-code">
                            <pre><%=post.getCode()%></pre>
                        </div>
                    </div>
                    <div class="card-footer">
                        <%
                            LikeDao likeDao = new LikeDao(ConnectionProvider.getConnection());
                        %>
                        <a href="#!" onclick="doLike(<%=post.getId()%>, this)"
                           class="btn btn-outline-primary btn-sm">
                            <i class="far fa-thumbs-up"></i>
                            <span class="like-counter"> <%=likeDao.countLikeByPost(post.getId())%></span>
                        </a>
                        <a href="#" class="btn btn-outline-primary btn-sm"><i
                                class="fa fa-commenting"></i><span> 20</span></a>
                    </div>
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
                <img src="profile-picture/<%= loggedInUser.getProfilePicture() %>" alt=""
                     class="img-fluid img-thumbnail"
                     style="border-radius: 50%; max-width: 150px">
                <h1 class="modal-title fs-5 mt-3"><%= loggedInUser.getName() %>
                </h1>
                <div id="profile-details">
                    <table class="table table-bordered">
                        <tbody>
                        <tr>
                            <th scope="row">ID</th>
                            <td><%= loggedInUser.getId() %>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">Email</th>
                            <td><%= loggedInUser.getEmail() %>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">Gender</th>
                            <td><%= loggedInUser.getGender() %>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">About</th>
                            <td><%= loggedInUser.getAbout() %>
                            </td>
                        </tr>
                        <tr>
                            <th scope="row">Reg Date</th>
                            <td><%= loggedInUser.getReg_date().toString() %>
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
                                <td><%= loggedInUser.getId() %>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">Name</th>
                                <td>
                                    <input type="text" name="name" value="<%= loggedInUser.getName() %>"
                                           class="form-control">
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">Email</th>
                                <td>
                                    <input type="email" name="email" value="<%= loggedInUser.getEmail() %>"
                                           class="form-control">
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">Password</th>
                                <td>
                                    <input type="password" name="password" value="<%= loggedInUser.getPassword() %>"
                                           class="form-control">
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">Gender</th>
                                <td>
                                    <%= loggedInUser.getGender().toUpperCase() %>
                                </td>
                            </tr>
                            <tr>
                                <th scope="row">About</th>
                                <td>
                                    <textarea name="about" rows="3"
                                              class="form-control"><%= loggedInUser.getAbout() %></textarea>
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
    function getPosts(catId, refElement) {
        $(".c-link").removeClass('active')

        $.ajax({
            url: "load_post.jsp",
            data: {categoryId: catId},
            success: function (data, textStatus, jqXRH) {
                $("#loader").hide();
                $("#post-container").html(data);
                $(refElement).addClass('active')
            }
        })
    }

    $(document).ready(function (e) {
        let allPostRef = $('.c-link')[0]
        getPosts(0, allPostRef);
    })
</script>
<script src="js/script.js"></script>
</body>
</html>
