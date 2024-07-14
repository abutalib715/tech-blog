package com.tech.blog.dao;

import com.tech.blog.entities.Category;
import com.tech.blog.entities.Post;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

public class PostDao {
    Connection connection;

    public PostDao(Connection connection) {
        this.connection = connection;
    }

    public ArrayList<Category> getAllCategories() {
        ArrayList<Category> allCategories = new ArrayList<>();

        try {
            String sql = "select * from categories";
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery(sql);

            while (resultSet.next()) {
                int catId = resultSet.getInt("id");
                String name = resultSet.getString("name");
                String description = resultSet.getString("description");

                Category category = new Category(catId, name, description);
                allCategories.add(category);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return allCategories;
    }

    // INSERT POST
    public boolean savePost(Post post) {
        boolean isInserted = false;
        try {
            String query = "insert into posts(category_id, title, content,code, image, user_id) values(?,?,?,?,?,?)";
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, post.getCategoryId());
            pstmt.setString(2, post.getTitle());
            pstmt.setString(3, post.getContent());
            pstmt.setString(4, post.getCode());
            pstmt.setString(5, post.getImage());
            pstmt.setInt(6, post.getUserId());

            pstmt.executeUpdate();
            isInserted = true;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return isInserted;
    }

    // UPDATE USER
    public boolean updatePost(Post post) {
        boolean isUpdated = false;
        try {
            String query = "update post set category_id =? title=?, content=?, code=?, image=? where id=?";
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, post.getCategoryId());
            pstmt.setString(2, post.getTitle());
            pstmt.setString(3, post.getContent());
            pstmt.setString(4, post.getCode());
            pstmt.setString(5, post.getImage());
            pstmt.setInt(6, post.getId());

            pstmt.executeUpdate();
            isUpdated = true;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return isUpdated;
    }
}
