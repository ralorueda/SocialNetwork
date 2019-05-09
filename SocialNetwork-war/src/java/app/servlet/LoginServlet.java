package app.servlet;

import app.ejb.UserFacade;
import app.entity.User;
import java.io.IOException;
import javax.ejb.EJB;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    @EJB
    private UserFacade userFacade;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Getting session and parameters
        HttpSession session = request.getSession();
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // If it's the first time, redirect to the jsp
        if (session.getAttribute("thisUser") == null && username == null) {
            if (request.getParameter("registered") != null) {
                request.setAttribute("registered", "true");
            } else if (request.getParameter("deleted") != null) {
                request.setAttribute("deleted", "true");
                request.setAttribute("account", request.getParameter("account"));
            }
            RequestDispatcher rd = this.getServletContext().getRequestDispatcher("/login.jsp");
            rd.forward(request, response);
        } else {

            // If user already logged, redirect to home
            if (session.getAttribute("thisUser") != null) {
                response.sendRedirect("home");
            } else {
                // Checking if username is correct
                if (userFacade.findByUsername(username) == null) {
                    request.setAttribute("error", "user");
                    RequestDispatcher rd = this.getServletContext().getRequestDispatcher("/login.jsp");
                    rd.forward(request, response);
                } else {
                    // Checking if password is correct
                    User user = userFacade.findByUsername(username);
                    if (user.getPassword().equals(password)) {
                        session.setAttribute("thisUser", user);
                        response.sendRedirect("home");
                    } else {
                        request.setAttribute("error", "password");
                        RequestDispatcher rd = this.getServletContext().getRequestDispatcher("/login.jsp");
                        rd.forward(request, response);
                    }
                }
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

}
