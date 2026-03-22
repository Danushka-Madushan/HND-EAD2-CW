/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/J2EE/EJB40/StatelessEjbClass.java to edit this template
 */
package sessions;

import jakarta.annotation.Resource;
import jakarta.ejb.Stateless;
import models.Admin;
import models.DashboardData;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.sql.DataSource;
import org.mindrot.jbcrypt.BCrypt;

/**
 *
 * @author Danushka-Madushan
 */
@Stateless
public class AdminSessionBean {

    /* Injects the connection pool managed by Payara */
    @Resource(lookup = "jdbc/qa_app")
    private DataSource dataSource;

    public DashboardData getDashboardData() {
        String sql = "SELECT (SELECT COUNT(*) FROM `users`) AS totalUsers, (SELECT COUNT(*) FROM `banned_users`) AS totalBannedUsers, (SELECT COUNT(*) FROM `questions`) AS totalPosts";

        try (
            Connection conn = dataSource.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
        ) {
            if (rs.next()) {
                return new DashboardData(
                    rs.getInt("totalUsers"),
                    rs.getInt("totalBannedUsers"),
                    rs.getInt("totalPosts")
                );
            } else {
                return new DashboardData(0, 0, 0);
            }
        } catch (Exception ex) {
            return new DashboardData(0, 0, 0);
        }
    }

    public Admin verifyLogin(String email, String password) {
        String sql = "SELECT * FROM `admins` WHERE `email` = ?";

        try (
            Connection conn = dataSource.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
        ) {

            stmt.setString(1, email);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    String storedHash = rs.getString("password_hash");
                    if (BCrypt.checkpw(password, storedHash)) {
                        return new Admin(rs.getString("name"), true);
                    }
                }
            }

            return new Admin("", false);

        } catch (Exception ex) {
           return new Admin("", false);
        }
    }
}
