<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="org.springframework.web.servlet.ModelAndView"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.example.CollegeNotes.Entities.Course"%>
<%@page import="com.example.CollegeNotes.Entities.Admin"%>
<%@page import="com.example.CollegeNotes.Entities.CourseDetails"%>
<!doctype html>
<html lang="en">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

    <title>view courses</title>
  </head>
  <body>
        <%
                             Admin admin=(Admin) session.getAttribute("admin");
                             int i=0;
                             ArrayList<ArrayList<CourseDetails>> arrayLists=(ArrayList<ArrayList<CourseDetails>>) request.getAttribute("arrayLists");
                             if(admin==null){
                                  response.sendRedirect("index");
                                                    }
            %>

<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <a class="navbar-brand" href="#"> <span class="fas fa-graduation-cap"> CollegeNotes</span></a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>

  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item active">
        <a class="nav-link" href="showDashboard"><span class="fa fa-edit"></span> Home<span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item active">
              <a class="nav-link" href="viewAllCourses"><span class="fa fa-window-maximize"></span> View All Courses<span class="sr-only">(current)</span></a>
            </li>
<li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                      Teacher Section
                    </a>
                    <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                     <a class="dropdown-item"  href="showTeachers"><span class="fa fa-address-book"></span> View All Teachers<span class="sr-only">(current)</span></a>
                     <a class="dropdown-item"  href="showTeachersRequest"><span class="fa fa-address-book"></span>Teachers Requests <span class="sr-only">(current)</span></a>
             </li>
                                <li class="nav-item active">
                                           <a class="nav-link"  href="showAdmins"><span class="fas fa-users"></span> View All Admins<span class="sr-only">(current)</span></a>
                                             </li>
    </ul>
    		<ul class="navbar-nav ml-auto">

    			<li class="nav-item active"><a class="nav-link"
    				href="#"><span class="fa fa-user-circle"></span> <%=admin.getAdminName()%></a></li>
    			<li class="nav-item active"><a class="nav-link" href="Logout"><span
    					class="fa fa-external-link"></span> Logout </a></li>

    		</ul>
     <form class="form-inline my-2 my-lg-0" action="search">
          <input class="form-control mr-sm-2" type="search" name="course" placeholder="Enter Course Name" aria-label="Search">
          <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
        </form>
  </div>
