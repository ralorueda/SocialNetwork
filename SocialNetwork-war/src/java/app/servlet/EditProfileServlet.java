package app.servlet;

import app.ejb.UserFacade;
import app.entity.User;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.ejb.EJB;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "EditProfileServlet", urlPatterns = {"/editProfile"})
public class EditProfileServlet extends HttpServlet {

    @EJB
    private UserFacade userFacade;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Getting session and parameters
        HttpSession session = request.getSession();

        // If user already logged, redirect to home
        if (session.getAttribute("thisUser") == null) {
            response.sendRedirect("login");
        } else {
            if (request.getParameter("first") != null) {
                User u = (User) session.getAttribute("thisUser");
                String name = request.getParameter("name");
                String surnames = request.getParameter("surnames");
                String username = request.getParameter("username");
                String email = request.getParameter("email");
                String newPassword = request.getParameter("newPassword");
                String confirmPassword = request.getParameter("confirmPassword");
                String password = request.getParameter("password");
                String description = request.getParameter("description");
                SimpleDateFormat oldPattern = new SimpleDateFormat("EEE MMM dd hh:mm:ss zzzz yyyy");
                Date date = null;
                try {
                    date = oldPattern.parse(u.getBirthdate().toString());
                } catch (ParseException ex) {
                    Logger.getLogger(EditProfileServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
                if (!username.equals(u.getUsername()) && userFacade.findByUsername(username) != null) {
                    request.setAttribute("error", "user");
                    RequestDispatcher rd = request.getRequestDispatcher("/editProfile.jsp");
                    rd.forward(request, response);
                } else if (!password.equals(u.getPassword())) {
                    request.setAttribute("error", "password");
                    RequestDispatcher rd = request.getRequestDispatcher("/editProfile.jsp");
                    rd.forward(request, response);
                } else {
                    if (newPassword.equals("")) {
                        User newUser = userFacade.find(u.getId());
                        newUser.setName(name);
                        newUser.setSurnames(surnames);
                        newUser.setUsername(username);
                        newUser.setPassword(password);
                        newUser.setEmail(email);
                        newUser.setBirthdate(date);
                        newUser.setDescription(description);
                        userFacade.edit(newUser);
                    } else {
                        if (!newPassword.equals(confirmPassword)) {
                            request.setAttribute("error", "confirmPassword");
                            RequestDispatcher rd = request.getRequestDispatcher("/editProfile.jsp");
                            rd.forward(request, response);
                        } else {
                            User newUser = userFacade.find(u.getId());
                            newUser.setName(name);
                            newUser.setSurnames(surnames);
                            newUser.setUsername(username);
                            newUser.setPassword(newPassword);
                            newUser.setEmail(email);
                            newUser.setBirthdate(date);
                            newUser.setDescription(description);
                            userFacade.edit(newUser);
                        }
                    }
                    User newUser = userFacade.findByUsername(username);
                    session.setAttribute("thisUser", newUser);
                    response.sendRedirect(request.getContextPath() + "/settings?edited=true");
                }
            } else {
                RequestDispatcher rd = this.getServletContext().getRequestDispatcher("/editProfile.jsp");
                rd.forward(request, response);
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
