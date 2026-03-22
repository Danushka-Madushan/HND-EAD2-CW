/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import java.io.IOException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.File;
import java.nio.file.Files;

/**
 *
 * @author Danushka-Madushan
 */
public class serve extends HttpServlet {

    private static final String UPLOAD_DIR = "D:/qa_uploads/";
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        /* Get filename from URL */
        String fileName = request.getPathInfo().substring(1);
        File file = new File(UPLOAD_DIR, fileName);

        response.setHeader("Content-Type", getServletContext().getMimeType(fileName));
        response.setHeader("Content-Length", String.valueOf(file.length()));

        Files.copy(file.toPath(), response.getOutputStream());
    }
}
