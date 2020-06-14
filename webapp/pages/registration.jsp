<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!doctype html>
<html lang="en">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link href="https://gitcdn.github.io/bootstrap-toggle/2.2.2/css/bootstrap-toggle.min.css" rel="stylesheet">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="pages/All.css">
    <title>Registraion</title>
  </head>
  <body>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
      <a class="navbar-brand" href="index"> <span class="fas fa-graduation-cap"> CollegeNotes</span></a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>

      <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
          <li class="nav-item">
            <a class="nav-link active" href="register"><span class="fa fa-user-plus"></span> Register</a>
          </li>
      </div>
    </nav>

    <div class="jumbotron  bg-light text-black">

             <div class="container c">
                   <div class="card">
                           <div class="card-header text-center">
                       <img class="card-img-top mx-auto" src="images/1.png"
                        style="height: 70px; width: 70px;" alt="Card image cap">
                                 <p>Register Here</p>
                           </div>
                          <c:if test="${message!=null}">
                                              <div class="alert alert-${message.cssClass}" role="alert">
                                                ${message.content}
                                              </div>
                                              </c:if>
                           <div class="card-body">
                                         <div class="container  text-center">
                                                 <div class="btn-group btn-group-toggle" data-toggle="buttons">
                                                       <label class="btn btn-success btn-sm active abc">
                                                         <input type="radio"  name="options" id="option1"  autocomplete="off" >Teacher
                                                       </label>
                                                       <label class="btn btn-info btn-sm xyz">
                                                         <input type="radio" name="options"  id="option2" autocomplete="off" checked>Student
                                                       </label>
                                                 </div>
                                         </div>

                                         <div id="div1" class="container  mt-3">

                                             <form action="studentRegister" method="post">
                                              <div class="form-group">
                                                  <label>Student Name</label>
                                                  <input type="text" name="name" required class="form-control" placeholder="Student name">
                                              </div>
                                               <div class="form-group">
                                                 <label for="exampleInputEmail1">Email address</label>
                                                 <input type="email" name="email" required class="form-control"  placeholder="Student email">

                                               </div>
                                                <div class="form-group">
                                                                    <label>Course:</label>
                                                                     <select required name="course" class="form-control">
                                                                     <option value="" selected disabled>select course</option>
                                                                            <c:forEach items="${c}" var="data">
                                                                                <option>${data.course}</option>
                                                                            </c:forEach>
                                                                     </select>
                                                </div>
                                           <div class="container  text-center">
                                               <button type="submit" class="btn btn-primary">Register</button>
                                           </div>
                                             </form>
                                         </div>
                                                                                  <div id="div2" class="container mt-3" style="display:none;">

                                                                                      <form action="teacherRegister" method="post">
                                                                                        <div class="form-group">
                                                                                          <label>Name:</label>
                                                                                          <input required type="text" name="name" placeholder="Teacher Name" class="form-control">
                                                                                        </div>

                                                                                        <div class="form-group">
                                                                                          <label for="exampleInputEmail1">Email:</label>
                                                                                          <input required type="email" name="email" placeholder="Teacher Email" class="form-control" aria-describedby="emailHelp">
                                                                                          <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
                                                                                        </div>

                                                                                        <div class="form-group">
                                                                                           <label>Select Courses:</label>
                                                                                           <select multiple required name="course" class="form-control">

                                                                                             <c:forEach items="${c}" var="data">
                                                                                             <option>${data.course}</option>
                                                                                             </c:forEach>
                                                                                           </select>
                                                                                        </div>
                                                                                        <div class="form-group">
                                                                                           <label>Mr.</label>
                                                                                           <input required type="radio" value="Mr." name="gender">
                                                                                           <label>Ms.</label>
                                                                                           <input required type="radio" value="Ms." name="gender">
                                                                                        </div>
                                                                                        <div class="container text-center">
                                                                                        <button type="submit" class="btn btn-success">Register</button>
                                                                                        </div>
                                                                                      </form>
                                                                                  </div>
                           </div>
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
         <script src="https://gitcdn.github.io/bootstrap-toggle/2.2.2/js/bootstrap-toggle.min.js"></script>


           <script>
                $(document).ready(function(){
                         $(".abc").click(function () {
                            $("#div1").hide();
                            $("#div2").show();
                         });
                         $(".xyz").click(function () {
                            $("#div2").hide();
                            $("#div1").show();
                         });
                });

              </script>

              <%
                   request.removeAttribute("c");
                   request.removeAttribute("message");
              %>
               </body>
</html>