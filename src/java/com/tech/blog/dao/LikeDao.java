package com.tech.blog.dao;
import java.sql.*;

public class LikeDao {
    Connection con;

    public LikeDao(Connection con) {
        this.con = con;
    }
    
    public boolean insertLike(int postId, int userId){
        boolean flag = false;
        try{
            String query = "Insert into likes(post_id, user_id) values(?, ?)";
            PreparedStatement ps = this.con.prepareStatement(query);
            ps.setInt(1, postId);
            ps.setInt(2, userId);
            
            ps.executeUpdate();
            
            flag = true;
            
        } catch(Exception e){
            e.printStackTrace();
        }
        
        return flag;
    }
    
    public int countLikeOnPost(int postId){
        int count = 0;
        try {
            String query = "Select count(*) from likes where post_id= ?";
            PreparedStatement ps = this.con.prepareStatement(query);
            ps.setInt(1, postId);
            ResultSet rs = ps.executeQuery();
            
            while(rs.next()){
                count = rs.getInt("count(*)");
            }
            
        } catch(Exception e){
            e.printStackTrace();
        }
        return count;
    }
    
    public boolean isLikedByUser(int postId, int userId){
        boolean flag = false;
        
        try{
            String query = "Select * from likes where post_id = ? and user_id =?";
            PreparedStatement ps = this.con.prepareStatement(query);
            ps.setInt(1, postId);
            ps.setInt(2, userId);
            ResultSet rs = ps.executeQuery();
            
            while(rs.next()){
                flag = true;
            }
            
        } catch(Exception e){
            e.printStackTrace();
        }
        
        return flag;
    }
    
    public boolean unlikeLiked(int postId, int userId){
        boolean flag = false;
        
        try{
            String query = "Delete from likes where post_id= ? and user_id = ?";
            PreparedStatement ps = this.con.prepareStatement(query);
            ps.setInt(1, postId);
            ps.setInt(2, userId);
            
            ps.executeUpdate();
            
            flag = true;
            
        } catch(Exception e){
            e.printStackTrace();
        }
        
        return flag;
        
    }
}
