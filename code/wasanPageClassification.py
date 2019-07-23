#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Aug 23 02:41:42 2018

@author: omusubi
"""

import readchar
import subprocess
import PyPDF2
import sys
from PyPDF2 import PdfFileReader, PdfFileWriter

#open pdf
if len(sys.argv)<2:
    start=1
else:
    start = int(sys.argv[1])

for j in range(start, 431):
    if j>=1 and j<=9 :
        pdfReader = PyPDF2.PdfFileReader("sakuma-000"+str(j)+".pdf")
    elif j<=99 :
        pdfReader = PyPDF2.PdfFileReader("sakuma-00"+str(j)+".pdf")
    elif j<=431 :
        pdfReader = PyPDF2.PdfFileReader("sakuma-0"+str(j)+".pdf")
        
    numPages=pdfReader.numPages
    print(str(j)+"冊目始め")
    print(numPages)

#open page
    for i in range(0, numPages):
        pageObj = pdfReader.getPage(i)
        writer = PdfFileWriter()
        writer.addPage(pageObj)
        with open('output'+str(j)+"-"+str(i)+'.pdf', 'wb') as outfile:
         writer.write(outfile)

#Acrobatで表示
        p = subprocess.Popen(["open",'output'+str(j)+"-"+str(i)+'.pdf'],shell=False)
        print(str(i)+"loop Left for non ima, right for ima") 
        c=readchar.readkey()
        print(type(c))

#キー選択
        print("you entered "+c)
        if c is "e":
          print("Copying "+'output'+str(j)+","+str(i)+'.pdf')
          subprocess.Popen(["cp",'output'+str(j)+"-"+str(i)+'.pdf',"今ある"], shell=False)
          print("今ある")
        elif c is "q":
            sys.exit()
        else:
               # instead of breaking need a control to save the pages that have "ima" to a different folder.
               print("continue")

    print(str(j)+"冊目終わり")