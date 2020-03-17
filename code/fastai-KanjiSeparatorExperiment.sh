#!/bin/bash
# bash fastai-KanjiSeparatorExperiment.sh /home/toya/Research/Wasan/code /home/toya/Research/Wasan/data cT 1 res 10 0.1
currentDir=$(pwd)

codeDir=$1
dataDir=$2
whatToDo=$3 #options: d, detect, c, classify
chosenMethod=$4 # Blob detector method
modelName=$5 #Use cT or cP
epoch=$6 #Use cT or cP
learningRate=$7 #Use cT or cP

summaryDir=$dataDir"/summary/"
fastaiResultDir=$summaryDir"fastaiResult/"
timeSummaryFile=$summaryDir"timeSummary.txt"



detect=0
classifTrain=0
classifPredict=0
combine=0
imshow=0
evaluate=0
if [[ $whatToDo == *"d"* ]]; then
detect=1
fi
if [[ $whatToDo == *"cT"* ]]; then
classifTrain=1
fi
if [[ $whatToDo == *"cP"* ]]; then
classifPredict=1
fi
if [[ $whatToDo == *"co"* ]]; then
combine=1
fi
if [[ $whatToDo == *"i"* ]]; then
imshow=1
fi
if [[ $whatToDo == *"e"* ]]; then
evaluate=1
fi

