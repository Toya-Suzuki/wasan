#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Sep 11 11:04:20 2018

@author: omusubi
"""

import os
import cv2
import sys
import numpy as np
import math
from itertools import groupby
from operator import itemgetter
from matplotlib import pyplot as plt

def separate(listOfLines,maxGapToLinkLines):
    returnList=[[]]
    currentReturnElement=0
    previousList=[]

    #Put the first element in the first list of previous elements
    previousX1=listOfLines[0][0]
    previousY1=listOfLines[0][1]
    previousX2=listOfLines[0][2]
    previousY2=listOfLines[0][3]
    previousList.append( (previousX1, previousY1, previousX2, previousY2) )

    for i in range(1,len(listOfLines)):
        x=listOfLines[i]
        currentX1=x[0]
        currentY1=x[1]
        currentX2=x[2]
        currentY2=x[3]
        if (abs(previousY2-currentY1)>maxGapToLinkLines):
            # Gap is too big
            returnList[currentReturnElement].extend(previousList)
            currentReturnElement+=1
            returnList.append([])
            previousList=[(currentX1, currentY1, currentX2, currentY2)]
        else:
            # gap is NOT too big
            previousList.append( (currentX1, currentY1, currentX2, currentY2) )

        previousX1=currentX1
        previousY1=currentY1
        previousX2=currentX2
        previousY2=currentY2

    returnList[currentReturnElement].extend(previousList)
    return returnList


def summarize(listOfLines):

    x1=listOfLines[0][0]
    y1=listOfLines[0][1]
    x2=listOfLines[0][2]
    y2=listOfLines[0][3]
    for x in listOfLines:
        #x1 is min x
        if (x[0]<x1):
            x1=x[0]
        elif (x[2]<x1):
            x1=x[2]
        #x2 is max x
        if (x[0]>x2):
            x2=x[0]
        elif (x[2]>x2):
            x2=x[2]
        #y1 is min y
        if (x[1]<y1):
            y1=x[1]
        elif (x[3]<y1):
            y1=x[3]
        #y2 is max y
        if (x[1]>y2):
            y2=x[1]
        elif (x[3]>y2):
            y2=x[3]

    return [(x1,y1,x2,y2)]

class newgroupby:
    # [k for k, g in groupby('AAAABBBCCDAABBB')] --> A B C D A B
    # [list(g) for k, g in groupby('AAAABBBCCD')] --> AAAA BBB CC D
    def __init__(self, iterable, key=None,margin=0):
        if key is None:
            key = lambda x: x
        self.keyfunc = key
        self.it = iter(iterable)
        self.tgtkey = self.currkey = self.currvalue = int()
        self.margin=margin
    def __iter__(self):
        return self
    def __next__(self):
        self.id = object()
        while math.fabs(int(self.currkey) - int(self.tgtkey))<= self.margin :
            self.currvalue = next(self.it)    # Exit on StopIteration
            self.currkey = self.keyfunc(self.currvalue)
        self.tgtkey = self.currkey
        return (self.currkey, self._grouper(self.tgtkey, self.id))
    def _grouper(self, tgtkey, id):
        while self.id is id and math.fabs(int(self.currkey) - int(self.tgtkey))<= self.margin:
            yield self.currvalue
            try:
                self.currvalue = next(self.it)
            except StopIteration:
                return
            self.currkey = self.keyfunc(self.currvalue)


path = "/Users/omusubi/Downloads/直線検出/imaaru"
path_list = os.listdir(path)

def main():
    for path_last in path_list:

        img = cv2.imread("/Users/omusubi/Downloads/直線検出/imaaru/{}".format(path_last))
        gray = cv2.cvtColor(img,cv2.COLOR_BGR2GRAY)
        edges = cv2.Canny(gray,100,200,apertureSize = 3)


        minLineLength = int(sys.argv[1])
        maxLineGap = int(sys.argv[2])
        maxGapToLinkLines = int(sys.argv[3])
        verticalTol=int(sys.argv[4])


        lines = cv2.HoughLinesP(edges,1,np.pi/180,15,minLineLength,maxLineGap)
        lines2 = []
        for x in range(0, len(lines)):
            for x1,y1,x2,y2 in lines[x]:
                if (abs(x1-x2)<verticalTol) and (abs(y1-y2)>minLineLength):
                    lines2.append(lines[x])
                else:
                    if (abs(x1-x2)<verticalTol):
                        print("("+str(x1)+","+str(y1)+") and ("+str(x2)+","+str(y2)+") line not vertical" )
                    else:
                        print("("+str(x1)+","+str(y1)+") and ("+str(x2)+","+str(y2)+") line not long enough, "+str(minLineLength)+" is longer than "+str(abs(y1-y2)) )
        print(lines2)


        #sorting by x1-coordinate
        print("NOW SORTING!!!!!!!!!!!!!!!!!!!!!! ")
        values = []
        for x in range(0, len(lines2)):
            for x1,y1,x2,y2 in lines2[x]:
                values.append((x1,y1,x2,y2))

        dtype = [('x1', int),('x2', int),('y1', int),('y2', int)]
        a = np.array(values, dtype=dtype)
        sortedList=np.sort(a, order='x1')
        print(sortedList)


        #grouping by x1-coordinate
        groups = []
        for unique_key, group in newgroupby(sortedList, itemgetter(0), verticalTol):
            groups.append(list(group))
        print(groups)


        # clean up line groups according to maxGapToLinkLines
        print("NOW Clean UP"+str(groups))
        cleanList=[]
        for x in groups:
            inList=separate(x,maxGapToLinkLines)
            for e in inList:
                cleanList.append(e)
        print(cleanList)

        #summary best tuple from each tuple
        print("NOW SUMMARY!!!!!!!!!!!!!!!!!!!!!! "+str(cleanList))
        summaryList=[]
        for x in cleanList:
            summaryList.append(summarize(x))
        print("END of summary "+str(summaryList))


        #show line
        for x in range(0, len(summaryList)):
            for x1,y1,x2,y2 in summaryList[x]:
                cv2.line(img,(x1,y1),(x2,y2),(0,255,0),5)

        cv2.imwrite("image-"+str(path_last)+"MinLine"+str(sys.argv[1])+"MaxGap"+str(sys.argv[2])+"maxGapToLinkLines"+str(sys.argv[3])+"verticalTol"+str(sys.argv[4])+".png",img)

if __name__ == '__main__':
    main()