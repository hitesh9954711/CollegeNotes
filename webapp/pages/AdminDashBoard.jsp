<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="org.springframework.web.servlet.ModelAndView"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.example.CollegeNotes.Entities.Course"%>
<%@page import="com.example.CollegeNotes.Entities.Admin"%>
<!doctype html>
<html lang="en">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<meta name='viewport' content='width=device-width, initial-scale=1'>
<script src='https://kit.fontawesome.com/a076d05399.js'></script>
       <script src="https://code.jquery.com/jquery-3.5.1.min.js" integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>
       <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
       <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
       <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <title>Admin Dashboard</title>
  </head>
  <body>
    <%
                     Admin admin=(Admin) session.getAttribute("admin");
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
         			<li class="nav-item active"><a class="nav-link"  href="Logout"><span
         					class="fa fa-external-link"></span> Logout </a></li>

         		</ul>
  </div>
</nav>
<div class="jumbotron"  style="clip-path: polygon(20% 0%, 80% 0%, 100% 0, 100% 97%, 63% 100%, 34% 99%, 0 97%, 0 0);">
  <div class="row">
     <div class="col-12">
       <c:if test="${message!=null}">
                    <div class="alert alert-${message.cssClass}" role="alert">
                      ${message.content}
                    </div>
                    </c:if>
     </div>
  </div>
    <div class="row">
         <div class="col-4">
          <div class="list-group" id="list-tab" role="tablist">
                     <a class="list-group-item list-group-item-action active" id="list-home-list" data-toggle="list" href="#list-home" role="tab" aria-controls="home">Add Course</a>
                     <a class="list-group-item list-group-item-action" id="list-profile-list" data-toggle="list" href="#list-profile" role="tab" aria-controls="profile">Course Details </a>
                     <a class="list-group-item list-group-item-action" id="list-messages-list" data-toggle="list" href="#list-messages" role="tab" aria-controls="messages">Create Admin</a>
                     <a class="list-group-item list-group-item-action" id="list-settings-list" data-toggle="list" href="#list-settings" role="tab" aria-controls="settings">Delete Teacher</a>
                     <a class="list-group-item list-group-item-action" id="list-wild-list" data-toggle="list" href="#list-wild" role="tab" aria-controls="wild">Delete Admin</a>


          </div>
         </div>
         <div class="col-8">
                   <div class="tab-content" id="nav-tabContent">
                       <div class="tab-pane fade show active" id="list-home" role="tabpanel" aria-labelledby="list-home-list">
                                <div class="card">
                                    <div class="card-header text-center">
                                    <span class="fa fa-plus-circle" style="font-size:48px;"></span><p>Add Course</p>
                                    </div>
                                <div class="card-body">
                                    <form id="addCourse" action="/addCourse" method="post">
                                         <div class="form-group">
                                            <label>Enter course:</label>
                                             <input class="form-control" required type="text" name="course">
                                         </div>
                                         <div class="form-group">
                                             <label>Select Semesters</label>
                                             <select name="semesters" multiple class="form-control">
                                                 <option value="Semester 1">Semester 1</option>
                                                 <option value="Semester 2">Semester 2</option>
                                                 <option value="Semester 3">Semester 3</option>
                                                 <option value="Semester 4">Semester 4</option>
                                                 <option value="Semester 5">Semester 5</option>
                                                 <option value="Semester 6">Semester 6</option>
                                                 <option value="Semester 7">Semester 7</option>
                                                 <option value="Semester 8">Semester 8</option>
                                                 <option value="Semester 9">Semester 9</option>
                                                 <option value="Semester 10">Semester 10</option>
                                             </select>
                                         </div>
                                         <div class="container text-center">
                                            <button type="submit" class="btn btn-primary btn-sm">Add Course</button>
                                          </div>
                                     </form>
                                </div>
                                </div>
                                </div>
                              <div class="tab-pane fade" id="list-profile" role="tabpanel" aria-labelledby="list-profile-list">
                                <div class="card">
                                    <div class="card-header text-center">
                                    <span class="fa fa-plus-circle" style="font-size:48px;"></span><p>Add Course Details</p>
                                     </div>
                                <div class="card-body">
                                <form id="addCourseDetails" action="addCourseDetails" method="post">
                                 <div class="form-group">
                                         <label>Course:</label>
                                         <select class="form-control" required name="course">
                                            <c:forEach items="${c}" var="element">
                                               <option value="${element.course}">${element.course}</option>
                                            </c:forEach>
                                           </select>
                                 </div>
                                 <div class="form-group">
                                     <label>Semester</label>
                                     <select class="form-control" required name="semester">
                                       <c:forEach items="${c}" var="element">
                                         <optgroup label="${element.course}">
                                             <c:forEach items="${element.semesters}" var="sem">
                                              <option value="${sem}">${sem}</option>
                                             </c:forEach>
                                         </optgroup>
                                       </c:forEach>
                                      </select>
                                 </div>
                                 <div class="row">
                                        <div class="col-md-6">
                                                   <div class="form-group">
                                                        <input type="text" required name="subjects" placeholder="subject 1" class="form-control">
                                                   </div>
                                        </div>

                                      <c:forEach var = "i" begin = "1" end = "10">
                                           <div class="col-md-6">
                                                   <div class="form-group">
                                                       <input type="text" name="subjects" placeholder="Subject ${i}" class="form-control">
                                                   </div>
                                           </div>
                                      </c:forEach>
                                  </div>
                                 <div class="container text-center">
                                 <button type="submit" class="btn btn-primary btn-sm">Add Details</button>
                                 </div>
                                </form>
                                </div>
                                </div>

                              </div>
                              <div class="tab-pane fade" id="list-messages" role="tabpanel" aria-labelledby="list-messages-list">
                                <div class="card">
                                    <div class="card-header text-center">
                                   <span class="fa fa-plus-circle" style="font-size:48px;"></span><p>Create Admin</p>
                                   </div>
                                <div class="card-body">
                                <form id="createAdmin" action="/createAdmin" method="post">

                                 <div class="form-group">
                                       <label>Admin Name:</label>
                                       <input type="text" required name="adminName" class="form-control">
                                 </div>
                                  <div class="form-group">
                                       <label>Admin Email:</label>
                                       <input type="text" required name="adminEmail" class="form-control">
                                  </div>
                                 <div class="form-group">
                                       <label>Admin  password:</label>
                                       <input type="password" required name="adminPassword" class="form-control">
                                 </div>
                                 <div class="container text-center">
                                  <button type="submit" class="btn btn-primary btn-sm">Create Admin</button>
                                  </div>
                                </form>
                                </div>
                                </div>

                              </div>
                              <div class="tab-pane fade" id="list-settings" role="tabpanel" aria-labelledby="list-settings-list">
                                <div class="card">
                                    <div class="card-header text-center">
                                        <span class="fa fa-plus-circle" style="font-size:48px;"></span><p>Delete Teacher</p>
                                    </div>
                                    <div class="card-body">
                                        <form  id="form" action="deleteTeacher" method="post">
                                           <div class="form-group">
                                              <label>Teacher Email:</label>
                                              <input type="text" name="email" class="form-control">
                                           </div>
                                           <div class="form-group">
                                              <div class="container text-center">

                                                 <button type="submit" class="btn btn-primary btn-sm">
                                                  Delete Teacher Id</button>

                                              </div>
                                           </div>
                                         </form>
                                    </div>

                             </div>
                              </div>
                              <div class="tab-pane fade" id="list-wild" role="tabpanel" aria-labelledby="list-wild-list">
                                <div class="card">
                                    <div class="card-header text-center">
                                     <span class="fa fa-plus-circle" style="font-size:48px;"></span><p>Delete Admin Id</p>
                                    </div>
                                    <div class="card-body">
                                        <form action="deleteAdmin" method="post" id="form1">
                                            <div class="form-group">
                                                <lable>Admin Email:</label>
                                                <input type="text" name="email" class="form-control">
                                            </div>
                                            <div class="form-group">
                                               <div class="container text-center">
                                                <button type="submit" class="btn btn-primary btn-sm">
                                                Delete Admin Id</button>
                                               </div>
                                            </div>
                                         </form>

                                    </div>

                                 </div>
                              </div>
                </div>

    </div>
  </div>
