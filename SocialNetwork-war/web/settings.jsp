<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="app.entity.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!-- Getting current user -->
<%
    if (session.getAttribute("thisUser") == null) {
        response.sendRedirect("login.jsp");
    } else {
        User u = (User) session.getAttribute("thisUser");
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Settings</title>
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
                        <li><a href="mentions">Mentions</a></li> 
                        <li><a href="profile?id=<% out.println(u.getId());%>">Profile</a></li>    
                        <li class="active"><a href="settings.jsp">Settings</a></li> 
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
                    <p> 
                        <b>Surnames: </b>
                        <%
                            out.print(u.getSurnames());
                        %>
                    </p>
                    <p> 
                        <b>Username: </b>
                        <%
                            out.print(u.getUsername());
                        %>
                    </p>           
                    <p> 
                        <b>Email: </b>
                        <%
                            out.print(u.getEmail());
                        %>
                    </p>
                    <p> 
                        <b>Password: </b>********          
                    </p>            
                    <p> 
                        <b>Birth date: </b>

                        <%
                            SimpleDateFormat oldPattern = new SimpleDateFormat("EEE MMM dd hh:mm:ss zzzz yyyy");
                            Date date = oldPattern.parse(u.getBirthdate().toString());
                            SimpleDateFormat newPattern = new SimpleDateFormat("MMMM dd, yyyy");
                            out.print(newPattern.format(date));
                        %>
                    </p>             
                    <div class="form-group">
                        <button onclick="window.location.href = 'http://localhost:8080/SocialNetwork-war/editProfile.jsp'" class="btn btn-default">Edit Profile</button>  
                        <button onclick="window.location.href = 'http://localhost:8080/SocialNetwork-war/removeProfile.jsp'" class="btn btn-default" style="background-color:lightcoral;">Remove Profile</button> 
                    </div>                   
                </table>
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
        <%}%>
    </body>
</html>
