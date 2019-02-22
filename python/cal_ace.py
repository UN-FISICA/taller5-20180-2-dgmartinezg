from cal_mod import *
import argparse
def cal_ace(imname,dx,f):
	a=cal(imname,dx,f)
	return((a))
	
	
if __name__ =="__main__":
	
	a=cal_ace("Bolas1.tif",0.2,5.3)
	print(a)

