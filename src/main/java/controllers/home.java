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
import models.Question;
import sessions.ActivitySessionBean;
import sessions.QuestionSessionBean;

/**
 *
 * @author Danushka-Madushan
 */
public class home extends HttpServlet {

    @EJB
    private QuestionSessionBean questionSessionBean;
    @EJB
    private ActivitySessionBean activitySessionBean;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Question[] questions = questionSessionBean.getAllQuestions();
        HttpSession session = request.getSession();
        if (session.getAttribute("userId") != null) {
            int userId = (int) session.getAttribute("userId");
            request.setAttribute("userActivity", activitySessionBean.getActivityInfo(userId));
        }

        request.setAttribute("questionList", questions);
        request.getRequestDispatcher("/WEB-INF/views/index.jsp").forward(request, response);
    }

}
