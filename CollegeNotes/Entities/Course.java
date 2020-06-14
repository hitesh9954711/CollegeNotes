package com.example.CollegeNotes.Entities;

import org.hibernate.annotations.GeneratorType;

import javax.persistence.*;
import java.util.ArrayList;

@Entity
@Table(name="courses")
public class Course {
    @Id
    private String course;
    @Lob
    private ArrayList<String> semesters;

    public Course(String course, ArrayList<String> semesters) {
        this.course = course;
        this.semesters = semesters;
    }
    public Course(){

    }

    public String getCourse() {
        return course;
    }

    public void setCourse(String course) {
        this.course = course;
    }

    public ArrayList<String> getSemesters() {
        return semesters;
    }

    public void setSemesters(ArrayList<String> semesters) {
        this.semesters = semesters;
    }
}
