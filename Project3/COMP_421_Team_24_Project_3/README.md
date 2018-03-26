# 421DBProject3
COMP 421 Database Systems Winter 2018  
Group project 3

## Q1

All the informations are in the Q1.sql file

## Q2

The GUI was done using the Tkinter python library and takes advantage of object-oriented programming.
The project was demo-ed to the TA on Friday, March 25th 2018.
Login happens in the terminal and all the rest of the operations happen in the GUI.

The application connects through standard SSH port 22 at `comp421.cs.mcgill.ca` using our group username and password using the `sshtunnel` and `paramiko` library.
It will bind to localhost on both sides of the tunnel (standard port 5432 on server and port 0 locally to let the OS select an open port).

It then connects to the `cs421` database using psycopg2 library using the same username and password.
It will use the server's local bind adress if on SSH otherwise it assumes `comp412.cs.mcgill.ca` and `5432`.

They can be easily changed by simply changing the variables in the Python source.

### Prerequisites
Be connected to the McGill internet or use a McGill VPN otherwise it will not be possible to access the database.  
Just in case we have implemented an SSH connection forwarder that can be used to allow database access without the two conditions mentioned above.
There will be a prompt asking whether to use it or not.

#### Note: this was made with Python 3

#### Librairies:  
- tkinter (Python 3)
- getpass
- psycopg2
- pandas
- sshtunnel (for SSH, optional)
- paramiko (for sshtunnel)

#### Installation of libraries (if necessary):
On Linux, most of them can normally be installed with the distribution's package manager (assuming using popular repositories), for example in Debian or Ubuntu-based it is `apt install python-tk python-psycopg2 python-pandas`.

On Mac there is Brew.

Recommended (or otherwise if above not possible) is using (Ana)conda, if not possible then pip, otherwise easy_install.
(Might need easy_install for sshtunnel, paramiko can use `python-paramkiko for Ubuntu or similar`)  
`conda install ...`, `easy_install ...`, `pip install --upgrade psycopg2 pandas` (might need `sudo -H`)

### Running
Terminal
```python
python menu.py
```
Might have to use `python3` instead.  
It will prompt for the password: `,./susiajtromb124`  
The GUI will then pop up with the 5 options

### GUI interface

#### Add client
Allows the user to add a client to the database, checks for email validity by looking for the @ (fully checking the validity of an email address purely from text is considered a very hard problem...) and ensures the phone number has exactly 10 digits (assume North American numbers).

#### Get receipts
Given a client ID, retrieve all of that client's receipt IDs along with the client's payments for each receipt.

#### Update `healthpractitioners` table
Allows to update the `healthpractitioners` info using their unique email address.
Checks that the number contains exactly 10 digits.
Update fails if trying to update the specialization of a pharmacist if this one is in the `pharmacists` table as that violates a constraint.

#### Subscribe to reward plan
Automate the process of offering trial subscriptions for a month, starting from the current date of a `planid` of our choice, to all clients that pay greater than a certain amount per month at the current date and are not yet registered in that plan.

#### List company drug records
Retrieve the drug ID and names of all the drugs manufactured by a certain company.

## Q3

1) **Index on the specialization attribute of the `HealthPractitioners` relation:**  
Indexing on specializations is useful for finding how frequent a specific drug is prescribed by medical specializations (e.g. cardiology).
Queries to find the most and least prescribed drugs are used to alter and optimize insurance plans.
For example, if a new dermatology drug is released and a lot of dermatologists are prescribing it, then it should be included in the offered insurance plans.

2) **Index on the manufacturer attribute of the `Drugs` relation:**  
Indexing on manufacturer is useful to categorize manufacturers into generic drug manufacturers and brand-name drug manufacturers.
When the client buys a prescribed drug, the drug sold to the client by the pharmacist could be made by different manufacturers.
This is important to the insurance company so that different coverages can be optimized and offered to the clients.
The clients also need to know about the difference in the coverage of a generic drug versus a brand-name drug.

## Q4

### Two charts obtained:
1. showing the number of new subscriptions per month in 2016; 
2. showing the top 10 average spending in the year 2001 labeled by client IDs.

## Q5
A trigger was made in order to ensure that the pharmacist constraints are respected when updating the `healthpractitioners` table.
