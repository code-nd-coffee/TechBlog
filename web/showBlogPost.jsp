<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import= "com.tech.blog.entities.User" %>
<%@page import= "com.tech.blog.helper.ConnectionProvider" %>
<%@page import= "com.tech.blog.dao.PostDao" %>
<%@page import= "com.tech.blog.dao.UserDao" %>
<%@page import= "com.tech.blog.dao.LikeDao" %>
<%@page import= "com.tech.blog.entities.Post" %>
<%@page import="java.util.ArrayList" %>
<%@page import="com.tech.blog.entities.Message" %>
<%@page import="com.tech.blog.entities.Category" %>
<%@page import="java.text.DateFormat" %>
<%@page errorPage="Error.jsp" %>

<%
    User user = (User)session.getAttribute("currentUser");
    if(user == null){
        response.sendRedirect("Login.jsp");
    }
%>

<%
    int postId = Integer.parseInt(request.getParameter("postId"));
    PostDao p = new PostDao(ConnectionProvider.getConnection());
    Post post = p.getAllPostByPostId(postId);
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%= post.getTitle()%> || Tech Blog</title>
        
        <!--css-->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link href="css/myCSS.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <style>
            .banner-background{
                clip-path: polygon(50% 0%, 100% 0, 100% 86%, 74% 100%, 44% 90%, 0 97%, 0 0);
            }
            .post-title{
                font-weight: 100;
                font-size: 30px;
            }
            .post-content{
                font-weight: 100;
                font-size: 20px;
            }
            .post-user{
                font-size: 15px;
            }
            .post-date{
                font-style: italic;
            }
            .row-user{
                border: 1px solid #e2e2e2;
                padding-top: 15px;
            }
        </style>
        <div id="fb-root"></div>
        <script async defer crossorigin="anonymous" src="https://connect.facebook.net/en_GB/sdk.js#xfbml=1&version=v20.0" nonce="hQIL6dMK"></script>
    </head>
    <body>
        
        <!--Nav Bar-->
        
        <nav class="navbar navbar-expand-lg navbar-dark primary-background">
            <a class="navbar-brand" href="index.jsp"> <span class = "fa fa-address-book"></span> Tech Blog</a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav mr-auto">
                    <li class="nav-item active">
                        <a class="nav-link" href="Profile.jsp"> <span class = "fa fa-folder"></span> Home <span class="sr-only">(current)</span></a>
                    </li>

                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            <span class = "fa fa-eyedropper"></span> Learning
                        </a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <a class="dropdown-item" href="#">Programming Language</a>
                            <a class="dropdown-item" href="#">Project</a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="#">Data Structure</a>
                        </div>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#"> <span class = "fa fa-send"></span> Contact</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#" data-toggle="modal" data-target="#do-post-modal"> <span class = "fa fa-address-card-o"></span> Do Post</a>
                    </li>
                    
                

                </ul>
                <ul class="navbar-nav mr-right">
                    <li class="nav-item">
                        <a class="nav-link" href="#!" data-toggle="modal" data-target="#profile-modal"> <span class = "fa fa-user-circle"></span> <%= user.getName()%></a>
                    </l>
                    <li class="nav-item">
                        <a class="nav-link" href="LogoutServlet"> <span class = "fa fa-eye-slash"></span> Logout</a>
                    </li>
                </ul>
            </div>
        </nav>
    <%
        Message m = (Message) session.getAttribute("msg");
            if(m!=null){
    %>
        <div class="alert <%=m.getCssClass() %>" role="alert">
            <%= m.getContent()%>
        </div>
    <%   
        session.removeAttribute("msg");
        }
    %>
    
    <!--Main part of the body-->
    <div class="container">
        <div class="row my-4">
            <div class="col-md-8 offset-md-2">
                <div class="card">
                    <div class="card-header primary-background text-white">
                        <h4 class="post-title"><%= post.getTitle()%></h4>
                    </div>
                    <div class="card-body">
                        <img class="card-img-top my-2" src="" alt="Card image cap">
                        
                        <div class="row my-3 row-user">
                            <div class="col-md-8">
                                <% UserDao d = new UserDao(ConnectionProvider.getConnection());
                                %>
                                <p class="post-user">Written By: <a href="#"><%= d.getUserByUserId(post.getUserId()).getName()%></a></p>
                            </div>
                            <div class="col-md-4">
                                <p class="post-date"><%= DateFormat.getDateTimeInstance().format(post.getDate())%></p>
                            </div>
                        </div>
                        
                        <div class="post-content">
                            <p><%= post.getContent()%></p>
                        </div>
                        <br>
                        <br>
                        <div class="post-code">
                            <pre><%= post.getCode()%></pre>
                        </div>
                    </div>
                    
                        <div class="card-footer primary-background text-center">
                            <%
                            LikeDao dao = new LikeDao(ConnectionProvider.getConnection());    
                            %>
                            
                            <a href="#!" onclick="doLike(<%= post.getPostId()%>,<%= user.getId()%>)" class="btn btn-outline-light btn-sm"><i class="fa fa-thumbs-o-up"></i>&nbsp;<span class = "like-counter"><%= dao.countLikeOnPost(post.getPostId()) %></span></a>
                            <a href="#!" class="btn btn-outline-light btn-sm"><i class="fa fa-commenting-o"></i>&nbsp;<span>5</span></a>
                            
                        </div>
                            
                            <div class="card-footer">
                                <div class="fb-comments" data-href="http://localhost:9017/TechBlog/showBlogPost.jsp?postId=<%= post.getPostId()%>" data-width="" data-numposts="5"></div>
                            </div>
                </div>
            </div>
        </div>
        
    </div>
    
    
    <!-- Profile Modal -->
    <div class="modal fade" id="profile-modal" tabindex="-1" role="dialog" aria-labelledby="profile-modal" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header primary-background text-white text-center">
                    <h5 class="modal-title" id="exampleModalLabel">TechBlog</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="container text-center">
                        <h5 class="modal-title" id="exampleModalLabel"><%= user.getName()%></h5>

                        <!--Details-->
                        <div id="profile-details">
                            <table class="table">
                                <tbody>
                                    <tr>
                                        <th scope="row">ID:</th>
                                        <td><%= user.getId() %></td>

                                    </tr>
                                    <tr>
                                        <th scope="row">Email:</th>
                                        <td><%= user.getEmail() %></td>

                                    </tr>
                                    <tr>
                                        <th scope="row">Gender:</th>
                                        <td><%= user.getGender() %></td>

                                    </tr>
                                    <tr>
                                        <th scope="row">About:</th>
                                        <td><%= user.getAbout() %></td>

                                    </tr>
                                    <tr>
                                        <th scope="row">Registered on:</th>
                                        <td><%= user.getDateTime().toString() %></td>

                                    </tr>
                                </tbody>
                            </table>
                        </div>       
                        <!--Profile Edit-->

                        <div id="profile-edit" style="display: none">
                            <h3 class="mt-2">Please Edit Carefully</h3> 

                            <form action="EditServlet" method="POST" enctype="multipart/form-data">
                                <table class="table">
                                    <tr>
                                        <td>ID:</td>
                                        <td><%= user.getId()%></td>
                                    </tr>
                                    <tr>
                                        <td>Name:</td>
                                        <td><input type="text" class="form-control" name="name" value="<%= user.getName()%>"></td>
                                    </tr>
                                    <tr>
                                        <td>Email:</td>
                                        <td><input type="email" class="form-control" name="email" value="<%= user.getEmail()%>"></td>
                                    </tr>
                                    <tr>
                                        <td>Password:</td>
                                        <td><input type="password" class="form-control" name="password" value="<%= user.getPassword()%>"></td>
                                    </tr>
                                    <tr>
                                        <td>Gender:</td>
                                        <td><%= user.getGender()%></td>
                                    </tr>
                                    <tr>
                                        <td>About:</td>
                                        <td>
                                            <textarea class="form-control" name="about" rows="3"><%= user.getAbout()%>
                                            </textarea>
                                        </td>
                                    </tr>
                                </table>
                                <div class="container">
                                    <button type ="submit" class="btn btn-outline-primary">Save</button>
                                </div>
                            </form>
                        </div>

                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button id="edit-profile-btn" type="button" class="btn btn-primary">Edit</button>
                </div>
            </div>
        </div>
    </div>

    <!--Add Post Modal-->

    <div class="modal fade" id="do-post-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Provide The Post Details:</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form id="add-post-form" action="PostServlet" method="POST">
                        <div class="form-group">
                            <select class="form-control" name="cid">
                                <option selected disabled>--- Select Category ---</option>
                                <%
                                    PostDao pd = new PostDao(ConnectionProvider.getConnection());
                                    ArrayList<Category> list = pd.getAllCategories();
                                    for(Category c : list){
                                %>

                                <option value="<%= c.getCategoryId()%>"><%= c.getName()%></option>

                                <% 
                                    }
                                %>

                            </select>
                        </div>
                        <div class="form-group">
                            <input name="title" type="text" placeholder="Enter Post Title" class="form-control"/>
                        </div>
                        <div class="form-group">
                            <textarea name="content" class="form-control" rows="5" placeholder="Enter Your Content"></textarea>
                        </div>
                        <div class="form-group">
                            <textarea name="code" class="form-control" rows="5" placeholder="Enter Your Program(If Any)"></textarea>
                        </div>
                        <div class="form-group">
                            <label>Select Your Picture</label>
                            <br>
                            <input name="picture" type="file"/>
                        </div>
                        <div class="container text-center">
                            <button type ="submit" class="btn btn-outline-primary">Post</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>


        <!--JavaScript-->
        <script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
        <script src="js/myJS.js" type="text/javascript"></script>
        
        <script>
            $(document).ready(function(){
                let editStatus = false;
                $('#edit-profile-btn').click(function(){
//                    alert("Button Clicked")
                   if(editStatus === false){
                        $('#profile-details').hide();
                        $('#profile-edit').show();
                        editStatus = true;
                        $(this).text("Back");
                   } else{
                        $('#profile-details').show();
                        $('#profile-edit').hide();
                        editStatus = false;
                        $(this).text("Edit");
                   }
                });
            });
        </script>
        
        <!--Add Post JS-->
        <script>
            $(document).ready(function(e){
                
                $("#add-post-form").on("submit", function(event){
                    event.preventDefault();
                    console.log("Submitted");
                    let form = new FormData(this);
                    
//                    now requeting to server
                    $.ajax({
                       url: "PostServlet",
                       type: "Post",
                       data: form,
                       success: function(data, textStatus, jqXHR){
                           if(data.trim() === 'Done'){
                               swal("Great job!", "Saved Successfully", "success");
                           } else{
                               swal("Error!", "Something Went Wrong", "error");

                           }
                       },
                       error: function(jqXHR, textStatus, errorThrown){
                           swal("Error!", "Something Went Wrong", "error");
                       },
                       processData: false,
                       contentType: false
                       
                    });
                });
                
            });
        </script>
            
    </body>
</html>
