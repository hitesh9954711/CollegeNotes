package com.example.CollegeNotes.Services;

import com.example.CollegeNotes.Entities.Notes;
import com.example.CollegeNotes.Repositories.RepositoryForNotesClass;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import java.lang.reflect.Array;
import java.util.ArrayList;

@Service
public class ServiceForNotesClass {
    @Autowired
    private  RepositoryForNotesClass repo;

    public Notes saveNotes(Notes note){
        Notes n=repo.save(note);
        return n;
    }
    public ArrayList<Notes> viewnotes(String course,String semester,String subject,String unit,String teacher_email) {
        ArrayList<Notes> notes = repo.viewNotes(course, semester, subject, unit, teacher_email);
        return notes;
    }

    public ArrayList<Notes> search(String course,String semester,String subject,String unit,String topic,String teacher_email){
        ArrayList<Notes> notes=repo.searchNotes(course,semester,subject,unit,topic,teacher_email);
        return notes;
    }

    public Notes findbyid(int id){
        Notes n=repo.findById(id);
        return n;
    }
    public void deletebyid(int id){
        Notes note=repo.deleteById(id);
    }


   public ArrayList<Notes> getByCourse(String subject){
        ArrayList<Notes> notes=repo.findBySubject(subject);
        return notes;
   }

   public ArrayList<Notes> findbycourse(String course){
       ArrayList<Notes> notes=repo.findByCourse(course);
       return notes;
   }

    public ArrayList<Notes> findbyemail(String teacher_email){
        ArrayList<Notes> notes=repo.findByemail(teacher_email);
        return notes;
    }

    public ArrayList<Notes> searchnotes(String course,String semester,String subject,String unit){
        ArrayList<Notes> notes=repo.searchStudentNotes(course,semester,subject,unit);
        return notes;
    }
    public ArrayList<Notes> searchnotesbytopic(String course,String semester,String subject,String unit,String topic){
        ArrayList<Notes> notes=repo.searchNotesByunit(course,semester,subject,unit,topic);
        return notes;
    }

}
