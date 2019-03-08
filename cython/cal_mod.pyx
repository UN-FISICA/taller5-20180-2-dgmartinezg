#!/usr/bin/env python
# coding: utf-8

from matplotlib.pyplot import imread

def su(r):
	s=0.0
	a=0.0
	for n in range(len(r)):
		s=a+r[n]
		a=s
		
	return a

def promedio(y):
	pro=float(sum(y)/len(y))
	return(pro)

def cal_acele(imname,dx,f):
	fi=imread(imname)
	#blanco y negro
	im=(fi[:,:,0]+fi[:,:,1]+fi[:,:,2])/3
	#binarizando
	k=40
	for i in range(len(im)):         # barre sobre las filas
		for j in range(len(im[i])):  #barre sobre las componentes de las filas
			if im[i][j]<=k:          #distingue si es mayor o menor para la binarizacion
				im[i][j]=1
			else:
				im[i][j]=0
	#alfinal entrega la imagen im binarizada, ceros y unos 

	pixel=im[13][13]

	inim=[]
	#etiquetando
	for i in range(len(im)):               #barre sobre las filas de la matriz binarizada
		for j in range(len(im[i])):        #barre sobre las componenetes de cada fila 
			if pixel==1:                   #si el pixel de fondo es obscuro  
				if im[i][j]==0:            # si el pixel es igual a cero, cuando el fondo es obscuro se encuentra unos de fondo
					inim.append(i)
			else:                          #si el pixel de fondo no es oscuro si no blanco, entonces 
				if im[i][j]==1:           
					inim.append(i)
										#entrega la lista inim[] donde contiene una serie de numeros iguales por cada fila donde el pixel es diferente del fondo                

	pos=[]                                            
	for e in range(len(inim)):                                  #sobre la lista que contiene los numeros que se le asigno a cada pixel
		if e+1<len(inim):                                
			if  inim[e+1]-inim[e]!=1 and inim[e+1]-inim[e]!=0:  #aqui se distingue los bordes de las bolas
				pos.append(e)                                   #entrega una lista "pos" con numero que son solo iteracciones
																#lo importates es el numero de componentes que entrega
																#corresponde a numero de bolas en la foto
	bol=[]                           
	for k in range(len(pos)):                                   #esta parte se encarga de agrupar los pixeles que corresponden a una misma bola 
		ubol=[]                                                 #esta lista es la que va a contener todos los pixeles de una misma bola
		if k+1<len(pos):                           
			for j in range(pos[k]+1,pos[k+1]):                    #agrega a la lista todos los que esten en el rango correspondiente
				ubol.append(inim[j])							#agrega las coordenadas que estan en inim
			bol.append(ubol)                                    #luego agregra esta lista "ubol" a la lista bol
		else:
			bol.append(inim[pos[len(pos)-1]:])                  
																#al final entrega la lista "bol" con  listas de las coordenadas de cada 
																#cada pixel de las bolas en el eje vertical 

	#centros de masas    
	cmass=[]  

	for i in bol:                                             # esta parte de encarga de sacar el promedio de las posiciones de los pixeles en cada 
		cmass.append(promedio(i)*dx)                          #lista de la lista bol y entrega el centro de masa en la posicion y
		
	for i in range(2):
		cmass.pop(0)
		
	#print(cmass)
	time=[]
	for i in range(len(cmass)):                               #generamos el tiempo 
		time.append(i*(1.0/f))

	x=time
	y=cmass        
	
	#minimos cuadrados
	#link de donde obtuve la formula (https://www.azdhs.gov/documents/preparedness/state-laboratory/lab-licensure-certification/technical-resources/calibration-training/12-quadratic-least-squares-regression-calib.pdf)
	n=len(x)    
	Sx=su(x)     
	Sy=su(y)     
	Sxy=[]
	Sxx=[]
	Sxx2=[]
	Sx2y=[]
	Sx2x2=[]

	for i in range(len(x)):
		Sxy.append(x[i]*y[i])
		Sxx.append(x[i]*x[i])
		Sxx2.append(x[i]*x[i]*x[i])
		Sx2y.append(x[i]*x[i]*y[i])
		Sx2x2.append(x[i]*x[i]*x[i]*x[i])

	s_xx=su(Sxx)-(Sx**2/n)
	s_xy=su(Sxy)-(Sx*Sy/n)
	s_xxx=su(Sxx2)-(Sx/n)*(su(Sxx))
	s_xxy=su(Sx2y)-(Sy/n)*(su(Sxx))
	s_xxxx=su(Sx2x2)-(su(Sxx)**2/n)
	a=(s_xxy*s_xx-s_xy*s_xxx)/(s_xx*s_xxxx-s_xxx**2)
	return(a*2)




