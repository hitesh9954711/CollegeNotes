<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="com.example.CollegeNotes.Entities.Teacher"%>
<!doctype html>
<html lang="en">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="pages/All.css">
    <title>Add Noes</title>

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
            <a class="nav-link active" href="teacherDashboard"><span></span>Add Notes</a>
          </li>
           <li class="nav-item">
                 <a class="nav-link active" href="viewNotes"><span class></span>View Notes</a>
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
           <c:if test="${message!=null}">
                        <div class="alert alert-${message.cssClass}" role="alert">
                          ${message.content}
                        </div>
           </c:if>
         <div class="container c">
              <div class="card">
                    <div class="card-header text-center">
                                 <img class="card-img-top mx-auto" src="images/add.png"
                                  style="height: 70px; width: 70px;" alt="Card image cap">
                                 <p>Add Notes</p>
                    </div>
                    <div class="card-body">
                       <form method="post" action="savenotes" enctype="multipart/form-data">
                          <div class="form-group">
                            <label>Select Course:</label>
                            <select name="course" id="course" onchange="chg()" required class="form-control">
                            <option value="" selected disabled>select course</option>
                               <c:forEach items="${user.course}" var="t">
                                   <option value="${t}">${t}</option>
                               </c:forEach>
                            </select>
                          </div>
                          <div class="form-group">
                               <label>select semester</label>
                              <select name="semester" required class="form-control">
                              <option value="" selected disabled>select semester</option>
                                   <c:forEach items="${courses}" var="s">
                                      <optgroup label="${s.course}">
                                           <c:forEach items="${s.semesters}" var="sem">
                                                 <option value="${sem}">${sem}</option>
                                           </c:forEach>
                                      </optgroup>
                                   </c:forEach>
                               </select>
                          </div>
                          <div class="form-group">
                               <label>select subjects</label>
                                   <select name="subject" required class="form-control">
                                   <option value="" selected disabled>select subject</option>
                                       <c:forEach items="${courseDetails}" var="list">
                                             <c:forEach items="${list}" var="c">
                                               <optgroup label="${c.course}">
                                                  <optgroup label="${c.semester}">
                                                   <c:forEach items="${c.subjects}" var="s">
                                                      <option value="${s}">${s}</option>
                                                   </c:forEach>
                                                  </optgroup>
                                               </optgroup>
                                             </c:forEach>
                                       </c:forEach>
                                   </select>
                          </div>
                          <div class="form-group">
                                  <label>Select Unit</label>
                                 <select name="unit" required class="form-control" id="unit">
                                      <option value="" selected disabled>select Unit</option>
                                      <option value="Unit 1">Unit 1</option>
                                      <option value="Unit 2">Unit 2</option>
                                      <option value="Unit 3">Unit 3</option>
                                      <option value="Unit 4">Unit 4</option>
                                      <option value="Unit 5">Unit 5</option>
                                      <option value="Unit 6">Unit 6</option>
                                      <option value="Unit 7">Unit 7</option>
                                 </select>
                    </div>
                     <span class="mt-2"><a href="#" data-toggle="modal" data-target="#exampleModal" class="btn btn-info btn-sm">Add Units</a></span>
                      <div class="form-group mt-1">
                                       <label for="exampleFormControlInput1">Topic</label>
                                       <input name="topic" type="text" class="form-control" id="exampleFormControlInput1" placeholder="Topic">
                                    </div>

                                    <div class="form-group">
                                         <label for="exampleFormControlInput1">Select Images</label>
                                         <input name="images" accept="image/*" multiple type="file" class="form-control" id="exampleFormControlInput1" placeholder="Select Images">
                                         </div>
                                    <div class="form-group">
                                          <label for="exampleFormControlInput1">Select Files</label>
                                          <input name="files" multiple type="file" class="form-control" id="exampleFormControlInput1" placeholder="Select Fileso">
                                    </div>
                                    <div class="container text-center">
                                           <button type="submit" class="btn btn-primary btn-sm">Add Notes</button>
                                    </div>
                                  </form>
                               </div>

              </div>
         </div>
      </div>
    </div>




    <!-- Modal -->
    <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
                       <input type="text" id="val" placeholder="Enter Unit" class="form-control">
               <div class="container text-center mt-3">
                  <button type="button" class="btn btn-primary btn-sm" onclick="insertValue();">Add Unit</button>
                  <button type="button" class="btn btn-danger btn-sm" onclick="deleteOption();">Delete Unit</button>
               </div>

          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
          </div>
        </div>
      </div>
    </div>
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

    <!-- Optional JavaScript -->
         <!-- jQuery first, then Popper.js, then Bootstrap JS -->
         <script src="https://code.jquery.com/jquery-3.5.1.min.js" integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>
         <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
         <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
         <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
         <script src='https://kit.fontawesome.com/a076d05399.js'></script>

         <%
           request.removeAttribute("message");
         %>
  </body>
</html>