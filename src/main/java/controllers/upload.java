/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.util.UUID;
import jakarta.ejb.EJB;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import sessions.QuestionSessionBean;
import models.Util;

/**
 *
 * @author Danushka-Madushan
 */
@MultipartConfig
public class upload extends HttpServlet {

    @EJB
    private QuestionSessionBean questionSessionBean;
    private static final String UPLOAD_DIR = "C:/qa_uploads/";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Part filePart = request.getPart("image");
        String fileName = "NULL-IMAGE";

        String description = request.getParameter("description");
        String title = request.getParameter("title");
        String userId = request.getSession().getAttribute("userId").toString();

        if (filePart != null && filePart.getSize() > 0) {

            File uploadDir = new File(UPLOAD_DIR);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            fileName = UUID.randomUUID().toString() + "_" + Util.getFileName(filePart);

            File fileToSave = new File(uploadDir, fileName);

            try (InputStream input = filePart.getInputStream()) {
                Files.copy(input, fileToSave.toPath(), java.nio.file.StandardCopyOption.REPLACE_EXISTING);
            }
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("newQuestion.jsp");

        boolean isQuestionInserted = questionSessionBean.InsertQuestion(Integer.parseInt(userId), title, description, fileName);

        if (isQuestionInserted) {
            request.setAttribute("status", "SUCCESS");
        } else {
            request.setAttribute("status", "FAILED");
        }

        dispatcher.forward(request, response);
    }

}
