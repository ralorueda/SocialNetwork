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
        HttpSession session = request.getSession();
        User u = (User) session.getAttribute("thisUser");
        String name = request.getParameter("name");
        String surnames = request.getParameter("surnames");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        String password = request.getParameter("password");
        SimpleDateFormat oldPattern = new SimpleDateFormat("EEE MMM dd hh:mm:ss zzzz yyyy");
        Date date = null;
        try {
            date = oldPattern.parse(u.getBirthdate().toString());
        } catch (ParseException ex) {
            Logger.getLogger(EditProfileServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        SimpleDateFormat newPattern = new SimpleDateFormat("yyyy-MM-dd");
        String birthdate = newPattern.format(date);
        if (!username.equals(u.getUsername()) && userFacade.findByUsername(username) != null) {
            response.sendRedirect(request.getContextPath() + "/editProfile.jsp?userError=true");
        } else if (!password.equals(u.getPassword())) {
            response.sendRedirect(request.getContextPath() + "/editProfile.jsp?passwordError=true");
        } else {
            if (newPassword.equals("")) {
                userFacade.updateUser(name, surnames, username, password, email, birthdate, u.getUsername());
            } else {
                if (!newPassword.equals(confirmPassword)) {
                    response.sendRedirect(request.getContextPath() + "/editProfile.jsp?newPasswordError=true");
                } else {
                    userFacade.updateUser(name, surnames, username, newPassword, email, birthdate, u.getUsername());
                }
            }
            response.sendRedirect(request.getContextPath() + "/myProfileInfo.jsp?editSuccess=true");
            User newUser = userFacade.findByUsername(username);
            session.setAttribute("thisUser", newUser);
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
