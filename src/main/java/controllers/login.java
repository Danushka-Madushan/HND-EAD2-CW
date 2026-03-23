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
import models.UserAuthInfo;
import sessions.UserSessionBean;

/**
 *
 * @author Danushka-Madushan
 */
public class login extends HttpServlet {

    /* Inject the UserSessionBean EJB */
    @EJB
    private UserSessionBean userSessionBean;

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

        UserAuthInfo isAuthenticated = userSessionBean.verifyLogin(email, password);
        HttpSession session = request.getSession(true);

        if (isAuthenticated.isAuthenticated()) {
            request.setAttribute("status", "SUCCESS");
            
            session.setAttribute("isAuthenticated", true);
            session.setAttribute("userName", isAuthenticated.getUserName());
            session.setAttribute("userId", isAuthenticated.getUserId());
            session.setAttribute("avatar_url", isAuthenticated.getAvatar_url());
        } else {
            request.setAttribute("status", "FAILED");
        }

        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
}
