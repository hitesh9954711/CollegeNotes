package com.example.CollegeNotes.Controllers;

import com.example.CollegeNotes.Entities.*;
import com.example.CollegeNotes.Helpers.DeleteFilesAndImages;
import com.example.CollegeNotes.Helpers.Message;
import com.example.CollegeNotes.Helpers.PasswordGenerator;
import com.example.CollegeNotes.Helpers.StudentNotes;
import com.example.CollegeNotes.MailClasses.MailServicesImp;
import com.example.CollegeNotes.Repositories.RepositoryForCourseClass;
import com.example.CollegeNotes.Services.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Array;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller
public class AdminController {

    @Autowired
    ServicesForAdminClass adminService;

    @Autowired
    ServicesForCourseClass repoService;

    @Autowired
    ServicesForTeacherClass teacherService;

    @Autowired
    ServicesForCourseDetailsClass detailService;

    @Autowired
    ServicesForTeacherRequestClass teacherRequestClass;

    @Autowired
    MailServicesImp mail;

    @Autowired
    ServicesForStudentClass studentService;

    @Autowired
    ServiceForNotesClass noteService;

    @RequestMapping("/index")
    public ModelAndView admin(HttpServletRequest request) {
        ModelAndView mv = new ModelAndView("index");
        adminService.createAdmin();
        HttpSession session=request.getSession();
        Message message=(Message) session.getAttribute("message");
        session.removeAttribute("message");
        request.setAttribute("message",message);
        return mv;
    }

    @RequestMapping("/showTeachers")
    public ModelAndView showTeachers(HttpServletRequest request){
        ModelAndView mv=new ModelAndView("viewTeachers");
        ArrayList<Teacher> teachers=teacherService.show();
        request.setAttribute("teacher",teachers);
        return mv;
    }

    @RequestMapping("/showAdmins")
    public ModelAndView showAdmins(HttpServletRequest request){
        ModelAndView mv=new ModelAndView("viewAdmins");
        ArrayList<Admin> admins=adminService.viewAllAdmins();
        request.setAttribute("admins",admins);
        return mv;
    }

    @RequestMapping("/search")
    public ModelAndView search(@RequestParam("course") String course,HttpServletRequest request){
        ModelAndView mv=new ModelAndView("view");
        ArrayList<ArrayList<CourseDetails>> arrayLists=new ArrayList<>();
        String courseName = course.toUpperCase();
        ArrayList<CourseDetails> lists=detailService.view(courseName);
        arrayLists.add(lists);
        request.setAttribute("arrayLists",arrayLists);
        return mv;
    }

    @RequestMapping("/viewAllCourses")
    public ModelAndView view(HttpServletRequest request){
        ModelAndView mv=new ModelAndView("view");
        ArrayList<Course> courses=repoService.getCourses();
        int i=0;
        ArrayList<ArrayList<CourseDetails>> arrayLists=new ArrayList<ArrayList<CourseDetails>>();
        for(Course c:courses){
            ArrayList<CourseDetails> lists=detailService.view(c.getCourse());
            arrayLists.add(lists);
        }

        for(ArrayList<CourseDetails> c:arrayLists) {
            for (CourseDetails d : c) {
                System.out.println(d.getId());
                System.out.println(d.getCourse());
                System.out.println(d.getSemester());
                i = 0;
                ArrayList<String> subjects = d.getSubjects();
                for (int j = 0; j < subjects.size(); j++) {
                    System.out.println(subjects.get(j));
                }

            }
        }
        request.setAttribute("arrayLists",arrayLists);
        return mv;

    }

    @RequestMapping(value = "/login",method = RequestMethod.POST)
    public ModelAndView login(@RequestParam("email") String email, @RequestParam("password") String password,
                     HttpServletRequest request, HttpServletResponse response) throws IOException {
        ModelAndView mv = new ModelAndView();
        HttpSession session = request.getSession();
        Student student=studentService.findbyidandpassword(email,password);
        Teacher teacher=teacherService.findbyidandpassword(email,password);
        Admin admin = adminService.checkAdmin(email, password);
        if (admin != null) {
            session.setAttribute("admin", admin);
            mv.setViewName("AdminDashBoard");
            Message message = new Message("success", "Welcome " + admin.getAdminName());
            session.setAttribute("message", message);
            response.sendRedirect("showDashboard");
            return mv;
        }

        else if(student!=null){
            session.setAttribute("student",student);
            mv.setViewName("StudentNotes");
            Message message=new Message("success","Welcome "+student.getName());
            response.sendRedirect("studentDashboard");
            request.setAttribute("message",message);
            return mv;
        }
        else if(teacher!=null){
            session.setAttribute("user",teacher);
            mv.setViewName("addNotes");
            Message message=new Message("success","Welcome "+teacher.getName());
            session.setAttribute("message",message);
            response.sendRedirect("teacherDashboard");
            return mv;
        }

        else {
            Message message = new Message("danger", "You Hava Entered Wrong  Password and  Email");
            mv.addObject(message);
            mv.setViewName("index");
            return mv;
        }

    }


