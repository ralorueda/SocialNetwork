package app.servlet;

import app.ejb.PostFacade;
import app.entity.Post;
import app.entity.User;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import javax.ejb.EJB;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "HomeServlet", urlPatterns = {"/home"})
public class HomeServlet extends HttpServlet {

    @EJB
    private PostFacade postFacade;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Getting session and current user
        HttpSession session = request.getSession();
        User u = (User) session.getAttribute("thisUser");

        // If user is not logged, redirect to login
        if (session.getAttribute("thisUser") == null) {
            response.sendRedirect("login");
        } else {
            // Getting posts to show and forwarding to jsp file
            List<Post> posts;
            posts = postFacade.findFriendsPostsByUserId(u.getId());
            request.setAttribute("posts", posts);
            RequestDispatcher rd = this.getServletContext().getRequestDispatcher("/home.jsp");
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
