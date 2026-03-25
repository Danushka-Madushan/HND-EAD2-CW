# Project Documentation: Knowledge Hub (EAD Coursework)

This document provides a comprehensive overview of the Knowledge Hub project, a Jakarta EE-based Q&A platform.

## 1. Project Overview
- **Platform**: Jakarta EE 11
- **Server**: Payara 7 (Community Edition)
- **Build Tool**: Maven 3.x
- **Architecture**: Model-View-Controller (MVC)
- **Database**: MySQL 9.x
- **Frontend**: JSP, JSTL, Tailwind CSS (v4), SweetAlert2

---

## 2. Core Architectures & Technologies

### 2.1 MVC Architecture
The project follows a strict MVC pattern to separate concerns:
- **Model**: Java classes in `models` package act as Data Transfer Objects (DTOs).
- **View**: JSP files located in `webapp` and `WEB-INF/views` or `WEB-INF/admin`.
- **Controller**: Jakarta Servlets in the `controllers` package manage request flow.
- **Service Layer**: EJB Session Beans in the `sessions` package handle business logic and persistence.

### 2.2 Database Connection Pooling
We utilize **Payara 7 Connection Pooling** instead of a custom `DBConnector` class. This approach is more robust and scalable.
- **Configuration**: The database connection pool and JDBC resource (`jdbc/qa_app`) are configured in the Payara Administration Console.
- **Usage**: Connections are injected into EJB Session Beans using the `@Resource` annotation:
  ```java
  @Resource(lookup = "jdbc/qa_app")
  private DataSource dataSource;
  ```
- **Benefit**: Connection management (opening, closing, and reuse) is handled automatically by the application server.

### 2.3 Security (Password Hashing)
Security is a priority, especially for user credentials.
- **Library**: `jBCrypt` (v0.4) is used for secure hashing.
- **Implementation**:
  - **Registration**: Passwords are hashed using `BCrypt.hashpw(password, BCrypt.gensalt(12))` before being stored in the database.
  - **Login**: Verification is done using `BCrypt.checkpw(password, storedHash)`.
- **Benefit**: Even if the database is compromised, the actual passwords remain secure as they are one-way hashed with a unique salt.

### 2.4 Error Handling
Error pages are managed globally via the `web.xml` configuration:
- **404 Not Found**: Redirects to `/error.jsp`.
- **500 Internal Server Error**: Redirects to `/error.jsp`.
This ensures a consistent and user-friendly experience during unexpected failures.

### 2.5 JSTL & Tailwind CSS
- **JSTL**: Used in JSPs for logic-heavy operations (loops, conditionals) without embedding messy Java scriptlets.
- **Tailwind CSS**: Integrated via CDN to provide a modern, responsive, and sleek design with minimal CSS overhead. "Glassmorphism" and vibrant color palettes are used for a premium feel.

---

## 3. Directory and File Breakdown

### 3.1 JSPs (9 Files)
| File | Path | Description |
| :--- | :--- | :--- |
| `index.jsp` | `/WEB-INF/views/` | The main landing page showing recent discussions. |
| `discussions.jsp` | `/WEB-INF/views/` | Detailed view of a single question and its answers. |
| `adminDashboard.jsp` | `/WEB-INF/admin/` | Admin management console for user control and stats. |
| `bannedList.jsp` | `/WEB-INF/admin/` | List of currently banned users for admin review. |
| `login.jsp` | `/` | User login portal. |
| `register.jsp` | `/` | User registration portal. |
| `adminLogin.jsp` | `/` | Admin-specific login portal. |
| `newQuestion.jsp` | `/` | Interface for authenticated users to post new questions. |
| `error.jsp` | `/` | Generic error display page for 404/500 codes. |

