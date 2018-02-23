CREATE
	TYPE gender AS ENUM(
		'MALE',
		'FEMALE',
		'OTHER'
	);

CREATE
	TABLE
		Clients(
			cID INTEGER PRIMARY KEY,
			email VARCHAR(30) NOT NULL,
			phone VARCHAR(20) NOT NULL,
			address TEXT NOT NULL,
			account VARCHAR(30) NOT NULL
		);

CREATE
	TABLE
		Individuals(
			cID INTEGER PRIMARY KEY,
			fName VARCHAR(30) NOT NULL,
			lName VARCHAR(30) NOT NULL,
			gender gender NOT NULL,
			birthdate DATE NOT NULL,
			FOREIGN KEY(cID) REFERENCES Clients
		);

CREATE
	TABLE
		InsurancePlans(
			planID INTEGER PRIMARY KEY,
			coverage TEXT NOT NULL,
			price INTEGER NOT NULL,
			pName VARCHAR(30) NOT NULL
		);

CREATE
	TABLE
		Companies(
			cID INTEGER PRIMARY KEY,
			compName VARCHAR(30) NOT NULL,
			numEmploy INTEGER NOT NULL,
			FOREIGN KEY(cID) REFERENCES Clients
		);

CREATE
	TABLE
		HealthPractitioner(
			dID INTEGER PRIMARY KEY,
			fName VARCHAR(30) NOT NULL,
			lName VARCHAR(30) NOT NULL,
			phone VARCHAR(20) NOT NULL,
			email VARCHAR(30) NOT NULL,
			specialization VARCHAR(30) NOT NULL
		);

CREATE
	TABLE
		Prescriptions(
			pID INTEGER PRIMARY KEY,
			cID INTEGER,
			dID INTEGER,
			startDate DATE NOT NULL,
			endDate DATE NOT NULL,
			FOREIGN KEY(cID) REFERENCES Clients,
			FOREIGN KEY(dID) REFERENCES HealthPractitioner
		);

CREATE 
	TABLE
		Healthfacilities
		(
			hID integer PRIMARY KEY,
			hname varchar(30) NOT NULL,
			address text NOT NULL,
			phone varchar(20) NOT NULL,
			fType text NOT NULL
		);

CREATE 
	TABLE
		Pharmacists
		(
			dID integer PRIMARY KEY,
			FOREIGN KEY (dID) REFERENCES healthpractitioner
		);
		
CREATE 
	TABLE
		Reciepts
		(
			rID integer PRIMARY KEY,
			cID integer,
			pID integer,
			date Date NOT NULL,
			totalprice integer NOT NULL,
			CHECK (totalprice > 0),
			FOREIGN KEY (cID) REFERENCES clients,
			FOREIGN KEY (pID) REFERENCES Pharmacists
		);

CREATE
	TABLE
		Drugs
		(
			duID integer PRIMARY KEY,
			dName varchar(30) NOT NULL,
			manufacturer varchar(30) NOT NULL,
			price integer NOT NULL,
			CHECK (price > 0)
		);

CREATE
	TABLE
		Subscriptions
			(
				subID integer PRIMARY KEY, 
				cID integer,
				planID integer,
				startDate Date NOT NULL,
				endDate Date NOT NULL,
				FOREIGN KEY (cid) REFERENCES clients,
				FOREIGN KEY (planId) REFERENCES insuranceplans
			);

CREATE
	TABLE
		Insuranceclaims
		(
			icID integer PRIMARY KEY,
			subID integer,
			date Date NOT NULL,
			FOREIGN KEY (subID) REFERENCES Subscriptions	
		);

/*Relationships */

CREATE
	TABLE 
		PrescriptionContants
		(
			pID integer,
			duID integer,
			quantity integer NOT NULL,
			refills integer NOT NULL,
			PRIMARY KEY (pID,duID),
			FOREIGN KEY (pID) REFERENCES prescriptions,
			FOREIGN KEY (duID) REFERENCES drugs
		);

CREATE 
	TABLE
		WorksAt
		(
			dID integer,
			hID integer,
			PRIMARY KEY (dID,hID),
			FOREIGN KEY (dID) REFERENCES healthpractitioner,
			FOREIGN KEY (hid) REFERENCES healthfacilities
		);

CREATE
	TABLE 
		ReceiptDrugs
		(
			rID integer,
			duID integer,
			price integer NOT NULL,
			quantity integer NOT NULL,
			PRIMARY KEY (rID,duID),
			FOREIGN KEY (rID) REFERENCES reciepts,
			FOREIGN KEY (duID) REFERENCES drugs,
			CHECK (price > 0),
			CHECK (amount > 0)
		);

CREATE
	TABLE 
		Rembursed
		(
			subID integer,
			icID integer PRIMARY KEY,
			amount integer,
			DATA Date NOT NULL,
			FOREIGN KEY (icID) REFERENCES insuranceclaims,
			FOREIGN KEY (subID) REFERENCES subscriptions
		);

CREATE 
	TABLE 
		Covers
			(
				planID integer,
				duID integer,
				PRIMARY KEY (planID,duID),
				FOREIGN KEY (planID) REFERENCES insuranceplans,
				FOREIGN KEY (duID) REFERENCES drugs
			);

