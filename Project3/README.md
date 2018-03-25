# 421DBProject3
COMP 421 Database Systems Winter 2018 Group project 3
## Q1
    All the informations are in the Q1.sql file
## Q2

The GUI was done using Tkinter python librairy and takes advantage of object oriented programming. The project was demoed to the TA on Friday 25 of March 2018. Login happens in the terminal all the rest of the operations happen in the GUI.

### Prerequisites

Be connected to the McGill internet or use a McGill vpn otherwise it will not be possible to access the database.  
 We have just in case implemented a potential ssh connection that can be uncomented to allow database access without the two conditions mentioned above.   
Librairies:  

    Tkinter
    getpass
    psycopg2
    pandas
    sshtunel (optional)


    

### Running
Terminal

    python menu.py
    password:
the password is: ,./susiajtromb124  
The GUI will then pop up with the 5 options

### GUI interface
#### Add client
Allows the user to add a client to the database, checks for email validity using the @ and ensures the phone number has exactly 10 digits

#### Get receipts
Given a client ID retrieve all of that clients receipt ID along with the clients payment for that receipt

#### Update healthpractitioners
Allows to update the healthpractitioners info using their unique email address. Checking that the number contains exactly 10 digits. Update fails if trying to update the specialization of a pharmacist if this one is in the pharmacits table as that violates a constrain.

#### Subscribe to reward plan
Automate the process of offering trial subscriptions for a month starting from the current date of a planid of our choice to all clients that pay greater than a certain amount per month at the current date and are not yet register in that plan.

#### List company drug records
Retrieve the drug ID and names of all the drugs manufactured by a certain company.

## Q3

1) Index on the specialization attribute of the HealthPractitioners relation:
Indexing on specializations is useful for finding how frequent a specific drug is prescribed by medical specializations (e.g. cardiology).
Queries to find the most and least prescribed drugs are used to alter and optimize insurance plans. For example, if a new dermatology drug is released and a lot of dermatologists are prescribing it, then it should be included in the offered insurance plans.

2) Index on the manufacturer attribute of the Drugs relation:
Indexing on manufacturer is useful to categorize manufacturers into generic drug manufacturers and brand-name drug manufacturers.
When the client buys a prescribed drug, the drug sold to the client by the pharmacist could be made by different manufacturers.
This is important to the insurance company so that different coverages can be optimized and offered to the clients. The clients also need to know about the difference in the coverage of a generic drug versus a brand-name drug.

## Q4
Obtained two charts:  
1 showing the number of new subscriptions per month in 2016.  
2 showing the top 10 avg spending in the year 2001 label by clint IDs.

## Q5
 A trigger was made in order to ensure that the pharmicist constrains stays respected when updating the healthpractitioners table.
