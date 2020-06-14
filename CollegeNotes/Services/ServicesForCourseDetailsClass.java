package com.example.CollegeNotes.Services;

import com.example.CollegeNotes.Entities.Course;
import com.example.CollegeNotes.Entities.CourseDetails;
import com.example.CollegeNotes.Repositories.RepositoryForCourseDetailsClass;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

@Service
public class ServicesForCourseDetailsClass {
    @Autowired
    RepositoryForCourseDetailsClass service;


    public CourseDetails saveDetails(CourseDetails c){
        CourseDetails details=service.save(c);

        try{
            details.getCourse();
            return  details;
        }
        catch (Exception e){
            return null;
        }
    }
    public  CourseDetails get(int id){
        CourseDetails  d=service.findById(id);
        return d;
    }

    public ArrayList<CourseDetails> view(String course){

        ArrayList<CourseDetails> cdetails=service.findByCourse(course);

        return  cdetails;
    }

    public void delete(int id){
        service.deleteById(id);
    }
}
