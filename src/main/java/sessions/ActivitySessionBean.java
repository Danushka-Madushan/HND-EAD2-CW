/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/J2EE/EJB40/StatelessEjbClass.java to edit this template
 */
package sessions;

import jakarta.annotation.Resource;
import jakarta.ejb.Stateless;
import models.ActivityInfo;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author Danushka-Madushan
 */
@Stateless
public class ActivitySessionBean {

    /* Injects the connection pool managed by Payara */
    @Resource(lookup = "jdbc/qa_app")
    private DataSource dataSource;

    public ActivityInfo getActivityInfo(int userId) {
        String sql = "SELECT (SELECT COUNT(*) FROM `questions` WHERE user_id = ?) AS questions_posted, (SELECT COUNT(*) FROM `answers` WHERE user_id = ?) AS answers_posted";
        try (
            Connection conn = dataSource.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql)
        ) {
            stmt.setInt(1, userId);
            stmt.setInt(2, userId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    int questionCount = rs.getInt("questions_posted");
                    int answerCount = rs.getInt("answers_posted");
                    return new ActivityInfo(questionCount, answerCount);
                }
            }

        } catch (Exception ex) {
            return new ActivityInfo(0, 0);
        }

        return new ActivityInfo(0, 0);
    }
}
