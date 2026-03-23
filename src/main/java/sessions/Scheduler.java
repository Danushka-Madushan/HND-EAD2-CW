/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/J2EE/EJB40/SingletonEjbClass.java to edit this template
 */
package sessions;

import jakarta.ejb.EJB;
import jakarta.ejb.Schedule;
import jakarta.ejb.Singleton;
import jakarta.ejb.Startup;
import models.Question;

/**
 *
 * @author Danushka-Madushan
 */
@Singleton
@Startup
/* Loads at Startup */
public class Scheduler {

    @EJB
    private QuestionSessionBean questionSessionBean;

    /* Executes every day at Midnight */
    @Schedule(hour = "0", minute = "0", second = "0", persistent = true)
    public void dailyJob() {
        System.out.println("Executing Daily Cleanup: " + new java.util.Date());
        Question[] oldQuestions = questionSessionBean.getQuestionsOlderThanThreeMonths();
        for (Question question : oldQuestions) {
            questionSessionBean.deleteQuestion(question.getQuestionId());
        }
    }

    /* Executes on the 1st of every 3rd month (Jan, April, July, Oct) */
    @Schedule(dayOfMonth = "1", month = "1,4,7,10", hour = "1", minute = "0", persistent = true)
    public void quarterlyJob() {
        System.out.println("Executing Quarterly Cleanup: " + new java.util.Date());
        Question[] oldQuestions = questionSessionBean.getQuestionsOlderThanThreeMonths();
        for (Question question : oldQuestions) {
            questionSessionBean.deleteQuestion(question.getQuestionId());
        }
    }
}
