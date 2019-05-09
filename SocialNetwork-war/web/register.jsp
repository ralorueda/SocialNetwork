<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="app.entity.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8");%>
<!DOCTYPE html>

<%
    User user = null;

    String strName = "", strSurNames = "", strUserName = "", strEmail = "";
    Date userBirthdate = new SimpleDateFormat("yyyy-mm-dd").parse("1970-01-01");
    String error;
    if (request.getAttribute("error") == null) {
        error = "none";
    } else {
        error = (String) request.getAttribute("error");
    }
    request.setAttribute("error", error);
    if (!error.equals("none")) {
        user = (User) request.getAttribute("user");
        strName = user.getName();
        strSurNames = user.getSurnames();
        strUserName = user.getUsername();
        strEmail = user.getEmail();
        if (user.getBirthdate() != null) {
            userBirthdate = user.getBirthdate();
        }
    }

    SimpleDateFormat format = new SimpleDateFormat("yyyy-mm-dd");
    String dateStr = format.format(userBirthdate);
%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register</title>
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="css/formStyle.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
    </head>
    <body>
        <div class="container well" id="containerRegister">
            <form name="register" action="register" method="post">
                <div class="form-group">
                    <h1>Create new account:</h1>
                </div>
                <%                    if (error.equals("user")) {
                %>
                <div class="alert alert-danger" role="alert">
                    <span class="closebtn" onclick="this.parentElement.style.display = 'none';">&times;</span> 
                    The requested username is already in use.
                </div>
                <%
                    }
                    if (error.equals("password")) {
                %>
                <div class="alert alert-danger" role="alert">
                    <span class="closebtn" onclick="this.parentElement.style.display = 'none';">&times;</span> 
                    Password confirmation doesn't match Password.
                </div>  
                <%
                    }
                %>
                <div class="form-group">
                    <label for="name">Name:</label>
                    <input type="text" name="name" class="form-control" value="<%=strName%>" id="nameInput" required >
                </div>             
                <div class="form-group">
                    <label for="surnames">Surnames:</label>
                    <input type="text" name="surnames" class="form-control" id="surnamesInput" required value="<%=strSurNames%>">
                </div> 
                <div class="form-group">
                    <label for="username">Username:</label>
                    <input type="text" name="username" class="form-control" id="usernameInput" required value="<%=strUserName%>">
                </div>             
                <div class="form-group">
                    <label for="email">Email:</label>
                    <input type="text" name="email" class="form-control" id="emailInput" required value="<%=strEmail%>">
                </div> 
                <div class="form-group">
                    <label for="password">Password:</label>
                    <input type="password" name="password" class="form-control" id="passwordInput" required>
                </div>             
                <div class="form-group">
                    <label for="confirmPassword">Password confirmation:</label>
                    <input type="password" name="confirmPassword" class="form-control" id="confirmPasswordInput" required>
                </div> 
                <div class="form-group">
                    <label for="birthdate">Birth date:</label>
                    <input type="date" name="birthdate" class="form-control" id="birthdateInput" required value="<%=dateStr%>">
                </div> 
                <div class="form-group">
                    <label for="description">Description:</label>
                    <br>
                    <textarea rows="3" name="description"  class="form-control" id="description"></textarea>
                </div>
                <div class="form-group">
                    <input type="hidden" name="first" class="form-control" id="firstInput" value="true">
                </div>
                <center><button type="submit" class="btn btn-default">Submit</button></center>
                <br>
                <div class="form-group">
                    <p></p>
                    <center> <a href="/SocialNetwork-war/login"><u>I already have an account</u></a></center>
                </div>              
            </form>
        </div>
    </body>
</html>
