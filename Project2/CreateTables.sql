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

