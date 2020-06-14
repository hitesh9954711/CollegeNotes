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
    <title>view notes</title>
     <!-- Optional JavaScript -->
             <!-- jQuery first, then Popper.js, then Bootstrap JS -->
             <script src="https://code.jquery.com/jquery-3.5.1.min.js" integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>
             <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
             <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
             <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
             <script src='https://kit.fontawesome.com/a076d05399.js'></script>

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
   <!-- Modal -->
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

 <%
                     Teacher teacher=(Teacher) session.getAttribute("user");
                     ArrayList<Notes> t=(ArrayList<Notes>) session.getAttribute("notes");
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
                                      <img class="card-img-top mx-auto" src="images/search.png"
                                       style="height: 70px; width: 70px;" alt="Card image cap">
                                      <p>Search Notes</p>
                         </div>
                         <div class="card-body">
                            <form method="post" action="findnotes">
                                 <div class="form-group">
                                           <label>Select Course:</label>

                                              <select name="course" required class="form-control">
                                              <option value="" selected disabled>--select Course--</option>
                                    <c:forEach items="${user.course}" var="t">

                                        <option value="${t}">${t}</option>
                                    </c:forEach>
                                 </select>
                               </div>
                               <div class="form-group">
                                    <label>select semester</label>
                                   <select name="semester" required class="form-control">
                                   <option value="" selected disabled>--select semester--</option>
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
                                        <option value="" selected disabled>--select Subject--</option>

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
                                           <option value="" selected disabled>--select Unit--</option>
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
                         <div class="container text-center mt-2">
                                 <button type="submit" class="btn btn-primary btn-sm">Search Notes</button>
                         </div>
                    </form>
                   </div>
                 </div>

    </div>
    <div class="container">
  <c:if test="${notes!=null}">
     <%Notes t1=t.get(0);%>
              <div class="container-fluid mt-3">
                                   <form action="searchUnitNotes" method="post">
                                          <input name="id" type="hidden" value="<%=teacher.getEmail()%>">
                                          <input name="course" type="hidden" value="<%=t1.getCourse()%>">
                                          <input type="hidden" name="semester" value="<%=t1.getSemester()%>">
                                          <input type="hidden" name="subject" value="<%=t1.getSubject()%>">
                                          <input type="hidden" name="unit" value="<%=t1.getUnit()%>">
                                          <div class="form-group">
                                              <input type="text" name="topic" class="form-control" placeholder="Enter Topic">
                                          </div>
                                          <div class="container text-center">
                                               <button type="submit" class="btn btn-info btn-sm">Search</button>
                                          </div>
                                   </form>
                            </div>
              <c:forEach items="${notes}" var="element">
                 <div class="card mt-3">
                            <div class="card-header">
                               <label>Unit:<span> ${element.unit}</span></label><br>
                               <label>Topic:<span> ${element.topic}</span></label>
                            </div>

                     <div class="card-body">
                            <div class="row mt-3">
                              <div class="col-md-6 mt-3">
                                  <c:forEach items="${element.images}" var="images" varStatus="loop">
                                       <label>Images:</label><span style=" overflow-wrap: break-word;"><a href="download?name=${images}&type=image">${images}</a></span></label>
                                      <span  style=" overflow-wrap: break-word;"><a  href="delete?course=<%=t1.getCourse()%>&semester=<%=t1.getSemester()%>&subject=<%=t1.getSubject()%>&unit=<%=t1.getUnit()%>&email=<%=teacher.getEmail()%>&id=${element.id}&name=${images}&index=${loop.index}&type=images" class="badge badge-danger form1">delete</a></span><br>
                                  </c:forEach>
                              </div>
                              <div class="col-md-6 mt-3">
                                <c:forEach items="${element.files}" var="files" varStatus="loop">
                                  <label>Files:</label><span style=" overflow-wrap: break-word;"><a href="download?name=${files }&type=file" >${files}</a></span></label>
                                  <span  style=" overflow-wrap: break-word;"><a  href="delete?course=<%=t1.getCourse()%>&semester=<%=t1.getSemester()%>&subject=<%=t1.getSubject()%>&unit=<%=t1.getUnit()%>&email=<%=teacher.getEmail()%>&id=${element.id}&name=${files}&index=${loop.index}&type=files" class="badge badge-danger form2 ">delete</a></span><br>
                                </c:forEach>
                            </div>

                     </div>

                     <div class="container text-center mt-3">
                          <a href="#" class="btn btn-warning btn-sm"  data-toggle="modal" data-target="#exampleModall${element.id}">Update</a>
                          <span><a  href="delete?course=<%=t1.getCourse()%>&semester=<%=t1.getSemester()%>&subject=<%=t1.getSubject()%>&unit=<%=t1.getUnit()%>&email=<%=teacher.getEmail()%>&id=${element.id}&name=kdajfa&index=343&type=delete" class="btn btn-danger btn-sm semester">Delete</a></span>
                     </div>