</nav>

  <div class="container mt-3">
         <div class="card">
              <div class="card-header text-center">
                  <img class="card-img-top mx-auto" src="images/1.png"
                   style="height: 70px; width: 70px;" alt="Card image cap">
                  <p>Courses</p>
              </div>
              <div class="card-body">
                                    <div class="container text-center">
                                         <form action="deleteCourse" class="course" method="post">
                                           <div class="form-group">
                                                <label>Delete Course</label>
                                                <select name="course" class="form-control">
                                                     <option value="" selected disabled>select course</option>
                                                   <c:forEach items="${c}" var="data">
                                                      <option value="${data.course}">${data.course}</option>
                                                   </c:forEach>
                                                </select>
                                           </div>
                                           <div class="container text-center">
                                              <button  type="submit" class="btn btn-danger btn-sm course">Delete Course</button>
                                           </div>
                                         </form>
                                    </div>


                   <%
                                           for(ArrayList<CourseDetails> c:arrayLists) {
                   %>

                                                     <table class="table mt-3 pr-0 pl-0">
                   <%
                                                       for (CourseDetails d : c) {


                   %>
                                                         <tr>
                                                                  <th  class="pr-0 pl-0 text-primary"><%=d.getCourse()%></th>
                                                                  <th colspan="2" class="pr-0 pl-0 text-primary"><%=d.getSemester()%></th>
                                                            </tr>
                                                            <tr>
                                                                  <th class="pr-0 pl-0">Subjects</th>

                                                                  <th class="pr-0 pl-0">Action</th>
                                                            </tr>
                   <%

                                                           ArrayList<String> subjects = d.getSubjects();
                                                           for (int j = 0; j < subjects.size(); j++) {
                   %>
                                                    <tr>
                                                          <th><%=subjects.get(j)%></th>
                                                          <th class="pr-0 pl-0"><a  href="deleteSubject?id=<%=d.getId()%>&subjectIndex=<%=j%>" class="btn btn-danger btn-sm form1">delete</a></th>
                  <%
                                                           }
                   %>
                                                          </tr>
                                                          <tr>
                                                          <th class="pr-0 pl-0"><a data-toggle="modal" data-target="#exampleModal<%=d.getId()%>"  class="btn btn-warning btn-md">update semester</th>
                                                          <th   class="pr-0 pl-0"><a href="deleteSemester?id=<%=d.getId()%>&course=<%=d.getCourse()%>&semester=<%=d.getSemester()%>"  class="btn btn-danger btn-md deleteSemester">delete semester</th>
                                                        </tr>



                                                     <!-- Modal -->
                                                     <div class="modal fade" id="exampleModal<%=d.getId()%>" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                                                       <div class="modal-dialog" role="document">
                                                         <div class="modal-content">
                                                           <div class="modal-header">
                                                             <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
                                                             <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                               <span aria-hidden="true">&times;</span>
                                                             </button>
                                                           </div>
                                                           <div class="modal-body">
                                                             <form method="post" action="addSubject">
                                                             <div class="form-group">
                                                             <input type="hidden" name="id" value="<%=d.getId()%>">
                                                             </div>
                                                             <div class="form-group">
                                                               <label>Add Course</label>
                                                               <input type="text"  name="course" class="form-control">
                                                             </div>



                                                           </div>
                                                           <div class="modal-footer">
                                                             <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                                             <button type="submit" class="btn btn-primary">Add Subject</button>
                                                             </form>
                                                           </div>
                                                         </div>
                                                       </div>
                                                     </div>

                    <%

                                                       }
                    %>
                                               </table>

                    <%
                                                   }
                   %>
              </div>
         </div>
  </div>


    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js" integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <script src='https://kit.fontawesome.com/a076d05399.js'></script>
<script type='text/javascript'>
        $(document).ready(function() {
            $(".form1").click(function(e){
              var href = $(this).attr('href');
              e.preventDefault();
                swal({
  title: "Are you sure?",
  text: "If you delete the subject all related notes of this subject will we deleted.",
  icon: "warning",
  buttons: true,
  dangerMode: true,
})
.then((willDelete) => {
  if (willDelete) {
    swal("Subject is deleted", {
      icon: "success",
    });
    window.location.href = href;
  } else {
    swal("subject is not deleted");

  }
});
          });

                      $(".course").submit(function(e){

                        e.preventDefault();
                          swal({
            title: "Are you sure?",
            text: "If you delete this course then all related semester,subject and notes  will be deleted.",
            icon: "warning",
            buttons: true,
            dangerMode: true,
          })
          .then((willDelete) => {
            if (willDelete) {
              swal("course  is deleted.", {
                icon: "success",
              });
              e.currentTarget.submit();
            } else {
              swal("course  is not deleted.");

            }
          });
                    });




                                              $(".deleteSemester").click(function(e){
                                                  var href = $(this).attr('href');
                                                  e.preventDefault();
                                                    swal({
                                      title: "Are you sure?",
                                      text: "If you delete this semester then all related notes of this semester will be deleted.",
                                      icon: "warning",
                                      buttons: true,
                                      dangerMode: true,
                                    })
                                    .then((willDelete) => {
                                      if (willDelete) {
                                        swal("semester and its related notes is deleted", {
                                          icon: "success",
                                        });
                                        window.location.href = href;
                                      } else {
                                        swal("semester and its related notes is safe.");

                                      }
                                    });
          });

               });
       </script>
  <%
   request.removeAttribute("arrayLists");

  %>
  </body>
</html>