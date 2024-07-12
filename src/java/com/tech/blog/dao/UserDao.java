
package com.tech.blog.dao;

import com.tech.blog.entities.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDao {
    private Connection con;

    public UserDao(Connection con) {
        this.con = con;
    }

    // INSERT USER
    public boolean saveUser(User user) {
        boolean isInserted = false;
        try {
            String query = "insert into user(name, email, password, gender, about) values(?,?,?,?,?)";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, user.getName());
            pstmt.setString(2, user.getEmail());
            pstmt.setString(3, user.getPassword());
            pstmt.setString(4, user.getGender());
            pstmt.setString(5, user.getAbout());

            pstmt.executeUpdate();
            isInserted = true;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return isInserted;
    }

    public User getUserByEmailAndPassword(String email, String password) {
        User user = null;
        try {
            String query = "select * from user where email =? and password = ?";
            PreparedStatement preparedStatement = con.prepareStatement(query);
            preparedStatement.setString(1, email);
            preparedStatement.setString(2, password);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                user = new User();
                user.setId(resultSet.getInt("id"));
                user.setName(resultSet.getString("name"));
                user.setEmail(resultSet.getString("email"));
                user.setPassword(resultSet.getString("password"));
                user.setAbout(resultSet.getString("about"));
                user.setGender(resultSet.getString("gender"));
                user.setReg_date(resultSet.getTimestamp("reg_date"));
                user.setProfilePicture(resultSet.getString("profile_picture"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }

    // UPDATE USER
    public boolean updateUser(User user) {
        boolean isUpdated = false;
        try {
            String query = "update user set name=?, email=?, password=?, about=?,profile_picture=? where id=?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, user.getName());
            pstmt.setString(2, user.getEmail());
            pstmt.setString(3, user.getPassword());
            pstmt.setString(4, user.getAbout());
            pstmt.setString(5, user.getProfilePicture());
            pstmt.setInt(6, user.getId());

            pstmt.executeUpdate();
            isUpdated = true;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return isUpdated;
    }
}