    @RequestMapping(value = "/teacherDashboard")
    public ModelAndView teacher(HttpServletResponse response,HttpServletRequest request){
        ModelAndView mv=new ModelAndView("addNotes");
        HttpSession session=request.getSession();
        Teacher teacher=(Teacher) session.getAttribute("user");
        Message message=(Message) session.getAttribute("message");
        ArrayList<Course> courses=new ArrayList<>();
        ArrayList<ArrayList<CourseDetails>> courseDetails=new ArrayList<ArrayList<CourseDetails>>();
        for(String str1:teacher.getCourse()){
            courses.add(repoService.view(str1));
        }
        for(String str1:teacher.getCourse()){
            ArrayList<CourseDetails> list=detailService.view(str1);
            courseDetails.add(list);
        }

        session.setAttribute("courses",courses);
        session.setAttribute("courseDetails",courseDetails);
        session.removeAttribute("message");
        request.setAttribute("message",message);
        return mv;
    }

    @RequestMapping(value = "/showDashboard")
    public ModelAndView show(HttpServletRequest request, HttpServletResponse response) {
        ModelAndView mv = new ModelAndView("AdminDashBoard");
        ArrayList<Course> c = repoService.getCourses();
        HttpSession session = request.getSession();
        Message message = (Message) session.getAttribute("message");
        request.setAttribute("message",message);
        session.setAttribute("c",c);
        session.removeAttribute("message");
        return mv;
    }

    @RequestMapping(value = "/addCourse", method = RequestMethod.POST)
    public ModelAndView addCourse(@RequestParam("course") String course,
                                  @RequestParam("semesters") ArrayList<String> semesters, HttpServletResponse response, HttpServletRequest request) throws IOException {
        String courseName = course.toUpperCase();
        ModelAndView mv = new ModelAndView();
        mv.setViewName("AdminDashBoard");
        HttpSession session = request.getSession();
        Course b = repoService.check(courseName);
        if (b == null) {
            Course c = repoService.addCourse(courseName, semesters);
            Message message = new Message("success", "Course is added succesfully");
            session.setAttribute("message", message);
            response.sendRedirect("showDashboard");
            return mv;
        } else {
            Message message = new Message("danger", "Sorry" +
                    "Course is not added succesfully. Course is already added");
            mv.addObject(message);
            return mv;

        }
    }




    @RequestMapping(value = "/addCourseDetails", method = RequestMethod.POST)
    public ModelAndView addCourseDetails(@RequestParam("course") String course, @RequestParam("semester") String semester
            , @RequestParam("subjects")ArrayList<String> list1, HttpServletRequest request,
                                         HttpServletResponse response) throws IOException {
        ModelAndView mv=new ModelAndView("AdminDashBoard");
        ArrayList<String> list=new ArrayList<>();
        list=list1;
        for(int i=0;i<list.size();i++){
            String str=list.get(i);
            if(str.isEmpty()){
               list.remove(i);
               list.add(i,null);
            }
        }
        while (list.remove(null)) {
        }
       CourseDetails details=new CourseDetails();
        details.setCourse(course);
        details.setSemester(semester);
        details.setSubjects(list);
        CourseDetails c=detailService.saveDetails(details);
        if(c!=null){
            Message message=new Message("success","Course details is added successfully");
            HttpSession session=request.getSession();
            session.setAttribute("message",message);
            response.sendRedirect("/showDashboard");

        }
        else{
            Message message=new Message("danger","error");
            mv.addObject(message);

        }
        return mv;
    }

    @RequestMapping(value = "/createAdmin",method = RequestMethod.POST)
    public ModelAndView createAdmin(Admin admin,HttpServletResponse response,HttpServletRequest request) throws IOException {
        ModelAndView mv=new ModelAndView("AdminDashBoard");
         Admin a=adminService.verify(admin.getAdminEmail());
         Teacher teacher=teacherService.findbyidandpassword(admin.getAdminEmail(),admin.getAdminPassword());
         Student student=studentService.findbyidandpassword(admin.getAdminEmail(),admin.getAdminPassword());
         if(a==null&&teacher==null&&student==null){
             Admin a1=adminService.saveAdmin(admin);
             Message message=new Message("success","Admin id is created successfully");
             HttpSession session=request.getSession();
             session.setAttribute("message",message);
             response.sendRedirect("showDashboard");
             return  mv;
         }
         else{
             Message message=new Message("danger","Admin id is not created successfully please use other email");
             mv.addObject(message);
             return mv;
         }
    }

    @RequestMapping("Logout")
    public void logout(HttpServletRequest request,HttpServletResponse response) throws IOException {
        HttpSession session=request.getSession();
        session.removeAttribute("admin");
        session.removeAttribute("c");
        Message message=new Message("success","You Have Successfully Logout.");
        response.sendRedirect("index");
    }

    //Teachers-block


