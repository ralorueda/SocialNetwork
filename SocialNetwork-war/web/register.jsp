<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="app.entity.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8");%>
<!DOCTYPE html>

<%
    Boolean error = false;
    User user = null;
    
    String strName = "", strSurNames = "", strUserName = "", strEmail = "";
    
    if((String)request.getAttribute("error")!=null){
        error = ((String)request.getAttribute("error")).equals("user") || ((String)request.getAttribute("error")).equals("password");
    }
    
    if(error){
        
        user =  (User)request.getAttribute("user");
        
        strName = user.getName();
        strSurNames = user.getSurnames();
        strUserName = user.getUsername();
        strEmail = user.getEmail();
        
    //    Date strBDate = user.getBirthdate();
    }
 %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register</title>
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="css/formStyle.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <div class="container well" id="containerRegister">
            <form name="register" action="register" method="post">
                <div class="form-group">
                    <h1>Create new account:</h1>
                </div>
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
                    <label for="confirmPassword">Confirm Password:</label>
                    <input type="password" name="confirmPassword" class="form-control" id="confirmPasswordInput" required>
                </div> 
                <div class="form-group">
                    <label for="birthdate">Birth date:</label>
                    <input type="date" name="birthdate" class="form-control" id="birthdateInput" required >
                    
                    <%
            /*          como convertir la fecha             
                        Converting to String again, using an alternative format
            DateFormat df2 = new SimpleDateFormat("dd/MM/yyyy"); 
            String strBDate = df2.format(user.getBirthdate()); */
                        %>
                    
                </div> 
                <center><button type="submit" class="btn btn-default">Submit</button></center>   
                    <%
                        if (request.getAttribute("error") != null) {
                            if (request.getAttribute("error").equals("user")) {
                    %>
                <div class="form-group">
                    <p style="color:red">The username already exists.</p>
                </div>   
                <%
                    }
                }
                
                if (request.getAttribute("error") != null) {
                    if (request.getAttribute("error").equals("password")) {
                %>

                <div class="form-group">
                    <p style="color:red">Password doesn't match.</p>
                </div>   
                <%
                        }
                    }
                %>
            </form>
        </div>
    </body>
</html>
