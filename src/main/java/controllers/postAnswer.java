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
import sessions.AnswerSessionBean;

/**
 *
 * @author Danushka-Madushan
 */
public class postAnswer extends HttpServlet {

    @EJB
    private AnswerSessionBean answerSessionBean;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int questionId = Integer.parseInt(request.getParameter("questionId"));
        int userId = (int) request.getSession().getAttribute("userId");
        String content = request.getParameter("answerContent");
        boolean success = answerSessionBean.postAnswer(questionId, userId, content);
        if (!success) {
            request.getSession().setAttribute("status", "FAILED");
        }
        response.sendRedirect(request.getContextPath() + "/discussion/" + questionId);
    }

}
