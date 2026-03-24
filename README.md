# QA Platform: Project Setup Guide

This project is a Jakarta EE-based Question & Answer platform designed to demonstrate robust backend concepts like **EJB Timer Services**, **Connection Pooling**, and **Session Management**.

## Tools

  * **IDE:** NetBeans
  * **Server:** Payara 7 (Jakarta EE 10 compatible)
  * **Database:** MySQL (via XAMPP)
  * **Frontend:** JSP & JSTL (Tailwind CSS for styling)
  * **Backend:** EJB (Stateless/Singleton Session Beans)

-----

## 1\. Database Configuration (XAMPP)

1.  Open **XAMPP Control Panel** and start **MySQL**.
2.  Go to `localhost/phpmyadmin`.
3.  Create a new database named: `qa_app`.
4.  Import the provided `.sql` file to generate the tables (`users`, `questions`, `answers`, `admins`, `banned_users`).

-----

## 2\. Server Configuration (Payara 7)

Since this project uses **Connection Pooling**, you must set up the JDBC resource in the Payara Admin Console before deploying.

1.  Start your **Payara 7** server.
2.  Open the Admin Console (usually `http://localhost:4848`).
3.  **Create a Connection Pool:**
      * Resources \> JDBC \> JDBC Connection Pools \> **New**.
      * Name: `QAAppPool`.
      * Resource Type: `javax.sql.DataSource`.
      * Database Driver: `com.mysql.cj.jdbc.MysqlDataSource`.
      * Under **Additional Properties**, add: `user`, `password`, `url` (`jdbd:mysql://localhost:3306/qa_app`).
4.  **Create a JDBC Resource:**
      * Resources \> JDBC \> JDBC Resources \> **New**.
      * JNDI Name: `jdbc/qa_app` (Ensure this matches the `@Resource` name in your Session Beans).
      * Pool Name: Select `QAAppPool`.

-----

## 3\. Deploying in NetBeans

1.  Open the project in **NetBeans IDE**.
2.  Right-click the project and select **Clean and Build**.
3.  Right-click the project and select **Run**.
4.  NetBeans will automatically package the `.war` file and deploy it to Payara.

-----

## Access & Credentials

| Role | Access URL | Credentials |
| :--- | :--- | :--- |
| **Client/User** | `http://localhost:8080/HND-EAD2-CW/` | Register a new account |
| **Admin** | `http://localhost:8080/HND-EAD2-CW/adminLogin.jsp` | **Email:** `super@admin.com` <br> **Pass:** `Admin@1234` |

-----

## Key Features

  * **Ask & Answer:** Users can post technical questions with image support and receive community answers.
  * **Admin Dashboard:** Separate entry point for administrators to monitor content, delete offensive users, or ban users.
  * **Security:** Implements Session Fixation protection by invalidating sessions on login and custom Auth Filters for protected routes.
  * **Scheduled Tasks:** Uses EJB `@Singleton` and `@Schedule` to handle periodic database maintenance (like clearing expired bans).
  * **Error Handling:** Custom `404` and `500` error pages ensure a professional user experience even when things go wrong.

-----

## Troubleshooting

  * **404 Not Found:** Check your context path. If you renamed the project folder, the URL might be `localhost:8080/YourNewName/`.
  * **Database Link Error:** Ensure the MySQL Connector (JAR) is added to the Payara `lib` folder or bundled within the project libraries.

-----

## Screenshots

### User Register
![User Register](https://raw.githubusercontent.com/Danushka-Madushan/HND-EAD2-CW/refs/heads/main/screens/client_register.png)

### User Login
![User Login](https://raw.githubusercontent.com/Danushka-Madushan/HND-EAD2-CW/refs/heads/main/screens/client_login.png)

### Home
![Home](https://raw.githubusercontent.com/Danushka-Madushan/HND-EAD2-CW/refs/heads/main/screens/client_home.png)

### Post Question
![Post Question](https://raw.githubusercontent.com/Danushka-Madushan/HND-EAD2-CW/refs/heads/main/screens/client_post_question.png)

### Home (with Questions)
![Home (with Questions)](https://raw.githubusercontent.com/Danushka-Madushan/HND-EAD2-CW/refs/heads/main/screens/client_questions_home.png)

### Question Page
![Question Page](https://raw.githubusercontent.com/Danushka-Madushan/HND-EAD2-CW/refs/heads/main/screens/client_discussions.png)

### Admin Login
![Admin Login](https://raw.githubusercontent.com/Danushka-Madushan/HND-EAD2-CW/refs/heads/main/screens/admin_login.png)

### Admin Dashboard
![Admin Dashboard](https://raw.githubusercontent.com/Danushka-Madushan/HND-EAD2-CW/refs/heads/main/screens/admin_dashboaord.png)

### Admin Banned List
![Admin Banned List](https://raw.githubusercontent.com/Danushka-Madushan/HND-EAD2-CW/refs/heads/main/screens/admin_banned_list.png)
