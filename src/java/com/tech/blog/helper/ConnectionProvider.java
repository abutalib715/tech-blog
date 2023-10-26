/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tech.blog.helper;
import java.sql.*;


public class ConnectionProvider {
    private static Connection con;
    
    public static Connection getConnection(){
        try{
            
            if(con == null){
                // LOAD DATABASE DRIVER
                Class.forName("com.mysql.jdbc.Driver");

                // CREATE CONNECTION
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/tech_blog", "root", "");

            }
        } catch(Exception e){
            e.printStackTrace();
        }
        
        return con;
    }
}
