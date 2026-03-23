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
 * @author Danushka-Madushan
 */
public class adminDashboard extends HttpServlet {

    @EJB
    private AdminSessionBean adminSessionBean;
    @EJB
    private UserSessionBean userSessionBean;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        DashboardData dashboardData = adminSessionBean.getDashboardData();
        DashboardUsers[] dashboardUsers = userSessionBean.getDashboardUsers();

        request.setAttribute("dashboardData", dashboardData);
        request.setAttribute("dashboardUsers", dashboardUsers);
        
        request.getRequestDispatcher("/WEB-INF/admin/adminDashboard.jsp").forward(request, response);
    }
}