    @RequestMapping("/register")
    public ModelAndView register(HttpServletRequest request){
        ModelAndView mv=new ModelAndView("registration");
        ArrayList<Course> c=repoService.getCourses();
        HttpSession session=request.getSession();
        Message message=(Message) session.getAttribute("message");
        request.setAttribute("c",c);
        request.setAttribute("message",message);
        session.removeAttribute("message");
        return mv;
    }


    @RequestMapping(value="/teacherRegister",method = RequestMethod.POST)
    public ModelAndView addTeacher(@RequestParam("name")String name,@RequestParam("email") String email,
            @RequestParam("course") ArrayList<String> course,@RequestParam("gender") String gender,HttpServletResponse response,HttpServletRequest request) throws IOException {
        ModelAndView mv=new ModelAndView("registration");
        HttpSession session = request.getSession();
        String password=PasswordGenerator.generate(15);
        TeacherRequest teacherRequest=new TeacherRequest();
        teacherRequest.setEmail(email);
        teacherRequest.setName(name);
        teacherRequest.setCourse(course);
        teacherRequest.setGender(gender);
        teacherRequest.setPassword(password);
        Admin admin=adminService.findbyidandpassword(teacherRequest.getEmail(),teacherRequest.getPassword());
        Student student=studentService.findbyidandpassword(teacherRequest.getEmail(),teacherRequest.getPassword());
        Teacher teacher=teacherService.findbyidandpassword(teacherRequest.getEmail(),teacherRequest.getPassword());
        Teacher teacher1=teacherService.findbyid(teacherRequest.getEmail());
        if(admin==null&&student==null&&teacher==null&&teacher1==null) {
            TeacherRequest teachers = teacherRequestClass.saveRequest(teacherRequest);
            Message msg = new Message("success", "You have successfully registered! Admin will send password in your email.");
            session.setAttribute("message", msg);
        }
        else {
            Message msg = new Message("danger", "Something went wrong please try again or use another email!!");
            session.setAttribute("message", msg);
        }
        response.sendRedirect("register");
        return mv;
    }

    @RequestMapping(value = "/studentRegister",method = RequestMethod.POST)
    public void addStudent(@RequestParam("name") String name,@RequestParam("email") String email,
            @RequestParam("course") String course,HttpServletRequest request,HttpServletResponse response) throws IOException {
        HttpSession session=request.getSession();
        Student student=new Student();
        student.setEmail(email);
        student.setName(name);
        student.setCourse(course);
        String password=PasswordGenerator.generate(15);
        student.setPassword(password);
        Admin admin=adminService.findbyidandpassword(student.getEmail(),student.getPassword());
        Teacher request1=teacherService.findbyidandpassword(student.getEmail(),student.getPassword());
        Student st=studentService.findbyidandpassword(student.getEmail(),student.getPassword());
        Student st1=studentService.findByid(student.getEmail());
        if(admin==null&&request1==null&&st==null&&st1==null) {
                        try {
                            mail.send(student.getEmail(), "collegenotesnotes@gmail.com", "Student Password",
                                    "<p>email</p>" + student.getEmail() + "<p>password</p>" + student.getPassword());
                            Student s = studentService.saveStudent(student);
                            Message message = new Message("success", "Check your email for password");
                            session.setAttribute("message", message);


                        } catch (Exception e) {
                            Message message = new Message("danger", "something went wrong!");
                            session.setAttribute("message", message);

                            e.printStackTrace();
                        }
        }
        else{
              Message message=new Message("danger","Sorry Something Went Wrong. please try again!!");
              session.setAttribute("message",message);
        }
        response.sendRedirect("register");

    }


    @RequestMapping("/showTeachersRequest")
    public ModelAndView showRequests(HttpServletRequest request){
        ModelAndView mv=new ModelAndView("viewTeacherRequests");
        ArrayList<TeacherRequest> requests=teacherRequestClass.teacherRequests();
        HttpSession session=request.getSession();
        Message message=(Message) session.getAttribute("messsage");
        request.setAttribute("message",message);
        request.setAttribute("teacherRequests",requests);
        session.removeAttribute("message");
        return mv;
    }


    @RequestMapping("verify")
    public void verify(HttpServletRequest request,@RequestParam("id") int id,HttpServletResponse response) throws IOException {
        TeacherRequest teacher=teacherRequestClass.get(id);
        HttpSession session=request.getSession();
        Teacher newTeacher=new Teacher();
        newTeacher.setName(teacher.getName());
        newTeacher.setEmail(teacher.getEmail());
        newTeacher.setCourse(teacher.getCourse());
        newTeacher.setGender(teacher.getGender());
        newTeacher.setPassword(teacher.getPassword());
        teacherRequestClass.delete(id);
        try {
            mail.send(newTeacher.getEmail(), "collegenotesnotes@gmail.com", "CollegeNotes username and password", "<p>Email:</p>"+newTeacher.getEmail()+
                    "<p>password:</p><p>"+newTeacher.getPassword()+"<p>Course</p>"+newTeacher.getCourse());
            Message message=new Message("success","Email is send");
            teacherService.addTeacher(newTeacher);
            session.setAttribute("message",message);
            response.sendRedirect("showTeachersRequest");
        }
        catch (Exception e){
            e.printStackTrace();
            Message message=new Message("danger","Email is not send");
            session.setAttribute("message",message);
            response.sendRedirect("showTeachersRequest");
        }
    }

