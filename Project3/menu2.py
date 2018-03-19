#!/usr/bin/python
# -*- coding: utf-8 -*-
#
#  menu.py
#
'''
Database tool menu
'''
from __future__ import print_function
import os, sys
import tkinter as tk
import psycopg2
import getpass
from pandas import DataFrame as pdDataFrame

LARGE_FONT = ("Verdana",12)
##################################################
# FOR TESTING ONLY REMOVE HARDCODED PASSWORD AFTER
# getpass.getpass(prompt='Password: ')
##################################################
conn = psycopg2.connect(dbname='cs421', user='cs421g24', password=",./susiajtromb124", host='comp421.cs.mcgill.ca')
cursor = conn.cursor()

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
        option4 = tk.Radiobutton(self,text='Reward Plan',value=4,variable=option)
        option4.pack(anchor="nw")
        option5 = tk.Radiobutton(self,text='Option5',value=5,variable=option)
        option5.pack(anchor="nw")

        select_bt = tk.Button(self,text="Select",command=lambda: controller.show_frame(option.get()))
        select_bt.pack()
        quit_bt = tk.Button(self,text="Quit",command=quit)
        quit_bt.pack()

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
        submit_btn.pack()
        self.message = tk.Label(self,text='')
        goBack = tk.Button(self,text="<- Back",command=lambda: controller.show_frame(0))
        goBack.pack()
        quit_bt = tk.Button(self,text="Quit",command=quit)
        self.message.pack()
        quit_bt.pack()
    def addclient(self):
        global cursor
        argtuple = (self.e1.get(),self.e2.get(),self.e3.get(),self.e4.get())
        try:
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
    Fetch client receipts
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
        quit_button = tk.Button(self,text="Quit",command=quit)

        self.cid_label.pack()
        self.cid_entry.pack()
        self.fetch_button.pack()
        self.fetch_label.pack()
        back_button.pack()
        quit_button.pack()

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

        self.did_label = tk.Label(self,text='ID number')
        self.did_entry = tk.Entry(self)
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

        self.did_label.pack()
        self.did_entry.pack()
        self.fname_label.pack()
        self.fname_entry.pack()
        self.lname_label.pack()
        self.lname_entry.pack()
        self.phone_label.pack()
        self.phone_entry.pack()
        self.email_label.pack()
        self.email_entry.pack()
        self.specialization_label.pack()
        self.specialization_entry.pack()

        self.update_button = tk.Button(self,text='Update',command=self.updateinfo)
        self.feedback = tk.Label(self)

        self.update_button.pack()
        self.feedback.pack()

        back_button = tk.Button(self,text="<- Back",command=lambda: controller.show_frame(0))
        quit_button = tk.Button(self,text="Quit",command=quit)

        back_button.pack()
        quit_button.pack()

    def updateinfo(self):
        try:
            did = int(self.did_entry.get())
            entries = {
                'fname' : self.fname_entry.get(),
                'lname' : self.lname_entry.get(),
                'phone' : self.phone_entry.get(),
                'email' : self.email_entry.get(),
                'specialization' : self.specialization_entry.get()
            }

            inputs = ["'"+entry+"'" if i==len(entries)-1 or all([True if x == '' else False for x in entries.values()[i:]]) else "'"+entry+"'"+',' for i,entry in enumerate(entries.values())]
            inputs = tuple(['' if inputs[i] in ('',',',"''","'',") else entryname+'='+inputs[i] for i,entryname in enumerate(entries.keys())] + [did])
            print(inputs)

            cursor.execute('''UPDATE healthpractitioners
SET %s
WHERE did = %s''', inputs)
            # results = cursor.fetchall()
            # fetch_msg = pdDataFrame(results, columns=('Receipt id', 'Total price')).to_string(index=False)
            # self.fetch_label.config(text=str(fetch_msg))
            # conn.commit()
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
        label = tk.Label(self,text="Reward Plan",font=LARGE_FONT)
        label.pack(pady=10,padx=10)
        PLANID = tk.Label(self,text="PlanID")
        PLANID.pack()
        self.e1 = tk.Entry(self)
        self.e1.pack()
        spendlimit = tk.Label(self,text="Spend limit")
        spendlimit.pack()
        self.e2= tk.Entry(self)
        self.e2.pack()
        submit_btn = tk.Button(self,text="Submit",command=self.subscribe)
        submit_btn.pack()
        self.message = tk.Label(self,text='')
        goBack = tk.Button(self,text="<- Back",command=lambda: controller.show_frame(0))
        self.lb = tk.Listbox(self,height=5)
        quit_bt = tk.Button(self,text="Quit",command=quit)
        self.message.pack()
        self.lb.pack()
        goBack.pack()
        quit_bt.pack()

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
        label = tk.Label(self,text="You choose option 5",font=LARGE_FONT)
        label.pack(pady=10,padx=10)


APP = Insurance()

def quit():
    cursor.close()
    conn.close()
    APP.destroy()
    return 0

def main(argc, args):
    APP.mainloop()
    cursor.close()
    conn.close()
    return 0

if __name__ == "__main__":
    exit_code = main(len(sys.argv), sys.argv)
    cursor.close()
    conn.close()
    sys.exit(exit_code)

cursor.close()
conn.close()
