#!/usr/bin/python
# -*- coding: utf-8 -*-
#
#  menutest.py
#
'''
Database tool menu
'''
from __future__ import print_function
import os, sys
import psycopg2
from tkinter import *
import getpass

def someEvent(event):
    w = event.widget

def main(argc, args):
    ##################################################
    # FOR TESTING ONLY REMOVE HARDCODED PASSWORD AFTER
    pswd = ',./susiajtromb124'
    # psswd = getpass.getpass(prompt='Password: ')
    ##################################################
    conn = psycopg2.connect(dbname='cs421', user='cs421g24', password=pswd, host='comp421.cs.mcgill.ca')
    cursor = conn.cursor()
    root = Tk()
    frame = Frame(root, bg='pink', width=500, height=500)
    frame.pack()
    option1 = Radiobutton(root, text='option1',value=1)
    option1.pack()
    root.mainloop()
    return 0

if __name__ == "__main__":
    sys.exit(main(len(sys.argv), sys.argv))
