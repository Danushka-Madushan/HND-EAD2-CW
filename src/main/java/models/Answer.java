/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

/**
 *
 * @author Danushka-Madushan
 */
public class Answer {
    private final int answerId;
    private final String content;
    private final String ownerName;
    private final String ownerAvatar;
    private final String createdAt;
    private final boolean isAccepted;

    public Answer(int answerId, String content, String ownerName, String ownerAvatar, String createdAt, boolean isAccepted) {
        this.answerId = answerId;
        this.content = content;
        this.ownerName = ownerName;
        this.ownerAvatar = ownerAvatar;
        this.createdAt = createdAt;
        this.isAccepted = isAccepted;
    }
    
    public int getAnswerId() {
        return answerId;
    }

    public String getContent() {
        return content;
    }

    public String getOwnerName() {
        return ownerName;
    }

    public String getOwnerAvatar() {
        return ownerAvatar;
    }

    public String getPostedAgo() {
        return Util.getTimeAgo(createdAt);
    }

    public boolean isAccepted() {
        return isAccepted;
    }
}
