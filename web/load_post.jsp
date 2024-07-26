<%@ page import="com.tech.blog.dao.PostDao" %>
<%@ page import="com.tech.blog.helper.ConnectionProvider" %>
<%@ page import="java.util.List" %>
<%@ page import="com.tech.blog.entities.Post" %>

<div class="row">
    <%
        PostDao postDao = new PostDao(ConnectionProvider.getConnection());

        List<Post> postList;
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        if (categoryId == 0)
            postList = postDao.getAllPosts();
        else
            postList = postDao.getPostByCatId(categoryId);

        if (postList.isEmpty()) {
            out.println("<h3 class='text-center'>No post found in this category!</h3>");
            return;
        }
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