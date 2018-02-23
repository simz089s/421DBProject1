CREATE TYPE Gen AS ENUM ('male','female','other');
CREATE
	TABLE
		Clients 
		(
		cID integer PRIMARY KEY,
		fName VARCHAR(30) NOT NULL,
		lNmame varchar(30) NOT NULL,
		email varchar(30) NOT NULL,
		phone varchar(20) NOT NULL,
		gender Gen NOT NULL,
		address text NOT NULL,
		birthdate date NOT NULL,
		account varchar(30) NOT NULL UNIQUE 
		);
DROP TABLE Clients;
