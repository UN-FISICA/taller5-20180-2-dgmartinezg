#!/usr/bin/python3
import argparse
from cal_mod import *



if __name__ =="__main__":
    ap = argparse.ArgumentParser()
    ap.add_argument('-imname','--imname',required=True)
    ap.add_argument('-dx',type=float)
    ap.add_argument('-f',type=float)
    args = vars(ap.parse_args())
print(cal_acele(args['imname'],args['dx'],args['f']))
