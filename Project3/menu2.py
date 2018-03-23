#!/usr/bin/python
# -*- coding: utf-8 -*-
#
#  menu.py
#
'''
Database tool menu (Python 3)
'''
# SHOULD BE USING PYTHON 3 !!!
# from __future__ import print_function
import os, sys
import tkinter as tk
import getpass
import psycopg2
from pandas import DataFrame as pdDataFrame
# import paramiko
from sshtunnel import SSHTunnelForwarder

LARGE_FONT = ("Verdana",12)
##################################################
REMOTE_HOST = 'comp421.cs.mcgill.ca'
REMOTE_USERNAME = 'cs421g24'
REMOTE_PASSWORD =  getpass.getpass(prompt='Password: ')
REMOTE_SSH_PORT = 22
server = SSHTunnelForwarder((REMOTE_HOST, REMOTE_SSH_PORT),
                            ssh_username=REMOTE_USERNAME,
                            ssh_password=REMOTE_PASSWORD,
                            remote_bind_address=('localhost', REMOTE_SSH_PORT))
server.start()
print("Server connected on remote host:", REMOTE_HOST)
print("Local bind port:", server.local_bind_port)
##################################################
PORT = 5432
DB = 'cs421'
conn = psycopg2.connect(dbname=DB, user=REMOTE_USERNAME, password=REMOTE_PASSWORD, host=REMOTE_HOST, port=PORT)
print("Database connected:", DB)
cursor = conn.cursor()

del REMOTE_PASSWORD # Doesn't do much but hey ¯\_(¬_¬)_/¯

class Insurance(tk.Tk):
    def __init__(self,*args,**kwargs):
        tk.Tk.__init__(self,*args,**kwargs)
        container = tk.Frame(self)
        container.pack(side="top",fill="both",expand=True)
        container.grid_rowconfigure(0,weight=1)
        container.grid_columnconfigure(0,weight=1)

        self.frames = []

        frame = StartPage(container, self)
        frame1 = Option1(container, self)
        frame2 = Option2(container, self)
        frame3 = Option3(container, self)
        frame4 = Option4(container, self)
        frame5 = Option5(container, self)
        self.frames.append(frame)
        self.frames.append(frame1)
        self.frames.append(frame2)
        self.frames.append(frame3)
        self.frames.append(frame4)
        self.frames.append(frame5)
        for f in self.frames:
            f.grid(row=0, column=0, sticky="nsew")
        self.show_frame(0)

    def show_frame(self,cont):
        frame = self.frames[cont]
        frame.tkraise()

class StartPage(tk.Frame):
    def __init__(self,parent,controller):
        tk.Frame.__init__(self,parent)
        label = tk.Label(self,text="Select option:",font=LARGE_FONT)
        label.pack(pady=10,padx=10)

        option = tk.IntVar()
        option1 = tk.Radiobutton(self,text='Add client',value=1,variable=option)
        option1.pack(anchor="nw")
        option2 = tk.Radiobutton(self,text='Get client receipts',value=2,variable=option)
        option2.pack(anchor="nw")
        option3 = tk.Radiobutton(self,text='Update health practictioner info',value=3,variable=option)
        option3.pack(anchor="nw")
        option4 = tk.Radiobutton(self,text='Subscribe to reward plan',value=4,variable=option)
        option4.pack(anchor="nw")
        option5 = tk.Radiobutton(self,text='List company drug records',value=5,variable=option)
        option5.pack(anchor="nw")

        select_bt = tk.Button(self,text="Select",command=lambda: controller.show_frame(option.get()))
        quit_bt = tk.Button(self,text="Quit",command=self.quit)
        quit_bt.pack(side='bottom')
        select_bt.pack(side='bottom')

        # Default selection
        option1.select()