    @RequestMapping("/deleteRequest")
    public void deleteRequest(@RequestParam("id") int id, HttpServletRequest request,HttpServletResponse response) throws IOException {
        teacherRequestClass.delete(id);
        Message message=new Message("info","request is deleted successfully");
        HttpSession session=request.getSession();
        session.setAttribute("message",message);
        response.sendRedirect("showTeachersRequest");
    }

    @RequestMapping("savenotes")
    public ModelAndView savenotes(@RequestParam("course") String course, @RequestParam("semester")
           String semester, @RequestParam("subject") String subject, @RequestParam("unit")String unit
          , @RequestParam("topic") String topic,
             @RequestParam("images") MultipartFile[] images,
             @RequestParam("files") MultipartFile[] files, HttpServletRequest request,HttpServletResponse response) throws IOException {
        ModelAndView mv=new ModelAndView("addNotes");
        HttpSession session=request.getSession();
        Teacher teacher=(Teacher) session.getAttribute("user");
        ArrayList<String> image=new ArrayList<>();
        ArrayList<String> file=new ArrayList<>();
        String imagePath=request.getRealPath("/")+"notesImages";
        String filePath=request.getRealPath("/")+"notesFiles";
        for(MultipartFile img:images){
           if(img.isEmpty()){
               System.out.println("zero");
           }
           else{
                  String originalImageName=img.getOriginalFilename();
                  String ext=PasswordGenerator.generate(3);
                  String finalName=ext+originalImageName;
                  Path imageNamePath= Paths.get(imagePath,finalName);
                  image.add(finalName);
                  try{
                      Files.write(imageNamePath,img.getBytes());
                  }
                  catch (Exception e){
                     e.printStackTrace();
                  }
           }
        }
        for(MultipartFile file1:files){
            if(file1.isEmpty()){
                System.out.println("zero");
            }
            else{
                String originalFileName=file1.getOriginalFilename();
                String ext=PasswordGenerator.generate(3);
                String finalFileName=ext+originalFileName;
                Path fileNamePath=Paths.get(filePath,finalFileName);
                file.add(finalFileName);
                try{
                    Files.write(fileNamePath,file1.getBytes());
                }
                catch (Exception e){
                    e.printStackTrace();
                }
            }
        }

        String topic1=topic.toUpperCase();
        Notes note=new Notes(course,semester,subject,unit,topic1,image,file,teacher);
        note.setDate(new Date());
        noteService.saveNotes(note);
        Message message=new Message("success","Notes is added successfully");
        session.setAttribute("message",message);
        response.sendRedirect("teacherDashboard");
        return mv;
    }

    @RequestMapping("/viewNotes")
    public ModelAndView viewNotes(HttpServletRequest request){
        ModelAndView mv=new ModelAndView("viewnotes");
        HttpSession session=request.getSession();
        return mv;
    }

    @RequestMapping("/searchUnitNotes")
     public void searchunitnotes(@RequestParam("course") String course,@RequestParam("semester") String semester,@RequestParam("subject") String subject,
                                 @RequestParam("unit") String unit,@RequestParam("id") String id,@RequestParam("topic") String topic, HttpServletRequest request,HttpServletResponse response) throws IOException {

        HttpSession session=request.getSession();
        ArrayList<Notes> notes=noteService.search(course,semester,subject,unit,topic,id);
        session.setAttribute("notes",notes);
        response.sendRedirect("viewNotes");
    }

    @RequestMapping(value = "/findnotes",method = RequestMethod.POST)
    public void findNotes(@RequestParam("course") String course,@RequestParam("semester") String semster,@RequestParam("subject") String subject,
                                  @RequestParam("unit") String unit,HttpServletRequest request,HttpServletResponse response) throws IOException {


        HttpSession session=request.getSession();
        Teacher teacher= (Teacher) session.getAttribute("user");
        String email=teacher.getEmail();
        ArrayList<Notes> notes=noteService.viewnotes(course,semster,subject,unit,email);
        session.setAttribute("notes",notes);
        response.sendRedirect("viewNotes");


    }
    @RequestMapping("/delete")
    public void delete(@RequestParam("course") String course,@RequestParam("semester") String semester,@RequestParam("subject") String subject,@RequestParam("unit") String unit,@RequestParam("id") int id,@RequestParam("name") String name,@RequestParam("index") int index,@RequestParam("type") String type
    ,@RequestParam("email") String email,HttpServletRequest request,HttpServletResponse response) throws IOException {
        Notes note = noteService.findbyid(id);
        DeleteFilesAndImages delete = new DeleteFilesAndImages();
        System.out.println(type);
        String type1="images";
        String type2="files";
        if(type.equals(type1)) {
            ArrayList<String> image = note.getImages();
            image.remove(index);
            note.setImages(image);
            Notes getNotes = noteService.saveNotes(note);
            String path1 = request.getRealPath("/") + "notesImages" + File.separator + name;
            System.out.println(path1);
            Boolean f = delete.delete(path1);
            System.out.println(f);
        }
        else if(type.equals(type2)){
            ArrayList<String> file = note.getFiles();
            file.remove(index);
            note.setFiles(file);
            Notes getNotes = noteService.saveNotes(note);
            String path1 = request.getRealPath("/") + "notesFiles" + File.separator + name;
            System.out.println(path1);
            Boolean f = delete.delete(path1);
            System.out.println(f);
        }
        else{
            ArrayList<String> images=note.getImages();
            ArrayList<String> files=note.getFiles();
            for(String img:images){
                String path1 = request.getRealPath("/") + "notesImages" + File.separator + img;
                delete.delete(path1);
            }
            for(String file:files){
                String path1 = request.getRealPath("/") + "notesFiles" + File.separator + file;
                delete.delete(path1);
            }
            noteService.deletebyid(id);
        }
        ArrayList<Notes> notes=noteService.viewnotes(course,semester,subject,unit,email);
        HttpSession session=request.getSession();
        session.setAttribute("notes",notes);
        response.sendRedirect("viewNotes");

    }

