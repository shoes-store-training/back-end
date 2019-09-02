/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.bean.Account;
import model.bo.AccessAccountBO;

/**
 *
 * @author Dell Inspiron14
 */
@WebServlet(name = "EditProfileUserServlet", urlPatterns = {"/EditProfileUserServlet"})
public class EditProfileUserServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws java.sql.SQLException
     * @throws java.lang.ClassNotFoundException
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException, ClassNotFoundException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet EditProfileUserServlet</title>");
            out.println("</head>");
            out.println("<body>");
            String cancelButton = request.getParameter("cancel-btn");
            String saveButton = request.getParameter("save-btn");
            if ("cancel".equals(cancelButton)) {
                HttpSession session = request.getSession();
                Account acc = (Account) session.getAttribute("account");
                String url = "/view-edit-profile-user.jsp";
                getServletContext()
                        .getRequestDispatcher(url)
                        .forward(request, response);
            } else {
            }
            if ("save".equals(saveButton)) {
                String fullName = request.getParameter("full_name");
                String phoneNumber = request.getParameter("phone_number");
                String email = request.getParameter("email");
                String valueOfGender = request.getParameter("gender");
                out.println(valueOfGender);
                String gender;
                if ("off".equals(valueOfGender)) {
                    gender = "2";
                } else {
                    gender = "1";
                }
                out.println(gender);
                String address = request.getParameter("address");
                HttpSession session = request.getSession();
                Account acc = (Account) session.getAttribute("account");
                acc.setFullName(fullName);
                acc.setPhoneNumber(phoneNumber);
                acc.setEmail(email);
                acc.setGender(gender);
                acc.setAddress(address);
                acc.setIsSaved(true);
                AccessAccountBO accessAccountBO = new AccessAccountBO();
                accessAccountBO.saveAccount(acc);
                session.setAttribute("account", acc);
                String url = "/view-edit-profile-user.jsp";
                getServletContext()
                        .getRequestDispatcher(url)
                        .forward(request, response);
            }
            out.println("</body>");
            out.println("</html>");
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
        try {
            processRequest(request, response);
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(EditProfileUserServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (SQLException | ClassNotFoundException ex) {
            Logger.getLogger(EditProfileUserServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
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
