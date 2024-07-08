
package com.tech.blog.dao;
import com.tech.blog.entities.User;
import java.sql.*;

public class UserDao {
    private Connection con;

    public UserDao(Connection con) {
        this.con = con;
    }
    
    // INSERT USER
    public boolean saveUser(User user){
        boolean isInserted = false;
        try{
            String query = "insert into user(username, email, password, gender, about) values(?,?,?,?,?)";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, user.getUsername());
            pstmt.setString(2, user.getEmail());
            pstmt.setString(3, user.getPassword());
            pstmt.setString(4, user.getGender());
            pstmt.setString(5, user.getAbout());
            
            pstmt.executeUpdate();
            isInserted = true;
        } catch(Exception e){
            e.printStackTrace();
        }
        
        return isInserted;
    }
}
