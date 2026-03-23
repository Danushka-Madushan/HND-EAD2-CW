/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

/**
 *
 * @author Danushka-Madushan
 */
public class QuestionWithAnswers extends Question {

    private final Answer[] answers;

    public QuestionWithAnswers(int questionId, String ownerName, int ownerId, String ownerAvatar, String title, String description, String imageUrl, String createdAt, int answerCount, Answer[] answers) {
        super(questionId, ownerName, ownerId, ownerAvatar, title, description, imageUrl, createdAt, answerCount);
        this.answers = answers;
    }

    public Answer[] getAnswers() {
        return answers;
    }

}
