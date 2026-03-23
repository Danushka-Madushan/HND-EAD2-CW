/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

/**
 *
 * @author Danushka-Madushan
 */
public class Question {

    private final int questionId;
    private final String ownerName;
    private final int ownerId;
    private final String ownerAvatar;
    private final String title;
    private final String description;
    private final String imageUrl;
    private final String createdAt;
    private final int answerCount;

    public Question(int questionId, String ownerName, int ownerId, String ownerAvatar, String title, String description, String imageUrl, String createdAt, int answerCount) {
        this.questionId = questionId;
        this.ownerName = ownerName;
        this.ownerId = ownerId;
        this.ownerAvatar = ownerAvatar;
        this.title = title;
        this.description = description;
        this.imageUrl = imageUrl;
        this.createdAt = createdAt;
        this.answerCount = answerCount;
    }

    public int getQuestionId() {
        return questionId;
    }

    public int getOwnerId() {
        return ownerId;
    }

    public String getOwnerName() {
        return ownerName;
    }

    public String getOwnerAvatar() {
        return ownerAvatar;
    }

    public String getTitle() {
        return title;
    }

    public String getDescription() {
        return description;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public String getCreatedTimeAgo() {
        return Util.getTimeAgo(createdAt);
    }

    public int getAnswerCount() {
        return answerCount;
    }
}
