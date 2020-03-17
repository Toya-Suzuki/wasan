import os

def main():
    #path = "/home/toya/ダウンロード/ImaData_tiff"
    path = "/home/toya/ダウンロード/ImaData_tiff_noiseRemove"
    Dir = os.listdir(path)
    for fileName in Dir:
        print(fileName)
        output = fileName.split("_")[0]
        print(output)
        bookNumber = output.split("-")[0].split("t")[-1]
        bookPage = output.split("-")[-1]
        print(bookNumber, bookPage)
        if 1<=int(bookNumber)<=9:
            renameFile = "sakuma-000"+bookNumber+"_Pаgina_"+bookPage+"_Imagen_0001.tif_resultat_noiseRemoval.tif"
            if 1<=int(bookPage)<=9:
                renameFile = "sakuma-000"+bookNumber+"_Pаgina_0"+bookPage+"_Imagen_0001.tif_resultat_noiseRemoval.tif"
        elif 10<=int(bookNumber)<=99:
            renameFile = "sakuma-00"+bookNumber+"_Pаgina_"+bookPage+"_Imagen_0001.tif_resultat_noiseRemoval.tif"
            if 1<=int(bookPage)<=9:
                renameFile = "sakuma-00"+bookNumber+"_Pаgina_0"+bookPage+"_Imagen_0001.tif_resultat_noiseRemoval.tif"
        else:
            renameFile = "sakuma-0"+bookNumber+"_Pаgina_"+bookPage+"_Imagen_0001.tif_resultat_noiseRemoval.tif"
            if 1<=int(bookPage)<=9:
                renameFile = "sakuma-0"+bookNumber+"_Pаgina_0"+bookPage+"_Imagen_0001.tif_resultat_noiseRemoval.tif"
        os.rename(path+"/"+fileName, path+"/"+renameFile)

if __name__ == "__main__":
    main()