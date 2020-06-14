package com.example.CollegeNotes.Services;

import com.example.CollegeNotes.Entities.Student;
import com.example.CollegeNotes.Repositories.RepositoryForStudentClass;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ServicesForStudentClass {
    @Autowired
    RepositoryForStudentClass repo;

    public Student saveStudent(Student student){
        Student student1=repo.save(student);
        return  student1;
    }

    public Student findbyidandpassword(String email,String password){
        Student student=repo.findByIdAndPassword(email,password);
        try{
            student.getEmail();
            return student;
        }
        catch (Exception e){
            e.printStackTrace();
            return null;
        }
    }

    public Student findByid(String email){
        Student student=repo.findByid(email);
        try {
            student.getEmail();
            return student;
        }
        catch (Exception e){
            e.printStackTrace();
            return null;
        }
    }

}
