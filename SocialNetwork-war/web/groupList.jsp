<%-- 
    Document   : group_List
    Created on : Apr 24, 2019, 2:36:23 PM
    Author     : love2
--%>


<%@page import="java.util.List"%>
<%@page import="app.entity.Party"%>
<%@page import="app.entity.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    User user=(User) session.getAttribute("thisUser");
    List <Party> parties= (List) request.getAttribute("list");
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Lista</h1>
       
        <table>
            <tr>
                <th> Name of groups </th>
            
            </tr>
            <%
                for(Party party:parties){
                   
                %>
                <tr>
                    <td><%=party.getName() %> </td>
                </tr>
            <%
                
                }
                %>         
                    </table>
        
    </body>
</html>
