# Comprehensive Project Documentation: Knowledge Hub (EAD Coursework)

This document provides a full, comprehensive, and in-depth explanation of the entire Knowledge Hub platform. It is designed to evaluate and demonstrate the Software Engineering (SE) and Enterprise Application Development (EAD) aspects for the final project demonstration.

## Table of Contents
1. [Core Architectures & Technologies](#1-core-architectures--technologies)
2. [Project Infrastructure & Configuration](#2-project-infrastructure--configuration)
3. [Comprehensive File & Method Breakdown](#3-comprehensive-file--method-breakdown)
    - [3.1 JSP Files (Views)](#31-jsp-files-views-9-files)
    - [3.2 Java Models](#32-java-models-9-classes)
    - [3.3 EJB Session Beans](#33-ejb-session-beans-6-beans)
    - [3.4 Servlets (Controllers)](#34-servlets-controllers-16-controllers)
4. [Process Flows](#4-process-flows)

---

## 1. Core Architectures & Technologies

### 1.1 Strict MVC Architecture
The system heavily adheres to the **Model-View-Controller (MVC)** design pattern to cleanly separate application concerns:
- **Model**: Located within the `models` package, these encapsulated Java classes (POJOs/DTOs) represent application data and state.
- **View**: Implemented via **JSP (JavaServer Pages)**. They exclusively handle UI rendering.
- **Controller**: Handled by **Jakarta Servlets** (`controllers` package). They intercept HTTP requests, invoke the necessary business logic, assign data to request/session attributes, and forward the request to the appropriate View.

### 1.2 Maven Build System (Replacing Ant)
We chose **Maven 3.x** over Apache Ant. Maven simplifies the build process through convention-over-configuration and provides robust dependency management (`pom.xml`). Instead of manually managing JAR files (like jBCrypt or MySQL Connector) or writing verbose build steps as required by Ant, Maven automatically resolves and downloads transitive dependencies, ensuring a uniform build pipeline.

### 1.3 Usage of JSTL
The **JSTL (JSP Standard Tag Library)** is employed to handle logic within the view layer. By using core tags such as `<c:forEach>` for iterating over lists (like questions or answers) and `<c:if>` for conditional rendering (like showing "Delete" buttons only to admins), we entirely eliminate messy embedded Java scriptlets (`<% ... %>`). This enforces the separation of logic and presentation.

### 1.4 Tailwind CSS for Rapid UI Development
**Tailwind CSS (v4)** is integrated directly via CDN. Using a utility-first CSS framework drastically reduces the workload required to build a responsive, modern interface. We utilized it to implement complex aesthetic features like "Glassmorphism", flexbox layouts, and vibrant UI components directly within the DOM, without the overhead of maintaining massive, custom CSS files.

---

## 2. Project Infrastructure & Configuration

### 2.1 Database Connection Pooling (Payara 7)
Unlike smaller applications that use a custom `DBConnector` class to establish database connections manually, this enterprise application utilizes **Payara 7 Connection Pooling**. 
- **How it works**: The Payara server maintains a warm "pool" of open MySQL database connections. 
- **Implementation**: The pool is configured in the Payara Administration Console under the JNDI name `jdbc/qa_app`. Within the application, these connections are dynamically injected into the EJB Session beans via the `@Resource(lookup = "jdbc/qa_app")` annotation.
- **Why it matters**: It drastically improves application scalability and performance by removing the latency of opening a new TCP database connection for every individual user query. Resource lifecycle management (closing/returning connections) is handled safely by the server natively.

### 2.2 Security: Password Hashing
To secure the database against breaches, plaintext passwords are never stored.
- **Library**: We use `jBCrypt`. 
- **Implementation**: When a user registers, their password undergoes a one-way hash: `BCrypt.hashpw(password, BCrypt.gensalt(12))`. Wait-time is algorithmically expanded (using a salt factor of 12) to thwart brute-force and dictionary attacks. During login, `BCrypt.checkpw()` validates the input against the stored hash safely.

### 2.3 Error Handling in `web.xml`
Global application error states are caught and handled gracefully routing through the deployment descriptor (`web.xml`).
- Instead of showing users a dangerous or confusing Tomcat/Payara stack trace, `<error-page>` tags map HTTP `404` (Not Found) and HTTP `500` (Internal Server Error) to a stylized `error.jsp` page. This protects application structural integrity and improves user experience.

---

## 3. Comprehensive File & Method Breakdown

### 3.1 JSP Files (Views - 9 Files)
All views are appropriately secured. Direct access to internal views is blocked by placing them inside the `WEB-INF` directory.
1. `index.jsp` (`/WEB-INF/views/`): The primary home feed. Uses JSTL to iterate through active questions and displays a dashboard summary for logged-in users.
2. `discussions.jsp` (`/WEB-INF/views/`): A detailed breakdown page for a specific question. It renders the question body, user information, and a loop of associated answers. Shows the "Mark as Accepted" button dynamically if the logged-in user is the question owner.
3. `adminDashboard.jsp` (`/WEB-INF/admin/`): The core management view for admins. Displays total platform metrics and lists all active users with the ability to trigger a ban.
4. `bannedList.jsp` (`/WEB-INF/admin/`): A dedicated table view specifically for reviewing users currently in the `BANNED` state, providing options to revoke the ban.
5. `login.jsp` (`/`): The public authentication portal for standard users. Includes form validation and session triggers.
6. `register.jsp` (`/`): The user onboarding form gathering email, username, and password securely.
7. `adminLogin.jsp` (`/`): A heavily isolated login portal mapped strictly to Admin credentials, separating standard user auth from admin auth.
8. `newQuestion.jsp` (`/`): A form interface accessible only to verified sessions, allowing `multipart/form-data` uploads to include images in questions.
9. `error.jsp` (`/`): The designated fallback page tied to the `web.xml` error triggers, displaying a structured "Something went wrong" message.

### 3.2 Java Models (9 Classes)
These POJOs act as data carriers between the Database (via EJBs) and the View (via Servlets).
1. `UserAuthInfo`:
    - `getUserId()`, `getName()`, `getEmail()`: Fetch base user details.
    - `getAvatarUrl()`: Retrieves the user's profile image to render globally in the navbar.
2. `Admin`:
    - `getId()`, `getUsername()`, `getPasswordHash()`: Basic admin mapping properties.
3. `Question`:
    - `getId()`, `getTitle()`, `getDescription()`, `getImageUrl()`: Core metadata for the post.
    - `getCreatedTimeAgo()`: Utilizes a time-formatter to display "2 hours ago" instead of raw timestamps.
    - `getOwnerName()`: Maps the foreign key user ID back to a human-readable author name.
4. `Answer`:
    - `getId()`, `getContent()`, `getQuestionId()`: Post mapping attributes.
    - `isAccepted()`: A boolean flag indicating if the original author marked this as the correct solution.
    - `getOwnerName()`: The author of the reply.
5. `QuestionWithAnswers`:
    - `getQuestion()`: Returns the parent `Question` object.
    - `getAnswersList()`: Returns a `List<Answer>` associated strictly with this question. Used by `discussion.jsp`.
6. `DashboardData`:
    - `getTotalUsers()`, `getTotalPosts()`, `getTotalBannedUsers()`: Aggregation counts required to populate the admin statistical cards at the top of the admin dashboard.
7. `DashboardUsers`:
    - `getUserId()`, `getUsername()`, `getStatus()`: Identifies the user within the management table.
    - `getQuestionCount()`, `getAnswerCount()`: Shows admin how active a particular user is before taking moderation actions.
8. `ActivityInfo`:
    - `getQuestionCount()`, `getAnswerCount()`, `getAcceptedAnswersCount()`: Used to display a standard user's personal activity metrics on their profile/home sidebar.
9. `Util`:
    - `getFileName(Part part)`: Parses the HTTP Header to extract an uploaded file's original name.
    - `getTimeAgo(Timestamp ts)`: A critical logic method converting standard SQL Dates into relative human time (e.g., "Just now", "5 mins ago").

### 3.3 EJB Session Beans (6 Beans)
Annotated primarily with `@Stateless`, these Enterprise Beans handle business logic and JDBC database operations.
1. `UserSessionBean`:
    - `verifyLogin(String email, String password)`: Retrieves the hashed password from the DB and queries against `BCrypt.checkpw()`. Returns a `UserAuthInfo` object.
    - `InsertUser(User model)`: Hashes a newly registered password using `BCrypt` and executes the SQL `INSERT`.
    - `banUserById(int id)`: Executed by an admin to update a user's status flag in the DB to `BANNED`.
2. `AdminSessionBean`:
    - `verifyAdminLogin(...)`: Specialized authentication against the admin credential table.
    - `getDashboardData()`: Executes multiple `COUNT(*)` SQL aggregation queries, bundling the result into a `DashboardData` model.
3. `QuestionSessionBean`:
    - `InsertQuestion(...)`: Pushes a new question into the DB.
    - `getAllQuestions()`: Returns a `List<Question>` ordered by timestamp descending, feeding the main index feed.
    - `deleteQuestion(int id)`: Erases a question and cascades deletion for its answers.
4. `AnswerSessionBean`:
    - `InsertAnswer(...)`: Adds a reply to the db linked via `question_id`.
    - `getAnswersForQuestion(int qId)`: Queries all answers where the foreign key matches the active question.
    - `markAccepted(int answerId, int questionId)`: Executes an SQL transactional `UPDATE` to first strip accepted status from all other answers on the question, and applies it purely to the selected one.
5. `ActivitySessionBean`:
    - `getActivityInfo(int userId)`: Runs user-specific aggregate queries to build their personal `ActivityInfo` scorecard.
6. `Scheduler` (Annotated `@Singleton` & `@Startup`):
    - Background task bean using `@Schedule(hour = "0", minute = "0")`. This automated Cron task executes daily to clean up orphaned database records or expired HTTP sessions, showcasing advanced Jakarta EE backgrounds jobs.

### 3.4 Servlets (16 Controllers)
The routing layer. Each Servlet manages the Request/Response lifecycle.
1. `home`: Checks for a valid `HttpSession`. Calls `QuestionSessionBean` to fetch the feed, binds it to the request, and forwards to `index.jsp`.
2. `login`: Handles `POST` requests from the login form. Validates input. On success, creates `HttpSession`, sets `userAuth`, and triggers a redirect to `/home`.
3. `register`: Accepts basic signup values. Forwards parameters to `UserSessionBean.InsertUser()`. Redirects to `/login` upon success.
4. `logout`: Invokes `request.getSession().invalidate()`. Ends the auth session and redirects home.
5. `discussion`: Extracts the `?id=` parameter. Fetches a `QuestionWithAnswers` bundle from the EJB and forwards to `discussions.jsp`.
6. `upload`: Uses `@MultipartConfig`. Processes image uploads, saves them locally to the server's drive, and triggers question creation in the DB.
7. `serve`: A specialized `GET` controller that reads images from the local file system using a stream and writes them directly to the `HttpServletResponse` output to display uploaded files securely.
8. `postAnswer`: Extracts `content` and `question_id`, calls EJB to insert, and issues a redirect back to the `discussion` servlet.
9. `markAccepted`: Protected route. Verifies the user owns the question, then flags a specific answer as the correct solution.
10. `adminLogin`: Validates the admin portal credentials and establishes an `admin_session`.
11. `adminDashboard`: Rejects non-admin sessions. Fetches `DashboardData` and `List<DashboardUsers>` then forwards to `adminDashboard.jsp`.
12. `adminLogout`: Destroys the admin session token.
13. `banUser`: An admin action that triggers `UserSessionBean.banUserById()`.
14. `unbanUser`: Admin action that restores access for a previously banned user.
15. `deleteUser`: Admin action that initiates a complete cascading hard-delete of a user and all their questions/answers from the system.
16. `bannedList`: Fetches only users with a `BANNED` status for the secondary admin review view.

---

## 4. Process Flows

### 4.1 Global Login & Session Flow
1. User navigates to `/login.jsp` and submits their Email & Password.
2. The `login` Servlet captures the `doPost` data.
3. The Servlet invokes `UserSessionBean.verifyLogin()`.
4. The DB pool provides a connection. The server retrieves the hashed password string. `jBCrypt` verifies the plaintext against the hash.
5. If true, a `UserAuthInfo` object is placed into the `HttpSession` scope. The user is redirected to `/home`. All secured JSPs verify this `sessionScope.userAuth` object to render appropriately (e.g., hiding login buttons, showing user avatars).

### 4.2 Posting a Target Question (With Multipart Uploads)
1. An authenticated user accesses `/newQuestion.jsp`.
2. User submits text data and attaches an image file. The form `enctype` is set to `multipart/form-data`.
3. The `upload` Servlet intercepts the request. It extracts `Part` file data using the `Util.getFileName()` model method.
4. The image is saved to a secure physical directory on the server.
5. The `QuestionSessionBean.InsertQuestion()` is queued with the generated Image Path String and textual data. The Database handles the `INSERT`.
6. The user is redirected back to the `index` where the new post is dynamically visible.

### 4.3 Administrator Moderation & Banning Flow
1. An admin logs in via `/adminLogin.jsp`. The `adminLogin` Servlet validates the payload against the admin database table.
2. An `admin` attribute is attached purely to the session.
3. Accessing the dashboard triggers the `adminDashboard` Servlet. This servlet interrogates the EJB layer for `DashboardUsers` mapping.
4. The admin clicks the red "Ban" button on a malicious user. This triggers a `POST` request to the `banUser` Servlet.
5. `banUser` triggers the `UserSessionBean.banUserById(int)` method, updating the SQL `status` column to `'BANNED'`.
6. Immediate subsequent requests from the banned user's token will hit conditional checks in internal servlets, effectively invalidating their application access until unbanned.

---
**End of Project Documentation.**  
