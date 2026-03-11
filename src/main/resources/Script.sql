drop database if exists Shop;

create database if not exists Shop;

use Shop;

create table wallet
(
	Id Int auto_increment PRIMARY KEY,
	Currency DECIMAL(10,2) not null
);

create table client(
	Id Int auto_increment PRIMARY KEY,
	Username VARCHAR(20) NOT NULL,
	Password_Hash VARCHAR(20) NOT NULL,
	Wallet_Id INT NOT NULL,

	CONSTRAINT fk_wallet_client
	FOREIGN KEY (Wallet_Id)
	REFERENCES wallet (Id)
	ON DELETE RESTRICT
	ON UPDATE CASCADE
);

create table player
(
	Id Int primary key,
	OtherAlias VARCHAR(20),
	AppsPlayed Int not null,

	CONSTRAINT fk_player_client
	FOREIGN KEY (Id)
	REFERENCES client(Id)
	ON DELETE RESTRICT
	ON UPDATE CASCADE
);

create table developer
(
	Id Int primary key,
	BrandName VARCHAR(20) not null,
	AppsPublished Int not null,

	CONSTRAINT fk_developer_client
	FOREIGN KEY (Id)
	REFERENCES client(Id)
	ON DELETE RESTRICT
	ON UPDATE CASCADE
);

create table creditCard
(
	Number VARCHAR(16) primary key,
	Cvc Int not null,
	ExpiredDate Date not null
);

create table contain
(
	WalletId Int not null,
	CardNumber VARCHAR(16) not null,

	primary key(WalletId, CardNumber),

	CONSTRAINT fk_contain_wallet
	FOREIGN KEY (WalletId)
	REFERENCES wallet (Id)
	ON DELETE RESTRICT
	ON UPDATE CASCADE,

	CONSTRAINT fk_contain_creditCard
	FOREIGN KEY (CardNumber)
	REFERENCES creditCard (Number)
	ON DELETE RESTRICT
	ON UPDATE CASCADE
);

create table project(
	Id Int auto_increment primary key,
	DevId Int,
	Title VARCHAR(20) not null,
	Description VARCHAR(100),
	Portray longblob,

	CONSTRAINT fk_project_developer
	FOREIGN KEY (DevId)
	REFERENCES developer (Id)
	ON DELETE RESTRICT
	ON UPDATE CASCADE
);

create table genre(
	IdGenero Int auto_increment primary key,
	Name VARCHAR(30) not null
);

create table projectGenre(
	DevId Int not null,
	IdGenero Int not null,

	primary key(DevId, IdGenero),

	CONSTRAINT fk_projectGenre_project
	FOREIGN KEY (DevId)
	REFERENCES project(DevId)
	ON DELETE RESTRICT
	ON UPDATE CASCADE,

	CONSTRAINT fk_projectGenre_genre
	FOREIGN KEY (IdGenero)
	REFERENCES genre(IdGenero)
	ON DELETE RESTRICT
	ON UPDATE CASCADE
);

create table application(
	DevId Int primary key,
	LaunchedDate DATE,
	ReceiptId INT,

	CONSTRAINT fk_application_project
	FOREIGN KEY (DevId)
	REFERENCES project(DevId)
	ON DELETE restrict
	ON UPDATE cascade
);

create table run(
	ClientId Int not null,
	DevId Int not null,
	CounterHours Int,

	primary key(ClientId, DevId),

	CONSTRAINT fk_run_client
	FOREIGN KEY (ClientId)
	REFERENCES client(Id)
	ON DELETE restrict
	ON UPDATE cascade,

	CONSTRAINT fk_run_application
	FOREIGN KEY (DevId)
	REFERENCES application(DevId)
	ON DELETE RESTRICT
	ON UPDATE CASCADE
);

create table receipt(
	Id Int auto_increment primary key,
	Price DECIMAL(10,2) not null,
	DevId Int not null,

	CONSTRAINT fk_receipt_application
	FOREIGN KEY (DevId)
	REFERENCES application(DevId)
	ON DELETE restrict
	ON UPDATE cascade
);

create table pay(
	ReceiptId Int not null,
	WalletId Int not null,
	ClientId Int not null,
	Date DATE not null,

	primary key(ReceiptId, WalletId),

	CONSTRAINT fk_pay_receipt
	FOREIGN KEY (ReceiptId)
	REFERENCES receipt(Id)
	ON DELETE restrict
	ON UPDATE cascade,

	CONSTRAINT fk_pay_wallet
	FOREIGN KEY (WalletId)
	REFERENCES wallet (Id)
	ON DELETE RESTRICT
	ON UPDATE cascade,

	CONSTRAINT fk_pay_client
	FOREIGN KEY (ClientId)
	REFERENCES client(Id)
	ON DELETE RESTRICT
	ON UPDATE cascade
);