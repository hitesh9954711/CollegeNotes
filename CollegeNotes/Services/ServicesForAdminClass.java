package com.example.CollegeNotes.Services;

import com.example.CollegeNotes.Entities.Admin;
import com.example.CollegeNotes.Repositories.RepositoryForAdminClass;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

@Service
public class ServicesForAdminClass {

    @Autowired
    RepositoryForAdminClass repo;

    public void  createAdmin(){
        Admin a=repo.findByEmailAndPassword("admin177001@gamil.com","admin177001");
        try{
            a.getAdminEmail();
        }
        catch (Exception e){
            a=null;
        }
        if(a==null) {
            Admin admin = new Admin("admin", "admin177001@gmail.com", "admin177001");
            repo.save(admin);
        }
    }

    public Admin checkAdmin(String  adminEmail,String adminPassword){
      try {
          Admin admin=repo.findByEmailAndPassword(adminEmail,adminPassword);
          admin.getAdminEmail();
          return admin;
      }
      catch(NullPointerException e){
          return null;
      }
    }

    public Admin verify(String email){
        try{

            Admin admin=repo.findByadminEmail(email);
            admin.getAdminName();
            return admin;

        }
        catch (Exception e){
            e.printStackTrace();
            return null;
        }
    }

    public Admin saveAdmin(Admin admin){
        Admin admin1=repo.save(admin);
        return admin1;
    }

    public ArrayList<Admin> viewAllAdmins(){
        ArrayList<Admin> admins=repo.viewAll();
        return admins;
    }

    public Admin findbyidandpassword(String email,String password){
        Admin admin=repo.findByEmailAndPassword(email,password);
        try{
            admin.getAdminEmail();
            return admin;
        }
        catch (Exception e){
            e.printStackTrace();
            return null;
        }
    }

    public void  delete(String adminEmail){
        repo.deleteByadminEmail(adminEmail);
    }

}
