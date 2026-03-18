/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import org.mindrot.jbcrypt.BCrypt;

/**
 *
 * @author dm
 */
public class Users {

  public static boolean isEmailInUse(String email) {
    DBConnector DB = new DBConnector();

    String sql = "SELECT * FROM `users` WHERE `email` = ?";
    PreparedStatement stmt;

    try {
      stmt = DB.conn.prepareStatement(sql);
      stmt.setString(1, sql);

      ResultSet rs = stmt.executeQuery();
      return rs.next();

    } catch (SQLException ex) {
      return false;
    }
  }

  public boolean InsertUser(
          String name,
          String email, 
          String password,
          String profile_pic
  ) {
    String password_hash = BCrypt.hashpw(password, BCrypt.gensalt(12));
    String sql = "INSERT INTO `users`(`name`, `email`, `password_hash`, `profile_pic_url`, `created_at`) VALUES ( ?, ?, ?, ?, now())";
    PreparedStatement stmt;

    DBConnector DB = new DBConnector();
    try {
      stmt = DB.conn.prepareStatement(sql);
      stmt.setString(1, name);
      stmt.setString(2, email);
      stmt.setString(3, password_hash);
      stmt.setString(4, profile_pic);

      int rowsAffected = stmt.executeUpdate();
      return (rowsAffected > 0);

    } catch (SQLException ex) {
      return false;
    } catch (Exception e) {
      return false;
    }
  }
}
