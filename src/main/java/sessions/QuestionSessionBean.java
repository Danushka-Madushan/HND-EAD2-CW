/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/J2EE/EJB40/StatelessEjbClass.java to edit this template
 */
package sessions;

import jakarta.annotation.Resource;
import jakarta.ejb.EJB;
import jakarta.ejb.Stateless;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import models.Question;
import models.QuestionWithAnswers;

/**
 *
 * @author Danushka-Madushan
 */
@Stateless
public class QuestionSessionBean {

    /* Injects the connection pool managed by Payara */
    @Resource(lookup = "jdbc/qa_app")
    private DataSource dataSource;
    @EJB
    private AnswerSessionBean answerSessionBean;


    public boolean InsertQuestion(int userId, String title, String description, String imageUrl) {
        String sql = "INSERT INTO `questions` (`user_id`, `title`, `description`, `image_url`, `created_at`) VALUES ( ?, ?, ?, ?, NOW())";

        try (
            Connection conn = dataSource.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
        ) {

            stmt.setInt(1, userId);
            stmt.setString(2, title);
            stmt.setString(3, description);
            stmt.setString(4, imageUrl);

            int rowsAffected = stmt.executeUpdate();
            return (rowsAffected > 0);

        } catch (SQLException ex) {
            return false;
        }
    }

    public Question[] getAllQuestions() {
        String sql = "SELECT q.id, q.user_id, q.title, q.description, q.image_url, q.created_at, u.name, u.profile_pic_url FROM questions q JOIN users u ON q.user_id = u.id ORDER BY q.created_at DESC";
        try (
            Connection conn = dataSource.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
        ) {
            ResultSet rs = stmt.executeQuery();

            ArrayList<Question> questionsList = new ArrayList<>();
            while (rs.next()) {
                Question question = new Question(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getInt("user_id"),
                    rs.getString("profile_pic_url"),
                    rs.getString("title"),
                    rs.getString("description"),
                    rs.getString("image_url"),
                    rs.getTimestamp("created_at").toString(),
                    answerSessionBean.getAnswerCountForQuestion(rs.getInt("id"))
                );
                questionsList.add(question);
            }
            return questionsList.toArray(Question[]::new);

        } catch (SQLException ex) {
            return new Question[0];
        }
    }

    public Question[] getQuestionsOlderThanThreeMonths() {
        String sql = "SELECT q.id, q.user_id, q.title, q.description, q.image_url, q.created_at, u.name, u.profile_pic_url FROM questions q JOIN users u ON q.user_id = u.id WHERE q.created_at < (NOW() - INTERVAL 3 MONTH) ORDER BY q.created_at DESC";
        try (
            Connection conn = dataSource.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
        ) {
            ResultSet rs = stmt.executeQuery();

            ArrayList<Question> questionsList = new ArrayList<>();
            while (rs.next()) {
                Question question = new Question(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getInt("user_id"),
                    rs.getString("profile_pic_url"),
                    rs.getString("title"),
                    rs.getString("description"),
                    rs.getString("image_url"),
                    rs.getTimestamp("created_at").toString(),
                    answerSessionBean.getAnswerCountForQuestion(rs.getInt("id"))
                );
                questionsList.add(question);
            }
            return questionsList.toArray(Question[]::new);

        } catch (SQLException ex) {
            return new Question[0];
        }
    }

    public boolean deleteQuestion(int questionId) {
        String sql = "DELETE FROM questions WHERE id = ?";
        try (
            Connection conn = dataSource.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
        ) {
            stmt.setInt(1, questionId);
            int rowsAffected = stmt.executeUpdate();
            return (rowsAffected > 0);

        } catch (SQLException ex) {
            return false;
        }
    }

    public QuestionWithAnswers getQuestionWithAnswers(int questionId) {
        String sql = "SELECT q.id, q.user_id, q.title, q.description, q.image_url, q.created_at, u.name, u.profile_pic_url FROM questions q JOIN users u ON q.user_id = u.id WHERE q.id = ?";
        try (
            Connection conn = dataSource.getConnection();
            PreparedStatement stmt = conn.prepareStatement(sql);
        ) {
            stmt.setInt(1, questionId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                QuestionWithAnswers question = new QuestionWithAnswers(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getInt("user_id"),
                    rs.getString("profile_pic_url"),
                    rs.getString("title"),
                    rs.getString("description"),
                    rs.getString("image_url"),
                    rs.getTimestamp("created_at").toString(),
                    answerSessionBean.getAnswerCountForQuestion(rs.getInt("id")),
                    answerSessionBean.getAnswersForQuestion(rs.getInt("id"))
                );
                return question;
            } else {
                return null;
            }

        } catch (SQLException ex) {
            return null;
        }
    }

}
