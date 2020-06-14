package com.example.CollegeNotes.Services;

import com.example.CollegeNotes.Entities.Course;
import com.example.CollegeNotes.Repositories.RepositoryForCourseClass;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

@Service
public class ServicesForCourseClass {
    @Autowired
    RepositoryForCourseClass repo;

    public Course addCourse(String course, ArrayList<String> semesters){
        Course courses=new Course(course,semesters);
        Course c=repo.save(courses);
        return c;
    }

    public Course s(Course c){
        Course a=repo.save(c);
        return a;
    }

    public void delete(String course){
        repo.deleteById(course);
    }

    public Course check(String course){
        Course c=repo.findByCourse(course);
        try{
            c.getCourse();
            return  c;
        }
        catch (Exception e){
            return null;
        }
    }

    public Course view(String course){
        Course courses=repo.findBycourse(course);
        return courses;
    }

    public ArrayList<Course> getCourses(){
        ArrayList<Course> c=repo.selectCourse();
        return c;
    }
}
