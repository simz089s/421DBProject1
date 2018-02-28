from pprint import pprint
from tinydb import TinyDB, Query

db = TinyDB('db.json')
receipts = db.table('receipts')
presc_cont = db.table('presc_cont')
receipt_drugs = db.table('receipt_drugs')

def add_receipt(rid, pid):
    receipts.insert({'rid': rid, 'pid': pid})

def add_presc_cont(pid, duid, quantity):
    presc_cont.insert({'pid': pid, 'duid': duid, 'quantity': quantity})

def add_receipt_drugs(rid, duid, quantity):
    receipt_drugs.insert({'rid': rid, 'duid': duid, 'quantity': quantity})

def build_receipt(f_name):
    f = open(f_name)
    for line in f.readlines():
        line_contents = line.split()
        rid = line_contents[0]
        pid = line_contents[-1]
        add_receipt(rid, pid)

def build_presc_cont(f_name):
    f = open(f_name)
    for line in f.readlines():
        line_contents = line.split()
        pid = line_contents[0]
        duid = line_contents[1]
        quantity = line_contents[2]
        add_presc_cont(pid, duid, quantity)

def build_receipt_drugs():
    for rec in receipts.all():
        pid = rec['pid']
        presc_query = Query()
        list_presc = presc_cont.search(presc_query.pid == pid)
        for presc in list_presc:
            add_receipt_drugs(rec['rid'], presc['duid'], presc['quantity'])

def main():
    # pprint(receipt_drugs.all())
    for rec_dr in receipt_drugs.all():
        print("INSERT INTO receiptdrugs VALUES ({}, {}, {});".format(rec_dr['rid'], rec_dr['duid'], rec_dr['quantity']))

def purge():
    db.purge()

purge()
build_receipt("receipts.txt")
build_presc_cont("prescriptioncontents.txt")
build_receipt_drugs()
main()
