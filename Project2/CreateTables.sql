CREATE TYPE Gen AS ENUM ('male','female','other');
CREATE
	TABLE
		Clients 
		(
		cID INTEGER PRIMARY KEY,
		fName VARCHAR(30) NOT NULL,
		lNmame varchar(30) NOT NULL,
		email varchar(30) NOT NULL,
		phone integer NOT NULL,
		gender Gen NOT NULL,
		address text NOT NULL,
		birthdate int NOT NULL,
		account int NOT NULL UNIQUE 
		);

