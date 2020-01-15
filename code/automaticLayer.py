import cv2
import numpy as np
import sys

from math import sqrt
from skimage import data
from skimage.transform import rescale
from skimage.feature import blob_dog, blob_log, blob_doh
from skimage.color import rgb2gray
import matplotlib.pyplot as plt
#import dice


def main(argv):
    data_path = "/home/toya/Research/Wasan/data/"
    file_data = "/home/toya/Research/Wasan/data/summary/ima_image/ima_image.txt"
    GT_path = "/home/toya/Research/Wasan/data/GT/"

    with open(file_data, "rt") as ima_txt:
        #open a file to get page_path, x_path, y_path and r_path 
        for x in ima_txt:
            y = x.strip()
            z = y.split(" ")
            page_path = z[0]
            y_path = z[2]
            x_path = z[3]
            r_path = z[4]
            print(str(page_path)+" "+str(y_path)+" "+str(x_path)+" "+str(r_path))
            print(data_path+str(page_path))

            #creating GT
            img = cv2.imread(data_path+"CO"+str(page_path))
            print(str(img.shape))
            maskOutputFile = "GT"+str(page_path)
            outputMask=np.ones((img.shape[0],img.shape[1]),np.uint8)
            y, x, r = float(y_path), float(x_path), float(r_path)
            print(str(x)+" "+str(y)+" "+str(r))
            outputMask[int(y-r):int(y+r),int(x-r):int(x+r)]=255
 
            invertOutputMask=255-outputMask
            cv2.imwrite(GT_path+maskOutputFile,invertOutputMask)
            #sys.exit()


if __name__ == "__main__":
    main(sys.argv)