package com.example.CollegeNotes.Helpers;

import java.io.File;

public class DeleteFilesAndImages {

    public Boolean delete(String path){
        Boolean f=false;
        try {
            File file = new File(path);
            f = file.delete();

        }
        catch (Exception e){e.printStackTrace();}
        return f;
    }
}
