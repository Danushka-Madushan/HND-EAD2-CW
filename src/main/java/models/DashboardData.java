/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

/**
 *
 * @author Danushka-Madushan
 */
public class DashboardData {

    private final int totalUsers;
    private final int totalBannedUsers;
    private final int totalPosts;

    public DashboardData(int totalUsers, int totalBannedUsers, int totalPosts) {
        this.totalUsers = totalUsers;
        this.totalBannedUsers = totalBannedUsers;
        this.totalPosts = totalPosts;
    }

    public int getTotalUsers() {
        return totalUsers;
    }

    public int getTotalBannedUsers() {
        return totalBannedUsers;
    }

    public int getTotalPosts() {
        return totalPosts;
    }

}
