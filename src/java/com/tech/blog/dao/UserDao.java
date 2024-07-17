package com.tech.blog.dao;
import com.tech.blog.entities.User;
import java.sql.*;

public class UserDao {
    private Connection con;
    
    public UserDao(Connection con){
        this.con = con;
    }
    public boolean saveData(User user){
        boolean f = false;
        try{
            String query = "Insert into user(name, email, password, gender, about) values(?, ?, ?, ?, ?)";
            PreparedStatement ps = this.con.prepareStatement(query);
            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getGender());
            ps.setString(5, user.getAbout());
            
            ps.executeUpdate();
            f = true;
        } catch(Exception e){
            e.printStackTrace();
        }
        return f;
    }
    
//    Get User by email and password
    public User getUserByEmailAndPassword(String email, String password){
        User user = null;
        
        try{
            String query = "Select * from user where email=? and password = ?";
            PreparedStatement pstm = con.prepareStatement(query);
            pstm.setString(1, email);
            pstm.setString(2, password);
            
            ResultSet rs = pstm.executeQuery();
            if(rs.next()){
                user = new User();
                String name = rs.getString("name");
                user.setName(name);
                user.setId(rs.getInt("id"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setGender(rs.getString("gender"));
                user.setAbout(rs.getString("about"));
                user.setDateTime(rs.getTimestamp("registration_date"));
            }
        } catch(Exception e){
            e.printStackTrace();
        }
        
        return user;
    }
    
    public boolean updateUser(User user){
        boolean f =false;
        try{
            String query = "Update user set name=?, email=?, password=?,gender=?, about=? where id=?";
            PreparedStatement p = con.prepareStatement(query);
            p.setString(1,user.getName());
            p.setString(2,user.getEmail());
            p.setString(3,user.getPassword());
            p.setString(4,user.getGender());
            p.setString(5,user.getAbout());
            p.setInt(6,user.getId());
            
            p.executeUpdate();
            f =true;
        }catch(Exception e){
            e.printStackTrace();
        }
        return f;
    }
    
    public User getUserByUserId(int userId){
        User user = null;
        try{
            String query = "select * from user where id=?";
            PreparedStatement ps = this.con.prepareStatement(query);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                user = new User();
                user.setName(rs.getString("name"));
                user.setId(rs.getInt("id"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setGender(rs.getString("gender"));
                user.setAbout(rs.getString("about"));
                user.setDateTime(rs.getTimestamp("registration_date"));
            }
        } catch(Exception e){
            e.printStackTrace();
        }
        return user;
    }
}
