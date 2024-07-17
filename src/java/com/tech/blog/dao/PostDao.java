package com.tech.blog.dao;
import com.tech.blog.entities.Category;
import com.tech.blog.entities.Post;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PostDao {
    Connection con;

    public PostDao(Connection con) {
        this.con = con;
    }
    public ArrayList<Category> getAllCategories(){
        ArrayList<Category> list= new ArrayList<>();
        
        try{
            String query = "Select * from categories";
            Statement st = this.con.createStatement();
            ResultSet rs = st.executeQuery(query);
            
            while(rs.next()){
                int id = rs.getInt("categories_id");
                String name = rs.getString("name");
                String description = rs.getString("description");
                Category c = new Category(id, name, description);
                list.add(c);
            }
             
        }catch(Exception e){
            e.printStackTrace();
        }
        
        return list;
    }
    
    public boolean savePost(Post p){
        boolean flag = false;
        
        try{
            String query = "Insert into posts(title, content, code, pic, categories_id, user_id) values(?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = this.con.prepareStatement(query);
            ps.setString(1, p.getTitle());
            ps.setString(2, p.getContent());
            ps.setString(3, p.getCode());
            ps.setString(4, p.getPic());
            ps.setInt(5, p.getCategoryId());
            ps.setInt(6, p.getUserId());
            
            ps.executeUpdate();
            
            flag = true;
        } catch(Exception e){
            e.printStackTrace();
        }
        
        return flag;
    }
    
    public List<Post> getAllLists(){
        List<Post> list = new ArrayList<>();
//        Get All Post
        try{
            String query = "Select * from posts order by post_id desc";
            PreparedStatement ps = this.con.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            
            while(rs.next()){
                int postId = rs.getInt("post_id");
                String title = rs.getString("title");
                String content = rs.getString("content");
                String code = rs.getString("code");
                String pic = rs.getString("pic");
                Timestamp date = rs.getTimestamp("date");
                int categoriesId = rs.getInt("categories_id");
                int userId = rs.getInt("user_id");
                
                Post p = new Post(postId, title, content, code, pic, date, categoriesId, userId);
                list.add(p);
            }
            
        } catch(Exception e){
            e.printStackTrace();
        }
        
        return list;
    }
    
    public List<Post> getAllPostByCatId(int catId){
        List<Post> list = new ArrayList<>();
//        Get All Post By ID
        try{
            String query = "Select * from posts where categories_id = ?";
            PreparedStatement ps = this.con.prepareStatement(query);
            ps.setInt(1, catId);
            ResultSet rs = ps.executeQuery();
            
            while(rs.next()){
                int postId = rs.getInt("post_id");
                String title = rs.getString("title");
                String content = rs.getString("content");
                String code = rs.getString("code");
                String pic = rs.getString("pic");
                Timestamp date = rs.getTimestamp("date");
                int userId = rs.getInt("user_id");
                
                Post p = new Post(postId, title, content, code, pic, date, catId, userId);
                list.add(p);
            }
            
        } catch(Exception e){
            e.printStackTrace();
        }
        
        return list;
    }
    
    public Post getAllPostByPostId(int postId){
        Post p = null;
//        Get All Post By PostID
        try{
            String query = "Select * from posts where post_id = ?";
            PreparedStatement ps = this.con.prepareStatement(query);
            ps.setInt(1, postId);
            ResultSet rs = ps.executeQuery();
            
            while(rs.next()){
               
                int catId = rs.getInt("categories_id");
                String title = rs.getString("title");
                String content = rs.getString("content");
                String code = rs.getString("code");
                String pic = rs.getString("pic");
                Timestamp date = rs.getTimestamp("date");
                int userId = rs.getInt("user_id");
                
                p = new Post(postId, title, content, code, pic, date, catId, userId);
            }
            
        } catch(Exception e){
            e.printStackTrace();
        }
        
        return p;
    }
}
