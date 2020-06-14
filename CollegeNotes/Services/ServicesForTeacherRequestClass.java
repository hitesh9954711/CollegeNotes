package com.example.CollegeNotes.Services;

import com.example.CollegeNotes.Entities.Teacher;
import com.example.CollegeNotes.Entities.TeacherRequest;
import com.example.CollegeNotes.Repositories.RepositoryForTeacherRequestClass;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

@Service
public class ServicesForTeacherRequestClass {

    @Autowired
    private RepositoryForTeacherRequestClass repo;

    public TeacherRequest saveRequest(TeacherRequest teacherRequest){
        TeacherRequest request=repo.save(teacherRequest);
        return request;
    }

    public ArrayList<TeacherRequest> teacherRequests(){
        ArrayList<TeacherRequest> requests=repo.getRequests();
        return requests;
    }

    public TeacherRequest get(int id){
        TeacherRequest teacher=repo.findByid(id);
        return teacher;
    }
    public  void delete(int id){
        repo.deleteById(id);

    }

    public TeacherRequest findbyidandpassword(String email,String password){
        TeacherRequest teacherRequest=repo.findByidAndPassword(email,password);
        try{
            teacherRequest.getEmail();
            return teacherRequest;
        }
        catch (Exception e){
            e.printStackTrace();
            return null;
        }
    }
}
