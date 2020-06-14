package com.example.CollegeNotes.Repositories;

import com.example.CollegeNotes.Entities.Course;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.RepositoryDefinition;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;

@RepositoryDefinition(domainClass = Course.class,idClass = String.class)
public interface  RepositoryForCourseClass extends JpaRepository<Course,String> {

    public Course save(Course course);

    public Course findByCourse(String course);

    @Query("from Course")
    public ArrayList<Course> selectCourse();

    @Query("from Course where course=:course")
    public Course findBycourse(@RequestParam("course") String course);

    public Course deleteByCourse(String course);
}
