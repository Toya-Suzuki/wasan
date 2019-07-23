#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Aug 20 03:43:55 2018

@author: omusubi
"""
import sys
import os
import numpy as np
import cv2
import readchar
import shutil

file_data = "/Users/omusubi/Yago Lab Dropbox/Toya Suzuki/tooya/dataExamples/summary/method1classification_toya.txt"  
imaaru = "/Users/omusubi/Downloads/image-show/今ある"
imanai = "/Users/omusubi/Downloads/image-show/今ない"

def main():
    count = 0
    start_count=int(sys.argv[1])
    with open(file_data) as fp:
        lines = fp.readline()
        #print(lines)
        while lines:
            line = lines.split(" ")
            if len(line) > 4:
                #print(line[4].strip())
                if line[4] and line[4].strip()=="16247":
                    #print("aaaaaaaaaaaaaaaaaaaaaaaa")
                    #print(lines)
                    count += 1
                    #print("ループ"+str(count)+"番目")
                    path = line[0] + " " + line[1] + " " + line[2] + " " + line[3]
                    print(path)

                    if count < start_count:
                        pass
                    else:
                        print("ループ"+str(count)+"番目")
                        img = cv2.imread(path)
                        #print(img)
                        imS = cv2.resize(img, (960, 540))
                        wname = path
                        cv2.namedWindow(wname)
                        cv2.imshow(wname, imS)
                        k = cv2.waitKey(0) & 0xFF
                        if k==ord('1'):
                            shutil.copy(path,imaaru)
                            cv2.destroyAllWindows()
                        elif k==ord('2'):
                            shutil.copy(path,imanai)
                            cv2.destroyAllWindows()
                        else:
                            print("お疲れ様")
                            sys.exit()

            lines = fp.readline()   
            #print(lines)
    sys.exit(0)

if __name__ == "__main__":
    main()