<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="css/formStyle.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <!--Getting current user and errors-->
        <%           
            String error;
            if (request.getAttribute("error") == null) {
                error = "none";
            } else {
                error = (String) request.getAttribute("error");
            }
        %>
        
        <!--Username and password form-->
        <div class="container well" id="containerLogin">
            <center><img src="Images/userIcon.png" alt="" class="img-circle"/></center>
            <form name="login" action="login" method="post">
                <div class="form-group">
                    <label for="user">Username</label>
                    <input type="text" name="username" class="form-control" id="UserInput" required>
                </div>
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" name="password" class="form-control" id="PasswordInput" required>
                </div>
                <center><button type="submit" class="btn btn-default">Submit</button></center>   
                <div class="form-group">
                    <p></p>
                    <center> <a href="/SocialNetwork-war/register.jsp">Create new account!</a></center>
                </div>  
                
                <!--Errors control-->
                <%
                    if (error.equals("user")) {
                %>
                <div class="alert">
                    <span class="closebtn" onclick="this.parentElement.style.display = 'none';">&times;</span> 
                    Incorrect username.
                </div>            
                <%
                    }
                    if (error.equals("password")) {
                %>
                <div class="alert">
                    <span class="closebtn" onclick="this.parentElement.style.display = 'none';">&times;</span> 
                    Incorrect password.
                </div>    
                <%
                    }
                %>
            </form>
        </div>
    </body>
</html>
