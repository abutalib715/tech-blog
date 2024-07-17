<%@ page import="com.tech.blog.dao.PostDao" %>
<%@ page import="com.tech.blog.helper.ConnectionProvider" %>
<%@ page import="java.util.List" %>
<%@ page import="com.tech.blog.entities.Post" %>

<div class="row">
    <%
        PostDao postDao = new PostDao(ConnectionProvider.getConnection());
        List<Post> postList = postDao.getAllPosts();
        for (Post post : postList) {
    %>

    <div class="col-md-6 mt-2">
        <div class="card">
            <img class="card-img-top" src="blog-images/<%= post.getImage() %>" alt="">
            <div class="card-body">
                <b><%= post.getTitle() %>
                </b>
                <p><%= post.getContent() %>
                </p>
                <pre><%= post.getCode() %></pre>
            </div>
        </div>
    </div>

    <%
        }
    %>
</div>