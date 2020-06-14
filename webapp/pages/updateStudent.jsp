<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="com.example.CollegeNotes.Entities.Student"%>
<%@page import="com.example.CollegeNotes.Helpers.StudentNotes"%>
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
    <title>Update Student</title>
     <script>

                    function insertValue()
                    {
                        var select = document.getElementById("unit"),
                            txtVal = document.getElementById("val").value,
                            newOption = document.createElement("OPTION"),
                            newOptionVal = document.createTextNode(txtVal);
                            document.getElementById("val").value="";
                                                          if(txtVal!=""){
                                                            newOption.appendChild(newOptionVal);
                                                            select.insertBefore(newOption,select.lastChild);
                                                        }
                    }

                    function deleteOption(){

                                      var selectobject=document.getElementById("unit"),
                                      txtVal=document.getElementById("val").value;
                                        document.getElementById("val").value="";
                                                      for (var i=0; i<selectobject.length; i++) {
                                                          if (selectobject.options[i].value == txtVal){
                                                              selectobject.remove(i);
                                                          }
                                                              }

        }
                </script>
  </head>
  <body>
   <%
                       Student s=(Student) session.getAttribute("student");



                       if(s==null){
                            response.sendRedirect("index");
                                              }
      %>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
      <a class="navbar-brand" href="index"> <span class="fas fa-graduation-cap"> CollegeNotes</span></a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>

      <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav ml-auto">
                 			<li class="nav-item active"><a class="nav-link"
                 		    href="updateStudent"><span class="fa fa-user-circle"></span> ${student.name}</a></li>
                 			<li class="nav-item active"><a class="nav-link"  href="studentLogout"><span
                 		   class="fa fa-external-link"></span> Logout </a></li>

                 		</ul>
      </div>
    </nav>
<div class="jumbotron bg-light text-black">
          <div class="container c">
                    <div class="card mt-3">
                              <div class="card-header text-center">
                                      <img class="card-img-top mx-auto" src="images/1.png"
                                       style="height: 70px; width: 70px;" alt="Card image cap">
                                      <p>Update Student Details</p>
                              </div>
                                                <c:if test="${message!=null}">
                                                 <div class="alert alert-${message.cssClass}" role="alert">
                                                   ${message.content}
                                                 </div>
                                                 </c:if>
                              <div class="card-body">
                               <form method="post" action="updatestudent">
                                 <div class="form-group">
                                     <input type="hidden" name="email" required value="<%=s.getEmail()%>">
                                     <label>Name</label>
                                     <input type="text" class="form-control" name="name" required value="<%=s.getName()%>">
                                 </div>
                                 <div class="form-group">
                                     <label>Password</label>
                                     <input type="password" id="password" name="password" required class="form-control" value="<%=s.getPassword()%>"
                                 </div>
                                 <div class="form-check mt-1">
                                                <input type="checkbox" class="form-check-input" id="showPassword">
                                                <label class="form-check-label" for="exampleCheck1">Show Password</label>
                                 </div>
                                     <div class="container text-center">
                                         <button type="submit" class="btn btn-primary btn-sm">Update</button>
                                     </div>
                                 </div>
                               </form>


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