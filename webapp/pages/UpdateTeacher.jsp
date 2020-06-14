<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="com.example.CollegeNotes.Entities.Teacher"%>
<%@page import="com.example.CollegeNotes.Entities.Notes"%>
<%@page import="java.util.ArrayList"%>
<!doctype html>
<html lang="en">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="pages/All.css">
    <title>Update Teacher</title>
     <!-- Optional JavaScript -->
             <!-- jQuery first, then Popper.js, then Bootstrap JS -->
             <script src="https://code.jquery.com/jquery-3.5.1.min.js" integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>
             <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
             <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
             <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
             <script src='https://kit.fontawesome.com/a076d05399.js'></script>
    </head>
    <body>
    <%
                         Teacher teacher=(Teacher) session.getAttribute("user");
                         if(teacher==null){
                              response.sendRedirect("index");
                                                }
        %>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
          <a class="navbar-brand" href="index"> <span class="fas fa-graduation-cap"> CollegeNotes</span></a>
          <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
          </button>

          <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav mr-auto">
              <li class="nav-item">
                <a class="nav-link active" href="teacherDashboard"><span ></span>Add Notes</a>
              </li>
               <li class="nav-item">
                     <a class="nav-link active" href="viewNotes"><span></span>View Notes</a>
                </li>
            </ul>
                  <ul class="navbar-nav ml-auto">
             			<li class="nav-item active"><a class="nav-link"
             		    href="updateTeacher"><span class="fa fa-user-circle"></span> <%=teacher.getName()%></a></li>
             			<li class="nav-item active"><a class="nav-link"  href="teacherLogout"><span
             		   class="fa fa-external-link"></span> Logout </a></li>

             		</ul>
          </div>
</nav>
          <div class="jumbotron">
                  <div class="container c">
                      <div class="card">
                             <div class="card-header text-center">
                                       <img class="card-img-top mx-auto" src="images/teacher.png"
                                       style="height: 70px; width: 70px;" alt="Card image cap">
                                       <p>Update Teacher Details</p>
                             </div>
         <c:if test="${message!=null}">
                                                 <div class="alert alert-${message.cssClass}" role="alert">
                                                   ${message.content}
                                                 </div>
                                                 </c:if>
                             <div class="card-body">
                                             <div class="form-group">
                                                 <form action="updateteachers" method="post">

                                                   <input type="hidden"  name="email" class="form-control" value="${user.email}">
                                             </div>
                                             <div class="form-group">
                                                 <label>Name:</label>
                                                <input type="text" name="name" class="form-control" value="${user.name}">
                                             </div>
                                             <div class="form-group">
                                                 <label>Course:</label>
                                                 <select name="course" class="form-control" multiple>
                                                    <c:forEach items="${user.course}" var="abc">
                                                       <option value="${abc}" selected>${abc}</option>
                                                    </c:forEach>
                                                    <c:forEach items="${c}" var="xyz">
                                                              <option value="${xyz.course}">${xyz.course}</option>
                                                    </c:forEach>
                                                 </select>
                                             </div>
                                             <div class="form-group">
                                            <label>Password:</label>
                                            <input type="password" name="password" id="password" class="form-control" value="${user.password}">
                                            </div>
                                             <div class="form-check">
                                                <input type="checkbox" class="form-check-input" id="showPassword">
                                                <label class="form-check-label" for="exampleCheck1">Show Password</label>
                                              </div>
                                            <div class="container mt-2 text-center">
                                                <button type="submit" name="submit" class="btn btn-primary btn-sm">Update</button>
                                            </div>
                           </div>
                      </div>
                   </div>
          </div>
          <script>
                       $(document).ready(function(){
                          var a=0;
                          $("#showPassword").click(function(){
                           if(a==0){
                           $('#password').attr('type', 'text');
                           a=1;
                           }
                           else{
                             $('#password').attr('type', 'password');
                             a=0;
                             }
                          });
                       });
          </script>
    </body>
  </html>
