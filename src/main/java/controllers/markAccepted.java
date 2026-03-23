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
public class markAccepted extends HttpServlet {

    @EJB
    private AnswerSessionBean answerSessionBean;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int answerId = Integer.parseInt(request.getParameter("answerId"));
        int questionId = Integer.parseInt(request.getParameter("questionId"));

        boolean success = answerSessionBean.markAnswerAsAccepted(answerId);
        if (!success) {
            request.getSession().setAttribute("status", "FAILED_MARK_ACCEPTED");
        }
        response.sendRedirect(request.getContextPath() + "/discussion/" + questionId);
    }

}
