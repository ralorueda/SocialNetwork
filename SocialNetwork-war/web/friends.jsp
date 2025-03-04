<%@page import="app.entity.User"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    User u = (User) session.getAttribute("thisUser");
    List<User> friends = (List) request.getAttribute("friends");
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
                        <li><a href="profile?id=<% out.println(u.getId());%>">Profile</a></li>    
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
                                    <a href="friends" class="list-group-item active">Friends<span class="badge badge-primary badge-pill"><% out.println(u.getFriendshipCollection().size() + u.getFriendshipCollection1().size()); %></span></a>
                                    <a href="groups" class="list-group-item">Groups<span class="badge badge-primary badge-pill"><% out.println(u.getPartyCollection().size() + u.getMembershipCollection().size()); %></span></a>
                                </ul>
                            </div>
                        </div>

                        <!-- Friend list part -->
                        <div class="col-md-9">
                            <div class="col-md-12" style="border-width: 1px 1px 0px 1px; border-style: solid; border-color: lightgrey; background: #f1f3f6;">
                                <h3 style="text-align: left">Friends <p><small>This is your friends list.</small></p></h3>
                            </div>
                            <div class="col-md-12" style="border: 1px solid lightgrey; background: #e5eaf2;">      
                                <br/>
                                <%
                                    if (friends != null) {
                                        for (User friend : friends) {
                                %>
                                <div class="containerPost">
                                    <img src="Images/userIcon.png" alt="Avatar" style="width:100%;">
                                    <span class="friendInfo"><a href="/SocialNetwork-war/profile?id=<% out.println(friend.getId());%>"><%= friend.getName() + " " + friend.getSurnames() + " - @" + friend.getUsername()%></a></span>
                                    &nbsp;&nbsp;                                  
                                    <p>
                                        <%=friend.getDescription()%>
                                    </p>
                                    <div align="right">
                                        <a href="DeleteFriendServlet?friendId=<%= friend.getId()%>" data-toggle="modal">
                                            <span style="font-size: 20px" class="glyphicon glyphicon-minus-sign" id="delete"></span>
                                        </a>
                                    </div>   
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
