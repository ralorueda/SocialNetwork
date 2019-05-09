<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="app.entity.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!-- Getting current user -->
<%
    User u = (User) request.getAttribute("user");
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Settings</title>
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="css/formStyle.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
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
                        <li class="active"><a href="settings">Settings</a></li>   
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
                <!-- Info part -->
                <div class="col-md-9">
                    <div class="col-md-12" style="border-width: 1px 1px 0px 1px; border-style: solid; border-color: lightgrey; background: #f1f3f6;">
                        <h3 style="text-align: left">Settings <p><small>This is your profile info.</small></p></h3>
                    </div>
                    <div class="col-md-12" style="border: 1px solid lightgrey; background: #e5eaf2;"> 
                        <table>
                            <br/>  
                            <p> 
                                <b>Name: </b>
                                <%
                                    out.print(u.getName());
                                %>
                            </p>
                            <br/> 
                            <p> 
                                <b>Surnames: </b>
                                <%
                                    out.print(u.getSurnames());
                                %>
                            </p>
                            <br/> 
                            <p> 
                                <b>Username: </b>
                                <%
                                    out.print(u.getUsername());
                                %>
                            </p>  
                            <br/> 
                            <p> 
                                <b>Email: </b>
                                <%
                                    out.print(u.getEmail());
                                %>
                            </p>
                            <br/> 
                            <p> 
                                <b>Password: </b>********          
                            </p>      
                            <br/> 
                            <p> 
                                <b>Birth date: </b>

                                <%
                                    SimpleDateFormat oldPattern = new SimpleDateFormat("EEE MMM dd hh:mm:ss zzzz yyyy");
                                    Date date = oldPattern.parse(u.getBirthdate().toString());
                                    SimpleDateFormat newPattern = new SimpleDateFormat("MMMM dd, yyyy");
                                    out.print(newPattern.format(date));
                                %>
                            </p>   
                            <br/> 
                            <p> 
                                <b>Description: </b>
                            </p>
                            <p> 
                                <%
                                    out.print(u.getDescription());
                                %>
                            </p>
                            <br/> 
                            <br/> 
                            <div class="form-group">
                                <button onclick="window.location.href = 'editProfile'" class="btn btn-default">Edit profile</button>      
                                <a href="#popUp" data-toggle="modal">
                                    <button class="btn btn-default" style="background-color:lightcoral;">Remove profile</button> 
                                </a>
                            </div>                       
                        </table>
                        <!-- Pop up delete profile -->
                        <form action="removeProfile" method="post">
                            <div id="popUp" class="modal fade" >
                                <div class="modal-dialog">
                                    <!-- Modal content-->
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                                            <h4 class="modal-title">Removing profile</h4>
                                        </div>
                                        <div class="modal-body">
                                            <div class="form-group">
                                                You are about to delete your profile. This action can not be undone. 
                                                If you are sure you want to do it, enter your password and click on 
                                                the "REMOVE PROFILE" button.
                                            </div>
                                            <div class="form-group">
                                                <label for="name">Password:</label>
                                                <input type="password" name="password" class="form-control" id="passwordInput" required >
                                            </div>
                                            <br/>                                           
                                        </div>
                                        <div class="modal-footer">
                                            <button type="submit" class="btn btn-primary" style="background-color:lightcoral;">REMOVE PROFILE</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </form>
                        <!-- End of the pop up delete profile -->
                        <% if (request.getAttribute("edited") != null) { %>
                        <div class="alert alert-success" role="alert">
                            <span class="closebtn" onclick="this.parentElement.style.display = 'none';">&times;</span> 
                            Your profile has been successfully edited.
                        </div>  
                        <%
                            }
                            if (request.getAttribute("deleted") != null) { %>
                        <div class="alert alert-danger" role="alert">
                            <span class="closebtn" onclick="this.parentElement.style.display = 'none';">&times;</span> 
                            Error removing your profile: wrong password.
                        </div>  
                        <%
                            }
                        %>

                    </div>
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
