
package com.tech.blog.entities;

import java.sql.Timestamp;

public class Post {
    private int id;
    private int categoryId;
    private String title;
    private String content;
    private String code;
    private String image;
    private Timestamp createdOn;

    public Post(int id, int categoryId, String title, String content, String code, String image, Timestamp createdOn) {
        this.id = id;
        this.categoryId = categoryId;
        this.title = title;
        this.content = content;
        this.code = code;
        this.image = image;
        this.createdOn = createdOn;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
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

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public Timestamp getCreatedOn() {
        return createdOn;
    }

    public void setCreatedOn(Timestamp createdOn) {
        this.createdOn = createdOn;
    }
}
