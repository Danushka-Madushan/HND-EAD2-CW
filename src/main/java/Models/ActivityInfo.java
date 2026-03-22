/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

/**
 *
 * @author Danushka-Madushan
 */
public class ActivityInfo {

    private final int questionCount;
    private final int answerCount;

    public ActivityInfo(int questionCount, int answerCount) {
        this.questionCount = questionCount;
        this.answerCount = answerCount;
    }

    public int getQuestionCount() {
        return questionCount;
    }

    public int getAnswerCount() {
        return answerCount;
    }
}
