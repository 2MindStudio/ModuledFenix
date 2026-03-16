DROP  DATABASE IF EXISTS shop;

CREATE DATABASE IF NOT EXISTS shop;

USE shop;

CREATE TABLE Client
(
    Id Int PRIMARY KEY AUTO_INCREMENT,
    Username VARCHAR(25) UNIQUE,
    Password_hash VARCHAR(128),
    Email VARCHAR(50) UNIQUE
);

CREATE TABLE Project
(
    Id Int PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(20),
    Version VARCHAR(20),
    Version_date DATE,
    S3_url VARCHAR(200) UNIQUE
);

CREATE TABLE Develop
(
    Client_id Int NOT NULL,
    Project_id Int NOT NULL,
    PRIMARY KEY(Client_id, Project_id),
    CONSTRAINT fk_Develop_Client
        FOREIGN KEY (Client_id)
            REFERENCES Client(Id)
            ON DELETE RESTRICT
            ON UPDATE CASCADE,
    CONSTRAINT fk_Develop_Project
        FOREIGN KEY (Project_id)
            REFERENCES Project(Id)
            ON DELETE RESTRICT
            ON UPDATE CASCADE
);

CREATE TABLE Application
(
    Id Int PRIMARY KEY AUTO_INCREMENT,
    Title VARCHAR(50) UNIQUE,
    Description VARCHAR(250),
    Published_date DATE,
    Price DECIMAL(6,2),
    Project_id Int NOT NULL,
    CONSTRAINT fk_Application_Project
        FOREIGN KEY (Project_id)
            REFERENCES Project(Id)
            ON DELETE RESTRICT
            ON UPDATE CASCADE
);

CREATE TABLE Genre
(
    Id Int PRIMARY KEY AUTO_INCREMENT,
    Type VARCHAR(30)
);

CREATE TABLE App_genre
(
    Application_id Int NOT NULL,
    Genre_id Int NOT NULL,
    PRIMARY KEY(Application_id,Genre_id),
    CONSTRAINT fk_App_genre_Application
        FOREIGN KEY (Application_id)
            REFERENCES Application(Id)
            ON DELETE RESTRICT
            ON UPDATE CASCADE,
    CONSTRAINT fk_App_genre_Genre
        FOREIGN KEY (Genre_id)
            REFERENCES Genre(Id)
            ON DELETE RESTRICT
            ON UPDATE CASCADE
);

CREATE TABLE Purchase
(
    Id Int PRIMARY KEY AUTO_INCREMENT,
    Client_id Int NOT NULL,
    Payment_date DATE,
    Paid DECIMAL(6,2),
    CONSTRAINT fk_Purchase_Client
        FOREIGN KEY (Client_id)
            REFERENCES Client(Id)
            ON DELETE RESTRICT
            ON UPDATE CASCADE
);

CREATE TABLE Purchase_item
(
    Purchase_id Int NOT NULL,
    Application_id Int NOT NULL,
    PRIMARY KEY(Purchase_id,Application_id),
    CONSTRAINT fk_Purchase_item_Purchase
        FOREIGN KEY (Purchase_id)
            REFERENCES Purchase(Id)
            ON DELETE RESTRICT
            ON UPDATE CASCADE,
    CONSTRAINT fk_Purchase_item_Application
        FOREIGN KEY (Application_id)
            REFERENCES Application(Id)
            ON DELETE RESTRICT
            ON UPDATE CASCADE
);