DROP DATABASE IF EXISTS shop;

CREATE DATABASE IF NOT EXISTS shop;

USE shop;

CREATE TABLE client
(
    id Int PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(50),
    password_hashed VARCHAR(128),
    username VARCHAR(25) UNIQUE,
    nickname VARCHAR(25) UNIQUE,
    email_verificado BOOLEAN,
    fecha_verificado DATE,
    intentos_login Int,
    ultimo_intento_login DATETIME,
    bloqueado_hasta DATETIME,
    path_profile_picture_s3 VARCHAR(512),
    bio VARCHAR(250),
    fecha_creacion DATE
);

CREATE TABLE tag
(
    id Int PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(30),
    description VARCHAR(250)
);

CREATE TABLE game
(
    id Int PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(50) UNIQUE,
    dev_id Int,
    description VARCHAR(250),
    published_date DATE,
    s3_path_generic VARCHAR(512) UNIQUE,
    tamano_mb DECIMAL(10,2),
    downloads Int,
    price DECIMAL(6,2),
    CONSTRAINT fk_game_client
        FOREIGN KEY (dev_id)
            REFERENCES client(id)
            ON DELETE RESTRICT
            ON UPDATE CASCADE
);

CREATE TABLE game_tag
(
    game_id Int NOT NULL,
    tag_id Int NOT NULL,
    PRIMARY KEY(game_id, tag_id),
    CONSTRAINT fk_game_tag_game
        FOREIGN KEY (game_id)
            REFERENCES game(id)
            ON DELETE RESTRICT
            ON UPDATE CASCADE,
    CONSTRAINT fk_game_tag_tag
        FOREIGN KEY (tag_id)
            REFERENCES tag(id)
            ON DELETE RESTRICT
            ON UPDATE CASCADE
);

CREATE TABLE purchase
(
    id Int PRIMARY KEY AUTO_INCREMENT,
    payment_date DATE,
    client_id Int NOT NULL,
    game_id Int NOT NULL,
    CONSTRAINT fk_purchase_client
        FOREIGN KEY (client_id)
            REFERENCES client(id)
            ON DELETE RESTRICT
            ON UPDATE CASCADE,
    CONSTRAINT fk_purchase_game
        FOREIGN KEY (game_id)
            REFERENCES game(id)
            ON DELETE RESTRICT
            ON UPDATE CASCADE
);

CREATE TABLE wishlist
(
    id Int PRIMARY KEY AUTO_INCREMENT,
    client_id Int NOT NULL,
    game_id Int NOT NULL,
    added_at DATE,
    CONSTRAINT fk_wishlist_client
        FOREIGN KEY (client_id)
            REFERENCES client(id)
            ON DELETE RESTRICT
            ON UPDATE CASCADE,
    CONSTRAINT fk_wishlist_game
        FOREIGN KEY (game_id)
            REFERENCES game(id)
            ON DELETE RESTRICT
            ON UPDATE CASCADE
);

CREATE TABLE teaser
(
    id Int AUTO_INCREMENT,
    game_id Int NOT NULL,
    file_name VARCHAR(255),
    type VARCHAR(50),
    PRIMARY KEY(id, game_id),
    CONSTRAINT fk_teaser_game
        FOREIGN KEY (game_id)
            REFERENCES game(id)
            ON DELETE RESTRICT
            ON UPDATE CASCADE
);