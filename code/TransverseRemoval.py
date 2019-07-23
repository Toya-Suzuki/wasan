#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Sep 11 11:04:20 2018

@author: omusubi
"""

import cv2
import sys
import numpy as np

def main():
    img = cv2.imread(sys.argv[1])
    gray = cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)
    edges = cv2.Canny(gray,100,200,apertureSize = 3)

    minLineLength = int(sys.argv[2])
    maxLineGap = int(sys.argv[3])
    lines = cv2.HoughLinesP(edges,1,np.pi/180,15,minLineLength,maxLineGap)
    verticalTol=1
    for x in range(0, len(lines)):
        for x1,y1,x2,y2 in lines[x]:
            #store only vertical lines
            if (abs(x1-x2)<verticalTol) and (abs(y1-y2)>minLineLength) :
                cv2.line(img,(x1,y1),(x2,y2),(0,255,0),2)
            else:
                if (abs(x1-x2)<verticalTol):
                    print("("+str(x1)+","+str(y1)+") and ("+str(x2)+","+str(y2)+") line not vertical" )
                else:
                    print("("+str(x1)+","+str(y1)+") and ("+str(x2)+","+str(y2)+") line not long enough" )

    cv2.imwrite("yokosen-jyokyo.png",img)

if __name__ == '__main__':
    main()