echo "Chosen Method $chosenMethod"
fileList="sakuma-0001_Pаgina_01_Imagen_0001 sakuma-0001_Pаgina_30_Imagen_0001"
#fileList="sakuma-0001_Pаgina_01_Imagen_0001 sakuma-0001_Pаgina_04_Imagen_0001 sakuma-0001_Pаgina_07_Imagen_0001 sakuma-0001_Pаgina_10_Imagen_0001 sakuma-0001_Pаgina_13_Imagen_0001 sakuma-0001_Pаgina_14_Imagen_0001 sakuma-0001_Pаgina_16_Imagen_0001 sakuma-0001_Pаgina_18_Imagen_0001 sakuma-0001_Pаgina_20_Imagen_0001 sakuma-0001_Pаgina_21_Imagen_0001 sakuma-0001_Pаgina_22_Imagen_0001 sakuma-0001_Pаgina_23_Imagen_0001 sakuma-0001_Pаgina_24_Imagen_0001 sakuma-0001_Pаgina_25_Imagen_0001 sakuma-0001_Pаgina_26_Imagen_0001 sakuma-0001_Pаgina_28_Imagen_0001 sakuma-0001_Pаgina_29_Imagen_0001 sakuma-0001_Pаgina_30_Imagen_0001 sakuma-0001_Pаgina_31_Imagen_0001 sakuma-0001_Pаgina_33_Imagen_0001 sakuma-0001_Pаgina_34_Imagen_0001 sakuma-0002_Pаgina_02_Imagen_0001 sakuma-0002_Pаgina_05_Imagen_0001 sakuma-0002_Pаgina_06_Imagen_0001 sakuma-0002_Pаgina_09_Imagen_0001 sakuma-0002_Pаgina_10_Imagen_0001 sakuma-0002_Pаgina_11_Imagen_0001 sakuma-0002_Pаgina_12_Imagen_0001 sakuma-0002_Pаgina_13_Imagen_0001 sakuma-0002_Pаgina_14_Imagen_0001 sakuma-0002_Pаgina_15_Imagen_0001 sakuma-0002_Pаgina_16_Imagen_0001 sakuma-0002_Pаgina_18_Imagen_0001 sakuma-0002_Pаgina_19_Imagen_0001 sakuma-0002_Pаgina_20_Imagen_0001 sakuma-0002_Pаgina_22_Imagen_0001 sakuma-0002_Pаgina_27_Imagen_0001 sakuma-0002_Pаgina_28_Imagen_0001 sakuma-0003_Pаgina_42_Imagen_0001 sakuma-0004_Pаgina_01_Imagen_0001 sakuma-0004_Pаgina_02_Imagen_0001 sakuma-0004_Pаgina_03_Imagen_0001 sakuma-0004_Pаgina_04_Imagen_0001 sakuma-0004_Pаgina_08_Imagen_0001 sakuma-0004_Pаgina_12_Imagen_0001 sakuma-0004_Pаgina_15_Imagen_0001 sakuma-0004_Pаgina_17_Imagen_0001 sakuma-0004_Pаgina_20_Imagen_0001 sakuma-0004_Pаgina_25_Imagen_0001 sakuma-0004_Pаgina_28_Imagen_0001 sakuma-0004_Pаgina_29_Imagen_0001 sakuma-0005_Pаgina_03_Imagen_0001 sakuma-0005_Pаgina_04_Imagen_0001 sakuma-0005_Pаgina_06_Imagen_0001 sakuma-0005_Pаgina_07_Imagen_0001 sakuma-0005_Pаgina_08_Imagen_0001 sakuma-0005_Pаgina_10_Imagen_0001 sakuma-0005_Pаgina_11_Imagen_0001 sakuma-0005_Pаgina_13_Imagen_0001 sakuma-0005_Pаgina_15_Imagen_0001 sakuma-0005_Pаgina_17_Imagen_0001 sakuma-0005_Pаgina_18_Imagen_0001 sakuma-0006_Pаgina_02_Imagen_0001 sakuma-0006_Pаgina_03_Imagen_0001 sakuma-0006_Pаgina_05_Imagen_0001 sakuma-0006_Pаgina_06_Imagen_0001 sakuma-0006_Pаgina_08_Imagen_0001 sakuma-0006_Pаgina_09_Imagen_0001 sakuma-0006_Pаgina_10_Imagen_0001 sakuma-0006_Pаgina_11_Imagen_0001 sakuma-0006_Pаgina_12_Imagen_0001 sakuma-0006_Pаgina_13_Imagen_0001 sakuma-0006_Pаgina_14_Imagen_0001 sakuma-0006_Pаgina_15_Imagen_0001 sakuma-0006_Pаgina_16_Imagen_0001 sakuma-0006_Pаgina_18_Imagen_0001 sakuma-0006_Pаgina_20_Imagen_0001 sakuma-0006_Pаgina_21_Imagen_0001 sakuma-0006_Pаgina_22_Imagen_0001 sakuma-0006_Pаgina_23_Imagen_0001 sakuma-0006_Pаgina_24_Imagen_0001 sakuma-0007_Pаgina_01_Imagen_0001 sakuma-0007_Pаgina_16_Imagen_0001 sakuma-0007_Pаgina_17_Imagen_0001 sakuma-0007_Pаgina_18_Imagen_0001 sakuma-0007_Pаgina_19_Imagen_0001 sakuma-0007_Pаgina_20_Imagen_0001 sakuma-0008_Pаgina_16_Imagen_0001 sakuma-0008_Pаgina_18_Imagen_0001 sakuma-0008_Pаgina_20_Imagen_0001 sakuma-0008_Pаgina_22_Imagen_0001 sakuma-0008_Pаgina_25_Imagen_0001 sakuma-0008_Pаgina_26_Imagen_0001 sakuma-0008_Pаgina_28_Imagen_0001 sakuma-0009_Pаgina_01_Imagen_0001 sakuma-0009_Pаgina_02_Imagen_0001 sakuma-0009_Pаgina_03_Imagen_0001 sakuma-0009_Pаgina_04_Imagen_0001 sakuma-0009_Pаgina_05_Imagen_0001 sakuma-0009_Pаgina_06_Imagen_0001 sakuma-0009_Pаgina_07_Imagen_0001 sakuma-0009_Pаgina_09_Imagen_0001 sakuma-0009_Pаgina_10_Imagen_0001 sakuma-0009_Pаgina_13_Imagen_0001 sakuma-0010_Pаgina_03_Imagen_0001 sakuma-0010_Pаgina_05_Imagen_0001 sakuma-0010_Pаgina_06_Imagen_0001 sakuma-0010_Pаgina_07_Imagen_0001 sakuma-0010_Pаgina_09_Imagen_0001 sakuma-0010_Pаgina_10_Imagen_0001 sakuma-0011_Pаgina_11_Imagen_0001 sakuma-0011_Pаgina_13_Imagen_0001 sakuma-0011_Pаgina_15_Imagen_0001 sakuma-0011_Pаgina_16_Imagen_0001 sakuma-0011_Pаgina_17_Imagen_0001 sakuma-0011_Pаgina_20_Imagen_0001 sakuma-0011_Pаgina_25_Imagen_0001 sakuma-0011_Pаgina_26_Imagen_0001 sakuma-0011_Pаgina_28_Imagen_0001 sakuma-0012_Pаgina_01_Imagen_0001 sakuma-0012_Pаgina_09_Imagen_0001 sakuma-0012_Pаgina_12_Imagen_0001 sakuma-0012_Pаgina_14_Imagen_0001 sakuma-0013_Pаgina_02_Imagen_0001 sakuma-0013_Pаgina_04_Imagen_0001 sakuma-0013_Pаgina_05_Imagen_0001 sakuma-0013_Pаgina_06_Imagen_0001 sakuma-0013_Pаgina_07_Imagen_0001 sakuma-0013_Pаgina_08_Imagen_0001 sakuma-0013_Pаgina_09_Imagen_0001 sakuma-0013_Pаgina_10_Imagen_0001 sakuma-0013_Pаgina_11_Imagen_0001 sakuma-0013_Pаgina_12_Imagen_0001 sakuma-0013_Pаgina_13_Imagen_0001 sakuma-0013_Pаgina_14_Imagen_0001 sakuma-0013_Pаgina_15_Imagen_0001 sakuma-0013_Pаgina_16_Imagen_0001 sakuma-0013_Pаgina_17_Imagen_0001 sakuma-0013_Pаgina_18_Imagen_0001 sakuma-0013_Pаgina_19_Imagen_0001 sakuma-0013_Pаgina_20_Imagen_0001 sakuma-0013_Pаgina_21_Imagen_0001 sakuma-0013_Pаgina_22_Imagen_0001 sakuma-0014_Pаgina_01_Imagen_0001 sakuma-0014_Pаgina_03_Imagen_0001 sakuma-0014_Pаgina_10_Imagen_0001 sakuma-0015_Pаgina_01_Imagen_0001 sakuma-0015_Pаgina_02_Imagen_0001 sakuma-0015_Pаgina_05_Imagen_0001 sakuma-0015_Pаgina_07_Imagen_0001 sakuma-0015_Pаgina_09_Imagen_0001 sakuma-0015_Pаgina_11_Imagen_0001 sakuma-0015_Pаgina_13_Imagen_0001 sakuma-0015_Pаgina_15_Imagen_0001 sakuma-0015_Pаgina_17_Imagen_0001 sakuma-0015_Pаgina_19_Imagen_0001 sakuma-0015_Pаgina_21_Imagen_0001 sakuma-0015_Pаgina_23_Imagen_0001 sakuma-0015_Pаgina_25_Imagen_0001 sakuma-0015_Pаgina_26_Imagen_0001 sakuma-0015_Pаgina_27_Imagen_0001 sakuma-0015_Pаgina_28_Imagen_0001 sakuma-0015_Pаgina_30_Imagen_0001 sakuma-0015_Pаgina_31_Imagen_0001 sakuma-0015_Pаgina_32_Imagen_0001 sakuma-0015_Pаgina_33_Imagen_0001 sakuma-0015_Pаgina_34_Imagen_0001 sakuma-0016_Pаgina_01_Imagen_0001 sakuma-0016_Pаgina_02_Imagen_0001 sakuma-0016_Pаgina_03_Imagen_0001 sakuma-0016_Pаgina_04_Imagen_0001 sakuma-0016_Pаgina_05_Imagen_0001 sakuma-0016_Pаgina_06_Imagen_0001 sakuma-0016_Pаgina_07_Imagen_0001 sakuma-0016_Pаgina_08_Imagen_0001 sakuma-0016_Pаgina_09_Imagen_0001 sakuma-0016_Pаgina_10_Imagen_0001 sakuma-0016_Pаgina_11_Imagen_0001 sakuma-0016_Pаgina_12_Imagen_0001 sakuma-0016_Pаgina_14_Imagen_0001 sakuma-0016_Pаgina_15_Imagen_0001 sakuma-0016_Pаgina_17_Imagen_0001 sakuma-0018_Pаgina_01_Imagen_0001 sakuma-0018_Pаgina_06_Imagen_0001 sakuma-0018_Pаgina_08_Imagen_0001 sakuma-0018_Pаgina_13_Imagen_0001 sakuma-0018_Pаgina_22_Imagen_0001 sakuma-0019_Pаgina_02_Imagen_0001 sakuma-0019_Pаgina_04_Imagen_0001 sakuma-0019_Pаgina_05_Imagen_0001 sakuma-0019_Pаgina_06_Imagen_0001 sakuma-0019_Pаgina_07_Imagen_0001 sakuma-0019_Pаgina_08_Imagen_0001 sakuma-0019_Pаgina_09_Imagen_0001 sakuma-0019_Pаgina_10_Imagen_0001 sakuma-0019_Pаgina_11_Imagen_0001 sakuma-0019_Pаgina_12_Imagen_0001 sakuma-0019_Pаgina_13_Imagen_0001 sakuma-0019_Pаgina_14_Imagen_0001 sakuma-0019_Pаgina_15_Imagen_0001 sakuma-0019_Pаgina_17_Imagen_0001 sakuma-0019_Pаgina_19_Imagen_0001 sakuma-0019_Pаgina_20_Imagen_0001 sakuma-0019_Pаgina_21_Imagen_0001 sakuma-0019_Pаgina_22_Imagen_0001 sakuma-0019_Pаgina_23_Imagen_0001 sakuma-0019_Pаgina_24_Imagen_0001 sakuma-0019_Pаgina_26_Imagen_0001 sakuma-0019_Pаgina_27_Imagen_0001 sakuma-0019_Pаgina_28_Imagen_0001 sakuma-0019_Pаgina_29_Imagen_0001 sakuma-0019_Pаgina_30_Imagen_0001 sakuma-0019_Pаgina_31_Imagen_0001 sakuma-0019_Pаgina_32_Imagen_0001 sakuma-0019_Pаgina_33_Imagen_0001 sakuma-0019_Pаgina_34_Imagen_0001 sakuma-0019_Pаgina_35_Imagen_0001 sakuma-0020_Pаgina_01_Imagen_0001 sakuma-0020_Pаgina_04_Imagen_0001 sakuma-0020_Pаgina_13_Imagen_0001 sakuma-0020_Pаgina_18_Imagen_0001 sakuma-0020_Pаgina_19_Imagen_0001 sakuma-0020_Pаgina_21_Imagen_0001 sakuma-0020_Pаgina_22_Imagen_0001 sakuma-0020_Pаgina_23_Imagen_0001 sakuma-0020_Pаgina_24_Imagen_0001 sakuma-0020_Pаgina_27_Imagen_0001 sakuma-0020_Pаgina_28_Imagen_0001 sakuma-0020_Pаgina_41_Imagen_0001 sakuma-0021_Pаgina_02_Imagen_0001 sakuma-0022_Pаgina_02_Imagen_0001 sakuma-0022_Pаgina_03_Imagen_0001 sakuma-0022_Pаgina_05_Imagen_0001 sakuma-0022_Pаgina_06_Imagen_0001 sakuma-0022_Pаgina_07_Imagen_0001 sakuma-0022_Pаgina_08_Imagen_0001 sakuma-0022_Pаgina_09_Imagen_0001 sakuma-0022_Pаgina_10_Imagen_0001 sakuma-0022_Pаgina_11_Imagen_0001 sakuma-0022_Pаgina_12_Imagen_0001 sakuma-0022_Pаgina_14_Imagen_0001 sakuma-0022_Pаgina_16_Imagen_0001 sakuma-0022_Pаgina_17_Imagen_0001 sakuma-0022_Pаgina_18_Imagen_0001 sakuma-0022_Pаgina_19_Imagen_0001 sakuma-0022_Pаgina_20_Imagen_0001 sakuma-0022_Pаgina_21_Imagen_0001 sakuma-0022_Pаgina_22_Imagen_0001 sakuma-0022_Pаgina_23_Imagen_0001 sakuma-0022_Pаgina_24_Imagen_0001 sakuma-0022_Pаgina_25_Imagen_0001 sakuma-0022_Pаgina_26_Imagen_0001 sakuma-0022_Pаgina_27_Imagen_0001 sakuma-0022_Pаgina_29_Imagen_0001 sakuma-0022_Pаgina_31_Imagen_0001 sakuma-0022_Pаgina_32_Imagen_0001 sakuma-0022_Pаgina_35_Imagen_0001 sakuma-0022_Pаgina_37_Imagen_0001 sakuma-0022_Pаgina_38_Imagen_0001 sakuma-0022_Pаgina_39_Imagen_0001 sakuma-0022_Pаgina_41_Imagen_0001 sakuma-0023_Pаgina_01_Imagen_0001 sakuma-0023_Pаgina_02_Imagen_0001 sakuma-0023_Pаgina_03_Imagen_0001 sakuma-0023_Pаgina_04_Imagen_0001 sakuma-0023_Pаgina_05_Imagen_0001 sakuma-0023_Pаgina_06_Imagen_0001 sakuma-0023_Pаgina_07_Imagen_0001 sakuma-0023_Pаgina_08_Imagen_0001 sakuma-0023_Pаgina_10_Imagen_0001 sakuma-0023_Pаgina_11_Imagen_0001 sakuma-0023_Pаgina_12_Imagen_0001 sakuma-0023_Pаgina_13_Imagen_0001 sakuma-0023_Pаgina_14_Imagen_0001 sakuma-0023_Pаgina_15_Imagen_0001 sakuma-0023_Pаgina_17_Imagen_0001 sakuma-0023_Pаgina_18_Imagen_0001 sakuma-0023_Pаgina_19_Imagen_0001 sakuma-0023_Pаgina_20_Imagen_0001 sakuma-0023_Pаgina_21_Imagen_0001 sakuma-0023_Pаgina_24_Imagen_0001 sakuma-0023_Pаgina_25_Imagen_0001 sakuma-0023_Pаgina_26_Imagen_0001 sakuma-0023_Pаgina_27_Imagen_0001 sakuma-0023_Pаgina_29_Imagen_0001 sakuma-0024_Pаgina_01_Imagen_0001 sakuma-0024_Pаgina_02_Imagen_0001 sakuma-0024_Pаgina_03_Imagen_0001 sakuma-0024_Pаgina_05_Imagen_0001 sakuma-0024_Pаgina_08_Imagen_0001 sakuma-0024_Pаgina_09_Imagen_0001 sakuma-0024_Pаgina_11_Imagen_0001 sakuma-0024_Pаgina_15_Imagen_0001 sakuma-0024_Pаgina_18_Imagen_0001 sakuma-0024_Pаgina_19_Imagen_0001 sakuma-0024_Pаgina_23_Imagen_0001 sakuma-0025_Pаgina_01_Imagen_0001 sakuma-0025_Pаgina_06_Imagen_0001 sakuma-0026_Pаgina_01_Imagen_0001 sakuma-0026_Pаgina_02_Imagen_0001 sakuma-0026_Pаgina_03_Imagen_0001 sakuma-0026_Pаgina_04_Imagen_0001 sakuma-0026_Pаgina_05_Imagen_0001 sakuma-0026_Pаgina_06_Imagen_0001 sakuma-0026_Pаgina_08_Imagen_0001 sakuma-0026_Pаgina_09_Imagen_0001 sakuma-0026_Pаgina_10_Imagen_0001 sakuma-0026_Pаgina_11_Imagen_0001 sakuma-0026_Pаgina_12_Imagen_0001 sakuma-0026_Pаgina_13_Imagen_0001 sakuma-0026_Pаgina_14_Imagen_0001 sakuma-0026_Pаgina_15_Imagen_0001 sakuma-0026_Pаgina_16_Imagen_0001 sakuma-0026_Pаgina_18_Imagen_0001 sakuma-0026_Pаgina_19_Imagen_0001 sakuma-0026_Pаgina_20_Imagen_0001 sakuma-0026_Pаgina_21_Imagen_0001 sakuma-0026_Pаgina_22_Imagen_0001 sakuma-0026_Pаgina_23_Imagen_0001 sakuma-0026_Pаgina_24_Imagen_0001 sakuma-0026_Pаgina_25_Imagen_0001 sakuma-0026_Pаgina_26_Imagen_0001 sakuma-0026_Pаgina_27_Imagen_0001 sakuma-0026_Pаgina_28_Imagen_0001 sakuma-0026_Pаgina_29_Imagen_0001 sakuma-0026_Pаgina_30_Imagen_0001 sakuma-0026_Pаgina_31_Imagen_0001 sakuma-0027_Pаgina_01_Imagen_0001 sakuma-0027_Pаgina_03_Imagen_0001 sakuma-0027_Pаgina_06_Imagen_0001 sakuma-0027_Pаgina_07_Imagen_0001 sakuma-0027_Pаgina_08_Imagen_0001 sakuma-0027_Pаgina_09_Imagen_0001 sakuma-0027_Pаgina_10_Imagen_0001 sakuma-0027_Pаgina_11_Imagen_0001 sakuma-0027_Pаgina_13_Imagen_0001 sakuma-0027_Pаgina_14_Imagen_0001 sakuma-0027_Pаgina_16_Imagen_0001 sakuma-0027_Pаgina_17_Imagen_0001 sakuma-0027_Pаgina_18_Imagen_0001 sakuma-0027_Pаgina_19_Imagen_0001 sakuma-0027_Pаgina_22_Imagen_0001 sakuma-0027_Pаgina_23_Imagen_0001 sakuma-0027_Pаgina_24_Imagen_0001 sakuma-0027_Pаgina_25_Imagen_0001 sakuma-0027_Pаgina_26_Imagen_0001 sakuma-0027_Pаgina_27_Imagen_0001 sakuma-0027_Pаgina_28_Imagen_0001 sakuma-0027_Pаgina_29_Imagen_0001 sakuma-0027_Pаgina_30_Imagen_0001 sakuma-0027_Pаgina_32_Imagen_0001 sakuma-0027_Pаgina_33_Imagen_0001 sakuma-0028_Pаgina_01_Imagen_0001 sakuma-0028_Pаgina_03_Imagen_0001 sakuma-0028_Pаgina_04_Imagen_0001 sakuma-0028_Pаgina_05_Imagen_0001 sakuma-0028_Pаgina_07_Imagen_0001 sakuma-0028_Pаgina_08_Imagen_0001 sakuma-0028_Pаgina_10_Imagen_0001 sakuma-0028_Pаgina_11_Imagen_0001 sakuma-0028_Pаgina_14_Imagen_0001 sakuma-0028_Pаgina_15_Imagen_0001 sakuma-0028_Pаgina_17_Imagen_0001 sakuma-0028_Pаgina_18_Imagen_0001 sakuma-0029_Pаgina_01_Imagen_0001 sakuma-0029_Pаgina_03_Imagen_0001 sakuma-0029_Pаgina_04_Imagen_0001 sakuma-0029_Pаgina_05_Imagen_0001 sakuma-0029_Pаgina_07_Imagen_0001 sakuma-0029_Pаgina_08_Imagen_0001 sakuma-0029_Pаgina_10_Imagen_0001 sakuma-0029_Pаgina_11_Imagen_0001 sakuma-0031_Pаgina_01_Imagen_0001 sakuma-0031_Pаgina_02_Imagen_0001 sakuma-0031_Pаgina_05_Imagen_0001 sakuma-0031_Pаgina_11_Imagen_0001 sakuma-0031_Pаgina_13_Imagen_0001 sakuma-0031_Pаgina_14_Imagen_0001 sakuma-0031_Pаgina_17_Imagen_0001 sakuma-0031_Pаgina_20_Imagen_0001 sakuma-0031_Pаgina_22_Imagen_0001 sakuma-0031_Pаgina_23_Imagen_0001 sakuma-0032_Pаgina_01_Imagen_0001 sakuma-0032_Pаgina_02_Imagen_0001 sakuma-0032_Pаgina_05_Imagen_0001 sakuma-0032_Pаgina_07_Imagen_0001 sakuma-0032_Pаgina_09_Imagen_0001 sakuma-0032_Pаgina_17_Imagen_0001 sakuma-0032_Pаgina_19_Imagen_0001 sakuma-0032_Pаgina_23_Imagen_0001 sakuma-0032_Pаgina_25_Imagen_0001 sakuma-0032_Pаgina_27_Imagen_0001 sakuma-0032_Pаgina_28_Imagen_0001 sakuma-0033_Pаgina_01_Imagen_0001 sakuma-0033_Pаgina_02_Imagen_0001 sakuma-0033_Pаgina_05_Imagen_0001 sakuma-0033_Pаgina_06_Imagen_0001 sakuma-0033_Pаgina_07_Imagen_0001 sakuma-0033_Pаgina_09_Imagen_0001 sakuma-0033_Pаgina_10_Imagen_0001 sakuma-0033_Pаgina_12_Imagen_0001 sakuma-0033_Pаgina_14_Imagen_0001 sakuma-0033_Pаgina_17_Imagen_0001 sakuma-0033_Pаgina_18_Imagen_0001 sakuma-0033_Pаgina_23_Imagen_0001 sakuma-0033_Pаgina_26_Imagen_0001 sakuma-0033_Pаgina_29_Imagen_0001 sakuma-0033_Pаgina_31_Imagen_0001 sakuma-0034_Pаgina_02_Imagen_0001 sakuma-0034_Pаgina_03_Imagen_0001 sakuma-0034_Pаgina_04_Imagen_0001 sakuma-0034_Pаgina_05_Imagen_0001 sakuma-0034_Pаgina_06_Imagen_0001 sakuma-0034_Pаgina_07_Imagen_0001 sakuma-0034_Pаgina_08_Imagen_0001 sakuma-0034_Pаgina_09_Imagen_0001 sakuma-0034_Pаgina_10_Imagen_0001 sakuma-0034_Pаgina_11_Imagen_0001 sakuma-0034_Pаgina_12_Imagen_0001 sakuma-0034_Pаgina_13_Imagen_0001 sakuma-0034_Pаgina_14_Imagen_0001 sakuma-0034_Pаgina_15_Imagen_0001 sakuma-0034_Pаgina_16_Imagen_0001 sakuma-0034_Pаgina_17_Imagen_0001 sakuma-0034_Pаgina_18_Imagen_0001 sakuma-0034_Pаgina_19_Imagen_0001 sakuma-0034_Pаgina_20_Imagen_0001 sakuma-0034_Pаgina_21_Imagen_0001 sakuma-0034_Pаgina_22_Imagen_0001 sakuma-0034_Pаgina_23_Imagen_0001 sakuma-0034_Pаgina_24_Imagen_0001 sakuma-0034_Pаgina_25_Imagen_0001 sakuma-0034_Pаgina_26_Imagen_0001 sakuma-0034_Pаgina_27_Imagen_0001 sakuma-0034_Pаgina_28_Imagen_0001 sakuma-0034_Pаgina_29_Imagen_0001 sakuma-0034_Pаgina_30_Imagen_0001 sakuma-0034_Pаgina_31_Imagen_0001 sakuma-0034_Pаgina_32_Imagen_0001 sakuma-0034_Pаgina_33_Imagen_0001 sakuma-0034_Pаgina_34_Imagen_0001 sakuma-0034_Pаgina_36_Imagen_0001 sakuma-0034_Pаgina_37_Imagen_0001 sakuma-0035_Pаgina_01_Imagen_0001 sakuma-0035_Pаgina_03_Imagen_0001 sakuma-0035_Pаgina_04_Imagen_0001 sakuma-0035_Pаgina_06_Imagen_0001 sakuma-0035_Pаgina_07_Imagen_0001 sakuma-0035_Pаgina_09_Imagen_0001 sakuma-0035_Pаgina_11_Imagen_0001 sakuma-0035_Pаgina_14_Imagen_0001 sakuma-0035_Pаgina_16_Imagen_0001 sakuma-0035_Pаgina_18_Imagen_0001 sakuma-0035_Pаgina_20_Imagen_0001 sakuma-0035_Pаgina_21_Imagen_0001 sakuma-0035_Pаgina_23_Imagen_0001 sakuma-0035_Pаgina_24_Imagen_0001 sakuma-0035_Pаgina_26_Imagen_0001 sakuma-0035_Pаgina_28_Imagen_0001 sakuma-0035_Pаgina_30_Imagen_0001 sakuma-0035_Pаgina_33_Imagen_0001 sakuma-0035_Pаgina_35_Imagen_0001 sakuma-0035_Pаgina_36_Imagen_0001 sakuma-0036_Pаgina_01_Imagen_0001 sakuma-0036_Pаgina_02_Imagen_0001 sakuma-0036_Pаgina_03_Imagen_0001 sakuma-0036_Pаgina_06_Imagen_0001 sakuma-0036_Pаgina_07_Imagen_0001 sakuma-0036_Pаgina_09_Imagen_0001 sakuma-0036_Pаgina_10_Imagen_0001 sakuma-0036_Pаgina_11_Imagen_0001 sakuma-0036_Pаgina_12_Imagen_0001 sakuma-0036_Pаgina_13_Imagen_0001 sakuma-0036_Pаgina_14_Imagen_0001 sakuma-0036_Pаgina_16_Imagen_0001 sakuma-0036_Pаgina_18_Imagen_0001 sakuma-0036_Pаgina_20_Imagen_0001 sakuma-0036_Pаgina_23_Imagen_0001 sakuma-0036_Pаgina_24_Imagen_0001 sakuma-0036_Pаgina_25_Imagen_0001 sakuma-0036_Pаgina_26_Imagen_0001 sakuma-0036_Pаgina_28_Imagen_0001 sakuma-0036_Pаgina_29_Imagen_0001 sakuma-0036_Pаgina_30_Imagen_0001 sakuma-0036_Pаgina_31_Imagen_0001 sakuma-0036_Pаgina_32_Imagen_0001 sakuma-0036_Pаgina_33_Imagen_0001 sakuma-0036_Pаgina_34_Imagen_0001 sakuma-0037_Pаgina_01_Imagen_0001 sakuma-0037_Pаgina_02_Imagen_0001 sakuma-0037_Pаgina_04_Imagen_0001 sakuma-0037_Pаgina_07_Imagen_0001 sakuma-0037_Pаgina_08_Imagen_0001 sakuma-0037_Pаgina_10_Imagen_0001 sakuma-0037_Pаgina_11_Imagen_0001 sakuma-0037_Pаgina_12_Imagen_0001 sakuma-0037_Pаgina_13_Imagen_0001 sakuma-0037_Pаgina_15_Imagen_0001 sakuma-0037_Pаgina_16_Imagen_0001 sakuma-0037_Pаgina_17_Imagen_0001 sakuma-0037_Pаgina_19_Imagen_0001 sakuma-0037_Pаgina_20_Imagen_0001 sakuma-0037_Pаgina_21_Imagen_0001 sakuma-0037_Pаgina_23_Imagen_0001 sakuma-0037_Pаgina_24_Imagen_0001 sakuma-0037_Pаgina_25_Imagen_0001"

