/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

/**
 *
 * @author Danushka-Madushan
 */
public class DashboardUsers {

    private final int id;
    private final String name;
    private final String profile_pic_url;
    private final String email;
    private final int questionCount;
    private final int answerCount;

    public DashboardUsers(int id, String name, String profile_pic_url, String email, int questionCount, int answerCount) {
        this.id = id;
        this.name = name;
        this.profile_pic_url = profile_pic_url;
        this.email = email;
        this.questionCount = questionCount;
        this.answerCount = answerCount;
    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getProfilePicUrl() {
        return profile_pic_url;
    }

    public String getEmail() {
        return email;
    }

    public int getQuestionCount() {
        return questionCount;
    }

    public int getAnswerCount() {
        return answerCount;
    }
}
