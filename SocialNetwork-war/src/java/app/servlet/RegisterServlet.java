package app.servlet;

import app.ejb.UserFacade;
import app.entity.User;
import java.io.IOException;
import java.text.DateFormat;
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

@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {

    @EJB
    private UserFacade userFacade;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Getting session and parameters
        HttpSession session = request.getSession();

        // If user already logged, redirect to home
        if (session.getAttribute("thisUser") != null) {
            response.sendRedirect("home");
        } else {
            String str;
            User user = new User();
            request.setAttribute("error", "");
            str = request.getParameter("name");
            user.setName(str);
            str = request.getParameter("surnames");
            user.setSurnames(str);
            str = request.getParameter("username");
            user.setUsername(str);
            str = request.getParameter("email");
            user.setEmail(str);
            str = request.getParameter("password");
            user.setPassword(str);
            String password2 = request.getParameter("confirmPassword");
            String birthdate = request.getParameter("birthdate");
            request.setAttribute("birthdate", birthdate);

            /*  DateFormat df = new SimpleDateFormat("dd/MM/yyyy"); 
        
        try {
            // Convert from String to Date
            Date BDate = df.parse(birthdate);
            user.setBirthdate(BDate);
        } catch (ParseException ex) {
            Logger.getLogger(RegisterServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        DateFormat df2 = new SimpleDateFormat("dd/MM/yyyy"); 
            String strBDate = df2.format(user.getBirthdate());
            request.setAttribute("datePrueba", strBDate);*/
            request.setAttribute("user", user);

            if (userFacade.findByUsername(user.getUsername()) != null) {
                request.setAttribute("error", "user");
                RequestDispatcher rd = request.getRequestDispatcher("/register.jsp");
                rd.forward(request, response);

            } else if (!user.getPassword().equals(password2)) {
                request.setAttribute("error", "password");
                RequestDispatcher rd = request.getRequestDispatcher("/register.jsp");
                rd.forward(request, response);
            } else {
                //userFacade.insertUser(user.getName(), user.getSurnames(), user.getUsername(), user.getPassword(), user.getEmail(), birthdate, 2);
                userFacade.insertUser(user, birthdate);
                response.sendRedirect(request.getContextPath() + "/login.jsp");
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
