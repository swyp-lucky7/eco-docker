CREATE DATABASE IF NOT EXISTS eco;
use eco;

-- Users
CREATE TABLE IF NOT EXISTS users
(
    id            BIGINT       NOT NULL AUTO_INCREMENT,
    name          VARCHAR(255) NOT NULL,
    email         VARCHAR(255) NOT NULL,
    picture       VARCHAR(255)                  DEFAULT NULL,
    role          ENUM ('ADMIN','GUEST','USER') DEFAULT NULL,
    created_date  DATETIME(6)                   DEFAULT NULL,
    modified_date DATETIME(6)                   DEFAULT NULL,
    PRIMARY KEY (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;


-- Characters
CREATE TABLE IF NOT EXISTS characters
(
    character_id      BIGINT                        NOT NULL AUTO_INCREMENT,
    name              VARCHAR(255)                  NOT NULL,
    type              ENUM ('ALL','ANIMAL','PLANT') NOT NULL,
    image             LONGTEXT                      NOT NULL,
    descriptions      LONGTEXT    DEFAULT NULL,
    is_possible       BIT(1)                        NOT NULL,
    max_level         INT                           NOT NULL,
    complete_messages LONGTEXT                      NOT NULL,
    created_at        TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at        TIMESTAMP ON UPDATE CURRENT_TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (character_id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;


-- Background
CREATE TABLE IF NOT EXISTS background
(
    background_id BIGINT                 NOT NULL AUTO_INCREMENT,
    name          VARCHAR(255) DEFAULT NULL,
    environment   ENUM ('CLEAN','TRASH') NOT NULL,
    level         INT                    NOT NULL,
    image         LONGTEXT               NOT NULL,
    created_at    DATETIME(6)  DEFAULT NULL,
    updated_at    DATETIME(6)  DEFAULT NULL,
    PRIMARY KEY (background_id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;


-- items
CREATE TABLE IF NOT EXISTS items
(
    item_id     BIGINT       NOT NULL AUTO_INCREMENT,
    name        VARCHAR(255) NOT NULL,
    price       INT          NOT NULL,
    image_url   LONGTEXT     NOT NULL,
    is_use      BIT(1)      DEFAULT NULL,
    level_up    INT          NOT NULL,
    description LONGTEXT    DEFAULT NULL,
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at  TIMESTAMP ON UPDATE CURRENT_TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (item_id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;


-- question
CREATE TABLE IF NOT EXISTS question
(
    question_id   BIGINT                                NOT NULL AUTO_INCREMENT,
    name          VARCHAR(255)                          NOT NULL,
    head          LONGTEXT                              NOT NULL,
    body          LONGTEXT                              NOT NULL,
    answer        VARCHAR(255)                          NOT NULL,
    question_type ENUM ('MULTIPLE_CHOICE','SUBJECTIVE') NOT NULL,
    created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at    TIMESTAMP ON UPDATE CURRENT_TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (question_id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;


-- video
CREATE TABLE IF NOT EXISTS video
(
    video_id   BIGINT       NOT NULL AUTO_INCREMENT,
    name       VARCHAR(255) NOT NULL,
    url        LONGTEXT     NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP ON UPDATE CURRENT_TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (video_id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;


-- user point
CREATE TABLE IF NOT EXISTS user_point
(
    user_point_id BIGINT NOT NULL AUTO_INCREMENT,
    user_id       BIGINT      DEFAULT NULL,
    user_point    INT    NOT NULL,
    updated_at    TIMESTAMP ON UPDATE CURRENT_TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_point_id),
    KEY idx_user_point_user (user_id),
    CONSTRAINT fk_user_point_user FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;


-- character detail
CREATE TABLE IF NOT EXISTS character_detail
(
    character_detail_id BIGINT   NOT NULL AUTO_INCREMENT,
    character_id        BIGINT                 DEFAULT NULL,
    environment         ENUM ('CLEAN','TRASH') DEFAULT NULL,
    level               INT      NOT NULL,
    image_url           LONGTEXT NOT NULL,
    created_at          DATETIME(6)            DEFAULT NULL,
    updated_at          DATETIME(6)            DEFAULT NULL,
    PRIMARY KEY (character_detail_id),
    KEY idx_character_detail_character (character_id),
    CONSTRAINT fk_character_detail_character FOREIGN KEY (character_id) REFERENCES characters (character_id) ON DELETE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;


-- character user
CREATE TABLE IF NOT EXISTS character_user
(
    character_user_id BIGINT NOT NULL AUTO_INCREMENT,
    character_id      BIGINT       DEFAULT NULL,
    user_id           BIGINT       DEFAULT NULL,
    is_use            BIT(1)       DEFAULT NULL,
    name              VARCHAR(255) DEFAULT NULL,
    level             INT    NOT NULL,
    created_at        DATETIME(6)  DEFAULT NULL,
    updated_at        DATETIME(6)  DEFAULT NULL,
    PRIMARY KEY (character_user_id),
    KEY idx_character_user_character (character_id),
    KEY idx_character_user_user (user_id),
    CONSTRAINT fk_character_user_user FOREIGN KEY (user_id) REFERENCES users (id),
    CONSTRAINT fk_character_user_character FOREIGN KEY (character_id) REFERENCES characters (character_id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;


-- content_user_count
CREATE TABLE IF NOT EXISTS content_user_count
(
    content_user_count_id BIGINT NOT NULL AUTO_INCREMENT,
    user_id               BIGINT DEFAULT NULL,
    before_question       BIGINT DEFAULT NULL,
    remain_question_count INT    NOT NULL,
    remain_video_count    INT    NOT NULL,
    reset_at              DATE   DEFAULT NULL,
    PRIMARY KEY (content_user_count_id),
    UNIQUE KEY uk_content_user_count_user (user_id),
    CONSTRAINT fk_content_user_count_user FOREIGN KEY (user_id) REFERENCES users (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;


-- trash_user
CREATE TABLE IF NOT EXISTS trash_user
(
    trash_user_id BIGINT NOT NULL AUTO_INCREMENT,
    user_id       BIGINT      DEFAULT NULL,
    cleaned_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (trash_user_id),
    UNIQUE KEY uk_trash_user_user (user_id),
    CONSTRAINT fk_trash_user_user FOREIGN KEY (user_id) REFERENCES users (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;


-- user_item
CREATE TABLE IF NOT EXISTS user_item
(
    user_item_id BIGINT NOT NULL AUTO_INCREMENT,
    user_id      BIGINT      DEFAULT NULL,
    item_id      BIGINT      DEFAULT NULL,
    is_use       BIT(1) NOT NULL,
    created_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at   TIMESTAMP ON UPDATE CURRENT_TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_item_id),
    KEY idx_user_item_item (item_id),
    KEY idx_user_item_user (user_id),
    CONSTRAINT fk_user_item_user FOREIGN KEY (user_id) REFERENCES users (id),
    CONSTRAINT fk_user_item_item FOREIGN KEY (item_id) REFERENCES items (item_id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;


-- gifticon_user
CREATE TABLE IF NOT EXISTS gifticon_user
(
    gifticon_id       BIGINT NOT NULL AUTO_INCREMENT,
    user_id           BIGINT       DEFAULT NULL,
    character_user_id BIGINT       DEFAULT NULL,
    name              VARCHAR(255) DEFAULT NULL,
    email             VARCHAR(255) DEFAULT NULL,
    is_send           BIT(1)       DEFAULT NULL,
    send_admin_name   VARCHAR(255) DEFAULT NULL,
    image_url         LONGTEXT DEFAULT NULL,
    sent_at           DATETIME(6)  DEFAULT NULL,
    created_at        DATETIME(6)  DEFAULT NULL,
    updated_at        DATETIME(6)  DEFAULT NULL,
    PRIMARY KEY (gifticon_id),
    UNIQUE KEY uk_gifticon_user_character_user (character_user_id),
    KEY idx_gifticon_user_user (user_id),
    CONSTRAINT fk_gifticon_user_character_user FOREIGN KEY (character_user_id) REFERENCES character_user (character_user_id),
    CONSTRAINT fk_gifticon_user_user FOREIGN KEY (user_id) REFERENCES users (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;


-- user_jwts_seq :: 삭제 예정
CREATE TABLE IF NOT EXISTS user_jwts_seq
(
    next_val BIGINT DEFAULT NULL
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;


-- user_jwts :: 삭제 예정
CREATE TABLE IF NOT EXISTS user_jwts
(
    id      BIGINT NOT NULL,
    user_id BIGINT       DEFAULT NULL,
    token   VARCHAR(255) DEFAULT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uk_user_jwts_user (user_id),
    CONSTRAINT fk_user_jwts_user FOREIGN KEY (user_id) REFERENCES users (id)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;
