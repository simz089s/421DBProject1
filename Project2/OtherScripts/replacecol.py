#!/usr/bin/python
# -*- coding: utf-8 -*-
from __future__ import print_function
import sys
from random import shuffle
try:
    import numpy as np
except ImportError:
    pass

# The filepath of the file you want to change
sqlfilepath = sys.argv[1]
################################################################################
# Extra space before closing parenthesis
extra_space = False
if extra_space:
    extraspace = ' '
else:
    extraspace = ''
# The list of random values you want to give
first = 1
last = 101
try:
    vals = map(lambda x: x+1, list(np.random.permutation(last-1)))
except NameError:
    try:
        vals = [i for i in xrange(first, last)]
    except NameError:
        vals = [i for i in range(first, last)]
shuffle(vals)
vals = tuple(vals)
with open('./healthpractitionersgen_col0.txt', "r") as txtfile:
    vals = []
    for line in txtfile:
        vals.append(line.strip())
################################################################################
# What to surround value with e.g. nothing for INTEGER and ' for VARCHAR and others
# The column (index) to replace
if len(sys.argv) is 4:
    around = str(sys.argv[2])
    col = int(sys.argv[3])
elif len(sys.argv) is 3:
    around = ""
    col = int(sys.argv[2])
else:
    print("Wrong number of arguments")
    exit(0)

sqlfile = open(sqlfilepath, mode="r")
# sqltext = sqlfile.read()

newsqltext = []
i = 0
for line in sqlfile:
    if line.startswith('VALUES( '):
        # line.replace(" ", "")
        newlinearr = line[8:-3].split(',')
        newlinearr[col] = ' ' + around + str(vals[i]) + around
        newline = 'VALUES(' + ('' if col is 0 else ' ') + ",".join(newlinearr) + extraspace + ');\n'
        newsqltext.append(newline)
        i+=1
    else:
        newsqltext.append(line)

sqlfile.close()

# newsqltext.append("\n")
newsqltext = ''.join(newsqltext)
print(newsqltext)
sqlfile = open(sqlfilepath, mode="w")
sqlfile.write(newsqltext)
sqlfile.close()
