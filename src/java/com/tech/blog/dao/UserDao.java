
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
            String query = "insert into user(username, email, password, gender, about) values(?,?,?,?,?)";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, user.getUsername());
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
        try{
            String query = "select * from user where email =? and password = ?";
            PreparedStatement preparedStatement = con.prepareStatement(query);
            preparedStatement.setString(1, email);
            preparedStatement.setString(2, password);
            ResultSet resultSet = preparedStatement.executeQuery();

            if(resultSet.next()){
                System.out.println(resultSet.getString("username"));
                user = new User();
                user.setUsername(resultSet.getString("username"));
                user.setEmail(resultSet.getString("email"));
                user.setPassword(resultSet.getString("password"));
                user.setAbout(resultSet.getString("about"));
                user.setGender(resultSet.getString("gender"));
                user.setReg_date(resultSet.getTimestamp("reg_date"));
                user.setProfilePicture(resultSet.getString("profile_picture"));
            }
        }
        catch (Exception e){
            e.printStackTrace();
        }

        return user;
    }
}
