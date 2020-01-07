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
import shutil

def main(argv):
    count = 0
    success=0
    #What image do you want to start with?
    start_count=int(argv[1])
    #input is the text of position and class 
    file_data = str(argv[2]) 

    #Create a folder that separates ima and not_ima
    #specify the folder path
    ima = str(argv[3])
    not_ima = str(argv[4])
    os.makedirs(ima, exist_ok = True)
    os.chmod(ima, 0o755)
    os.makedirs(not_ima, exist_ok = True)
    os.chmod(not_ima, 0o755)

    #create a text file that contains information about ima_image and not_ima_image
    with open(file_data, "rt") as fd, open(argv[5], "a") as ima_txt, open(argv[6], "a") as not_ima_txt, open(argv[7], "a") as summary_txt:
        for x in fd:
            y = x.strip()
            z = y.split(" ")
            page_path = z[0]
            image_path = z[1]
            class_category = z[-1]
            if class_category == "14883":
                count +=1
                if count < start_count:
                    pass
                else:
                    #Show a image
                    print("ループ"+str(count)+"番目")
                    #print(class_category)
                    img = cv2.imread(image_path)
                    imS = cv2.resize(img, dsize=None, fx=0.10, fy=0.10)

                    wname = str(image_path)
                    cv2.namedWindow(wname)
                    cv2.imshow(wname, imS)
                    k = cv2.waitKey(0) & 0xFF
                    #Copy ima to ima folder
                    if k==ord('1'):
                        print("今コピー")
                        success+=1
                        shutil.copy(image_path, ima)
                        ima_txt.write(str(x))
                        cv2.destroyAllWindows()
                    #Copy not_ima to not_ima folder
                    elif k==ord('2'):
                        print("NOT今コピー")
                        shutil.copy(image_path, not_ima)
                        #not_ima_txt.write(str(z[0]))
                        cv2.destroyAllWindows()
                    #end    
                    else:
                        print("お疲れ様")
                        sys.exit()

        #print the pages without ima in a file
        if success==0:
            not_ima_txt.write(str(page_path)+"\n")
            
        summary_txt.write(str(page_path)+" "+str(count)+" "+str(success)+"\n" )
        
 

        sys.exit()

if __name__ == "__main__":
    main(sys.argv)