package com.example.CollegeNotes.Repositories;

import com.example.CollegeNotes.Entities.CourseDetails;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.RepositoryDefinition;

import java.util.ArrayList;

@RepositoryDefinition(domainClass = CourseDetails.class,idClass = Integer.class)
public interface RepositoryForCourseDetailsClass extends JpaRepository<CourseDetails,Integer> {

    public CourseDetails save(CourseDetails details);

    @Query("from CourseDetails where course=:course")
    public ArrayList<CourseDetails> findByCourse(String course);

    public CourseDetails findById(int id);

    public void deleteById(int id);
}
