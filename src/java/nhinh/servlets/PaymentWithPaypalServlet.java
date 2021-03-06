/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package nhinh.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.Date;
import java.util.Map;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import nhinh.cart.CartObject;
import nhinh.daos.BillDAO;
import nhinh.daos.BillDetailsDAO;
import nhinh.daos.ProductDAO;
import nhinh.daos.UserDetailsDAO;
import nhinh.dtos.ProductDTO;
import nhinh.utils.Utils;
import org.apache.log4j.Logger;

/**
 *
 * @author PC
 */
@WebServlet(name = "PaymentWithPaypalServlet", urlPatterns = {"/PaymentWithPaypalServlet"})
public class PaymentWithPaypalServlet extends HttpServlet {

    private final String ERROR_PAGE = "error.jsp";
    private final String PAYMENT_SUCCESSFUL_PAGE = "paymentSuccess.jsp";
    private Logger log = Logger.getLogger(PaymentWithPaypalServlet.class.getName());

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
        String url = ERROR_PAGE;
        try {
            /* TODO output your page here. You may use following sample code. */
            HttpSession session = request.getSession(false);
            Object fullnameObj = session.getAttribute("FULLNAME_PAYMENT_SS");
            Object phoneObject = session.getAttribute("PHONE_PAYMENT_SS");
            Object addressObj = session.getAttribute("ADDRESS_PAYMENT_SS");
            Object totalPriceObj = session.getAttribute("TOTAL_PRICE_PAYMENT_SS");
            if (fullnameObj != null && phoneObject != null && addressObj != null & totalPriceObj != null) {
                String fullname = (String) fullnameObj;
                int phone = Integer.parseInt(phoneObject + "");
                String address = (String) addressObj;
                float totalPrice = Float.parseFloat(totalPriceObj + "");
                CartObject cart = (CartObject) session.getAttribute("CUSTCART");
                if (cart != null) {
                    Map<ProductDTO, Integer> products = cart.getProducts();
                    int numOfProduct = 1;
                    Date dateTime = new Date();
                    //check products not equal null
                    if (products != null) {
                        Object numObj = session.getAttribute("NUM_OF_PRODUCT");
                        if (numObj != null) {
                            numOfProduct = (int) numObj;
                        }
                        // create bill
                        BillDAO bdao = new BillDAO();

                        String userID = (String) session.getAttribute("USERID");

                        Utils utils = new Utils();
                        String dateTimeStr = utils.formatDateTimeToString(dateTime);

                        UserDetailsDAO uddao = new UserDetailsDAO();
                        //insert user detail
                        uddao.insertUserDetails(userID, fullname, phone, address);
                        ProductDAO pdao = new ProductDAO();
                        
                        BillDetailsDAO bddao = new BillDetailsDAO();
                        int success = bdao.insertBill(userID, totalPrice, numOfProduct, dateTimeStr);
                        if (success == 1) {
                            String billID = bdao.getLastBillIDFromBill();
                            for (Map.Entry<ProductDTO, Integer> entry : products.entrySet()) {
                                ProductDTO key = entry.getKey();
                                Integer value = entry.getValue();
                                bddao.insertBillDetails(billID,key.getProductID(), value);
                                pdao.updateQuantity(key.getProductID(), value);
                            }
                            session.removeAttribute("FULLNAME_PAYMENT_SS");
                            session.removeAttribute("PHONE_PAYMENT_SS");
                            session.removeAttribute("ADDRESS_PAYMENT_SS");
                            session.removeAttribute("TOTAL_PRICE_PAYMENT_SS");
                            session.removeAttribute("CUSTCART");
                            session.removeAttribute("NUM_OF_PRODUCT");
                            request.setAttribute("PAYMENT_SUCCESS", "true");
                            url = PAYMENT_SUCCESSFUL_PAGE;

                        }
                    }
                }
            }
        } catch (SQLException ex) {
            log.error("PaymentWithPaypal_SQL:" + ex.getMessage());
        } catch (NamingException ex) {
            log.error("PaymentWithPaypal_Naming:" + ex.getMessage());
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
