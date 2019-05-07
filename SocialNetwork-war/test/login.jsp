
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
        <div class="container well" id="containerLogin">
            <center><img src="Images/userIcon.png" alt="" class="img-circle"/></center>
            <form name="login" action="login" method="post">
                <div class="form-group">
                    <label for="user">User</label>
                    <input type="text" name="username" class="form-control" id="UserInput" placeholder="User" required>
                </div>
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" name="password" class="form-control" id="PasswordInput" placeholder="Password" required>
                </div>
                <center><button type="submit" class="btn btn-default">Submit</button></center>    
                    <%
                        if (request.getParameter("error") != null) {
                            if (request.getParameter("error").equals("userError")) {
                    %>
                <p style="color:red">Incorrect username.</p>
                <%
                } else if (request.getParameter("error").equals("passwordError")) {
                %>
                <p style="color:red">Incorrect password.</p>
                <%
                        }
                    }
                %>
            </form>
        </div>
    </body>
</html>