if [[ $classifTrain = 1 ]];then
	# Model Training

	source activate FastAI

	START=$(date +%s)

	echo "Let's training!!!"
	echo 

	cd $codeDir

	#echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$file " >> $summaryDir"method"$method"classification.txt"

	python fastaiWasan.py $codeDir"/minidata/" "Model"$modelName"-"$epoch"-"$learningRate $modelName t $epoch $learningRate >> $fastaiResultDir$modelName"-"$epoch"-"$learningRate"TrainResult.txt" 2>$fastaiResultDir"trainErrorOutput.txt"

	END=$(date +%s)
	DIFF=$(( $END - $START ))

	echo "@Classif Time: $DIFF" 
	echo -n "$DIFF" >> $fastaiResultDir"timeSummaryB.txt"

	conda deactivate

fi

#Loop over all files
for file in $fileList
   do
	echo "*********************************************************************Starting file $file"
	date

	# Here choose one blob detector method or loop over all of them
	for method in $chosenMethod 
	#for method in 0 1 2 3 
	do
		cd $dataDir
		#ls
		echo -n "$file " >> $summaryDir"method"$method"timeSummary.txt"
		echo -n "$file " >> $summaryDir"method"$method"timeSummaryB.txt"
		echo -n "$file " >> $summaryDir"method"$method"textOutput.txt"
		echo -n "$file " >> $summaryDir"method"$method"classification.txt"

		PATCHESDir=$dataDir"/"$file"method"$method"OUT.jpgPATCHES/"

		if [[ $detect = 1 ]];then
			#Activate python3 environment
			source activate wasan3

			#first degree correction, parameters:
			python $codeDir/degree.py $file".tif" 60 50 1000 15 
			# "degree, reads the original image and outputs a rotation of the NOISE REMOVED IMAGE"

			echo "Kanji detection for file $file and method $method"
			START=$(date +%s)

			echo "doing it"
			#parameters: min_sigma max_sigma num_sigma threshold overlap
			python $codeDir/blobDetector3.py "CO"$file".tif" $file"method"$method"OUT.jpg" $method 40 50 1 .01 .1 "KP"$file".tif" >> $summaryDir"method"$method"textOutput.txt" #2>$summaryDir/$file"method"$method"errorOutput.txt"
		
			mv $file"method"$method"OUT.jpg" $summaryDir$file"method"$method"OUT.jpg"
			mv $file"method"$method"OUTPOSITIONS.txt" $summaryDir$file"method"$method"OUTPOSITIONS.txt"
			mv $file"method"$method"OUTPATH.txt" $PATCHESDir$file"method"$method"OUTPATH.txt"
			conda deactivate

			END=$(date +%s)
			DIFF=$(( $END - $START ))

			echo "@Kanji Time: $DIFF" 
			echo -n "$DIFF" >> $summaryDir"method"$method"timeSummary.txt"
		fi

		if [[ $classifPredict = 1 ]];then
			# now classify all detected kanji
	
			source activate FastAI

			START=$(date +%s)

			echo "Kanji classification for file $file"
			echo 
		
			cd $codeDir
		
			echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$file " >> $summaryDir"method"$method"classification.txt"

			python fastaiWasan.py $codeDir"/minidata/" "Model"$modelName"-"$epoch"-"$learningRate $modelName p $PATCHESDir$file"method"$method"OUTPATH.txt" $fastaiResultDir$file"method"$method"classification.txt"  >> $fastaiResultDir$file"method"$method"Prediction.txt" 2>$fastaiResultDir$file"method"$method"errorOutput.txt"
			#python classify.py $kanjiFiles >> $summaryDir$file"method"$method"classification.txt" 2>$summaryDir/$file"method"$method"errorOutput.txt"

			END=$(date +%s)
			DIFF=$(( $END - $START ))

			echo "@Classif Time: $DIFF" 
			echo -n "$DIFF" >> $summaryDir"method"$method"timeSummaryB.txt"
		
			conda deactivate

		fi		

		if [[ $combine = 1 ]];then
			#Activate python3 environment
			source activate wasan3

			echo "Nothing done yet"
            positionFile=$summaryDir$file"method"$method"OUTPOSITIONS.txt"
            classifFile=$summaryDir$file"method"$method"classification.txt"

			# file position_class_combine.py writes the desired output (mixing of the first to files in the parameter list into the third file in the parameter list: $summaryDir/$file"method"$method"position_class.txt"
			python $codeDir/position_class_combine1.py $positionFile $classifFile $summaryDir$file"method"$method"position_class.txt"
			
			conda deactivate

		fi

		if [[ $imshow = 1 ]];then
			#Activate python3 environment
			source activate wasan3

			echo "Nothing done yet"

			python $codeDir/image-show.py 1 $summaryDir$file"method"$method"position_class.txt" $summaryDir"ima_image" $summaryDir"not_ima_image" $summaryDir"ima_image/ima_image.txt" $summaryDir"not_ima_image/not_ima_image.txt" $summaryDir"/summaryFile.txt"

			conda deactivate

		fi

		if [[ $evaluate = 1 ]];then
			#Activate python3 environment
			source activate wasan3

			#first degree correction, parameters:
			python $codeDir/degree.py $file".tif" 60 50 1000 15 

			echo "doing it"
			python $codeDir/wasanDice.py "CO"$file".tif" $method $summaryDir"AllKanjiPositionTest/KP"$file $summaryDir"AllKanjiPositionAN/KP"$file"AN.jpg" $bookNumber #>> $summaryDir"method"$method"textOutput.txt" #2>$summaryDir/$file"method"$method"errorOutput.txt"
			bookNumber=$((bookNumber + 1))
			conda deactivate

		fi

		echo "" >> $summaryDir"method"$method"timeSummary.txt"
		echo "" >> $summaryDir"method"$method"timeSummaryB.txt"

		rm -f $summaryDir$file"method"$method"errorOutput.txt"
		#rm -rf $dataDir/$file"method"$method"OUT.jpgPATCHES"

	done	
done	


cd $currentDir