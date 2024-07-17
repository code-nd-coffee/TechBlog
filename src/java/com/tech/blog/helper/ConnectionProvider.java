package com.tech.blog.helper;
import java.sql.*;

public class ConnectionProvider
{
    private static Connection con;
    public static Connection getConnection(){
        try{
            if(con == null){
                //Driver Class Load
                Class.forName("com.mysql.jdbc.Driver");

                //Create a Connection
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/techblog", "root", "7266194@MySql");
            }
        } catch(Exception e){
            
            e.printStackTrace();
        }
        return con;
    }
}