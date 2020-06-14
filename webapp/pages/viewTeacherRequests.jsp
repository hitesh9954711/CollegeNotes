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

    <title>View Teachers Requests</title>
  </head>
  <body>
        <%
                             Admin admin=(Admin) session.getAttribute("admin");
                             int i=0;
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
           				href="updateTeacher"><span class="fa fa-user-circle"></span> <%=admin.getAdminName()%></a></li>
           			<li class="nav-item active "><a class="nav-link" href="Logout"><span
           					class="fa fa-external-link"></span> Logout </a></li>

           		</ul>
    </div>
  </nav>


<div class="container mt-3">
           <div class="card">
               <div class="card-header text-center">
                                 <img class="card-img-top mx-auto" src="images/request.png"
                                  style="height: 70px; width: 70px;" alt="Card image cap">
                                 <p>All Admins</p>
               </div>
                    <c:if test="${message!=null}">
                                <div class="alert alert-${message.cssClass}" role="alert">
                                              ${message.content}
                                 </div>
                                 </c:if>
               <div class="card-body">
                 <div class="table-responsive">
                   <table  class="table">
                    <tr>
                          <th>Teacher Name</th>
                          <th>Teacher Email</th>
                          <th>Courses</th>
                          <th>Gender</th>
                          <th colspan="2">Action</th>

                    </tr>
                           <c:forEach items="${teacherRequests}" var="element">
                             <tr>
                                  <th>${element.name}</th>
                                  <th>${element.email}</th>
                                  <th>
                                  <c:forEach items="${element.course}" var="j">
                                  <span>${j}</span>
                                  </c:forEach>
                                  </th>
                                  <th>${element.gender}</th>
                                  <th><a href="verify?id=${element.id}" class="btn btn-info btn-sm">Verify</a></th>
                                  <th><a href="deleteRequest?id=${element.id}" id="delete" class="btn btn-danger btn-sm">Delete</a></th>
                             </tr>
                           </c:forEach>
                     </table>
                 </div>
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

        <script>
           $(document).ready(function() {
                    $("#delete").click(function(e){
                                                                 var href = $(this).attr('href');
                                                                 e.preventDefault();
                                                                                swal({
                                                                  title: "Are you sure?",
                                                                  text: "Do You Want To Delete Request!",
                                                                  icon: "warning",
                                                                  buttons: true,
                                                                  dangerMode: true,
                                                                })
                                                                .then((willDelete) => {
                                                                  if (willDelete) {
                                                                    swal("Request is deleted", {
                                                                      icon: "success",
                                                                    });
                                                                    window.location.href = href;

                                                                  } else {
                                                                    swal("Request is not deleted");
                                                                  }
                                                                });
                    });
                    });
        </script>

        <%
                request.removeAttribute("teacherRequests");
                request.removeAttribute("message");
        %>
   </body>
   </html>