class Option1(tk.Frame):
    '''
        Add a client to the database
    '''
    def __init__(self, parent, controller):
        tk.Frame.__init__(self,parent)
        label = tk.Label(self,text="Add client",font=LARGE_FONT)
        label.pack(pady=10,padx=10)
        email = tk.Label(self,text="Email")
        email.pack()
        self.e1 = tk.Entry(self)
        self.e1.pack()
        phone = tk.Label(self,text="Phone")
        phone.pack()
        self.e2= tk.Entry(self)
        self.e2.pack()
        address = tk.Label(self,text="Address")
        address.pack()
        self.e3 = tk.Entry(self)
        self.e3.pack()
        account = tk.Label(self,text="Account")
        account.pack()
        self.e4 = tk.Entry(self)
        self.e4.pack()
        submit_btn = tk.Button(self,text="Insert",command=self.addclient)
        self.message = tk.Label(self,text='')
        goBack = tk.Button(self,text="<- Back",command=lambda: controller.show_frame(0))
        quit_bt = tk.Button(self,text="Quit",command=self.quit)
        submit_btn.pack()
        self.message.pack()
        quit_bt.pack(side='bottom')
        goBack.pack(side='bottom')
    def addclient(self):
        global cursor
        argtuple = (self.e1.get(),self.e2.get(),self.e3.get(),self.e4.get())
        try:
            if '@' not in argtuple[0]:
                raise Exception("email address is not valid")
            try:
                phonum = int(argtuple[1])
            except Exception as e:
                self.message.config(text="Phone number invalid")
                return
            if phonum > 9999999999 and phonum > 999999999:
                raise Exception("Phone number is too long")
            for e in argtuple:
                if e=='':
                    raise Exception("All fields must have a value")
            cursor.execute("INSERT INTO clients VALUES (%s,%s,%s,%s)",argtuple)
            conn.commit()
            self.message.config(text="successfully added %s" %(self.e1.get()))
        except Exception as e:
            self.message.config(text=str(e))

        finally:
            self.e1.delete(0, tk.END)
            self.e2.delete(0, tk.END)
            self.e3.delete(0, tk.END)
            self.e4.delete(0, tk.END)

class Option2(tk.Frame):
    '''
    Fetch client receipts per ID number
    '''
    def __init__(self, parent, controller):
        tk.Frame.__init__(self,parent)
        label = tk.Label(self,text="Get client receipts",font=LARGE_FONT)
        label.pack(pady=10,padx=10)

        self.cid_label = tk.Label(self,text='ID number')
        self.cid_entry = tk.Entry(self)
        self.fetch_button = tk.Button(self,text='Fetch',command=self.fetchclientreceipts)
        self.fetch_label = tk.Label(self)
        back_button = tk.Button(self,text="<- Back",command=lambda: controller.show_frame(0))
        quit_button = tk.Button(self,text="Quit",command=self.quit)

        self.cid_label.pack()
        self.cid_entry.pack()
        self.fetch_button.pack()
        self.fetch_label.pack()
        quit_button.pack(side='bottom')
        back_button.pack(side='bottom')

    def fetchclientreceipts(self):
        try:
            cid = int(self.cid_entry.get())
            cursor.execute("SELECT R.rid, R.totalprice FROM clients C, prescriptions P, receipts R WHERE C.cid = P.cid AND P.pid = R.pid AND C.cid = %s", (cid,))
            results = cursor.fetchall()
            fetch_msg = pdDataFrame(results, columns=('Receipt id', 'Total price')).to_string(index=False)
            self.fetch_label.config(text=str(fetch_msg))
            # conn.commit()
        except Exception as e:
            self.fetch_label.config(text=str(e))
        finally:
            self.cid_entry.delete(0, tk.END)

