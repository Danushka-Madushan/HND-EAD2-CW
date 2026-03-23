/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

/**
 *
 * @author Danushka-Madushan
 */
public class UserAuthInfo {

    private final String userName;
    private final int userId;
    private final String avatar_url;
    private final boolean isAuthenticated;

    public UserAuthInfo(String userName, int userId, String avatar_url, boolean isAuthenticated) {
        this.userName = userName;
        this.userId = userId;
        this.avatar_url = avatar_url;
        this.isAuthenticated = isAuthenticated;
    }

    public boolean isAuthenticated() {
        return isAuthenticated;
    }

    public String getUserName() {
        return userName;
    }

    public int getUserId() {
        return userId;
    }

    public String getAvatar_url() {
        return avatar_url;
    }
}
