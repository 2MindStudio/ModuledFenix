drop database if exists shop;

create database if not exists shop;

use shop;

create table wallet
(
	id Int auto_increment PRIMARY KEY,
	currency DECIMAL(10,2) not null
);

create table client(
	id Int auto_increment PRIMARY KEY,
	username VARCHAR(20) NOT NULL,
	password_hash VARCHAR(20) NOT NULL,
	wallet_id INT NOT NULL,

	CONSTRAINT fk_wallet_client
	FOREIGN KEY (wallet_id)
	REFERENCES wallet (id)
	ON DELETE RESTRICT
	ON UPDATE CASCADE
);

create table player
(
	id Int primary key,
	other_alias VARCHAR(20),
	apps_played Int not null,

	CONSTRAINT fk_player_client
	FOREIGN KEY (id)
	REFERENCES client(id)
	ON DELETE RESTRICT
	ON UPDATE CASCADE
);

create table developer
(
	id Int primary key,
	brand_name VARCHAR(20) not null,
	apps_published Int not null,

	CONSTRAINT fk_developer_client
	FOREIGN KEY (id)
	REFERENCES client(id)
	ON DELETE RESTRICT
	ON UPDATE CASCADE
);

create table creditCard
(
	number VARCHAR(16) primary key,
	cvc Int not null,
	expired_date Date not null
);

create table contain
(
	wallet_id Int not null,
	card_number VARCHAR(16) not null,

	primary key(wallet_id, card_number),

	CONSTRAINT fk_contain_wallet
	FOREIGN KEY (wallet_id)
	REFERENCES wallet (id)
	ON DELETE RESTRICT
	ON UPDATE CASCADE,

	CONSTRAINT fk_contain_creditCard
	FOREIGN KEY (card_number)
	REFERENCES creditCard (number)
	ON DELETE RESTRICT
	ON UPDATE CASCADE
);

create table project(
	id Int auto_increment primary key,
	dev_id Int,
	title VARCHAR(20) not null,
	description VARCHAR(100),
	portray longblob,

	CONSTRAINT fk_project_developer
	FOREIGN KEY (dev_id)
	REFERENCES developer (id)
	ON DELETE RESTRICT
	ON UPDATE CASCADE
);

create table genre(
	id_genero Int auto_increment primary key,
	name VARCHAR(30) not null
);

create table projectGenre(
	dev_id Int not null,
	id_genero Int not null,

	primary key(dev_id, id_genero),

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

create table application(
	dev_id Int primary key,
	launched_date DATE,
	receipt_id INT,

	CONSTRAINT fk_application_project
	FOREIGN KEY (dev_id)
	REFERENCES project(dev_id)
	ON DELETE restrict
	ON UPDATE cascade
);

create table run(
	client_id Int not null,
	dev_id Int not null,
	counter_hours Int,

	primary key(client_id, dev_id),

	CONSTRAINT fk_run_client
	FOREIGN KEY (client_id)
	REFERENCES client(id)
	ON DELETE restrict
	ON UPDATE cascade,

	CONSTRAINT fk_run_application
	FOREIGN KEY (dev_id)
	REFERENCES application(dev_id)
	ON DELETE RESTRICT
	ON UPDATE CASCADE
);

create table receipt(
	id Int auto_increment primary key,
	price DECIMAL(10,2) not null,
	dev_id Int not null,

	CONSTRAINT fk_receipt_application
	FOREIGN KEY (dev_id)
	REFERENCES application(dev_id)
	ON DELETE restrict
	ON UPDATE cascade
);

create table pay(
	receipt_id Int not null,
	wallet_id Int not null,
	client_id Int not null,
	pay_date DATE not null,

	primary key(receipt_id, wallet_id),

	CONSTRAINT fk_pay_receipt
	FOREIGN KEY (receipt_id)
	REFERENCES receipt(id)
	ON DELETE restrict
	ON UPDATE cascade,

	CONSTRAINT fk_pay_wallet
	FOREIGN KEY (wallet_id)
	REFERENCES wallet (id)
	ON DELETE RESTRICT
	ON UPDATE cascade,

	CONSTRAINT fk_pay_client
	FOREIGN KEY (client_id)
	REFERENCES client(id)
	ON DELETE RESTRICT
	ON UPDATE cascade
);