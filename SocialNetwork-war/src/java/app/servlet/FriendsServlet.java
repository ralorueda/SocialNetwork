package app.servlet;

import app.ejb.FriendshipFacade;
import app.entity.User;
import java.io.IOException;
import java.util.List;
import javax.ejb.EJB;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "FriendsServlet", urlPatterns = {"/friends"})
public class FriendsServlet extends HttpServlet {

    @EJB
    private FriendshipFacade friendshipFacade;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Getting session and current user
        HttpSession session = request.getSession();
        User u = (User) session.getAttribute("thisUser");

        // If user is not logged, redirect to login
        if (session.getAttribute("thisUser") == null) {
            response.sendRedirect("login");
        } else {
            // Getting friends to show and forwarding to jsp file
            List<User> friends;
            friends = friendshipFacade.findFriendsListById(u.getId());
            request.setAttribute("friends", friends);
            RequestDispatcher rd = this.getServletContext().getRequestDispatcher("/friends.jsp");
            rd.forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

}
