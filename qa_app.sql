-- ============================================================
--  Q&A Application — MySQL Setup Script
--  Run this file once to initialize your database.
-- ============================================================

CREATE DATABASE IF NOT EXISTS qa_app
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE qa_app;

-- ------------------------------------------------------------
-- 1. Table: users 
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS users (
    id              INT UNSIGNED    NOT NULL AUTO_INCREMENT,
    name            VARCHAR(150)    NOT NULL,
    email           VARCHAR(255)    NOT NULL UNIQUE,
    password_hash   VARCHAR(255)    NOT NULL,          -- store bcrypt/argon2 hash, never plaintext
    profile_pic_url TEXT            DEFAULT NULL,
    created_at      TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------
-- 2. Table: admins
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS admins (
    id            INT UNSIGNED    NOT NULL AUTO_INCREMENT,
    name          VARCHAR(150)    NOT NULL,
    email         VARCHAR(255)    NOT NULL UNIQUE,
    password_hash VARCHAR(255)    NOT NULL,            -- store bcrypt/argon2 hash, never plaintext
    PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------
-- 3. Table: questions
--    image_url is NULL  →  text-only question
--    image_url has value →  image-based question
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS questions (
    id            INT UNSIGNED    NOT NULL AUTO_INCREMENT,
    user_id       INT UNSIGNED    NOT NULL,
    title         VARCHAR(255)    NOT NULL,
    description   TEXT            NOT NULL,
    image_url     TEXT            DEFAULT NULL,
    created_at    TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    CONSTRAINT fk_questions_user
        FOREIGN KEY (user_id) REFERENCES users (id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------
-- 4. Table: answers
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS answers (
    id            INT UNSIGNED    NOT NULL AUTO_INCREMENT,
    question_id   INT UNSIGNED    NOT NULL,
    user_id       INT UNSIGNED    NOT NULL,
    content       TEXT            NOT NULL,
    created_at    TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    CONSTRAINT fk_answers_question
        FOREIGN KEY (question_id) REFERENCES questions (id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_answers_user
        FOREIGN KEY (user_id) REFERENCES users (id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ------------------------------------------------------------
-- 5. Default admin user
--    ⚠  Change the name below before going to production.
-- ------------------------------------------------------------
-- ⚠  Replace the email and hash with real values before going to production.
--    The hash below is a bcrypt hash of the placeholder password: "Admin@1234"
INSERT INTO admins (name, email, password_hash)
SELECT 'Super Admin', 'admin@example.com', '$2b$12$ePCE7lJsVbMBQYEMCFVlJuPBaXKiEKVDwq0MuQRK3R5nS6BpFqzGy'
WHERE NOT EXISTS (
    SELECT 1 FROM admins WHERE email = 'admin@example.com'
);

-- ============================================================
--  Done! Tables created and default admin seeded.
-- ============================================================
