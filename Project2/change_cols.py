import sys
from random import shuffle

# The filepath of the file you want to change
sqlfilepath = sys.argv[2]
# The list of random values you want to give
vals = [i for i in range(1, 51)]
shuffle(vals)
vals = tuple(vals)
# The column (index) to replace
col = int(sys.argv[1])

sqlfile = open(sqlfilepath, mode="r")
sqltext = sqlfile.read()
sqlfile.close()

newsqltext = []
i = 0
for line in sqltext.split('\n'):
    if line.startswith('VALUES('):
        icol = 0
        start = 8 if line[7] == ' ' else 7
        end = -1
        startset = False
        for ci,c in enumerate(line):
            if icol == col and not startset:
                startset = True
                if col != 0:
                    start = ci+1 if line[ci] == ' ' else ci
            elif icol > col:
                end = ci
                break
            if c in (',',')'):
                icol+=1
        # print("%d, %d", start, end)
        newline = line[:start] + str(vals[i])
        newline += ' ' + line[end-1:] if line[end-1] == ')' else line[end-1:]
        newsqltext.append(newline + "\n")
        i+=1
    else:
        newsqltext.append(line + "\n")

while newsqltext[-1] == "\n":
    newsqltext.pop(-1)
newsqltext.append("\n")
newsqltext = ''.join(newsqltext)
print(newsqltext)
# sqlfile = open(sqlfilepath, mode="w")
# sqlfile.write(newsqltext)
# sqlfile.close()
