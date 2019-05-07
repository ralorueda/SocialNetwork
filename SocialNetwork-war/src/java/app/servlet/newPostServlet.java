package app.servlet;

import app.ejb.PostFacade;
import app.entity.Post;
import app.entity.User;
import java.io.IOException;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "newPostServlet", urlPatterns = {"/newPost"})
public class newPostServlet extends HttpServlet {

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
            // If text is null, redirect to home
            if (request.getParameter("text") == null) {
                response.sendRedirect("home");
            } else {
                // Insert the new post
                String text = request.getParameter("text");
                Post post = new Post();
                post.setAuthor(u);
                post.setText(text);
                postFacade.insertPost(post);
                response.sendRedirect("home");
            }
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

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
