package com.example.CollegeNotes.Repositories;

import com.example.CollegeNotes.Entities.Teacher;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.RepositoryDefinition;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;

@RepositoryDefinition(domainClass = Teacher.class,idClass = String.class)
public interface RepositoryForTeacherClass  extends JpaRepository<Teacher,String> {

    public Teacher save(Teacher teacher);




    @Query("from Teacher")
    public ArrayList<Teacher> view();

    @Query("from Teacher where email=:email and password=:password")
    public Teacher findByIdAndPassword(@RequestParam("email") String email, @RequestParam("password") String password);

    @Query("from Teacher where email=:email")
    public  Teacher findByid(@RequestParam("email")String email);

    public void deleteById(String email);

}
