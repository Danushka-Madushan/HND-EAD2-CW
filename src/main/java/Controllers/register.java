/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import sessions.UserSessionBean;
import jakarta.ejb.EJB;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author dm
 */
public class register extends HttpServlet {

  /* Injects the UserSessionBean EJB */
  @EJB
  private UserSessionBean userSessionBean;

  @Override
  protected void doPost(HttpServletRequest request, HttpServletResponse response)
          throws ServletException, IOException {
    
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String avatar_link = request.getParameter("avatar_link");
    String password = request.getParameter("password");
    String password_confirmation = request.getParameter("password_confirmation");
  
    RequestDispatcher dispatcher = request.getRequestDispatcher("register.jsp");
   
    if (userSessionBean.isEmailInUse(email))
    {
      request.setAttribute("status", "EMAIL_IN_USE");
      dispatcher.forward(request, response);
      return;
    }
    
    if (!password.equals(password_confirmation))
    {
      request.setAttribute("name", name);
      request.setAttribute("email", email);
      request.setAttribute("status", "PASS_NOT_MATCH");
      dispatcher.forward(request, response);
      return;
    }

    boolean isUserCreated = userSessionBean.InsertUser(name, email, password, avatar_link);
    
    if (isUserCreated) {
      request.setAttribute("status", "SUCCESS");
    } else {
      request.setAttribute("status", "FAILED");
    }
    
    dispatcher.forward(request, response);
  }
}
