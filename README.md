# wasan
和算図形の特徴抽出の為の前処理

## 開発環境
macOS
python 3.6  
numpy 1.14.5  
cv2 3.4.2  
scipy 1.10  

## コードの使用例

1. wasanPageClassificatiion.py  
１冊のPDFファイルをページ毎に分類し、必要なページと不必要なページに分類できます。

2. pdf-png-all.py  
1で分類したPDFファイルをPNG形式に変えます。

3. preprocessing.py  
４での直線検出の精度を高めるために、膨張収縮処理を施します。

4. degree1.py  
ハフ変換とその他の工夫で検出した直線によって、ページの角度を調整できます。
これには４つのパラメータが必要です。  
minLineLength・・・検出する直線の最小の長さを表し、この値より短い線分は検出されなくなります。  
maxLineGap・・・二つの線分を一つの直線とみなす時に許容される最大の長さを表す。この値より小さいギャップを持つ二本の直線は一つの直線とみなされます。  
maxGapToLinkLines・・・特に長い直線を検出するために設定します。　　
verticalTol・・・どこまでを縦線とみなすかを決める値になり、数値を大きくすればするほど、斜めや横の線を検出する様になります。  

## 引用したコード

1. blobDetector.py  
4つの異なる方法で漢字の検出をします。以下引用元  
https://github.com/TheLaueLab/blob-detection

2. classify.py  
CNNを用いて和算の漢字を分類します。以下引用元  
https://github.com/KyotoSunshine/CNN-for-handwritten-kanji
