/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/J2EE/EJB40/StatelessEjbClass.java to edit this template
 */
package sessions;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.ResultSet;
import jakarta.annotation.Resource;
import jakarta.ejb.Stateless;
import models.Answer;

/**
 *
 * @author Danushka-Madushan
 */
@Stateless
public class AnswerSessionBean {

    /* Injects the connection pool managed by Payara */
    @Resource(lookup = "jdbc/qa_app")
    private DataSource dataSource;

    public boolean markAnswerAsAccepted(int answerId) {
        String sql = "UPDATE `answers` SET `is_accepted` = TRUE WHERE `id` = ?";

        try (
            Connection conn = dataSource.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
        ) {

            stmt.setInt(1, answerId);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException ex) {
            return false;
        }
    }

    public boolean postAnswer(int questionId, int userId, String content) {
        String sql = "INSERT INTO `answers` (question_id, user_id, content) VALUES (?, ?, ?)";

        try (
            Connection conn = dataSource.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
        ) {

            stmt.setInt(1, questionId);
            stmt.setInt(2, userId);
            stmt.setString(3, content);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException ex) {
            return false;
        }
    }

    public int getAnswerCountForQuestion(int questionId) {
        String sql = "SELECT COUNT(*) AS answer_count FROM `answers` WHERE `question_id` = ?";

        try (
            Connection conn = dataSource.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
        ) {

            stmt.setInt(1, questionId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("answer_count");
                }
            }

        } catch (SQLException ex) {
            return 0;
        }

        return 0;
    }

    public Answer[] getAnswersForQuestion(int questionId) {
        String sql = "SELECT a.*, u.name AS poster_name, u.profile_pic_url AS poster_profile_pic FROM `answers` AS a JOIN `users` AS u ON a.user_id = u.id WHERE a.question_id = ? ORDER BY a.created_at DESC";

        try (
            Connection conn = dataSource.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
        ) {

            stmt.setInt(1, questionId);

            try (ResultSet rs = stmt.executeQuery()) {
                /* Initialize array to store answers */
                Answer[] answers = new Answer[100];
                int index = 0;
                while (rs.next()) {
                    answers[index++] = new Answer(
                        rs.getInt("id"),
                        rs.getString("content"),
                        rs.getString("poster_name"),
                        rs.getString("poster_profile_pic"),
                        rs.getTimestamp("created_at").toString(),
                        rs.getBoolean("is_accepted")
                    );
                }
                /* Return only filled portion */
                return java.util.Arrays.copyOf(answers, index);
            }

        } catch (SQLException ex) {
            return new Answer[0];
        }
    }
}
