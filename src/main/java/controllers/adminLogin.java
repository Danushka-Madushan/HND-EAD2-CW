/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import java.io.IOException;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.Admin;
import sessions.AdminSessionBean;

/**
 *
 * @author Danushka-Madushan
 */
public class adminLogin extends HttpServlet {

    @EJB
    private AdminSessionBean adminSessionBean;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        /* Kill the old session if it exists */
        HttpSession oldSession = request.getSession(false);
        if (oldSession != null) {
            oldSession.invalidate();
        }

        Admin admin = adminSessionBean.verifyLogin(email, password);
        HttpSession session = request.getSession(true);

        if (admin.isAuthenticated()) {
            request.setAttribute("status", "SUCCESS");

            session.setAttribute("isAdminAuthenticated", true);
            session.setAttribute("AdminUserName", admin.getName());
        } else {
            request.setAttribute("status", "FAILED");
        }

        request.getRequestDispatcher("adminLogin.jsp").forward(request, response);
    }
}
