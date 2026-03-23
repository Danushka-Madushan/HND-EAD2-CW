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
import sessions.UserSessionBean;

/**
 *
 * @author dm
 */
public class unbanUser extends HttpServlet {

  @EJB
  private UserSessionBean userSessionBean;

  @Override
  protected void doGet(HttpServletRequest request, HttpServletResponse response)
          throws ServletException, IOException {
    /* Get userId from URL */
    int userId = Integer.parseInt(request.getPathInfo().substring(1));
    boolean success = userSessionBean.unbanUserById(userId);
    if (!success) {
      request.getSession().setAttribute("status", "FAILED");
    }
    response.sendRedirect(request.getContextPath() + "/bannedList");
  }
}
