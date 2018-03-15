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
try:
    import Tkinter as tk
    try:
        from Tkinter import messagebox as tkMessageBox
    except ImportError:
        import tkMessageBox
except ImportError:
    import tkinter as tk
    try:
        from tkinter import messagebox as tkMessageBox
    except ImportError:
        import tkMessageBox

def someEvent(event):
    w = event.widget

def main(argc, args):
    root = tk.Tk()
    MENU_HEIGHT = 300
    MENU_WIDTH = 500
    menu_canvas = tk.Canvas(root, bg="grey", height=MENU_HEIGHT, width=MENU_WIDTH)
    menu_canvas.pack()
    menu_frame = tk.Frame(menu_canvas, bg="white", height=MENU_HEIGHT, width=MENU_WIDTH)
    menu_frame.pack()
    btn = tk.Button(menu_frame, text="hi", height=5, width=10)
    btn.pack()

    password = ''
    conn = psycopg2.connect("dbname='cs421', user='cs421g24', password='"+password+"', host='comp421.cs.mcgill.ca'")
    cursor = conn.cursor()

    root.mainloop()
    return 0

if __name__ == "__main__":
    sys.exit(main(len(sys.argv), sys.argv))
