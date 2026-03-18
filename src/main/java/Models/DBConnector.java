/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

import java.sql.*;

/**
 *
 * @author dm
 */
public class DBConnector {

  public Connection conn;
  private String url = "jdbc:mysql://localhost:3306/qa_app";
  private String username = "root";
  private String password = "";

  public DBConnector() {
    try {
      Class.forName("com.mysql.cj.jdbc.Driver");
      conn = DriverManager.getConnection(url, username, password);
    } catch (ClassNotFoundException | SQLException e) {
      System.out.println("Database Connection Failed!");
    }
  }
}
