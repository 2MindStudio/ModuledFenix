DROP  DATABASE IF EXISTS shop;

CREATE DATABASE IF NOT EXISTS shop;

USE shop;

CREATE TABLE client
(
    id Int PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(25) UNIQUE,
    password_hash VARCHAR(128),
    email VARCHAR(50) UNIQUE
);

CREATE TABLE project
(
    id Int PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(20),
    version VARCHAR(20),
    version_date DATE,
    s3_url VARCHAR(200) UNIQUE
);

CREATE TABLE develop
(
    client_id Int NOT NULL,
    project_id Int NOT NULL,
    PRIMARY KEY(client_id, project_id),
    CONSTRAINT fk_develop_client
        FOREIGN KEY (client_id)
            REFERENCES client(id)
            ON DELETE RESTRICT
            ON UPDATE CASCADE,
    CONSTRAINT fk_develop_project
        FOREIGN KEY (project_id)
            REFERENCES project(id)
            ON DELETE RESTRICT
            ON UPDATE CASCADE
);

CREATE TABLE application
(
    id Int PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(50) UNIQUE,
    description VARCHAR(250),
    published_date DATE,
    price DECIMAL(6,2),
    project_id Int UNIQUE,
    CONSTRAINT fk_application_project
        FOREIGN KEY (project_id)
            REFERENCES project(id)
            ON DELETE RESTRICT
            ON UPDATE CASCADE
);

CREATE TABLE genre
(
    id Int PRIMARY KEY AUTO_INCREMENT,
    genre_type VARCHAR(30)
);

CREATE TABLE app_genre
(
    application_id Int NOT NULL,
    genre_id Int NOT NULL,
    PRIMARY KEY(application_id,genre_id),
    CONSTRAINT fk_app_genre_application
        FOREIGN KEY (application_id)
            REFERENCES application(id)
            ON DELETE RESTRICT
            ON UPDATE CASCADE,
    CONSTRAINT fk_app_genre_genre
        FOREIGN KEY (genre_id)
            REFERENCES genre(id)
            ON DELETE RESTRICT
            ON UPDATE CASCADE
);

CREATE TABLE purchase
(
    id Int PRIMARY KEY AUTO_INCREMENT,
    client_id Int NOT NULL,
    payment_date DATE,
    paid DECIMAL(6,2),
    CONSTRAINT fk_purchase_client
        FOREIGN KEY (client_id)
            REFERENCES client(id)
            ON DELETE RESTRICT
            ON UPDATE CASCADE
);

CREATE TABLE purchase_app
(
    purchase_id Int NOT NULL,
    application_id Int NOT NULL,
    PRIMARY KEY(purchase_id,application_id),
    CONSTRAINT fk_purchase_app_purchase
        FOREIGN KEY (purchase_id)
            REFERENCES purchase(id)
            ON DELETE RESTRICT
            ON UPDATE CASCADE,
    CONSTRAINT fk_purchase_app_application
        FOREIGN KEY (application_id)
            REFERENCES application(id)
            ON DELETE RESTRICT
            ON UPDATE CASCADE
);