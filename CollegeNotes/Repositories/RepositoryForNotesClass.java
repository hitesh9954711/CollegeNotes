package com.example.CollegeNotes.Repositories;

import com.example.CollegeNotes.Entities.Notes;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.RepositoryDefinition;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;

@RepositoryDefinition(domainClass = Notes.class,idClass = Integer.class)
public interface RepositoryForNotesClass extends JpaRepository<Notes,Integer> {
    public Notes save(Notes note);

    @Query("from Notes where  course=:course and semester=:semester and subject=:subject and unit=:unit and teacher_email=:teacher_email")
    public ArrayList<Notes> viewNotes(@RequestParam("course") String course,
                                      @RequestParam("semester") String semester,
                                      @RequestParam("subject") String subject,
                                      @RequestParam("unit") String unit,
                                      @RequestParam("teacher_email") String teacher_email);

    @Query("from Notes where course=:course and semester=:semester and subject=:subject and unit=:unit and topic=:topic and teacher_email=:teacher_email")
    public ArrayList<Notes> searchNotes(@RequestParam("course") String course,@RequestParam("semester") String semester,@RequestParam("subject") String subject,
                                        @RequestParam("unit") String unit,@RequestParam("topic") String topic,@RequestParam("teacher_email") String teacher_email);

    @Query("from Notes where course=:course and semester=:semester and subject=:subject and unit=:unit and topic=:topic")
    public ArrayList<Notes> searchNotesByunit(@RequestParam("course") String course,@RequestParam("semester") String semester,@RequestParam("subject") String subject,
                                        @RequestParam("unit") String unit,@RequestParam("topic") String topic);

    public Notes findById(int id);

    public Notes deleteById(int id);

    @Query("from Notes where subject=:subject")
    public ArrayList<Notes> findBySubject(@RequestParam("subject") String subject);

    @Query("from Notes where course=:course")
    public ArrayList<Notes> findByCourse(@RequestParam("course") String course);

    @Query("from Notes where teacher_email=:teacher_email")
    public ArrayList<Notes> findByemail(@RequestParam("teacher_email") String teacher_email);


    @Query("from Notes where  course=:course and semester=:semester and subject=:subject and unit=:unit")
    public ArrayList<Notes> searchStudentNotes(@RequestParam("course") String course,
                                      @RequestParam("semester") String semester,
                                      @RequestParam("subject") String subject,
                                      @RequestParam("unit") String unit);

}
