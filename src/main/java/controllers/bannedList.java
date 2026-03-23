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
import models.DashboardData;
import models.DashboardUsers;
import sessions.AdminSessionBean;
import sessions.UserSessionBean;

/**
 *
 * @author dm
 */
public class bannedList extends HttpServlet {

    @EJB
    private UserSessionBean userSessionBean;
    @EJB
    private AdminSessionBean adminSessionBean;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        DashboardUsers[] bannedUsers = userSessionBean.getBannedUsers();
        DashboardData dashboardData = adminSessionBean.getDashboardData();
        request.setAttribute("bannedUsers", bannedUsers);
        request.setAttribute("dashboardData", dashboardData);

        request.getRequestDispatcher("/WEB-INF/admin/bannedList.jsp").forward(request, response);
    }
}
