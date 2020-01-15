#!/bin/bash
currentDir=$(pwd)

codeDir=$1
dataDir=$2
whatToDo=$3 #options: d, detect, c, classify
chosenMethod=$4 # Blob detector method

summaryDir=$dataDir"/summary/"
timeSummaryFile=$summaryDir"timeSummary.txt"

detect=0
classif=0
evaluate=0
imshow=0
if [[ $whatToDo == *"d"* ]]; then
detect=1
fi
if [[ $whatToDo == *"c"* ]]; then
classif=1
fi
if [[ $whatToDo == *"c"* ]]; then
combine=1
fi
if [[ $whatToDo == *"i"* ]]; then
imshow=1
fi

echo "Chosen Method $chosenMethod"
fileList="sakuma-0001_Pаgina_02_Imagen_0001 sakuma-0001_Pаgina_05_Imagen_0001 sakuma-0001_Pаgina_08_Imagen_0001 sakuma-0001_Pаgina_14_Imagen_0001 sakuma-0001_Pаgina_15_Imagen_0001 sakuma-0001_Pаgina_17_Imagen_0001 sakuma-0001_Pаgina_19_Imagen_0001 sakuma-0001_Pаgina_21_Imagen_0001 sakuma-0001_Pаgina_22_Imagen_0001 sakuma-0001_Pаgina_23_Imagen_0001 sakuma-0001_Pаgina_24_Imagen_0001 sakuma-0001_Pаgina_25_Imagen_0001 sakuma-0001_Pаgina_26_Imagen_0001 sakuma-0001_Pаgina_27_Imagen_0001 sakuma-0001_Pаgina_29_Imagen_0001 sakuma-0001_Pаgina_30_Imagen_0001 sakuma-0001_Pаgina_31_Imagen_0001 sakuma-0001_Pаgina_32_Imagen_0001 sakuma-0001_Pаgina_34_Imagen_0001 sakuma-0001_Pаgina_35_Imagen_0001 sakuma-0002_Pаgina_03_Imagen_0001 sakuma-0002_Pаgina_06_Imagen_0001 sakuma-0002_Pаgina_07_Imagen_0001 sakuma-0002_Pаgina_10_Imagen_0001 sakuma-0002_Pаgina_11_Imagen_0001 sakuma-0002_Pаgina_12_Imagen_0001 sakuma-0002_Pаgina_13_Imagen_0001 sakuma-0002_Pаgina_14_Imagen_0001 sakuma-0002_Pаgina_15_Imagen_0001 sakuma-0002_Pаgina_16_Imagen_0001 sakuma-0002_Pаgina_17_Imagen_0001 sakuma-0002_Pаgina_19_Imagen_0001 sakuma-0002_Pаgina_20_Imagen_0001 sakuma-0002_Pаgina_21_Imagen_0001 sakuma-0002_Pаgina_23_Imagen_0001 sakuma-0002_Pаgina_28_Imagen_0001 sakuma-0002_Pаgina_29_Imagen_0001 sakuma-0003_Pаgina_43_Imagen_0001 sakuma-0004_Pаgina_02_Imagen_0001 sakuma-0004_Pаgina_03_Imagen_0001 sakuma-0004_Pаgina_09_Imagen_0001 sakuma-0004_Pаgina_13_Imagen_0001 sakuma-0004_Pаgina_29_Imagen_0001 sakuma-0005_Pаgina_08_Imagen_0001 sakuma-0005_Pаgina_09_Imagen_0001 sakuma-0005_Pаgina_11_Imagen_0001 sakuma-0005_Pаgina_12_Imagen_0001 sakuma-0005_Pаgina_14_Imagen_0001 sakuma-0005_Pаgina_16_Imagen_0001 sakuma-0005_Pаgina_18_Imagen_0001 sakuma-0005_Pаgina_19_Imagen_0001 sakuma-0006_Pаgina_03_Imagen_0001 sakuma-0006_Pаgina_04_Imagen_0001 sakuma-0006_Pаgina_06_Imagen_0001 sakuma-0006_Pаgina_07_Imagen_0001 sakuma-0006_Pаgina_09_Imagen_0001 sakuma-0006_Pаgina_10_Imagen_0001 sakuma-0006_Pаgina_11_Imagen_0001 sakuma-0006_Pаgina_12_Imagen_0001 sakuma-0006_Pаgina_13_Imagen_0001 sakuma-0006_Pаgina_14_Imagen_0001 sakuma-0006_Pаgina_15_Imagen_0001 sakuma-0006_Pаgina_16_Imagen_0001 sakuma-0006_Pаgina_17_Imagen_0001 sakuma-0006_Pаgina_19_Imagen_0001 sakuma-0006_Pаgina_21_Imagen_0001 sakuma-0006_Pаgina_23_Imagen_0001 sakuma-0006_Pаgina_24_Imagen_0001 sakuma-0006_Pаgina_25_Imagen_0001 sakuma-0009_Pаgina_03_Imagen_0001 sakuma-0009_Pаgina_04_Imagen_0001 sakuma-0009_Pаgina_06_Imagen_0001 sakuma-0009_Pаgina_14_Imagen_0001 sakuma-0010_Pаgina_11_Imagen_0001 sakuma-0011_Pаgina_12_Imagen_0001 sakuma-0011_Pаgina_14_Imagen_0001 sakuma-0011_Pаgina_16_Imagen_0001 sakuma-0011_Pаgina_17_Imagen_0001 sakuma-0011_Pаgina_18_Imagen_0001 sakuma-0011_Pаgina_21_Imagen_0001 sakuma-0011_Pаgina_26_Imagen_0001 sakuma-0011_Pаgina_27_Imagen_0001 sakuma-0011_Pаgina_29_Imagen_0001 sakuma-0012_Pаgina_02_Imagen_0001 sakuma-0012_Pаgina_10_Imagen_0001 sakuma-0012_Pаgina_13_Imagen_0001 sakuma-0012_Pаgina_15_Imagen_0001 sakuma-0013_Pаgina_03_Imagen_0001 sakuma-0013_Pаgina_05_Imagen_0001 sakuma-0013_Pаgina_06_Imagen_0001 sakuma-0013_Pаgina_07_Imagen_0001 sakuma-0013_Pаgina_08_Imagen_0001 sakuma-0013_Pаgina_09_Imagen_0001 sakuma-0013_Pаgina_10_Imagen_0001 sakuma-0013_Pаgina_11_Imagen_0001 sakuma-0013_Pаgina_12_Imagen_0001 sakuma-0013_Pаgina_13_Imagen_0001 sakuma-0013_Pаgina_14_Imagen_0001 sakuma-0013_Pаgina_15_Imagen_0001 sakuma-0013_Pаgina_16_Imagen_0001"

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
		echo -n "$file " >> $summaryDir"method"$method"timeSummary.txt"
		echo -n "$file " >> $summaryDir"method"$method"timeSummaryB.txt"
		echo -n "$file " >> $summaryDir"method"$method"textOutput.txt"
		echo -n "$file " >> $summaryDir/"method"$method"classification.txt"

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
			python $codeDir/BlobDetector.py "CO"$file".tif" $file"method"$method"OUT.jpg" $method 40 50 1 .01 .1 "KP"$file".tif" >> $summaryDir"method"$method"textOutput.txt" #2>$summaryDir/$file"method"$method"errorOutput.txt"
		
			mv $file"method"$method"OUT.jpg" $summaryDir$file"method"$method"OUT.jpg"
			mv $file"method"$method"OUTPOSITIONS.txt" $summaryDir$file"method"$method"OUTPOSITIONS.txt"
			conda deactivate

			END=$(date +%s)
			DIFF=$(( $END - $START ))

			echo "@Kanji Time: $DIFF" 
			echo -n "$DIFF" >> $summaryDir"method"$method"timeSummary.txt"
		fi


		if [[ $classif = 1 ]];then

			# now classify all detected kanji

			cd $dataDir/$file"method"$method"OUT.jpgPATCHES"
		
			kanjiFiles=$(ls -d -1 $PWD/*.*)
	
			source activate wasan2

			START=$(date +%s)

			echo "Kanji classification for file $file"
			echo 
		
			cd $codeDir"/classify"
		
			echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$file " >> $summaryDir"method"$method"classification.txt"

			python classify.py $kanjiFiles >> $summaryDir$file"method"$method"classification.txt" 2>$summaryDir/$file"method"$method"errorOutput.txt"


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

		echo "" >> $summaryDir"method"$method"timeSummary.txt"
		echo "" >> $summaryDir"method"$method"timeSummaryB.txt"

		rm -f $summaryDir$file"method"$method"errorOutput.txt"

	done	
done	


cd $currentDir
