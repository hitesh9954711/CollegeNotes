package com.example.CollegeNotes.Entities;

import javax.persistence.*;
import java.util.ArrayList;

@Entity
public class CourseDetails {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private String course;
    private String semester;
    @Lob
    private ArrayList<String> subjects;
    public CourseDetails(String course, String semester, ArrayList<String> subjects) {
        this.course = course;
        this.semester = semester;
        this.subjects = subjects;
    }

    public CourseDetails(){

    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCourse() {
        return course;
    }

    public void setCourse(String course) {
        this.course = course;
    }

    public String getSemester() {
        return semester;
    }

    public void setSemester(String semester) {
        this.semester = semester;
    }

    public ArrayList<String> getSubjects() {
        return subjects;
    }

    public void setSubjects(ArrayList<String> subjects) {
        this.subjects = subjects;
    }

}