class Option3(tk.Frame):
    '''
    Update health practictioner info
    '''
    def __init__(self, parent, controller):
        tk.Frame.__init__(self,parent)
        label = tk.Label(self,text="Update health practictioner info",font=LARGE_FONT)
        label.pack(pady=10,padx=10)

        self.fname_label = tk.Label(self,text='First name')
        self.fname_entry = tk.Entry(self)
        self.lname_label = tk.Label(self,text='Last name')
        self.lname_entry = tk.Entry(self)
        self.phone_label = tk.Label(self,text='Phone number')
        self.phone_entry = tk.Entry(self)
        self.email_label = tk.Label(self,text='Email')
        self.email_entry = tk.Entry(self)
        self.specialization_label = tk.Label(self,text='Specialization')
        self.specialization_entry = tk.Entry(self)

        self.email_label.pack()
        self.email_entry.pack()
        self.fname_label.pack()
        self.fname_entry.pack()
        self.lname_label.pack()
        self.lname_entry.pack()
        self.phone_label.pack()
        self.phone_entry.pack()
        self.specialization_label.pack()
        self.specialization_entry.pack()

        self.update_button = tk.Button(self,text='Update',command=self.updateinfo)
        self.feedback = tk.Label(self)

        self.update_button.pack()
        self.feedback.pack()

        back_button = tk.Button(self,text="<- Back",command=lambda: controller.show_frame(0))
        quit_button = tk.Button(self,text="Quit",command=self.quit)

        quit_button.pack(side='bottom')
        back_button.pack(side='bottom')

    def updateinfo(self):
        try:
            email = self.email_entry.get()
            entries = [
                self.fname_entry.get(),
                self.lname_entry.get(),
                self.phone_entry.get(),
                self.specialization_entry.get()
            ]
            if not email:
                raise Exception("email field empty")
            if entries[2]:
                try:
                    phonum = int(entries[2])
                except Exception as e:
                    self.feedback.config(text="Phone number invalid")
                    return
                if phonum > 9999999999 and phonum > 999999999:
                    raise Exception("Phone number is too long")
            cursor.execute('''SELECT h.fname,h.lname,h.phone,h.specialization FROM
                                    healthpractitioners h WHERE H.email = %s''',(email,))
            data = cursor.fetchall()
            data = data[0]
            check = None
            if entries[3]:
                cursor.execute('''SELECT  H.did FROM healthpractitioners h, pharmacists P
                                  WHERE H.email = %s AND H.did = P.did''',(email,))
                check = cursor.fetchall()
                if check:
                    raise Exception(''' Healthpractitioner with email: %s is registered in the pharmacists table
                    changing specialization in Healthpratitioner causes a confilct'''%(email))

            if not data:
                raise Exception ("email not found")
            for i in range(0,len(data)):
                if entries[i] == '':
                    entries[i]=data[i]
            entries.append(email)
            entries=tuple(entries)
            cursor.execute('''UPDATE healthpractitioners SET fname=%s, lname=%s, phone=%s,specialization=%s
            WHERE email = %s ''',entries)
            conn.commit()
            self.feedback.config(text="Update sucessful")
        except Exception as e:
            self.feedback.config(text=str(e))
        finally:
            self.fname_entry.delete(0, tk.END)
            self.lname_entry.delete(0, tk.END)
            self.phone_entry.delete(0, tk.END)
            self.email_entry.delete(0, tk.END)
            self.specialization_entry.delete(0, tk.END)

