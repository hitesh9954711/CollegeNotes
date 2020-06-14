<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!doctype html>
<html lang="en">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="pages/All.css">
    <title>CollegeNotes</title>
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
 <div class="jumbotron bg-light text-black">

             <div class="container c">
                   <div class="card">
                           <div class="card-header text-center">
                                <img class="card-img-top mx-auto" src="images/vWqlogo.png"
                                 style="height: 130px; width: 130px;" alt="Card image cap">
                                 <p>Login Here</p>
                           </div>
                                          <c:if test="${message!=null}">
                                                 <div class="alert alert-${message.cssClass}" role="alert">
                                                   ${message.content}
                                                 </div>
                                                 </c:if>
                           <div class="card-body">
                                                        <form action="login" class="form-sm" method="post">
                                                          <div class="form-group">
                                                            <label>Email address</label>
                                                            <input type="email" class="form-control" required name="email" placeholder="Enter email">
                                                          </div>
                                                         <div class="form-group">
                                                         							<label for="exampleInputPassword1">Password</label> <input
                                                         								type="password" id="password" class="form-control" name="password"
                                                         								id="exampleInputPassword1" placeholder="Password">
                                                         						</div>
                                                          <div class="form-check mt-1">
                                                          <input type="checkbox" class="form-check-input" id="showPassword">
                                                          <label class="form-check-label" for="exampleCheck1">Show Password</label>
                                                          </div>

                                                         <div class="contaier text-center">
                                                          <button type="submit" class="btn btn-primary">Login</button>
                                                          </div>
                                                        </form>
                                                         <label><a href="ForgotPassword">Forgot Password ?</a></label>

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


         <%
           request.removeAttribute("message");
         %>
  </body>
</html>