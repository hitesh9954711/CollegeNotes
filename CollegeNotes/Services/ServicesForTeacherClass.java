package com.example.CollegeNotes.Services;

import com.example.CollegeNotes.Entities.Teacher;
import com.example.CollegeNotes.Repositories.RepositoryForTeacherClass;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import javax.transaction.Transactional;
import java.util.ArrayList;

@Service
public class ServicesForTeacherClass {
    @Autowired
    RepositoryForTeacherClass repo;

    public Teacher addTeacher(Teacher teacher){
        Teacher t=repo.save(teacher);
        return  t;
    }


    public ArrayList<Teacher> show(){
        ArrayList<Teacher> t=repo.view();
        return  t;
    }

   public Teacher findbyidandpassword(String email,String password){
        Teacher teacher=repo.findByIdAndPassword(email,password);
        try {
            teacher.getEmail();
            return teacher;
        }
        catch (Exception e){
            return null;
        }
   }
    public Teacher findbyid(String email){
        Teacher teacher=repo.findByid(email);
        try {
            teacher.getEmail();
            return teacher;
        }
        catch (Exception e){
            return null;
        }
    }

    public void delete(String email){
        repo.deleteById(email);
    }


}