    @RequestMapping(value = "/updateNotes",method = RequestMethod.POST)
    public void updateNotes(@RequestParam("id") int id,@RequestParam("topic") String topic,@RequestParam("images") MultipartFile[] images,
                            @RequestParam("files") MultipartFile[] files,HttpServletRequest request,HttpServletResponse response) throws IOException {
       Notes note=noteService.findbyid(id);
       ArrayList<String> imageList=note.getImages();
       ArrayList<String> fileList=note.getFiles();
       String imagePath=request.getRealPath("/")+"notesImages";
       String filePath=request.getRealPath("/")+"notesFiles";

      for(MultipartFile image:images){
          if(image.isEmpty()){
              System.out.println("null");
          }
           else {
                String imageName=image.getOriginalFilename();
                String random=PasswordGenerator.generate(3);
                String finalName=random+imageName;
                Path imageNamePath=Paths.get(imagePath,finalName);
                try{
                 Files.write(imageNamePath,image.getBytes());
                 imageList.add(finalName);
                }
                catch (Exception e){
                    e.printStackTrace();
                }

          }

      }
      for(MultipartFile file:files){
          if(file.isEmpty()){
              System.out.println("null");
          }
          else{
              String fileName=file.getOriginalFilename();
              String random=PasswordGenerator.generate(3);
              String finalName=random+fileName;
              Path fileNamePath=Paths.get(filePath,finalName);
              try{
                  Files.write(fileNamePath,file.getBytes());
                  fileList.add(finalName);
              }
              catch (Exception e){
                  e.printStackTrace();
              }
          }
      }

      note.setImages(imageList);
      note.setFiles(fileList);
      note.setTopic(topic);
      Notes notes=noteService.saveNotes(note);
      String course=note.getCourse();
      String semester=note.getSemester();
      String unit=note.getUnit();
      String subject=note.getSubject();
      Teacher teacher=note.getTeacher();
      String email=teacher.getEmail();
      ArrayList<Notes> n=noteService.viewnotes(course,semester,subject,unit,email);
      HttpSession session=request.getSession();
      session.setAttribute("notes",n);
      response.sendRedirect("viewNotes");

    }

    @RequestMapping("/download")
    public ModelAndView download(@RequestParam("name") String name,@RequestParam("type") String type,HttpServletRequest request,HttpServletResponse response) throws IOException {
        ModelAndView mv=new ModelAndView("viewnotes");
        response.setContentType("text/html;");
        PrintWriter out=response.getWriter();
        String type1="image";

               if(type.equals(type1)){
                   String path1 = request.getRealPath("/") + "notesImages" + File.separator + name;
                    response.setContentType("APPLICATION/OCTET-STREAM");
                    response.setHeader("Content-Disposition","attachment;fileName=\""+name+"\"");
                   FileInputStream fis=new FileInputStream(path1);
                   int i;
                   while ((i=fis.read()) != -1) {
                       out.write(i);
                   }
                   fis.close();
                   out.close();
               }
               else {
                   String path1 = request.getRealPath("/") + "notesFiles" + File.separator + name;
                   response.setContentType("APPLICATION/OCTET-STREAM");
                   response.setHeader("Content-Disposition","attachment; fileName=\""+name+"\"");
                   FileInputStream fis=new FileInputStream(path1);
                   int i;
                   while ((i=fis.read()) != -1) {
                       out.write(i);
                   }
                   fis.close();
                   out.close();
               }

        return mv;
    }

    @RequestMapping("/updateTeacher")
    public ModelAndView updateTeacher(HttpServletRequest request){
        ModelAndView mv=new ModelAndView("UpdateTeacher");
        ArrayList<Course> c=repoService.getCourses();
        HttpSession session=request.getSession();
        Message message=(Message) session.getAttribute("message");
        request.setAttribute("message",message);
        session.removeAttribute("message");
        mv.addObject("c",c);
        return mv;
    }

