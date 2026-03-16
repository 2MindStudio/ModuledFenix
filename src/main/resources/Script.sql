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
    portray LONGBLOB,
    price DECIMAL(6,2),
    project_id Int NOT NULL,
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
    purchase_date DATE,
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
    price_at_purchase DECIMAL(6,2),
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



INSERT INTO client (username, password_hash, email) VALUES
                                                        ('alice_dev', 'hash123', 'alice@email.com'),
                                                        ('bob_code', 'hash456', 'bob@email.com'),
                                                        ('charlie_prog', 'hash789', 'charlie@email.com'),
                                                        ('david_builder', 'hash111', 'david@email.com'),
                                                        ('eva_coder', 'hash222', 'eva@email.com'),
                                                        ('frank_dev', 'hash333', 'frank@email.com');

INSERT INTO project (name, s3_url) VALUES
                                       ('EngineX', 'https://s3.aws.com/enginex'),
                                       ('PixelCore', 'https://s3.aws.com/pixelcore'),
                                       ('AIHelper', 'https://s3.aws.com/aihelper'),
                                       ('CloudSync', 'https://s3.aws.com/cloudsync'),
                                       ('GameKit', 'https://s3.aws.com/gamekit');

INSERT INTO develop (client_id, project_id) VALUES
                                                (1,1),
                                                (1,2),
                                                (2,2),
                                                (2,4),
                                                (3,3),
                                                (4,1),
                                                (4,5),
                                                (5,3),
                                                (6,4);

INSERT INTO application (title, description, published_date, portray, price, project_id) VALUES
                                                                                             ('Space Adventure', 'Sci-fi exploration game', '2024-06-01', NULL, 19.99, 1),
                                                                                             ('Pixel Racer', 'Retro racing arcade game', '2024-06-15', NULL, 9.99, 2),
                                                                                             ('AI Assistant Pro', 'Smart AI productivity tool', '2024-07-10', NULL, 29.99, 3),
                                                                                             ('Cloud Notes', 'Note taking with cloud sync', '2024-07-12', NULL, 4.99, 4),
                                                                                             ('Dungeon Crawler', 'Classic dungeon RPG', '2024-07-18', NULL, 14.99, 5);

INSERT INTO genre (genre_type) VALUES
                                   ('Action'),
                                   ('Racing'),
                                   ('Productivity'),
                                   ('Sci-Fi'),
                                   ('Adventure'),
                                   ('RPG');

INSERT INTO app_genre (application_id, genre_id) VALUES
                                                     (1,1),
                                                     (1,4),
                                                     (1,5),
                                                     (2,2),
                                                     (2,1),
                                                     (3,3),
                                                     (4,3),
                                                     (5,6),
                                                     (5,5);

INSERT INTO purchase (client_id, purchase_date, paid) VALUES
                                                          (2, '2024-07-20', 19.99),
                                                          (3, '2024-07-21', 39.98),
                                                          (1, '2024-07-22', 9.99),
                                                          (4, '2024-07-23', 24.98),
                                                          (5, '2024-07-24', 29.99),
                                                          (6, '2024-07-25', 34.98);

INSERT INTO purchase_app (purchase_id, application_id, price_at_purchase) VALUES
                                                                              (1,1,19.99),
                                                                              (2,1,19.99),
                                                                              (2,3,19.99),
                                                                              (3,2,9.99),
                                                                              (4,2,9.99),
                                                                              (4,5,14.99),
                                                                              (5,3,29.99),
                                                                              (6,1,19.99),
                                                                              (6,5,14.99);