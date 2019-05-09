<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="app.entity.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Profile</title>
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="css/formStyle.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
    </head>
    <body>
        <!-- Getting current user and errors -->
        <%
            User u = (User) session.getAttribute("thisUser");
            String error;
            if (request.getAttribute("error") == null) {
                error = "none";
            } else {
                error = (String) request.getAttribute("error");
            }
        %> 
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
                            <a href="groups" class="list-group-item">Groups<span class="badge badge-primary badge-pill"><% out.println(u.getPartyCollection().size() + u.getMembershipCollection().size());%></span></a>
                        </ul>
                    </div>
                </div>
                <!-- Info part -->
                <div class="col-md-9">
                    <div class="col-md-12" style="border-width: 1px 1px 0px 1px; border-style: solid; border-color: lightgrey; background: #f1f3f6;">
                        <h3 style="text-align: left">Editing your profile <p><small>You can edit your profile here.</small></p></h3>
                    </div>
                    <div class="col-md-12" style="border: 1px solid lightgrey; background: #e5eaf2;"> 
                        <br>
                        <%
                            if (error.equals("user")) {
                        %>                           
                        <div class="alert alert-danger" role="alert">
                            <span class="closebtn" onclick="this.parentElement.style.display = 'none';">&times;</span> 
                            The requested username is already in use.
                        </div>

                        <%
                        } else if (error.equals("password")) {
                        %>                          
                        <div class="alert alert-danger" role="alert">
                            <span class="closebtn" onclick="this.parentElement.style.display = 'none';">&times;</span> 
                            Incorrect current password.
                        </div>

                        <%
                        } else if (error.equals("confirmPassword")) {
                        %>
                        <div class="alert alert-danger" role="alert">
                            <span class="closebtn" onclick="this.parentElement.style.display = 'none';">&times;</span> 
                            New password confirmation doesn't match New password.
                        </div>

                        <%
                            }
                        %>
                        <form name="editProfile" action="editProfile" method="post">                            
                            <div class="form-group">
                                <label for="name">Name:</label>
                                <input type="text" name="name" value="<%=u.getName()%>" class="form-control" id="nameInput" required>
                            </div>             
                            <div class="form-group">
                                <label for="surnames">Surnames:</label>
                                <input type="text" name="surnames" value="<%=u.getSurnames()%>" class="form-control" id="surnamesInput" required>
                            </div> 
                            <div class="form-group">
                                <label for="username">Username:</label>
                                <input type="text" name="username" value="<%=u.getUsername()%>" class="form-control" id="usernameInput" required>
                            </div>             
                            <div class="form-group">
                                <label for="email">Email:</label>
                                <input type="text" name="email" value="<%=u.getEmail()%>" class="form-control" id="emailInput" required>
                            </div>        
                            <div class="form-group">
                                <label for="newPassword">New password:</label>
                                <input type="password" name="newPassword" value="" class="form-control" id="newPasswordInput">
                            </div>  
                            <div class="form-group">
                                <label for="confirmPassword">New Password confirmation:</label>
                                <input type="password" name="confirmPassword" value="" class="form-control" id="confirmPasswordInput">
                            </div> 
                            <div class="form-group">
                                <label for="description">Description:</label>
                                <br>
                                <textarea rows="3" name="description"  class="form-control" id="description"><%=u.getDescription()%></textarea>
                            </div>
                            <%
                                SimpleDateFormat oldPattern = new SimpleDateFormat("EEE MMM dd hh:mm:ss zzzz yyyy");
                                Date date = oldPattern.parse(u.getBirthdate().toString());
                                SimpleDateFormat newPattern = new SimpleDateFormat("MMMM dd, yyyy");
                                String dateStr = newPattern.format(date);
                            %>
                            <div class="form-group">
                                <label for="birthdate">Birth date:</label>
                                <p><% out.print(dateStr);%> </p>
                            </div> 

                            <div class="form-group">
                                <label for="password">To apply changes, enter your current password:</label>
                                <input type="password" name="password" value="" class="form-control" id="passwordInput" required>
                            </div>    
                            <div class="form-group">
                                <input type="hidden" name="first" class="form-control" id="firstInput" value="true">
                            </div> 
                            <center><button type="submit" class="btn btn-default">Apply changes</button></center>  
                            <br>
                        </form>
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
