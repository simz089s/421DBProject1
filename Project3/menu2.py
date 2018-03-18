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
        option1 = tk.Radiobutton(self,text='Option1',value=1,variable=option)
        option1.pack()
        option2 = tk.Radiobutton(self,text='Option2',value=2,variable=option)
        option2.pack()
        option3 = tk.Radiobutton(self,text='Option3',value=3,variable=option)
        option3.pack()
        option4 = tk.Radiobutton(self,text='Option4',value=4,variable=option)
        option4.pack()
        option5 = tk.Radiobutton(self,text='Option5',value=5,variable=option)
        option5.pack()

        select_bt = tk.Button(self,text="Next",command=lambda: controller.show_frame(option.get()))
        select_bt.pack()
        quit_bt = tk.Button(self,text="Quit",command=quit)
        quit_bt.pack()

        # Default selection
        option1.select()

class Option1(tk.Frame):
    def __init__(self, parent, controller):
        tk.Frame.__init__(self,parent)
        label = tk.Label(self,text="You choose option 1",font=LARGE_FONT)
        label.pack(pady=10,padx=10)

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

def main(argc, args):
    APP.mainloop()


if __name__ == "__main__":
    sys.exit(main(len(sys.argv), sys.argv))