    @RequestMapping(value = "/updateteachers",method = RequestMethod.POST)
    public void updateteacher(@RequestParam("email") String email,@RequestParam("name") String name,@RequestParam("course") ArrayList<String> course,
                              @RequestParam("password") String password,HttpServletRequest request,HttpServletResponse response) throws IOException {

        Admin admin=adminService.findbyidandpassword(email,password);
        Student student=studentService.findbyidandpassword(email,password);
        Teacher teacher=teacherService.findbyid("email");
        HttpSession session=request.getSession();
           if(admin==null && student==null) {
               teacher.setEmail(email);
               teacher.setName(name);
               teacher.setCourse(course);
               teacher.setPassword(password);
               teacherService.addTeacher(teacher);
               Message message=new Message("success","Teacher Details is updated successfully");
               session.setAttribute("message",message);
               response.sendRedirect("index");
               session.removeAttribute("notes");
               session.removeAttribute("user");
               session.removeAttribute("courseDetails");
               session.removeAttribute("course");
               response.sendRedirect("index");
           }
           else{
               Message message=new Message("danger","Please use another password");
               session.setAttribute("message",message);
               response.sendRedirect("updateTeacher");
           }

    }

    @RequestMapping("/teacherLogout")
    public  void teacherlogout(HttpServletRequest request,HttpServletResponse response) throws IOException {
        HttpSession session=request.getSession();
        session.removeAttribute("notes");
        session.removeAttribute("user");
        session.removeAttribute("courseDetails");
        session.removeAttribute("course");
        Message message=new Message("success","You have Logout Successfully");
        session.setAttribute("message",message);
        response.sendRedirect("index");
    }

    @RequestMapping("/deleteSubject")
    public void deleteSubject(@RequestParam("id") String Id,@RequestParam("subjectIndex") int subjectIndex,HttpServletRequest request,HttpServletResponse response) throws IOException {
       int id=Integer.parseInt(Id);
        CourseDetails d=detailService.get(id);
        ArrayList<String> subjects=d.getSubjects();
        String subject=subjects.get(subjectIndex);
        subjects.remove(subjectIndex);
        detailService.saveDetails(d);
     try {
         DeleteFilesAndImages delete = new DeleteFilesAndImages();
         ArrayList<Notes> notes = noteService.getByCourse(subject);
         for (Notes note : notes) {
             ArrayList<String> images = note.getImages();
             ArrayList<String> files = note.getFiles();
             for (String img : images) {
                 String path1 = request.getRealPath("/") + "notesImages" + File.separator + img;
                 delete.delete(path1);
             }
             for (String file : files) {
                 String path1 = request.getRealPath("/") + "notesFiles" + File.separator + file;
                 delete.delete(path1);
             }
            noteService.deletebyid(note.getId());
         }
     }
     catch (Exception e){
     }
        response.sendRedirect("viewAllCourses");
    }


    @RequestMapping("/deleteSemester")
    public void deleteSemester(@RequestParam("id") int id,@RequestParam("course") String course,@RequestParam("semester") String sem, HttpServletRequest request,HttpServletResponse response) throws IOException {
        //coursedetails
        CourseDetails details=detailService.get(id);
        detailService.delete(id);
        //course
       Course c=repoService.view(course);
       ArrayList<String> semster=c.getSemesters();
       semster.remove(sem);
       c.setSemesters(semster);
       repoService.s(c);

       //notes
       DeleteFilesAndImages delete=new DeleteFilesAndImages();
        ArrayList<Notes> notes=noteService.findbycourse(course);
        for (Notes note : notes) {
            ArrayList<String> images = note.getImages();
            ArrayList<String> files = note.getFiles();
            for (String img : images) {
                String path1 = request.getRealPath("/") + "notesImages" + File.separator + img;
                delete.delete(path1);
            }
            for (String file : files) {
                String path1 = request.getRealPath("/") + "notesFiles" + File.separator + file;
                delete.delete(path1);
            }
            noteService.deletebyid(note.getId());
        }
        response.sendRedirect("viewAllCourses");
    }

    @RequestMapping(value = "/deleteCourse",method = RequestMethod.POST)
    public void deleteCourse(@RequestParam("course") String course,HttpServletRequest request,HttpServletResponse response) throws IOException {
        repoService.delete(course);
        ArrayList<CourseDetails> courseDetails=detailService.view(course);
        DeleteFilesAndImages delete=new DeleteFilesAndImages();
        for(CourseDetails c:courseDetails){
            int a=c.getId();
            detailService.delete(a);
        }
        ArrayList<Notes> notes=noteService.findbycourse(course);
        for (Notes note : notes) {
            ArrayList<String> images = note.getImages();
            ArrayList<String> files = note.getFiles();
            for (String img : images) {
                String path1 = request.getRealPath("/") + "notesImages" + File.separator + img;
                delete.delete(path1);
            }
            for (String file : files) {
                String path1 = request.getRealPath("/") + "notesFiles" + File.separator + file;
                delete.delete(path1);
            }
            noteService.deletebyid(note.getId());
        }
        response.sendRedirect("viewAllCourses");

    }