<!-- Modal -->
<div class="modal fade" id="exampleModall${element.id}" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
                    <form action="updateNotes" method="post" enctype="multipart/form-data">
                                                             <div class="form-group">
                                                             <input type="hidden" name="id" value="${element.id}">
                                                             </div>
                                                             <div class="form-group">
                                                               <input type="text" value="${element.topic}" name="topic" class="form-control">
                                                             </div>
                                                             <div class="form-group">
                                                                  <label for="exampleFormControlInput1">Select Images</label>
                                                                  <input name="images" accept="image/*" multiple type="file" class="form-control" id="exampleFormControlInput1" placeholder="Select Images">
                                                                  </div>
                                                             <div class="form-group">
                                                                   <label for="exampleFormControlInput1">Select Files</label>
                                                                   <input name="files" multiple type="file" class="form-control" id="exampleFormControlInput1" placeholder="Select Files">
                                                             </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="submit" class="btn btn-primary">Update Note</button>
        </form>
      </div>
    </div>
  </div>
</div>




                     <div class="container-fluid mt-3"><h6>${element.date}</div>
                 </div>
          </c:forEach>
              </c:if>




   </div>
</div>




<script type='text/javascript'>
        $(document).ready(function() {
            $(".form1").click(function(e){
              var href = $(this).attr('href');
              e.preventDefault();
                swal({
  title: "Are you sure?",
  text: "Do You Want To Delete The Note",
  icon: "warning",
  buttons: true,
  dangerMode: true,
})
.then((willDelete) => {
  if (willDelete) {
    swal("Note is deleted.", {
      icon: "success",
    });
    window.location.href = href;
  } else {
    swal("Note is not deleted!");

  }
});
          });

           $(".form2").click(function(e){
              var href = $(this).attr('href');
              e.preventDefault();
                swal({
  title: "Are you sure?",
  text: "Do You Want To Delete The Note",
  icon: "warning",
  buttons: true,
  dangerMode: true,
})
.then((willDelete) => {
  if (willDelete) {
    swal("Note is deleted.", {
      icon: "success",
    });
    window.location.href = href;
  } else {
    swal("Note is not deleted!");

  }
});
          });


                                              $(".semester").click(function(e){
                                                  var href = $(this).attr('href');
                                                  e.preventDefault();
                                                    swal({
                                      title: "Are you sure?",
                                      text: "Do You Want To Delete The Note",
                                      icon: "warning",
                                      buttons: true,
                                      dangerMode: true,
                                    })
                                    .then((willDelete) => {
                                      if (willDelete) {
                                        swal("Your Note Is Deleted.", {
                                          icon: "success",
                                        });
                                        window.location.href = href;
                                      } else {
                                        swal("Your Note Is Not Deleted.");

                                      }
                                    });
          });



               });
       </script>


<%
session.removeAttribute("notes");
%>
      </body>
    </html>