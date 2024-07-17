package com.tech.blog.entities;

import java.sql.*;

public class Post {
    private int postId;
    private String title;
    private String content;
    private String code;
    private String pic;
    private Timestamp date;
    private int categoryId;
    private int userId;

    public Post() {
    }

    public Post(int postId, String title, String content, String code, String pic, Timestamp date, int categoryId, int userId) {
        this.postId = postId;
        this.title = title;
        this.content = content;
        this.code = code;
        this.pic = pic;
        this.date = date;
        this.categoryId = categoryId;
        this.userId = userId;
    }

    public Post(String title, String content, String code, String pic, Timestamp date, int categoryId, int userId) {
        this.title = title;
        this.content = content;
        this.code = code;
        this.pic = pic;
        this.date = date;
        this.categoryId = categoryId;
        this.userId = userId;
    }

    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getPic() {
        return pic;
    }

    public void setPic(String pic) {
        this.pic = pic;
    }

    public Timestamp getDate() {
        return date;
    }

    public void setDate(Timestamp date) {
        this.date = date;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }
    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }
    
    
}
