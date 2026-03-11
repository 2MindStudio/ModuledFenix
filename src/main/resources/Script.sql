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
	password_Hash VARCHAR(20) NOT NULL,
	walletId INT NOT NULL,

	CONSTRAINT fk_wallet_client
	FOREIGN KEY (walletId)
	REFERENCES wallet (id)
	ON DELETE RESTRICT
	ON UPDATE CASCADE
);

create table player
(
	id Int primary key,
	otherAlias VARCHAR(20),
	appsPlayed Int not null,

	CONSTRAINT fk_player_client
	FOREIGN KEY (id)
	REFERENCES client(id)
	ON DELETE RESTRICT
	ON UPDATE CASCADE
);

create table developer
(
	id Int primary key,
	brandName VARCHAR(20) not null,
	appsPublished Int not null,

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
	expiredDate Date not null
);

create table contain
(
	walletId Int not null,
	cardNumber VARCHAR(16) not null,

	primary key(walletId, cardNumber),

	CONSTRAINT fk_contain_wallet
	FOREIGN KEY (walletId)
	REFERENCES wallet (id)
	ON DELETE RESTRICT
	ON UPDATE CASCADE,

	CONSTRAINT fk_contain_creditCard
	FOREIGN KEY (cardNumber)
	REFERENCES creditCard (number)
	ON DELETE RESTRICT
	ON UPDATE CASCADE
);

create table project(
	id Int auto_increment primary key,
	devId Int,
	title VARCHAR(20) not null,
	description VARCHAR(100),
	portray longblob,

	CONSTRAINT fk_project_developer
	FOREIGN KEY (devId)
	REFERENCES developer (id)
	ON DELETE RESTRICT
	ON UPDATE CASCADE
);

create table genre(
	idGenero Int auto_increment primary key,
	name VARCHAR(30) not null
);

create table projectGenre(
	devId Int not null,
	idGenero Int not null,

	primary key(devId, idGenero),

	CONSTRAINT fk_projectGenre_project
	FOREIGN KEY (devId)
	REFERENCES project(devId)
	ON DELETE RESTRICT
	ON UPDATE CASCADE,

	CONSTRAINT fk_projectGenre_genre
	FOREIGN KEY (idGenero)
	REFERENCES genre(idGenero)
	ON DELETE RESTRICT
	ON UPDATE CASCADE
);

create table application(
	devId Int primary key,
	launchedDate DATE,
	receiptId INT,

	CONSTRAINT fk_application_project
	FOREIGN KEY (devId)
	REFERENCES project(devId)
	ON DELETE restrict
	ON UPDATE cascade
);

create table run(
	clientId Int not null,
	devId Int not null,
	counterHours Int,

	primary key(clientId, devId),

	CONSTRAINT fk_run_client
	FOREIGN KEY (clientId)
	REFERENCES client(id)
	ON DELETE restrict
	ON UPDATE cascade,

	CONSTRAINT fk_run_application
	FOREIGN KEY (devId)
	REFERENCES application(devId)
	ON DELETE RESTRICT
	ON UPDATE CASCADE
);

create table receipt(
	id Int auto_increment primary key,
	price DECIMAL(10,2) not null,
	devId Int not null,

	CONSTRAINT fk_receipt_application
	FOREIGN KEY (devId)
	REFERENCES application(devId)
	ON DELETE restrict
	ON UPDATE cascade
);

create table pay(
	receiptId Int not null,
	walletId Int not null,
	clientId Int not null,
	payDate DATE not null,

	primary key(receiptId, walletId),

	CONSTRAINT fk_pay_receipt
	FOREIGN KEY (receiptId)
	REFERENCES receipt(id)
	ON DELETE restrict
	ON UPDATE cascade,

	CONSTRAINT fk_pay_wallet
	FOREIGN KEY (walletId)
	REFERENCES wallet (id)
	ON DELETE RESTRICT
	ON UPDATE cascade,

	CONSTRAINT fk_pay_client
	FOREIGN KEY (clientId)
	REFERENCES client(id)
	ON DELETE RESTRICT
	ON UPDATE cascade
);