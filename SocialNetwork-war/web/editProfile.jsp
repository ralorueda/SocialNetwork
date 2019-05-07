<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="app.entity.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Profile</title>
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="css/formStyle.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <%
            if (session.getAttribute("thisUser") == null) {
                String redirectURL = "http://localhost:8080/SocialNetwork-war/login.jsp";
                response.sendRedirect(redirectURL);
            } else {
                User u = (User) session.getAttribute("thisUser");
        %> 
        <div class="container well" id="containerRegister">
            <form name="editProfile" action="editProfile" method="post">
                <div class="form-group">
                    <h1>Editing your profile:</h1>
                </div>
                <div class="form-group">
                    <label for="name">Name:</label>
                    <input type="text" name="name" value=<% out.print(u.getName()); %> class="form-control" id="nameInput" required>
                </div>             
                <div class="form-group">
                    <label for="surnames">Surnames:</label>
                    <input type="text" name="surnames" value=<% out.print(u.getSurnames()); %> class="form-control" id="surnamesInput" required>
                </div> 
                <div class="form-group">
                    <label for="username">Username:</label>
                    <input type="text" name="username" value=<% out.print(u.getUsername()); %> class="form-control" id="usernameInput" required>
                </div>             
                <div class="form-group">
                    <label for="email">Email:</label>
                    <input type="text" name="email" value=<% out.print(u.getEmail()); %> class="form-control" id="emailInput" required>
                </div>        
                <div class="form-group">
                    <label for="newPassword">New password:</label>
                    <input type="password" name="newPassword" value="" class="form-control" id="newPasswordInput">
                </div>  
                <div class="form-group">
                    <label for="confirmPassword">Confirm new Password:</label>
                    <input type="password" name="confirmPassword" value="" class="form-control" id="confirmPasswordInput">
                </div> 

                <%
                    SimpleDateFormat oldPattern = new SimpleDateFormat("EEE MMM dd hh:mm:ss zzzz yyyy");
                    Date date = oldPattern.parse(u.getBirthdate().toString());
                    SimpleDateFormat newPattern = new SimpleDateFormat("MMMM dd, yyyy");
                    String dateStr = newPattern.format(date);
                %>

                <div class="form-group">
                    <label for="birthdate">Birth date:</label>
                    <p><% out.print(dateStr); %> </p>
                </div> 
                <div class="form-group">
                    <label for="password">To apply changes, enter your current password:</label>
                    <input type="password" name="password" value="" class="form-control" id="passwordInput" required>
                </div>      
                <center><button type="submit" class="btn btn-default">Apply changes</button></center>   
                    <%
                        if (request.getParameter("userError") != null) {
                            if (request.getParameter("userError").equals("true")) {
                    %>
                <div class="form-group">
                    <p style="color:red">The username already exists.</p>
                </div>   
                <%
                    }
                } else if (request.getParameter("passwordError") != null) {
                    if (request.getParameter("passwordError").equals("true")) {
                %>
                <div class="form-group">
                    <p style="color:red">Incorrect current password.</p>
                </div>   
                <%
                    }
                } else if (request.getParameter("newPasswordError") != null) {
                    if (request.getParameter("newPasswordError").equals("true")) {
                %>
                <div class="form-group">
                    <p style="color:red">Password doesn't match.</p>
                </div> 
                <%
                            }
                        }
                    }
                %>
            </form>
        </div>
    </body>
</html>
