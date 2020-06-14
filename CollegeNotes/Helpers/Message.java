package com.example.CollegeNotes.Helpers;

public class Message {
    private String cssClass;
    private String content;

    public Message(String cssClass, String content) {
        this.cssClass = cssClass;
        this.content = content;
    }

    public Message(){

    }

    public String getCssClass() {
        return cssClass;
    }

    public void setCssClass(String cssClass) {
        this.cssClass = cssClass;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
}
