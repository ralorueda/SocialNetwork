
<%@page import="java.util.List"%>
<%@page import="app.entity.Party"%>
<%@page import="app.entity.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    User u = (User) session.getAttribute("thisUser");
    List<Party> listParty = (List) request.getAttribute("listParty");
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
                                    <a href="friends" class="list-group-item">Friends<span class="badge badge-primary badge-pill"><% out.println(u.getFriendshipCollection().size() + u.getFriendshipCollection1().size()); %></span></a>
                                    <a href="groups" class="list-group-item active">Groups<span class="badge badge-primary badge-pill"><% out.println(u.getPartyCollection().size() + u.getMembershipCollection().size()); %></span></a>
                                </ul>
                            </div>
                        </div>

                        <!-- Group list part -->
                        <div class="col-md-9">
                            <div class="col-md-12" style="border-width: 1px 1px 0px 1px; border-style: solid; border-color: lightgrey; background: #f1f3f6;">
                                <h3 style="text-align: left">Groups <p><small>This is your group list.</small></p></h3>                                
                                <p></p>
                            </div>
                            <div class="col-md-12" style="border: 1px solid lightgrey; background: #e5eaf2;">      
                                <br>
                                <div>
                                    <a href="#popUp" data-toggle="modal">
                                        <button class="btn btn-default">Create new group</button> 
                                    </a>                                    
                                </div>
                                <br>
                                <%
                                    if (listParty != null) {
                                        for (Party party : listParty) {
                                %>
                                <div class="containerPost">
                                    <img src="Images/userIcon.png" alt="Avatar" style="width:100%;">
                                    <span class="partyInfo"><a href="/SocialNetwork-war/group?id=<%=party.getId()%>"><%=party.getName()%></a></span>
                                    &nbsp;&nbsp;
                                    <%
                                        if (party.getDescription() != null) {
                                    %>
                                    <p>
                                        <%=party.getDescription()%>
                                    </p>
                                    <%
                                    } else {
                                    %>
                                    <p> Group with no description.</p>
                                    <%
                                        }
                                    %>
                                    <%
                                        if (u.getId() == party.getOwner().getId()) {
                                    %>

                                    <div align="right">
                                        <a href="DeleteGroupServlet?partyId=<%= party.getId()%>" data-toggle="modal">
                                            <span style="font-size: 20px" class="glyphicon glyphicon-minus-sign" id="delete"></span>
                                        </a>
                                    </div>   
                                    <%
                                        }
                                    %>                      
                                </div>
                                <%
                                        }
                                    }
                                %>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Pop up delete profile -->
            <form action="createGroup" method="post">
                <div id="popUp" class="modal fade" >
                    <div class="modal-dialog">
                        <!-- Modal content-->
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal">&times;</button>
                                <h4 class="modal-title">Creating new group...</h4>
                            </div>
                            <div class="modal-body">
                                <div class="form-group">
                                    <label for="name">Name:</label>
                                    <input type="text" name="groupname" class="form-control" value="" id="nameInput" required >
                                </div>
                                <div class="form-group">
                                    <label for="description">Description:</label>
                                    <br>
                                    <textarea rows="3" name="description"  class="form-control" id="description"></textarea>
                                </div>
                                <div class="form-group">
                                    <input  name="owner" type="hidden" class="form-control" required value="<%=u.getId()%>">
                                </div>  
                            </div>
                            <div class="modal-footer">
                                <button type="submit" class="btn btn-primary">Create</button>
                            </div>
                        </div>
                    </div>
                </div>
            </form>

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
