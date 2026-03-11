DROP  DATABASE IF EXISTS shop;

CREATE DATABASE IF NOT EXISTS shop;

USE shop;

CREATE TABLE wallet
(
    id Int AUTO_INCREMENT PRIMARY KEY,
    currency DECIMAL(10,2) NOT NULL
);

CREATE TABLE client(
                       id Int AUTO_INCREMENT PRIMARY KEY,
                       username VARCHAR(20) NOT NULL,
                       password_hash VARCHAR(20) NOT NULL,
                       wallet_id INT NOT NULL,

                       CONSTRAINT fk_wallet_client
                           FOREIGN KEY (wallet_id)
                               REFERENCES wallet (id)
                               ON DELETE RESTRICT
                               ON UPDATE CASCADE
);

CREATE TABLE player
(
    id Int PRIMARY KEY,
    other_alias VARCHAR(20),
    apps_played Int NOT NULL,

    CONSTRAINT fk_player_client
        FOREIGN KEY (id)
            REFERENCES client(id)
            ON DELETE RESTRICT
            ON UPDATE CASCADE
);

CREATE TABLE developer
(
    id Int PRIMARY KEY,
    brand_name VARCHAR(20) NOT NULL,
    apps_published Int NOT NULL,

    CONSTRAINT fk_developer_client
        FOREIGN KEY (id)
            REFERENCES client(id)
            ON DELETE RESTRICT
            ON UPDATE CASCADE
);

CREATE TABLE creditCard
(
    number VARCHAR(16) PRIMARY KEY,
    cvc Int NOT NULL,
    expired_date Date NOT NULL
);

CREATE TABLE contain
(
    wallet_id Int NOT NULL,
    card_number VARCHAR(16) NOT NULL,

    PRIMARY KEY(wallet_id, card_number),

    CONSTRAINT fk_contain_wallet
        FOREIGN KEY (wallet_id)
            REFERENCES wallet (id)
            ON DELETE RESTRICT
            ON UPDATE CASCADE,

    CONSTRAINT fk_contain_creditCard
        FOREIGN KEY (card_number)
            REFERENCES creditCard(number)
            ON DELETE RESTRICT
            ON UPDATE CASCADE
);

CREATE TABLE project(
                        id Int AUTO_INCREMENT PRIMARY KEY,
                        dev_id Int,
                        title VARCHAR(20),
                        description VARCHAR(100),
                        portray longblob,

                        CONSTRAINT fk_project_developer
                            FOREIGN KEY (dev_id)
                                REFERENCES developer (id)
                                ON DELETE RESTRICT
                                ON UPDATE CASCADE
);

CREATE TABLE genre(
                      id_genero Int AUTO_INCREMENT PRIMARY KEY,
                      name VARCHAR(30) NOT NULL
);

CREATE TABLE projectGenre(
                             dev_id Int NOT NULL,
                             id_genero Int NOT NULL,

                             PRIMARY KEY(dev_id, id_genero),

                             CONSTRAINT fk_projectGenre_project
                                 FOREIGN KEY (dev_id)
                                     REFERENCES project(dev_id)
                                     ON DELETE RESTRICT
                                     ON UPDATE CASCADE,

                             CONSTRAINT fk_projectGenre_genre
                                 FOREIGN KEY (id_genero)
                                     REFERENCES genre(id_genero)
                                     ON DELETE RESTRICT
                                     ON UPDATE CASCADE
);

CREATE TABLE application(
                            dev_id Int PRIMARY KEY,
                            launched_date DATE,
                            receipt_id INT,

                            CONSTRAINT fk_application_project
                                FOREIGN KEY (dev_id)
                                    REFERENCES project(dev_id)
                                    ON DELETE RESTRICT
                                    ON UPDATE CASCADE
);

CREATE TABLE run(
                    client_id Int NOT NULL,
                    dev_id Int NOT NULL,
                    counter_hours Int,

                    PRIMARY KEY(client_id, dev_id),

                    CONSTRAINT fk_run_client
                        FOREIGN KEY (client_id)
                            REFERENCES client(id)
                            ON DELETE RESTRICT
                            ON UPDATE CASCADE,

                    CONSTRAINT fk_run_application
                        FOREIGN KEY (dev_id)
                            REFERENCES application(dev_id)
                            ON DELETE RESTRICT
                            ON UPDATE CASCADE
);

CREATE TABLE receipt(
                        id Int AUTO_INCREMENT PRIMARY KEY,
                        price DECIMAL(10,2) NOT NULL,
                        dev_id Int NOT NULL,

                        CONSTRAINT fk_receipt_application
                            FOREIGN KEY (dev_id)
                                REFERENCES application(dev_id)
                                ON DELETE RESTRICT
                                ON UPDATE CASCADE
);

CREATE TABLE pay(
                    receipt_id Int NOT NULL,
                    wallet_id Int NOT NULL,
                    client_id Int NOT NULL,
                    pay_date DATE NOT NULL,

                    PRIMARY KEY(receipt_id, wallet_id),

                    CONSTRAINT fk_pay_receipt
                        FOREIGN KEY (receipt_id)
                            REFERENCES receipt(id)
                            ON DELETE RESTRICT
                            ON UPDATE CASCADE,

                    CONSTRAINT fk_pay_wallet
                        FOREIGN KEY (wallet_id)
                            REFERENCES wallet (id)
                            ON DELETE RESTRICT
                            ON UPDATE CASCADE,

                    CONSTRAINT fk_pay_client
                        FOREIGN KEY (client_id)
                            REFERENCES client(id)
                            ON DELETE RESTRICT
                            ON UPDATE CASCADE
);