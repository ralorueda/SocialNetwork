<%@page import="java.util.Locale"%>
<%@page import="java.util.TimeZone"%>
<%@page import="app.ejb.UserFacade"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="app.entity.Post"%>
<%@page import="java.util.List"%>
<%@page import="app.entity.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<!-- Getting current user -->
<%
    User u = (User) session.getAttribute("thisUser");
    Integer id = u.getId();
    List<Post> posts = (List) request.getAttribute("posts");
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="css/formStyle.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" type="text/css" href="css/Style.css"  />
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
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
                        <li><a href="mentions">Mentions</a></li> 
                        <li class="active"><a href="profile?id=<% out.println(u.getId());%>">Profile</a></li>    
                        <li><a href="settings">Settings</a></li>   
                        <li><a href="logOut"><font style="color:#eb3f3f">Log out</font></a></li>   
                    </ul>                   
                    <p></p>
                    <form class="navbar-form" action="SearchServlet" role="search" align="right">
                        <div class="input-group">
                            <input type="text" class="form-control" placeholder="Search" name="srch-term" id="srch-term">
                            <div class="input-group-btn">
                                <button class="btn btn-default" type="submit"><i class="glyphicon glyphicon-search"></i></button>
                            </div>
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
                        <p class="text-center"><strong><%= u.getName() + " " + u.getSurnames() + " - " + "@" + u.getUsername()%></strong></p>
                        <p class="text-center"><%= u.getDescription()%></p>

                    </div>
                    <div class="col-md-12">
                        <br >
                        <ul class="list-group list-primary">
                            <a href="requests" class="list-group-item">Friend requests <span class="badge badge-primary badge-pill"><% out.println(u.getRequestCollection().size() + u.getRequestCollection1().size()); %></span></a>
                            <a href="friends" class="list-group-item">Friends<span class="badge badge-primary badge-pill"><% out.println(u.getFriendshipCollection().size() + u.getFriendshipCollection1().size()); %></span></a>
                            <a href="groups" class="list-group-item">Groups<span class="badge badge-primary badge-pill"><% out.println(u.getPartyCollection().size() + u.getMembershipCollection().size()); %></span></a>
                        </ul>
                    </div>
                </div>

                <!-- Posts part -->
                <div class="col-md-9">
                    <div class="col-md-12" style="border-width: 1px 1px 0px 1px; border-style: solid; border-color: lightgrey; background: #f1f3f6;">
                        <h3 style="text-align: left">Posts <p><small>You can see your friend posts here.</small></p></h3>
                    </div>
                    <div class="col-md-12" style="border: 1px solid lightgrey; background: #e5eaf2;"> 
                        <br/>
                        <form name="newPost" action="newPost"  method="post">
                            <textarea name="text" class="form-control" rows="3" placeholder="Write your post here!" required></textarea>
                            <button style="width: 100px;" type="submit" class="btn btn-default">Post</button>                              
                        </form>
                        <br>                     
                        <%
                            if (posts != null) {
                                for (Post post : posts) {
                        %>
                        <div class="containerPost">
                            <img src="Images/userIcon.png" alt="Avatar" style="width:100%;">
                            <span class="userPost"><a href="/SocialNetwork-war/profile?id=<% out.println(post.getAuthor().getId());%>"><%= post.getAuthor().getName() + " " + post.getAuthor().getSurnames() + " - @" + post.getAuthor().getUsername()%></a></span>                                                                                    
                            &nbsp;&nbsp;
                            <p><%= post.getText()%></p>

                            <%
                                Date date = post.getDate();
                                SimpleDateFormat newPattern = new SimpleDateFormat("HH:mm - MMMM dd, yyyy");
                                newPattern.setTimeZone(TimeZone.getTimeZone("UTC"));
                                String postDate = newPattern.format(date);
                            %>              
                            <span class="timePost"><%= postDate%></span>
                            <%
                                if (post.getAuthor().getId() == u.getId()) {
                            %>
                            <div align="right">
                                <a href="DeletePostServlet?postId=<%= post.getId()%>&profile=<%=id%>" data-toggle="modal">
                                    <span class="glyphicon glyphicon-trash" id="delete"></span>
                                </a>
                            </div>
                            <%
                                }
                            %>
                        </div>
                        <%
                                }
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
    </body>
</html>