</div>


    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->


 <script type='text/javascript'>
        $(document).ready(function() {
            $("#form").submit(function(e){
                                                         e.preventDefault();
                                                                        swal({
                                                          title: "Are you sure?",
                                                          text: "Once deleted, you will not be able to recover this imaginary file!",
                                                          icon: "warning",
                                                          buttons: true,
                                                          dangerMode: true,
                                                        })
                                                        .then((willDelete) => {
                                                          if (willDelete) {
                                                            swal("Poof! Your imaginary file has been deleted!", {
                                                              icon: "success",
                                                            });
                                                               e.currentTarget.submit();
                                                          } else {
                                                            swal("Your imaginary file is safe!");

                                                          }
                                                        });
            });

               $("#form1").submit(function(e){
                                                                     e.preventDefault();
                                                                                    swal({
                                                                      title: "Are you sure?",
                                                                      text: "Once deleted, you will not be able to recover this imaginary file!",
                                                                      icon: "warning",
                                                                      buttons: true,
                                                                      dangerMode: true,
                                                                    })
                                                                    .then((willDelete) => {
                                                                      if (willDelete) {
                                                                        swal("Poof! Your imaginary file has been deleted!", {
                                                                          icon: "success",
                                                                        });
                                                                           e.currentTarget.submit();
                                                                      } else {
                                                                        swal("Your imaginary file is safe!");
                                                                        var b=document.getElementById("#form1");

                                                                      }
                                                                    });
                });


        });
       </script>
     <%

        request.removeAttribute("message");
     %>
  </body>
</html>