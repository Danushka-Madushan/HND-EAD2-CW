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
import models.QuestionWithAnswers;
import sessions.QuestionSessionBean;

/**
 *
 * @author Danushka-Madushan
 */
public class discussion extends HttpServlet {

    @EJB
    private QuestionSessionBean questionSessionBean;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        /* Get question id from URL */
        int questionId = Integer.parseInt(request.getPathInfo().substring(1));
        QuestionWithAnswers questionContent = questionSessionBean.getQuestionWithAnswers(questionId);
        
        request.setAttribute("questionContent", questionContent);
        request.getRequestDispatcher("/WEB-INF/views/discussions.jsp").forward(request, response);
    }
}
