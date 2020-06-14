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
    <title>Student Notes</title>
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
                       ArrayList<StudentNotes> ss=(ArrayList<StudentNotes>) request.getAttribute("studentNotes");


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
                                      <img class="card-img-top mx-auto" src="images/search.png"
                                       style="height: 70px; width: 70px;" alt="Card image cap">
                                      <p>Search Notes</p>
                              </div>
                              <div class="card-body">
                                  <form action="searchStudentNotes" method="post">
                                           <div class="form-group">
                                                <label>Course:</label>
                                                <select required name="course" class="form-control">
                                                <option value="" selected disabled>select course</option>
                                                   <option value="${c.course}"> ${c.course}</option>
                                                </select>
                                           </div>
                                           <div class="form-group">
                                             <label>Semesters</label>
                                             <select required name="semester" class="form-control">
                                             <option value="" selected disabled>select semester</option>
                                                 <c:forEach items="${c.semesters}" var="sem">
                                                    <option value="${sem}">${sem}</option>
                                                 </c:forEach>
                                             </select>
                                           </div>
                                           <div class="form-group">
                                                        <label>Subjects</label>
                                                        <select required name="subject" class="form-control">
                                                        <option value="" selected disabled>select subject</option>
                                                             <c:forEach items="${co}" var="data">
                                                                    <optgroup label="${data.course}">
                                                                        <optgroup label="${data.semester}">
                                                                          <c:forEach items="${data.subjects}" var="subjects">
                                                                            <option value="${subjects}">${subjects}</option>
                                                                          </c:forEach>
                                                                        </optgroup>
                                                                    </optgroup>
                                                             </c:forEach>
                                                             </select>
                                                        </select>
                                           </div>
                                                  <div class="form-group">
                                                               <label>Select Unit</label>
                                                              <select name="unit" required class="form-control" id="unit">
                                                                    <option  selected disabled>select Unit</option>
                                                                   <option value="Unit 1">Unit 1</option>
                                                                   <option value="Unit 2">Unit 2</option>
                                                                   <option value="Unit 3">Unit 3</option>
                                                                   <option value="Unit 4">Unit 4</option>
                                                                   <option value="Unit 5">Unit 5</option>
                                                                   <option value="Unit 6">Unit 6</option>
                                                                   <option value="Unit 7">Unit 7</option>
                                                              </select>
                                                 </div>
                                                 <span class="mt-2"><a href="#" data-toggle="modal" data-target="#addunit" class="btn btn-info btn-sm">Add Units</a></span>

                                                 <div class="container text-center">
                                                   <button type="submit" class="btn btn-primary btn-sm">Search Notes</button>
                                                 </div>

                                  </form>
                              </div>
                    </div>
</div>

<div class="container c">







  <c:if test="${studentNotes!=null}">
<% StudentNotes sss=ss.get(0); %>
   <div class="container-fluid text-center mt-3">
                         <div class="form-group">
                          <form action="searchNotesByUnit" method="post">
                            <label>Enter Topic:</label>
                            <input type="hidden" name="course" value="<%=sss.getCourse()%>">
                            <input type="hidden" name="semester" value="<%=sss.getSemester()%>">
                            <input type="hidden" name="subject" value="<%=sss.getSubject()%>">
                            <input type="hidden" name="unit"    value="<%=sss.getUnit()%>">
                            <input type="text"  name="topic" class="form-control" placeholder="Enter Topic">
                            <div class="container text-center mt-3">
                               <button type="submit" class="btn btn-info btn-sm">Search Topic
                               </button>
                            </div>
                          </form>
    </div>
     </div>
     </div>
     <div class="container-fluid mt-3">

         <c:forEach items="${studentNotes}" var="element">
                 <div class="card mt-3">
                            <div class="card-header">
                               <label>Unit:<span> ${element.unit}</span></label><br>
                               <label>Topic:<span> ${element.topic}</span></label>
                            </div>

                     <div class="card-body">
                            <div class="row mt-3">
                              <div class="col-md-6 mt-3">
                                  <c:forEach items="${element.images}" var="images" varStatus="loop">
                                       <label>Images:</label><span style=" overflow-wrap: break-word;"><a href="download?name=${images}&type=image">${images}</a></span></label><br>

                                  </c:forEach>
                              </div>
                              <div class="col-md-6 mt-3">
                                <c:forEach items="${element.files}" var="files" varStatus="loop">
                                  <label>Files:</label><span style=" overflow-wrap: break-word;"><a href="download?name=${files}&type=file" >${files}</a></span></label><br>
                                </c:forEach>
                               </div>
                            </div>
                     </div>
                       <table class="table">
                           <tr>
                            <th>
                                 <h6 style="padding-left:4px;">Lect: ${element.name}</th><th>Date: ${element.date}</th>
                            </tr>
                       </table>
                     </div>
                </div>
         </c:forEach>
   </c:if>

   <div class="modal fade" id="addunit" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
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
</div>
</div>
        <!-- Optional JavaScript -->
             <!-- jQuery first, then Popper.js, then Bootstrap JS -->
             <script src="https://code.jquery.com/jquery-3.5.1.min.js" integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>
             <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
             <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
             <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
             <script src='https://kit.fontawesome.com/a076d05399.js'></script>



      </body>
    </html>