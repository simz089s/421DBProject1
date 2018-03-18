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
        option1 = tk.Radiobutton(self,text='Add Client',value=1,variable=option)
        option1.pack()
        option2 = tk.Radiobutton(self,text='Option2',value=2,variable=option)
        option2.pack()
        option3 = tk.Radiobutton(self,text='Option3',value=3,variable=option)
        option3.pack()
        option4 = tk.Radiobutton(self,text='Option4',value=4,variable=option)
        option4.pack()
        option5 = tk.Radiobutton(self,text='Option5',value=5,variable=option)
        option5.pack()

        select_bt = tk.Button(self,text="Select",command=lambda: controller.show_frame(option.get()))
        select_bt.pack()
        quit_bt = tk.Button(self,text="Quit",command=quit)
        quit_bt.pack()

        # Default selection
        option1.select()

class Option1(tk.Frame):
    def __init__(self, parent, controller):
        tk.Frame.__init__(self,parent)
        label = tk.Label(self,text="Add Client",font=LARGE_FONT)
        label.pack(pady=10,padx=10)
        email = tk.Label(self,text="e-mail")
        email.pack()
        self.e1 = tk.Entry(self)
        self.e1.pack()
        phone = tk.Label(self,text="phone")
        phone.pack()
        self.e2= tk.Entry(self)
        self.e2.pack()
        address = tk.Label(self,text="Address")
        address.pack()
        self.e3 = tk.Entry(self)
        self.e3.pack()
        account = tk.Label(self,text="account")
        account.pack()
        self.e4 = tk.Entry(self)
        self.e4.pack()
        submit_btn = tk.Button(self,text="Submit",command=self.addclient)
        submit_btn.pack()
        self.message = tk.Label(self,text='') 
        goBack = tk.Button(self,text="<- Back",command=lambda: controller.show_frame(0))
        goBack.pack()
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
            self.update()


        

            


class Option2(tk.Frame):
    def __init__(self, parent, controller):
        tk.Frame.__init__(self,parent)
        label = tk.Label(self,text="You choose option 2",font=LARGE_FONT)
        label.pack(pady=10,padx=10)

class Option3(tk.Frame):
    def __init__(self, parent, controller):
        tk.Frame.__init__(self,parent)
        label = tk.Label(self,text="You choose option 3",font=LARGE_FONT)
        label.pack(pady=10,padx=10)

class Option4(tk.Frame):
    def __init__(self, parent, controller):
        tk.Frame.__init__(self,parent)
        label = tk.Label(self,text="You choose option 4",font=LARGE_FONT)
        label.pack(pady=10,padx=10)

class Option5(tk.Frame):
    def __init__(self, parent, controller):
        tk.Frame.__init__(self,parent)
        label = tk.Label(self,text="You choose option 5",font=LARGE_FONT)
        label.pack(pady=10,padx=10)


APP = Insurance()

def quit():
    APP.destroy()
    conn.close()

def main(argc, args):
    APP.mainloop()
    conn.close()

if __name__ == "__main__":
    sys.exit(main(len(sys.argv), sys.argv))
