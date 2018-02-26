CREATE
	TYPE gender AS ENUM(
		'Male',
		'Female',
		'Other'
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
			price money NOT NULL,
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
			dID int8 PRIMARY KEY,
			fName VARCHAR(30) NOT NULL,
			lName VARCHAR(30) NOT NULL,
			phone VARCHAR(20) NOT NULL,
			email VARCHAR(30) NOT NULL,
			specialization VARCHAR(60) NOT NULL
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
		HealthFacilities(
			hID INTEGER PRIMARY KEY,
			hName VARCHAR(30) NOT NULL,
			address TEXT NOT NULL,
			phone VARCHAR(20) NOT NULL,
			fType TEXT NOT NULL
		);

CREATE
	TABLE
		Pharmacists(
			dID INTEGER PRIMARY KEY,
			FOREIGN KEY(dID) REFERENCES HealthPractitioner
		);

CREATE
	TABLE
		Receipts(
			rID INTEGER PRIMARY KEY,
			cID INTEGER,
			pID INTEGER,
			date DATE NOT NULL,
			totalPrice money NOT NULL,
			FOREIGN KEY(cID) REFERENCES Clients,
			FOREIGN KEY(pID) REFERENCES Pharmacists
		);

CREATE
	TABLE
		Drugs(
			duID INTEGER PRIMARY KEY,
			dName VARCHAR(200) NOT NULL,
			manufacturer VARCHAR(200) NOT NULL,
			price money NOT NULL,
		);

CREATE
	TABLE
		Subscriptions(
			subID INTEGER PRIMARY KEY,
			cID INTEGER,
			planID INTEGER,
			startDate DATE NOT NULL,
			endDate DATE NOT NULL,
			FOREIGN KEY(cid) REFERENCES Clients,
			FOREIGN KEY(planId) REFERENCES InsurancePlans
		);

CREATE
	TABLE
		InsuranceClaims(
			icID INTEGER PRIMARY KEY,
			subID INTEGER,
			DATE DATE NOT NULL,
			FOREIGN KEY(subID) REFERENCES Subscriptions
		);

-- Relationships

CREATE
	TABLE
		PrescriptionContents(
			pID INTEGER,
			duID INTEGER,
			quantity INTEGER NOT NULL,
			refills INTEGER NOT NULL,
			PRIMARY KEY(
				pID,
				duID
			),
			FOREIGN KEY(pID) REFERENCES Prescriptions,
			FOREIGN KEY(duID) REFERENCES Drugs
		);

CREATE
	TABLE
		WorksAt(
			dID INTEGER,
			hID INTEGER,
			PRIMARY KEY(
				dID,
				hID
			),
			FOREIGN KEY(dID) REFERENCES HealthPractitioner,
			FOREIGN KEY(hid) REFERENCES HealthFacilities
		);

CREATE
	TABLE
		ReceiptDrugs(
			rID INTEGER,
			duID INTEGER,
			price money NOT NULL,
			quantity INTEGER NOT NULL,
			PRIMARY KEY(
				rID,
				duID
			),
			FOREIGN KEY(rID) REFERENCES Receipts,
			FOREIGN KEY(duID) REFERENCES Drugs,
		);

CREATE
	TABLE
		Reimbursed(
			subID INTEGER,
			icID INTEGER PRIMARY KEY,
			amount money,
			DATA DATE NOT NULL,
			FOREIGN KEY(icID) REFERENCES InsuranceClaims,
			FOREIGN KEY(subID) REFERENCES Subscriptions
		);

CREATE
	TABLE
		Covers(
			planID INTEGER,
			duID INTEGER,
			PRIMARY KEY(
				planID,
				duID
			),
			FOREIGN KEY(planID) REFERENCES InsurancePlans,
			FOREIGN KEY(duID) REFERENCES Drugs
		);