    @RequestMapping(value = "/addSubject",method = RequestMethod.POST)
    public void addSubject(@RequestParam("id") int id,@RequestParam("course") String course,HttpServletResponse response) throws IOException {
        CourseDetails c=detailService.get(id);
        ArrayList<String> subject=c.getSubjects();
        subject.add(course);
        c.setSubjects(subject);
        detailService.saveDetails(c);
        response.sendRedirect("viewAllCourses");
    }

    @RequestMapping(value = "/deleteTeacher",method = RequestMethod.POST)
    public void deleteTeacher(@RequestParam("email") String email,HttpServletRequest request,HttpServletResponse response) throws IOException {

        ArrayList<Notes> notes=noteService.findbyemail(email);
        DeleteFilesAndImages delete=new DeleteFilesAndImages();
        for (Notes note : notes) {
            ArrayList<String> images = note.getImages();
            ArrayList<String> files = note.getFiles();
            for (String img : images) {
                String path1 = request.getRealPath("/") + "notesImages" + File.separator + img;
                delete.delete(path1);
            }
            for (String file : files) {
                String path1 = request.getRealPath("/") + "notesFiles" + File.separator + file;
                delete.delete(path1);
            }
            noteService.deletebyid(note.getId());
        }
         teacherService.delete(email);
        HttpSession session=request.getSession();
        Message message=new Message("success","Teacher id and all teacher's notes deleted successfully");
        session.setAttribute("message",message);
        response.sendRedirect("viewAllCourses");

    }

    @RequestMapping("/deleteAdmin")
    public void deleteAdmin(@RequestParam("email") String email,HttpServletRequest request,HttpServletResponse response) throws IOException {
        adminService.delete(email);
        HttpSession session=request.getSession();
        Message message=new Message("success","Admin id is deleted successfully.");
        session.setAttribute("message",message);
        response.sendRedirect("viewAllCourses");
    }

    @RequestMapping("/studentDashboard")
    public ModelAndView studentDashboard(HttpServletRequest request,HttpServletResponse response){
        ModelAndView mv=new ModelAndView("StudentNotes");
        HttpSession session=request.getSession();
        Student student=(Student) session.getAttribute("student");
        String course=student.getCourse();
        Course c=repoService.view(course);
        ArrayList<CourseDetails> courseDetails=detailService.view(course);
        session.setAttribute("c",c);
        session.setAttribute("co",courseDetails);
        ArrayList<StudentNotes> n=(ArrayList<StudentNotes>) session.getAttribute("studentN");
        request.setAttribute("studentNotes",n);
        session.removeAttribute("studentN");
        return mv;
    }

    @RequestMapping(value = "/searchStudentNotes",method = RequestMethod.POST)
    public void searchStudentNotes(@RequestParam("course") String course,@RequestParam("semester") String semester,@RequestParam("subject") String subject,
                                   @RequestParam("unit") String unit,HttpServletRequest request,HttpServletResponse response) throws IOException {
        ArrayList<Notes> notes=noteService.searchnotes(course,semester,subject,unit);
        ArrayList<StudentNotes> studentnotes=new ArrayList<StudentNotes>();
        for(Notes note:notes){
            StudentNotes s=new StudentNotes();
            s.setCourse(note.getCourse());
            s.setSemester(note.getSemester());
            s.setSubject(note.getSubject());
            s.setImages(note.getImages());
            s.setFiles(note.getFiles());
            s.setDate(note.getDate());
            s.setTopic(note.getTopic());
            s.setUnit(note.getUnit());
            Teacher t=note.getTeacher();
            s.setName(t.getName());
            studentnotes.add(s);
        }
        HttpSession session=request.getSession();
        session.setAttribute("studentN",studentnotes);
        response.sendRedirect("studentDashboard");

    }

    @RequestMapping(value="/searchNotesByUnit",method=RequestMethod.POST)
    public void searchNotesByUnit(@RequestParam("course") String course,@RequestParam("semester") String semester,@RequestParam("subject") String subject,
                                  @RequestParam("unit") String unit,@RequestParam("topic") String topic,HttpServletRequest request,HttpServletResponse response) throws IOException {
        ArrayList<Notes> notes=noteService.searchnotesbytopic(course,semester,subject,unit,topic);
        ArrayList<StudentNotes> studentnotes=new ArrayList<StudentNotes>();
        for(Notes note:notes){
            StudentNotes s=new StudentNotes();
            s.setCourse(note.getCourse());
            s.setSemester(note.getSemester());
            s.setSubject(note.getSubject());
            s.setImages(note.getImages());
            s.setFiles(note.getFiles());
            s.setDate(note.getDate());
            s.setTopic(note.getTopic());
            s.setUnit(note.getUnit());
            Teacher t=note.getTeacher();
            s.setName(t.getName());
            studentnotes.add(s);
        }
        HttpSession session=request.getSession();
        session.setAttribute("studentN",studentnotes);
        response.sendRedirect("studentDashboard");


    }

