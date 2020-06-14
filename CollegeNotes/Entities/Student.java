package com.example.CollegeNotes.Entities;

import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
public class Student {

    private String  name;
    @Id
    private String email;
    private String password;
    private String course;

    public Student(String name, String email,String password, String course) {
        this.name = name;
        this.email = email;
        this.course = course;
        this.password=password;
    }
    public Student(){

    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getCourse() {
        return course;
    }

    public void setCourse(String course) {
        this.course = course;
    }
}
