/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import jakarta.servlet.http.Part;

/**
 *
 * @author Danushka-Madushan
 */
public class Util {
    public static String getFileName(Part part) {
        for (String content : part.getHeader("content-disposition").split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return "unknown.jpg";
    }

    public static String getTimeAgo(String timestamp) {
        try {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.S");
            LocalDateTime past = LocalDateTime.parse(timestamp, formatter);
            LocalDateTime now = LocalDateTime.now();

            long seconds = ChronoUnit.SECONDS.between(past, now);
            long minutes = ChronoUnit.MINUTES.between(past, now);
            long hours   = ChronoUnit.HOURS.between(past, now);
            long days    = ChronoUnit.DAYS.between(past, now);

            if (seconds < 60)   return seconds + "s ago";
            if (minutes < 60)   return minutes + "m ago";
            if (hours < 24)     return hours + "h ago";
                                return days + " day" + (days > 1 ? "s" : "") + " ago";

        } catch (Exception e) {
            return "unknown";
        }
    }
}
