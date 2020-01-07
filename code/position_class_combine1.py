import sys

def main (argv):

    #First erase the initial part of the class_name file
    with open(argv[2], "r") as f:
        lines = f.readlines()
    with open(argv[2], "w") as f:
        for line in lines:
            if line[0] == "/":
                f.write(line)

    
    #Now define a dictionary to combine our information
    combDict={}
       
    #now, read first file and put a couple (key, value) for each line
    #Key will be the kanji file name, value will be a list with initial positions containing x,y,r
    with open(argv[1], "r") as pos:
        for x in pos:
            x = x.strip()
            #get kanji from first file
            kanji1=x.split(" ")[0]
            #now make new dictionary entry
            #print("Going to add the couple, key: "+str(kanji1)+" Value "+str(x.split(" ")[1:]))
            #The value in the dictionary is a list with its first three positions x,y,r, USING LIST COMPREHENSION! https://medium.com/better-programming/list-comprehension-in-python-8895a785550b
            combDict[kanji1]=[a for a in x.split(" ")[1:]]
    
    POSITION_CLASS = open(argv[3],"wt")
    #now, read SECOND file and put a couple (key, value) for each line
    #Key will be the kanji file name, the value will be a list with the final position containing the category
    with open(argv[2], "r") as class_name:
        for y in class_name:
            y = y.strip()
            #get kanji from first file
            linePart=y.split("/")[-1]
            kanji2=linePart.split(" ")[0]
            category=linePart.split(" ")[1]
            #print(str(kanji2)+" "+category)

            #now make new dictionary entry
            currentValue=combDict[kanji2]
            if(len(currentValue)!=3): raise ValueError("KANJI NOT FOUND")
            currentValue.append(category)
            #print(str(kanji2)+" "+str(currentValue))
            fullKanjiImagePath=y.split(" ")[0]
            #now, extract original image name from the full path of the kanji image
            originalImageName=fullKanjiImagePath.split("/")[-2].split(".")[0][:-10]
            POSITION_CLASS.write(originalImageName+".tif ")
            POSITION_CLASS.write(fullKanjiImagePath)
            for x in currentValue: 
                POSITION_CLASS.write(" "+str(x))    
            POSITION_CLASS.write("\n")

    POSITION_CLASS.close()    


if __name__ == "__main__":
    main(sys.argv)
