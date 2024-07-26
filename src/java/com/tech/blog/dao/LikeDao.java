package com.tech.blog.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class LikeDao {
    Connection connection;

    public LikeDao(Connection connection) {
        this.connection = connection;
    }

    // INSERT LIKE
    public boolean saveLike(int postId, int userId) {
        boolean isInserted = false;
        try {
            String query = "insert into post_likes(post_id, user_id) values(?,?)";
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, postId);
            pstmt.setInt(2, userId);

            pstmt.executeUpdate();
            isInserted = true;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return isInserted;
    }

    // COUNT POST LIKE
    public int countLikeByPost(int postId) {
        int count = 0;
        try {
            String query = "select count(*) from post_likes where post_id = ?";
            PreparedStatement pstmt = connection.prepareStatement(query);
            pstmt.setInt(1, postId);

            ResultSet result = pstmt.executeQuery();
            if (result.next()) count = result.getInt(1);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return count;
    }

    // CHECK IF ALREADY LIKED
    public boolean isLikedByUser(int postId, int userId) {
        boolean isLiked = false;
        try {
            PreparedStatement pstmt = connection.prepareStatement("select count(*) from post_likes where post_id = ? and user_id=?");
            pstmt.setInt(1, postId);
            pstmt.setInt(2, userId);

            ResultSet result = pstmt.executeQuery();
            if (result.next()) isLiked = true;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return isLiked;
    }

    // DISLIKE POST
    public boolean deleteLike(int postId, int userId) {
        boolean isDeleted = false;
        try {
            PreparedStatement pstmt = connection.prepareStatement("delete from post_likes where post_id = ? and user_id=?");
            pstmt.setInt(1, postId);
            pstmt.setInt(2, userId);
            pstmt.executeUpdate();

            isDeleted = true;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return isDeleted;
    }


}
