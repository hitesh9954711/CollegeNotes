package com.example.CollegeNotes.Repositories;

import com.example.CollegeNotes.Entities.Teacher;
import com.example.CollegeNotes.Entities.TeacherRequest;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.RepositoryDefinition;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;

@RepositoryDefinition(domainClass = TeacherRequest.class,idClass = Integer.class)
public interface RepositoryForTeacherRequestClass extends JpaRepository<TeacherRequest,Integer> {

    public TeacherRequest save(TeacherRequest teacherRequest);

    @Query("from TeacherRequest")
    public ArrayList<TeacherRequest> getRequests();

    public TeacherRequest findByid(int id);

    public TeacherRequest deleteById(@RequestParam("id") int id);

    @Query("from TeacherRequest where email=:email and password=:password")
    public TeacherRequest findByidAndPassword(@RequestParam("email") String email,@RequestParam("password") String password);
}
