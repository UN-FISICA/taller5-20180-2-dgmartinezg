import scipy.ndimage as nd
from scipy.misc import imread 

import numpy as np
from numpy.linalg import inv,lstsq
from pylab import *
#%pylab 

def cal(imname,dx,f ):
    imagen=imread(imname) #leer la imagen
    imfloat=np.asarray(imagen,dtype=np.float32) #covertir a punto flotante 
    imgrey=(imfloat[:,:,0]+imfloat[:,:,1]+imfloat[:,:,2])/3 #escala de grices 
    imfil=nd.median_filter(imgrey,(3,3)) #filtrar imagen 
    imbin=where(imfil<50,0,255) #binarizar
    imnum,n=nd.label(imbin) #etiquetar las bolas 
    px=nd.measurements.center_of_mass(imgrey,imnum, [3,4,5,6,7,8]) #encontrar los centros de masa
    

    
    y=[]
    b=len(px)
    for i in range(b):
        y.append((px[i][0]*dx))
    
    t=[]
    for i in range(len(y)):
        t.append(i*(1.0/f))

    #minimos cuadrados


    x=np.array(t)
    y=np.array(y)

    f=[]
    f.append(lambda x:np.ones_like(x))
    f.append(lambda x:x)
    f.append(lambda x:x**2)

    Xt=[]

    for fu in f:
        Xt.append(fu(x))

    Xt= np.array(Xt)
    X=Xt.transpose()



    a = np.dot(np.dot(inv(np.dot(Xt,X)),Xt),y)

    plot(x,y)

    y1=0
    for n,ac in enumerate(a):
        y1=y1+ac*x**n

    #plot(x,y1)
    #plt.ylabel("y(altura)")
    #plt.xlabel("t")

    #show()
 
    
    return((a[2]*2))
    


