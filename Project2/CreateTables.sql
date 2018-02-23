CREATE TYPE Gen AS ENUM ('MALE','FEMALE','OTHER');
CREATE 
	TABLE
		Clients
		(
			cID integer PRIMARY KEY,
			email varchar(30) NOT NULL,
			phone varchar(20) NOT NULL,
			address text NOT NULL,
			account varchar(30) NOT NULL
		);
CREATE
	TABLE
		Individuals 
		(
		cID integer PRIMARY KEY,
		fName VARCHAR(30) NOT NULL,
		lName varchar(30) NOT NULL,
		gender Gen NOT NULL,
		birthdate date NOT NULL,
		FOREIGN KEY (cID) REFERENCES Clients
		);
CREATE 
	TABLE 
		InsurancePlans
		(
			planID integer PRIMARY KEY,
			coverage text NOT NULL,
			price integer NOT NULL,
			pName varchar(30) NOT NULL
		);
CREATE
	TABLE
		Companies
		(
			cID integer PRIMARY KEY,
			compName varchar(30) NOT NULL,
			numEmploy integer NOT NULL,
			FOREIGN KEY (cID) REFERENCES Clients
		);
CREATE
	TABLE
		HealthPractitioner
		(
			dID integer PRIMARY KEY,
			fName VARCHAR(30) NOT NULL,
			lName varchar(30) NOT NULL,
			phone varchar(20) NOT NULL,
			email varchar(30) NOT NULL,
			specialization varchar(30) NOT NULL,
		)

		