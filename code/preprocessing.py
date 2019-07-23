#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Sep  3 13:54:34 2018

@author: omusubi
"""

import os
import cv2
import numpy as np
import sys

path = "/Users/omusubi/Downloads/前処理画像/imaaru"
path_list = os.listdir(path)
print(path_list)
def main():
    i = 0
    for path_last in path_list:
        
        # 入力画像の読み込み
        img = cv2.imread("/Users/omusubi/Downloads/前処理画像/imaaru/{}".format(path_last))
        # グレースケール変換
        gray = cv2.cvtColor(img, cv2.COLOR_RGB2GRAY)

        # 方法2 （OpenCVで実装）      
        ret, th2 = cv2.threshold(gray, 0, 255, cv2.THRESH_OTSU)    
    
        img = th2
        img = cv2.bitwise_not(img)

        # カーネルの定義
        kernel = np.ones((6, 6), np.uint8)

        # 膨張・収縮処理(方法2)
        dilate = cv2.dilate(img, kernel)
        erode = cv2.erode(dilate, kernel)
    
        dilate = cv2.bitwise_not(dilate)
        erode = cv2.bitwise_not(erode)
        # 結果を出力
        cv2.imwrite("dilate-"+str(path_last), dilate)
        cv2.imwrite("erode-"+str(path_last), erode)
    
if __name__ == "__main__":
    main()