    @RequestMapping("/updateStudent")
    public ModelAndView updateStudent(){
        ModelAndView mv=new ModelAndView("updateStudent");
        return mv;
    }

    @RequestMapping("/updatestudent")
    public void updatestudent(@RequestParam("email") String email,@RequestParam("name") String name,@RequestParam("password") String password
    ,HttpServletRequest request,HttpServletResponse response) throws IOException {
        Teacher t=teacherService.findbyidandpassword(email,password);
        Admin a=adminService.findbyidandpassword(email,password);
        HttpSession session=request.getSession();
        if(t==null && a==null){
            Student student=studentService.findByid(email);
            student.setName(name);
            student.setPassword(password);
            studentService.saveStudent(student);
            Message message=new Message("success","Profile is updated successfully.");
            session.setAttribute("message",message);
            session.removeAttribute("student");
            session.removeAttribute("c");
            session.removeAttribute("co");
            response.sendRedirect("/index");
        }
        else{
            Message message=new Message("danger","please use another password");
            session.setAttribute("message",message);
            response.sendRedirect("/updateStudent");
        }
    }

    @RequestMapping("/studentLogout")
    public void studentLogout(HttpServletRequest request,HttpServletResponse response) throws IOException {
        HttpSession session=request.getSession();
        session.removeAttribute("student");
        session.removeAttribute("c");
        session.removeAttribute("co");
        session.removeAttribute("message");
        Message message=new Message("success","You Have Logout Successfully.");
        session.setAttribute("message",message);
        response.sendRedirect("index");

    }

    @RequestMapping("/ForgotPassword")
    public ModelAndView forgot(){
        ModelAndView mv=new ModelAndView("forgotPassword");
        return mv;
    }


    @RequestMapping("/emailcheck")
    public ModelAndView emailcheck(@RequestParam("email") String email,HttpServletRequest request,HttpServletResponse response) throws IOException {
        ModelAndView mv=new ModelAndView("reset");
        HttpSession session=request.getSession();
        Teacher teacher=teacherService.findbyid(email);
        Student student=studentService.findByid(email);
        Admin admin=adminService.verify(email);
        ArrayList<String> roles=new ArrayList<>();
        if(teacher!=null){
            String str="teacher";
            roles.add(str);
        }
         if(student!=null){
            String str1="student";
            roles.add(str1);
        }
         if(admin!=null){
            String str2="admin";
            roles.add(str2);
        }
        if(teacher==null && student==null && admin==null){
            Message message=new Message("danger","please enter valid email");
            session.setAttribute("message",message);
            response.sendRedirect("index");
        }

       session.setAttribute("roles",roles);
        return mv;
    }

    @RequestMapping("reset")
    public ModelAndView reset(@RequestParam("r") String role,@RequestParam("email") String email,@RequestParam("password") String password, HttpServletRequest request,HttpServletResponse response) throws IOException {
        ModelAndView mv=new ModelAndView("reset");
        HttpSession session=request.getSession();
        String teacher="teacher";
        String student="student";
        String admin="admin";

        if(teacher.equals(role)){
            Student s=studentService.findbyidandpassword(email,password);
            Admin  a=adminService.findbyidandpassword(email,password);
            Teacher t=teacherService.findbyid(email);
            if(s==null && a==null){
                t.setPassword(password);
                teacherService.addTeacher(t);
                Message message=new Message("success","Password is reset successfully");
                session.setAttribute("message",message);
                response.sendRedirect("index");
            }
            else{
                Message message=new Message("danger","Please use another password");
                request.setAttribute("message",message);
            }
        }
        else if(student.equals(role)){
            Admin a=adminService.findbyidandpassword(email,password);
            Teacher t=teacherService.findbyidandpassword(email,password);
            Student s=studentService.findByid(email);
            if(a==null && t==null){
                s.setPassword(password);
                studentService.saveStudent(s);
                Message message=new Message("success","Password is reset successfully");
                session.setAttribute("message",message);
                session.removeAttribute("roles");
                response.sendRedirect("index");
            }
            else{
                Message message=new Message("danger","please use another password");
                request.setAttribute("message",message);
            }
        }
        else if(admin.equals(role)){
            Teacher t=teacherService.findbyidandpassword(email,password);
            Student s=studentService.findbyidandpassword(email,password);
            Admin a=adminService.verify(email);
            if(t==null && s==null){
                a.setAdminPassword(password);
                adminService.saveAdmin(a);
                Message message=new Message("success","Password is reset successfully");
                session.setAttribute("message",message);
                session.removeAttribute("roles");
                response.sendRedirect("index");
            }
            else{
                Message message=new Message("danger","please use another password");
                request.setAttribute("message",message);
            }
        }
        else{
            Message message=new Message("danger","please use another password");
            request.setAttribute("message",message);
        }
        return mv;
    }





    }



