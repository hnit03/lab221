/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package nhinh.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import nhinh.accessGoogle.GooglePojo;
import nhinh.accessGoogle.GoogleUtils;
import nhinh.daos.RegistrationDAO;
import nhinh.daos.UserDetailsDAO;
import nhinh.dtos.UserDetailsDTO;
import org.apache.log4j.Logger;

/**
 *
 * @author PC
 */
@WebServlet(name = "LoginWithGoogleServlet", urlPatterns = {"/LoginWithGoogleServlet"})
public class LoginWithGoogleServlet extends HttpServlet {
    private Logger log = Logger.getLogger(LoginWithGoogleServlet.class.getName());
    private final String LOGIN_PAGE = "login.jsp";
    private final String START_UP_CONTROLLER = "StartUpServlet";
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        String url = LOGIN_PAGE;
        try {
            /* TODO output your page here. You may use following sample code. */
            String code = request.getParameter("code");
            if (code != null) {
                HttpSession session = request.getSession();
                String accessToken = GoogleUtils.getToken(code);
                GooglePojo googlePojo = GoogleUtils.getUserInfo(accessToken);
                String userID = googlePojo.getEmail();
                RegistrationDAO dao = new RegistrationDAO();
                int role = dao.checkLoginWithGoogle(userID);

                boolean isAdmin = false;
                if (role != -1) {
                    if (role == 0) {
                        url = START_UP_CONTROLLER;
                        UserDetailsDAO udao = new UserDetailsDAO();
                        UserDetailsDTO udto = udao.getUserDetails(userID);
                        session.setAttribute("USER_DETAILS", udto);
                        session.setAttribute("USERID", userID);
                        isAdmin = false;
                    } else {
                        url = START_UP_CONTROLLER;
                        isAdmin = true;
                    }
                    session.setAttribute("USERID", userID);
                    session.setAttribute("FULLNAME", dao.getFullname(userID));
                    session.setAttribute("ISADMIN", isAdmin);
                }

            }

        } catch (SQLException ex) {
            log.error("LoginWithGoogle_SQL:" + ex.getMessage());
        } catch (NamingException ex) {
            log.error("LoginWithGoogle_Namings:" + ex.getMessage());
        } finally {
            RequestDispatcher rd = request.getRequestDispatcher(url);
            rd.forward(request, response);
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
