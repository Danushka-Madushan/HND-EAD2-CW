/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import jakarta.ejb.EJB;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import sessions.UserSessionBean;

/**
 *
 * @author Danushka-Madushan
 */
public class deleteUser extends HttpServlet {

    @EJB
    private UserSessionBean userSessionBean;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        /* Get userId from URL first is uid after dash is path /2-1 */
        String segment = request.getPathInfo().substring(1);
        String[] parts = segment.split("-");
        int userId = Integer.parseInt(parts[0]);
        int path = Integer.parseInt(parts[1]);
        boolean success = userSessionBean.deleteUserById(userId);
        if (!success) {
            request.getSession().setAttribute("status", "FAILED");
        }
        switch (path) {
            case 1: {
                response.sendRedirect(request.getContextPath() + "/adminDashboard");
                return;
            }
            case 2: {
                response.sendRedirect(request.getContextPath() + "/bannedList");
                return;
            }
        }
    }
}
