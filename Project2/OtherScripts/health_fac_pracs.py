import random
from pprint import pprint

def check_nums(f_name):
    f = open(f_name)
    li_nums = []
    for line in f.readlines():
        number = line.split()[0]
        li_nums.append(int(number))

    # print(li_nums)
    li_nums.sort()
    # for num in li_nums:
    #     print(num)
    f.close()
    return li_nums

def mix_facs_pracs():
    hfacs = check_nums("healthfacilities.txt")
    hpracs = check_nums("healthpractitioners.txt")
    hpracs_len = len(hpracs)
    combinations = []

    for fac in hfacs:
        for x in range(random.randint(1,6)):
            index = random.randint(0, hpracs_len-1)
            combo = [hpracs[index], fac]
            combinations.append(combo)

    random.shuffle(combinations)
    for combo in combinations:
        print("INSERT INTO worksat VALUES ({}, {});".format(combo[0], combo[1]))


mix_facs_pracs()
