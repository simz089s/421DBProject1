#!/usr/bin/python
# -*- coding: utf-8 -*-
from __future__ import print_function
import sys
try:
    import numpy as np
except ImportError:
    pass

# The filepath of the file you want to change
sqlfilepath = sys.argv[1]
# The column (index) to get
col = int(sys.argv[2])

sqlfile = open(sqlfilepath, mode="r")
# sqltext = sqlfile.read()

sqlcol = []
for line in sqlfile:
    if line.startswith('VALUES( '):
        sqlcol.append(line[8:-3].split(',')[col].replace("'", ""))

sqlfile.close()

print(sqlcol)
with open(sqlfilepath[:-4]+'_col'+str(col)+'.txt', mode="w") as sqlfile:
    for val in sqlcol:
        sqlfile.write(val+",\n")
