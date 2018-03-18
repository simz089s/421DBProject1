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
import psycopg2
from tkinter import *

root = Tk()
action = IntVar()
frame = Frame(root, bg='pink', width=500, height=500)
class StartPage(Frame):
    def __init__(self, parent, controller):
        Label(self,text="start page",font=LARGE_FONT).pacK()
        
    global root
    root.destroy()
def main(argc, args):
    #conn = psycopg2.connect(dbname='cs421', user='cs421g24', password=',./susiajtromb124', host='comp421.cs.mcgill.ca')
    conn = psycopg2.connect(dbname='cs421', user='cs421g24', password=',./susiajtromb124', host='comp421.cs.mcgill.ca')
    cursor = conn.cursor()
    frame.grid()
    quitbutton = Button(frame,text="Quit",command=quit)
    quitbutton.grid()
    global action
    option1 = Radiobutton(frame, text='option1',value=1,variable=action)
    option2 = Radiobutton(frame, text='option2',value=2,variable=action)
    option3= Radiobutton(frame, text='option3',value=3,variable=action)
    option4 = Radiobutton(frame, text='option4',value=4,variable=action)
    option5= Radiobutton(frame, text='option5',value=5,variable=action)
    oparr = [option1,option2,option3,option4,option5]
    option1.select()
    selection = Button(frame,text='Select',command=selection_action);
    for op in oparr:
        op.grid()
    selection.grid()
    root.mainloop()
    return 0

if __name__ == "__main__":
    sys.exit(main(len(sys.argv), sys.argv))