class Option4(tk.Frame):
    '''
        Reward Plan allowing anyone that spent above a certain amount
        in the span of a year on subscription plans
        to subscribe as a trial for a month to a plan chosen by the user
    '''
    def __init__(self, parent, controller):
        tk.Frame.__init__(self,parent)
        label = tk.Label(self,text="Subscribe to reward plan",font=LARGE_FONT)
        label.pack(pady=10,padx=10)
        PLANID = tk.Label(self,text="Plan ID")
        PLANID.pack()
        self.e1 = tk.Entry(self)
        self.e1.pack()
        spendlimit = tk.Label(self,text="Spending limit")
        spendlimit.pack()
        self.e2= tk.Entry(self)
        self.e2.pack()
        submit_btn = tk.Button(self,text="Submit",command=self.subscribe)
        submit_btn.pack()
        self.message = tk.Label(self,text='')
        goBack = tk.Button(self,text="<- Back",command=lambda: controller.show_frame(0))
        self.lb = tk.Listbox(self,height=5)
        quit_bt = tk.Button(self,text="Quit",command=self.quit)
        self.message.pack()
        self.lb.pack()
        quit_bt.pack(side='bottom')
        goBack.pack(side='bottom')

    def subscribe(self):
        global cursor
        try:
            argtuple = (int(self.e1.get()),int(self.e2.get()))
            for e in argtuple:
                if e=='':
                    raise Exception("All fields must have a value")
            cursor.execute('''SELECT S.cid,sum(P.price) FROM subscriptions S, insuranceplans P WHERE P.planid=S.planid AND age(
				CURRENT_DATE,
				S.enddate
			)< '1 years' AND NOT EXISTS (SELECT FROM subscriptions S1 WHERE S1.planid=%s AND S.cid = S1.cid)
			GROUP BY S.cid
			HAVING sum(P.price)>%s::money''',argtuple)
            data=cursor.fetchall()
            for row in data:
              cursor.execute("INSERT INTO subscriptions VALUES (%s,%s,CURRENT_DATE,CURRENT_DATE+30)",(row[0],argtuple[0]))
            conn.commit()
            fetch_msg = pdDataFrame(data, columns=('New Subscribed Clients','q'))
            fetch_msg = fetch_msg.drop('q',axis=1)
            self.message.config(text="Clients Added:")
            self.lb.delete(0, tk.END)
            for row in data:
                self.lb.insert(0,row[0])
        except Exception as e:
            self.lb.delete(0, tk.END)
            self.message.config(text=str(e))

        finally:
            self.e1.delete(0, tk.END)
            self.e2.delete(0, tk.END)

class Option5(tk.Frame):
    def __init__(self, parent, controller):
        tk.Frame.__init__(self,parent)
        label = tk.Label(self,text="List company drug records",font=LARGE_FONT)
        label.pack(pady=10,padx=10)
        PLANID = tk.Label(self,text="Company name")
        PLANID.pack()
        self.e1 = tk.Entry(self)
        self.e1.pack()
        submit_btn = tk.Button(self,text="Submit",command=self.getRegiseredDrugs)
        submit_btn.pack()
        self.message = tk.Label(self,text='')
        goBack = tk.Button(self,text="<- Back",command=lambda: controller.show_frame(0))
        self.lb = tk.Listbox(self,height=5,width=40)
        quit_bt = tk.Button(self,text="Quit",command=self.quit)
        self.message.pack()
        self.lb.pack()
        quit_bt.pack(side='bottom')
        goBack.pack(side='bottom')
    def getRegiseredDrugs(self):
        global cursor
        try:
            comp = self.e1.get()
            if comp == '':
                raise Exception('No company name entered')
            cursor.execute('''SELECT d.duid,d.dname FROM drugs d WHERE D.manufacturer=%s''',(comp,))
            data = cursor.fetchall()
            if not data:
                raise Exception('the company %s does not exist in the database'%(comp))
            self.lb.delete(0, tk.END)
            self.message.config(text="Drugs manufactured by %s"%(comp))
            for row in data:
                s = str(row[0])+' '+str(row[1])
                self.lb.insert(0,s)
        except Exception as e:
            self.lb.delete(0, tk.END)
            self.message.config(text=str(e))
        finally:
            self.e1.delete(0, tk.END)


APP = Insurance()

def quit():
    APP.destroy()
    APP.quit()

def main(argc, args):
    APP.protocol("WM_DELETE_WINDOW", APP.quit)
    APP.mainloop()
    print("Closing connections")
    quit()
    cursor.close()
    conn.close()
    server.stop()
    return 0

if __name__ == "__main__":
    exit_code = main(len(sys.argv), sys.argv)
    cursor.close()
    conn.close()
    server.stop()
    print("Exiting program")
    sys.exit(exit_code)
