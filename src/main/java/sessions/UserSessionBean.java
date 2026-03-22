/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package sessions;

import jakarta.annotation.Resource;
import jakarta.ejb.Stateless;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.sql.DataSource;
import models.DashboardUsers;
import models.UserAuthInfo;
import org.mindrot.jbcrypt.BCrypt;

/**
 *
 * @author dm
 */
@Stateless
public class UserSessionBean {

    /* Injects the connection pool managed by Payara */
    @Resource(lookup = "jdbc/qa_app")
    private DataSource dataSource;

    public boolean isEmailInUse(String email) {
        String sql = "SELECT 1 FROM `users` WHERE `email` = ?";

        try (
            Connection conn = dataSource.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
        ) {
            stmt.setString(1, email);

            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next();
            }

        } catch (SQLException ex) {
            return false;
        }
    }

    public UserAuthInfo verifyLogin(String email, String password) {
        String sql = "SELECT * FROM `users` WHERE `email` = ?";

        try (
            Connection conn = dataSource.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
        ) {

            stmt.setString(1, email);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    String storedHash = rs.getString("password_hash");
                    if (BCrypt.checkpw(password, storedHash)) {
                        return new UserAuthInfo(
                                rs.getString("name"),
                                rs.getInt("id"),
                                rs.getString("profile_pic_url"),
                                true
                        );
                    }
                }
            }

        } catch (SQLException ex) {
            return new UserAuthInfo(null, -1, null, false);
        }

        return new UserAuthInfo(null, -1, null, false);
    }

    public boolean InsertUser(String name, String email, String password, String profile_pic) {
        /* Hash the password */
        String password_hash = BCrypt.hashpw(password, BCrypt.gensalt(12));
        String sql = "INSERT INTO `users`(`name`, `email`, `password_hash`, `profile_pic_url`, `created_at`) VALUES (?, ?, ?, ?, NOW())";

        try (
            Connection conn = dataSource.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
        ) {

            stmt.setString(1, name);
            stmt.setString(2, email);
            stmt.setString(3, password_hash);
            stmt.setString(4, profile_pic);

            int rowsAffected = stmt.executeUpdate();
            return (rowsAffected > 0);

        } catch (SQLException ex) {
            return false;
        }
    }

    public DashboardUsers[] getDashboardUsers() {
        String sql = "SELECT u.id, u.name, u.profile_pic_url, u.email, (SELECT COUNT(*) FROM questions q WHERE q.user_id = u.id) AS questionCount, (SELECT COUNT(*) FROM answers a WHERE a.user_id = u.id) AS answerCount FROM users u ORDER BY u.created_at DESC";

        try (
            Connection conn = dataSource.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
        ) {
            DashboardUsers[] users = new DashboardUsers[100]; // Arbitrary size, can be optimized
            int index = 0;

            while (rs.next() && index < users.length) {
                users[index++] = new DashboardUsers(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("profile_pic_url"),
                        rs.getString("email"),
                        rs.getInt("questionCount"),
                        rs.getInt("answerCount")
                );
            }
            /* Return only filled portion */
            return java.util.Arrays.copyOf(users, index);

        } catch (SQLException ex) {
            return new DashboardUsers[0];
        }
    }
}
