<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="app.entity.Post"%>
<%@page import="java.util.List"%>
<%@page import="app.entity.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<!-- Getting current user -->
<%
    if (session.getAttribute("thisUser") == null) {
        response.sendRedirect("login.jsp");
    } else {
        User u = (User) session.getAttribute("thisUser");
        List<Post> posts = (List) request.getAttribute("posts");
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home</title>
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="css/formStyle.css" rel="stylesheet" type="text/css"/>
    </head>

    <body>

        <!-- Header -->
        <nav class="navbar navbar-inverse navbar-fixed-top">
            <div class="container">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>""
                    <a class="navbar-brand" href="home"><img src="Images/logo.png" style="width: auto; height: 90%; display: inline-block; clear: both; "></a>
                </div>
                <div id="navbar" class="collapse navbar-collapse">
                    <ul class="nav navbar-nav">
                        <li><a href="home">Home </a></li>
                        <li><a href="mentions.jsp">Mentions</a></li> 
                        <li class="active"><a href="profile?id=<% out.println(u.getId()); %>">Profile</a></li>    
                        <li><a href="myProfile.jsp">Settings</a></li> 
                    </ul>
                    <p></p>
                    <form action="SearchServlet">
                        <div class="col-sm-3" align="right">
                            <input type="text" name="search" placeholder="Search"/> <a href="search.jsp"> <img src="Images/search.png"  style="width: 10%; height: 10%; display: inline-block; clear: both; "/> </a> 
                        </div>
                    </form>
                </div>
            </div>
        </nav>
        <br/><br/><br/>  
        <!-- End of the header -->

        <div class="container">         
            <div class="row">

                <!-- Left part -->
                <div class="col-md-3">
                    <div class="col-md-12" align="center">
                        <img class="img-responsive img-portfolio img-hover" src="Images/userIcon.png">
                    </div>
                    <div class="col-md-12">
                        <p></p>
                        <p class="text-center"><strong><%= u.getName() + " " + u.getSurnames()%></strong></p>
                        <p class="text-center"><%= "@" + u.getUsername()%></p>
                    </div>
                    <div class="col-md-12">
                        <br >
                        <ul class="list-group list-primary">
                            <a href="friends.jsp" class="list-group-item">Friends</a>
                            <a href="groups.jsp" class="list-group-item">Groups</a>
                        </ul>
                    </div>
                </div>

                <!-- Posts part -->
                <div class="col-md-9">
                    <div class="col-md-12" style="border-width: 1px 1px 0px 1px; border-style: solid; border-color: lightgrey; background: #f1f3f6;">
                        <h3 style="text-align: left">Posts <p><small>You can see your friends posts here.</small></p></h3>
                    </div>
                    <div class="col-md-12" style="border: 1px solid lightgrey; background: #e5eaf2;"> 
                        <br/>
                        <form>
                            <textarea name="postText" class="form-control" rows="3" placeholder="Write your post here!" required></textarea>
                            <button type="submit" class="btn btn-default">Post</button>                                    
                        </form>
                        <br/>                       
                        <%
                            for (Post post : posts) {
                        %>
                        <div class="containerPost">
                            <img src="Images/userIcon.png" alt="Avatar" style="width:100%;">
                            <span class="userPost"><a href="/SocialNetwork-war/profile?id=<% out.println(post.getAuthor().getId()); %>"><%= post.getAuthor().getName() + " " + post.getAuthor().getSurnames() + " - @" + post.getAuthor().getUsername() %></a></span>
                            &nbsp;&nbsp;
                            <p><%= post.getText()%></p>
                            <%
                                SimpleDateFormat oldPattern = new SimpleDateFormat("EEE MMM dd hh:mm:ss zzzz yyyy");
                                Date date = oldPattern.parse(post.getDate().toString());
                                SimpleDateFormat newPattern = new SimpleDateFormat("hh:mm - MMMM dd, yyyy");
                                String postDate = newPattern.format(date);
                            %>
                            <span class="timePost"><%= postDate%></span>
                        </div>
                        <%
                            }
                        %>
                        <%
                            if (request.getAttribute("posted") != null) {
                        %>
                        <div class="alert">
                            <span class="closebtn" onclick="this.parentElement.style.display = 'none';">&times;</span> 
                            Incorrect password.
                        </div>    
                        <%
                            }
                        %>
                    </div>
                </div>  
            </div>
            &nbsp;
            <hr>

            <!-- Footer -->
            <footer>
                <div class="row">
                    <div class="col-lg-12 footer-align">
                        <p>Copyright &copy; Instamum 2019. All rights reserved</p>
                    </div>
                </div>
            </footer>
            <!-- End of the footer -->
        </div>
        <% }%>
    </body>
</html>
