<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!doctype html>
<html lang="en">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" type="text/css" href="pages/All.css">
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

    <title>Reset</title>
  </head>
  <body>
               <div class="container c">
                   <div class="card mt-3">
                            <div class="card-header text-center">
                                     <img class="card-img-top mx-auto" src="images/forgot.png"
                                       style="height: 70px; width: 70px;" alt="Card image cap">
                                      <p>Forgot Password</p>
                            </div>
                             <c:if test="${message!=null}">
                                                                             <div class="alert alert-${message.cssClass}" role="alert">
                                                                               ${message.content}
                                                                             </div>
                                                                             </c:if>
                            <div class="card-body">

                                            <div class="form-group mt-3">
                                                <form action="reset" method="post">
                                                 <label>Select Role:</label>
                                                 <select required class="form-control" name="r">
                                                     <c:forEach items="${roles}" var="role">
                                                        <option value="${role}">${role}</option>
                                                     </c:forEach>
                                                 </select>
                                            </div>
                                            <div class="form-group">
                                               <label>Email:</label>
                                               <input type="email" required name="email" class="form-control">
                                            </div>
                                            <div class="form-group">
                                               <label>Password</label>
                                               <input type="password" required name="password" class="form-control">
                                            </div>
                                            <div class="container text-center">
                                             <button type="submit" class="btn btn-primary btn-sm">Reset Password</button>
                                            </div>
                                            </form>
                                            </div>

                            </div>
                   </div>
               </div>
<%
  request.removeAttribute("message");
%>
    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
  </body>
</html>