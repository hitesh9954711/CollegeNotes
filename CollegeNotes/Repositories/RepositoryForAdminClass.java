package com.example.CollegeNotes.Repositories;

import com.example.CollegeNotes.Entities.Admin;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.RepositoryDefinition;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.ArrayList;

@RepositoryDefinition(domainClass = Admin.class,idClass = String.class)
public interface RepositoryForAdminClass extends JpaRepository<Admin,String> {

    public Admin save(Admin admin);

    @Query("from Admin where adminEmail=:adminEmail and adminPassword=:adminPassword")
    public Admin findByEmailAndPassword(@RequestParam("adminEmail") String adminEmail,@RequestParam("adminPassword")
            String adminPassword);

    public Admin findByadminEmail(String adminEmail);

    @Query("from Admin")
    public ArrayList<Admin> viewAll();

    public void deleteByadminEmail(String adminEmail);

}
