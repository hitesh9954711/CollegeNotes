package com.example.CollegeNotes.Repositories;

import com.example.CollegeNotes.Entities.Student;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.RepositoryDefinition;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.Optional;

@RepositoryDefinition(domainClass = Student.class,idClass = String.class)
public interface RepositoryForStudentClass extends JpaRepository<Student,String> {

    public Student save(Student student);

    @Query("from Student where email=:email and password=:password")
    public Student findByIdAndPassword(@RequestParam("email")String email,@RequestParam("password")String password);

    @Query("from Student where email=:email")
    public Student findByid(@RequestParam("email") String email);
}
