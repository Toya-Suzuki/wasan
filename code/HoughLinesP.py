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
        print(lines)
        for x in range(0, len(lines)):
            for x1,y1,x2,y2 in lines[x]:
                cv2.line(img,(x1,y1),(x2,y2),(0,255,0),2)


        cv2.imwrite('HoughLinesP-'+sys.argv[1],img)

if __name__ == "__main__":
    main()