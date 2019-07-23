import cv2
import numpy as np
import sys
from matplotlib import pyplot as plt


def main():
	img = cv2.imread(sys.argv[1])
	gray = cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)
	edges = cv2.Canny(gray,50,150,apertureSize = 3)

	lines = cv2.HoughLines(edges,50,np.pi/180,int(sys.argv[2]))
	i=0
	for i in range(0, len(lines)):
		for rho,theta in lines[i]:
		    a = np.cos(theta)
		    b = np.sin(theta)
		    x0 = a*rho
		    y0 = b*rho
		    x1 = int(x0 + 1000*(-b))
		    y1 = int(y0 + 1000*(a))
		    x2 = int(x0 - 1000*(-b))
		    y2 = int(y0 - 1000*(a))

		    cv2.line(img,(x1,y1),(x2,y2),(0,255,0),2)
		    i=i+1

	cv2.imwrite('HoughLines-'+sys.argv[1],img)

if __name__ == "__main__":
    main()