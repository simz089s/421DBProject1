# 421DBProject3
COMP 421 Database Systems Winter 2018 Group project 3
## Q1
    All the informations are in the Q1.sql file
## Q2

The GUI was done using Tkinter python librairy and takes advantage of object oriented programming. The project was demoed to the TA on Friday 25 of March 2018. Login happens in the terminal all the rest of the operations happen in the GUI.

### Prerequisites

Be connected to the McGill internet or use a McGill vpn otherwise it will not be possible to access the database.  
 We have just in case implemented a potential ssh connection that can be uncomented to allow database access without the two conditiions mentioned above. 
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
Allows to update the healthpractitioners info using their unique email address. Checking that the number contains exactly 10 digits. Update fails if updating the specialization of a pharmacist in the pharmacits table as that does not respect the constrains that only pharmacists are eligible to give drug receipts.

#### Subscribe to reward plan
Automate the process of offering trial subscriptions for a month starting from the current date of a planid of our choice to all clients that pay greater than a certain amount per month at the current date and are not yet register in that plan.

#### List company drug records
Retrieve the drug ID and names of all the drugs manufactured by a certain company.

## Q3

## Q4
Obtained two charts, 1 showing the amount of new subscriptions per month in 2016.  
2 showing the top 10 avg spending in the year 2001.

## Q5
 A trigger was made in order to ensure that the pharmicist constrains stays respected when updating the health practitioners list.