### 3.2 Java Models (9 Classes)
| Class | Description | Important Methods |
| :--- | :--- | :--- |
| `UserAuthInfo` | Stores session-level user authentication data. | `getName()`, `getUserId()`, `getAvatarUrl()` |
| `Admin` | Represents an administrative user. | `getId()`, `getUsername()` |
| `Question` | Represents a single discussion topic. | `getTitle()`, `getDescription()`, `getCreatedTimeAgo()` |
| `Answer` | Represents a reply to a question. | `getContent()`, `isAccepted()`, `getOwnerName()` |
| `QuestionWithAnswers`| A composite model for a question and its associated answers. | `getAnswersList()` |
| `DashboardData` | Summarized statistics for the admin dashboard. | `getTotalUsers()`, `getTotalPosts()`, `getTotalBannedUsers()` |
| `DashboardUsers` | Detailed user info for the admin management table. | `getQuestionCount()`, `getAnswerCount()` |
| `ActivityInfo` | Tracks a specific user's contribution (counts). | `getQuestionCount()`, `getAnswerCount()` |
| `Util` | Utility class for common tasks. | `getFileName(Part)`, `getTimeAgo(String)` |

### 3.3 EJB Session Beans (6 Beans)
| Bean | Description | Key Methods |
| :--- | :--- | :--- |
| `UserSessionBean` | Manages user registration, login, and banning. | `verifyLogin()`, `InsertUser()`, `banUserById()` |
| `AdminSessionBean` | Handles admin authentication and dashboard stats. | `verifyAdminLogin()`, `getDashboardData()` |
| `QuestionSessionBean`| Handles all question-related database operations. | `InsertQuestion()`, `getAllQuestions()`, `deleteQuestion()`|
| `AnswerSessionBean` | Manages answers and marking them as accepted. | `InsertAnswer()`, `getAnswersForQuestion()`, `markAccepted()`|
| `ActivitySessionBean`| Fetches activity metrics for specific users. | `getActivityInfo(int userId)` |
| `Scheduler` | A singleton EJB that performs periodic cleanup tasks. | `@Schedule(hour = "0", minute = "0")` for daily maintenance. |

### 3.4 Servlets (16 Controllers)
| Servlet | Description |
| :--- | :--- |
| `home` | Loads all questions and forwards to `index.jsp`. |
| `login` | Validates user credentials and initiates session. |
| `register` | Captures user data, hashes password, and saves to DB. |
| `logout` | Invalidates the user session. |
| `discussion` | Loads a specific question and its answers. |
| `upload` | Handles file uploads for question images. |
| `serve` | Serves uploaded images from the server storage. |
| `postAnswer` | Processes new answers submitted by users. |
| `markAccepted` | Allows the question owner to mark a specific answer as correct. |
| `adminLogin` | Validates admin credentials. |
| `adminDashboard` | Fetches system stats and user lists for management. |
| `adminLogout` | Invalidates the admin session. |
| `banUser` | Adds a user to the banned list. |
| `unbanUser` | Removes a user from the banned list. |
| `deleteUser` | Permanently removes a user and their data. |
| `bannedList` | Displays the list of banned users. |

---

## 4. Process Flows

### 4.1 Login Flow
1. User enters email/password in `login.jsp`.
2. Request hits `login` Servlet (`doPost`).
3. Servlet calls `UserSessionBean.verifyLogin()`.
4. Bean retrieves hash from DB and verifies via `BCrypt`.
5. If success, user info is stored in `HttpSession` and redirected to `home`.

### 4.2 Posting a Question
1. Authenticated user fills form in `newQuestion.jsp`.
2. Form (multi-part for images) is sent to `upload` Servlet.
3. Servlet saves the image and calls `QuestionSessionBean.InsertQuestion()`.
4. User is redirected back to the `home` feed.

### 4.3 Admin User Management
1. Admin logs into the portal.
2. `adminDashboard` Servlet fetches all users via `UserSessionBean.getDashboardUsers()`.
3. Admin clicks "Ban" on a user.
4. `banUser` Servlet is triggered, calls `UserSessionBean.banUserById()`.
5. Page refreshes to show updated status via `SweetAlert2` confirmation.

---
*Documentation generated for EAD (SE) Project Demonstration.*
