CREATE TYPE gender AS ENUM(
	'Male',
	'Female',
	'Other'
);

CREATE TABLE clients (
	cid int4 NOT NULL,
	email varchar(30) NOT NULL,
	phone varchar(20) NOT NULL,
	address text NOT NULL,
	account varchar(30) NOT NULL,
	CONSTRAINT clients_pkey PRIMARY KEY (cid)
);

CREATE TABLE healthpractitioners (
	did int8 NOT NULL,
	fname varchar(30) NOT NULL,
	lname varchar(30) NOT NULL,
	phone varchar(20) NOT NULL,
	email varchar(60) NOT NULL,
	specialization varchar(60) NOT NULL,
	CONSTRAINT healthpractitioner_pkey PRIMARY KEY (did)
);

CREATE TABLE healthfacilities (
	hid int4 NOT NULL,
	hname varchar(30) NOT NULL,
	address text NOT NULL,
	phone varchar(20) NOT NULL,
	ftype text NOT NULL,
	CONSTRAINT healthfacilities_pkey PRIMARY KEY (hid)
);

CREATE TABLE insuranceplans (
	planid int4 NOT NULL,
	coverage text NOT NULL,
	price money NOT NULL,
	pname varchar(30) NOT NULL,
	CONSTRAINT insuranceplans_pkey PRIMARY KEY (planid)
);

CREATE TABLE drugs (
	duid int4 NOT NULL,
	dname varchar(200) NOT NULL,
	manufacturer varchar(200) NOT NULL,
	price money NOT NULL,
	CONSTRAINT drugs_pkey PRIMARY KEY (duid)
);

CREATE TABLE individuals (
	cid int4 NOT NULL,
	fname varchar(30) NOT NULL,
	lname varchar(30) NOT NULL,
	birthdate date NOT NULL,
	genders varchar NULL,
	CONSTRAINT individuals_pkey PRIMARY KEY (cid),
	CONSTRAINT individuals_cid_fkey FOREIGN KEY (cid) REFERENCES clients(cid)
);

CREATE TABLE pharmacists (
	did int8 NOT NULL,
	CONSTRAINT pharmacists_pkey PRIMARY KEY (did),
	CONSTRAINT superlock FOREIGN KEY (did) REFERENCES healthpractitioners(did) ON DELETE CASCADE
);

CREATE TABLE prescriptions (
	pid int4 NOT NULL,
	cid int4 NULL,
	did int8 NULL,
	startdate date NOT NULL,
	enddate date NOT NULL,
	CONSTRAINT prescriptions_pkey PRIMARY KEY (pid),
	CONSTRAINT prescriptions_cid_fkey FOREIGN KEY (cid) REFERENCES clients(cid),
	CONSTRAINT prescriptions_did_fkey FOREIGN KEY (did) REFERENCES healthpractitioners(did)
);

CREATE TABLE receipts (
	rid int4 NOT NULL,
	did int8 NOT NULL,
	"date" date NOT NULL,
	totalprice money NOT NULL,
	pid int4 NOT NULL,
	CONSTRAINT receipts_pkey PRIMARY KEY (rid),
	CONSTRAINT receipts_pid_fkey FOREIGN KEY (did) REFERENCES pharmacists(did),
	CONSTRAINT receipts_prescriptions_fk FOREIGN KEY (pid) REFERENCES prescriptions(pid)
);

CREATE TABLE receiptdrugs (
	rid int4 NOT NULL,
	duid int4 NOT NULL,
	quantity int4 NOT NULL,
	CONSTRAINT receiptdrugs_pkey PRIMARY KEY (rid, duid),
	CONSTRAINT receiptdrugs_duid_fkey FOREIGN KEY (duid) REFERENCES drugs(duid),
	CONSTRAINT receiptdrugs_rid_fkey FOREIGN KEY (rid) REFERENCES receipts(rid)
);

CREATE TABLE insuranceclaims (
	icid int4 NOT NULL,
	"date" date NOT NULL,
	rid int4 NOT NULL,
	CONSTRAINT insuranceclaims_pkey PRIMARY KEY (icid),
	CONSTRAINT insuranceclaims_rid_fkey FOREIGN KEY (rid) REFERENCES receipts(rid)
);

CREATE TABLE subscriptions (
	cid int4 NULL,
	planid int4 NULL,
	startdate date NOT NULL,
	enddate date NOT NULL,
	subid serial NOT NULL,
	CONSTRAINT subscriptions_pk PRIMARY KEY (subid),
	CONSTRAINT subscriptions_cid_fkey FOREIGN KEY (cid) REFERENCES clients(cid),
	CONSTRAINT subscriptions_planid_fkey FOREIGN KEY (planid) REFERENCES insuranceplans(planid)
);

CREATE TABLE reimbursed (
	subid int4 NULL,
	icid int4 NOT NULL,
	amount money NOT NULL,
	"data" date NOT NULL,
	CONSTRAINT reimbursed_pkey PRIMARY KEY (icid),
	CONSTRAINT reimbursed_icid_fkey FOREIGN KEY (icid) REFERENCES insuranceclaims(icid),
	CONSTRAINT reimbursed_subid_fkey FOREIGN KEY (subid) REFERENCES subscriptions(subid)
);

CREATE TABLE covers (
	planid int4 NOT NULL,
	duid int4 NOT NULL,
	CONSTRAINT covers_pkey PRIMARY KEY (planid, duid),
	CONSTRAINT covers_duid_fkey FOREIGN KEY (duid) REFERENCES drugs(duid),
	CONSTRAINT covers_planid_fkey FOREIGN KEY (planid) REFERENCES insuranceplans(planid)
);

CREATE TABLE companies (
	cid int4 NOT NULL,
	compname varchar(30) NOT NULL,
	numemploy int4 NOT NULL,
	CONSTRAINT companies_pkey PRIMARY KEY (cid),
	CONSTRAINT companies_cid_fkey FOREIGN KEY (cid) REFERENCES clients(cid)
);

CREATE TABLE worksat (
	did int8 NOT NULL,
	hid int4 NOT NULL,
	CONSTRAINT worksat_pkey PRIMARY KEY (did, hid),
	CONSTRAINT worksat_did_fkey FOREIGN KEY (did) REFERENCES healthpractitioners(did),
	CONSTRAINT worksat_hid_fkey FOREIGN KEY (hid) REFERENCES healthfacilities(hid)
);

CREATE TABLE prescriptioncontents (
	pid int4 NOT NULL,
	duid int4 NOT NULL,
	quantity int4 NOT NULL,
	refills int4 NOT NULL,
	CONSTRAINT prescriptioncontents_pkey PRIMARY KEY (pid, duid),
	CONSTRAINT prescriptioncontents_duid_fkey FOREIGN KEY (duid) REFERENCES drugs(duid),
	CONSTRAINT prescriptioncontents_pid_fkey FOREIGN KEY (pid) REFERENCES prescriptions(pid)
);


