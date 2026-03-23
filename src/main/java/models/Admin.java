/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

/**
 *
 * @author Danushka-Madushan
 */
public class Admin {
    private final String name;
    private final boolean isAuthenticated;

    public Admin(String name, boolean isAuthenticated) {
        this.name = name;
        this.isAuthenticated = isAuthenticated;
    }

    public String getName() {
        return name;
    }

    public boolean isAuthenticated() {
        return isAuthenticated;
    }
}
