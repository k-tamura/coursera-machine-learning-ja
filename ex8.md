# プログラミング演習8: 異常検出とレコメンダー・システム

機械学習

## はじめに

この演習では、異常検出アルゴリズムを実装し、それを適用してネットワーク上の障害のあるサーバーを検出します。
2番目のパートでは、協調フィルタリングを使用して映画のレコメンダー・システムを構築します。
プログラミング演習を始める前に、ビデオ講義を見て、関連トピックのレビュー質問を完了することを強くお勧めします。

演習を開始するには、スターター・コードをダウンロードし、演習を終了するディレクトリーにその内容を解凍する必要があります。
必要に応じて、この演習を開始する前にOctave/MATLABの`cd`コマンドを使用してこのディレクトリーに移動してください。

また、コースウェブサイトの「環境設定手順」にOctave/MATLABをインストールするための手順も記載されています。

## この演習に含まれるファイル

 - `ex8.m` - 演習の最初のパートのためのOctave/MATLABスクリプト
 - `ex8_cofi.m` - 演習の2番目のパートのためのOctave/MATLABスクリプト
 - `ex8data1.mat` - 最初のサンプルの異常検出のデータセット
 - `ex8data2.mat` - 2番目のサンプルの異常検出のデータセット
 - `ex8_movies.mat` - 映画のレビューのデータセット
 - `ex8_movieParams.mat` - デバッグ用に提供されるパラメーター
 - `multivariateGaussian.m` - ガウス分布の確率密度関数を計算する
 - `visualizeFit.m` - ガウス分布とデータセットを2次元にプロットする
 - `checkCostFunction.m` - 協調フィルタリングの勾配をチェックする
 - `computeNumericalGradient.m` - 数値的に勾配を計算する
 - `fmincg.m` - 関数最小化ルーチン（fminuncと同様）
 - `loadMovieList.m` - 映画のリストをセル配列にロードする
 - `movie_ids.txt` - 映画のリスト
 - `normalizeRatings.m` - 協調フィルタリングを平均正規化する
 - `submit.m` - 解答を我々のサーバーに送信するスクリプト
 - [\*] `estimateGaussian.m` - 対角共分散行列を持つガウス分布のパラメーターを推定する
 - [\*] `selectThreshold.m` - 異常検出の閾値を見つける
 - [\*] `cofiCostFunc.m` - 協調フィルタリングのためのコスト関数を実装する
 
 \* はあなたが完了する必要があるものを示しています。

演習の最初のパート（異常検出）では、`ex8.m`スクリプトを使用します。
2番目のパート（協調フィルタリング）では、`ex8_cofi.m`を使用します。
これらのスクリプトは、問題に対するデータセットをセットアップし、あなたが実装する関数を呼び出します。
こららのスクリプトを変更する必要はありません。
この課題の指示に従って、他のファイルの関数を変更することだけが求められています。

### 助けを得る場所

このコースの演習では、数値計算に適した高度なプログラミング言語であるOctave（※1）またはMATLABを使用します。
OctaveまたはMATLABがインストールされていない場合は、コースWebサイトのEnvironment Setup Instructionsのインストール手順を参照してください。

Octave/MATLABコマンドラインでは、`help`の後に関数名を入力すると、組み込み関数のドキュメントが表示されます。
たとえば、`help plot`はプロットのヘルプ情報を表示します。
Octave関数の詳細のドキュメントは、[Octaveのドキュメントページ](www.gnu.org/software/octave/doc/interpreter/)にあります。
MATLABのドキュメントは、[MATLABのドキュメントページ](http://jp.mathworks.com/help/matlab/?refresh=true)にあります。

また、オンライン・ディスカッションを使用して、他の学生との演習について話し合うことを強く推奨します。
しかし、他人が書いたソースコードを見たり、他の人とソースコードを共有したりしないでください。

※1：Octaveは、MATLABの無料の代替ソフトウェアです。
プログラミング演習は、OctaveとMATLABのどちらでも使用できます。

## 1. 異常検出

この演習では、異常検出アルゴリズムを実装して、サーバー・コンピューターの異常動作を検出します。
フィーチャーは、各サーバーのレスポンスのスループット（mb/s）と待ち時間（ms）です。
あなたは、サーバーが稼動している間に<img src="https://latex.codecogs.com/gif.latex?\inline&space;m&space;=&space;307" title="m = 307" />個のサンプルを収集しており、ラベルなしのデータセット<img src="https://latex.codecogs.com/gif.latex?\inline&space;\left&space;\{&space;x^{(1)},&space;...,&space;x^{(m)}&space;\right&space;\}" title="\left \{ x^{(1)}, ..., x^{(m)} \right \}" />を持っています。
これらのサンプルの大部分は、正常に動作するサーバーの「正常」な（異常ではない）サンプルですが、このデータセット内に異常な動作をするサーバーのサンプルもいくつか存在する可能性があります。

ガウスモデルを使用して、データセット内の異常なサンプルを検出します。
最初に、アルゴリズムが何をしているのかを可視化できる2Dのデータセットを表示することから始めます。
このデータセットにガウス分布を適合し、確率が非常に低い（それ故に異常と見なすことができる）値を見つけます。
その後、より大きな多次元のデータセットに異常検出アルゴリズムを適用します。
演習のこのパートでは、`ex8.m`を使用します。

`ex8.m`の最初のパートは、図1に示すようにデータセットを可視化します。

![図1：最初のデータセット](images/ex8/ex8-F1.png)

&nbsp;&ensp;&nbsp;&ensp; 図1：最初のデータセット

### 1.1. ガウス分布

異常検出を実行するには、まずデータの分布にモデルを適合させる必要があります。

与えられたトレーニング・セット<img src="https://latex.codecogs.com/gif.latex?\inline&space;\left&space;\{&space;x^{(1)},&space;...,&space;x^{(m)}&space;\right&space;\}" title="\left \{ x^{(1)}, ..., x^{(m)} \right \}" />（ここで、<img src="https://latex.codecogs.com/gif.latex?\inline&space;x^{(i)}&space;\in&space;\mathbb{R}^{n}" title="x^{(i)} \in \mathbb{R}^{n}" />）に対して、各フィーチャー<img src="https://latex.codecogs.com/gif.latex?\inline&space;x^{(i)}" title="x^{(i)}" />のガウス分布を推定する必要があります。
<img src="https://latex.codecogs.com/gif.latex?\inline&space;i&space;=&space;1,&space;...,&space;n" title="i = 1, ..., n" />の各フィーチャーに対して、<img src="https://latex.codecogs.com/gif.latex?\inline&space;i" title="i" />番目の次元<img src="https://latex.codecogs.com/gif.latex?\inline&space;\left&space;\{&space;x_{i}^{(1)},&space;...,&space;x_{i}^{(m)}&space;\right&space;\}" title="\left \{ x_{i}^{(1)}, ..., x_{i}^{(m)} \right \}" />（各サンプルの<img src="https://latex.codecogs.com/gif.latex?\inline&space;i" title="i" />番目の次元）のデータに適合するパラメーター<img src="https://latex.codecogs.com/gif.latex?\inline&space;\mu&space;_{i}" title="\mu _{i}" />と<img src="https://latex.codecogs.com/gif.latex?\inline&space;\sigma_{i}^{2}" title="\sigma_{i}^{2}" />を見つける必要があります。

ガウス分布は、以下の式で与えられます。

![式1](images/ex8/ex8-NF1.png)

ここで、<img src="https://latex.codecogs.com/gif.latex?\inline&space;\mu" title="\mu" />は平均値、<img src="https://latex.codecogs.com/gif.latex?\inline&space;\sigma^{2}" title="\sigma^{2}" />は分散を制御します。

### 1.2. ガウス分布のパラメーターの推定

次の式を使用して、<img src="https://latex.codecogs.com/gif.latex?\inline&space;i" title="i" />番目のフィーチャーのパラメーター(<img src="https://latex.codecogs.com/gif.latex?\inline&space;\mu&space;_{i}" title="\mu _{i}" />, <img src="https://latex.codecogs.com/gif.latex?\inline&space;\sigma&space;^{2}" title="\sigma ^{2}" />)を推定することができます。
平均を推定するには、次を使用し、

![式2](images/ex8/ex8-NF2.png)

分散に対しては、次を使用します。

![式3](images/ex8/ex8-NF3.png)

あなたがすべきことは、`estimateGaussian.m`のコードを完成させることです。
この関数は、データ行列`X`を入力として受け取り、<img src="https://latex.codecogs.com/gif.latex?\inline&space;n" title="n" />個のフィーチャーのすべての平均を保持する<img src="https://latex.codecogs.com/gif.latex?\inline&space;n" title="n" />次元ベクトル`mu`と、すべてのフィーチャーの分散を保持する別の<img src="https://latex.codecogs.com/gif.latex?\inline&space;n" title="n" />次元ベクトル`sigma2`を出力として返す必要があります。
すべてのフィーチャーとすべてのトレーニング・サンプルに対するforループを使用して、実装することができます。
ベクトル化された実装はより効率的かもしれませんが、そうしなくてもかまいません。
Octave/MATLABの`var`関数のデフォルトでは、<img src="https://latex.codecogs.com/gif.latex?\inline&space;\sigma_{i}^{2}" title="\sigma_{i}^{2}" />を計算するときに<img src="https://latex.codecogs.com/gif.latex?\inline&space;\frac{1}{m}" title="\frac{1}{m}" />ではなく、<img src="https://latex.codecogs.com/gif.latex?\inline&space;\frac{1}{m&space;-&space;1}" title="\frac{1}{m - 1}" />を使用することに注意してください。
 
`estimateGaussian.m`のコードを完成させると、`ex8.m`の次のパートでは、フィットしたガウス分布の輪郭が可視化され、図2のようなプロットが得られるはずです。
プロットから、ほとんどのサンプルは確率の最も高い領域にあり、異常なサンプルは確率の低い領域にあることが分かります。

*ここで解答を提出する必要があります。*

![図2：データセットにフィットする分布のガウス分布の等高線](images/ex8/ex8-F2.png)

&nbsp;&ensp;&nbsp;&ensp; 図2：データセットにフィットする分布のガウス分布の等高線

### 1.3. 閾値<img src="https://latex.codecogs.com/gif.latex?\inline&space;\varepsilon" title="\varepsilon" />を選択する

ガウス分布のパラメーターを推定したので、どの分布のサンプルが非常に高い確率であり、どの分布が非常に低い確率であるかを調べることができます。
低確率のサンプルは、データセットの中で異常である可能性が高いです。
どのサンプルが異常であるかを判断する1つの方法は、クロス・バリデーション・セットをもとに閾値を選択することです。
演習のこのパートでは、クロス・バリデーション・セットに<img src="https://latex.codecogs.com/gif.latex?\inline&space;F_{1}" title="F_{1}" />スコアを使用して、閾値<img src="https://latex.codecogs.com/gif.latex?\inline&space;\varepsilon" title="\varepsilon" />を選択するアルゴリズムを実装します。

ここで、`selectThreshold.m`のコードを完成させる必要があります。
このために、クロス・バリデーション・セット<img src="https://latex.codecogs.com/gif.latex?\inline&space;\left&space;\{&space;(x_{cv}^{(1)},&space;y_{cv}^{(1)}),&space;...,&space;(x_{cv}^{(m_{cv})},&space;y_{cv}^{(m_{cv})})&space;\right&space;\}" title="\left \{ (x_{cv}^{(1)}, y_{cv}^{(1)}), ..., (x_{cv}^{(m_{cv})}, y_{cv}^{(m_{cv})}) \right \}" />を使用します。
ここで、ラベル<img src="https://latex.codecogs.com/gif.latex?\inline&space;y&space;=&space;1" title="y = 1" />は異常なサンプルに対応し、<img src="https://latex.codecogs.com/gif.latex?\inline&space;y&space;=&space;0" title="y = 0" />は通常のサンプルに対応します。
各クロス・バリデーション・サンプルに対して、<img src="https://latex.codecogs.com/gif.latex?\inline&space;p(x_{cv}^{(i)})" title="p(x_{cv}^{(i)})" />を計算します。
これらの確率のすべてのベクトル<img src="https://latex.codecogs.com/gif.latex?\inline&space;p(x_{cv}^{(1)}),&space;...,&space;p(x_{cv}^{(m_{cv})})" title="p(x_{cv}^{(1)}), ..., p(x_{cv}^{(m_{cv})})" />は、ベクトル`pval`で`selectThreshold.m`に渡されます。
対応するラベル<img src="https://latex.codecogs.com/gif.latex?\inline&space;y_{cv}^{(1)},&space;...,&space;y_{cv}^{(m_{cv})}" title="y_{cv}^{(1)}, ..., y_{cv}^{(m_{cv})}" />は、ベクトル`yval`で同じ関数に渡されます。

関数`selectThreshold.m`は2つの値を返す必要があります。
1つ目は選択された閾値<img src="https://latex.codecogs.com/gif.latex?\inline&space;\varepsilon" title="\varepsilon" />です。
サンプル<img src="https://latex.codecogs.com/gif.latex?\inline&space;x" title="x" />が低い確率<img src="https://latex.codecogs.com/gif.latex?\inline&space;p(x)&space;<&space;\varepsilon" title="p(x) < \varepsilon" />である場合、それは異常とみなされます。
この関数は<img src="https://latex.codecogs.com/gif.latex?\inline&space;F_{1}" title="F_{1}" />スコアも返す必要があります。
<img src="https://latex.codecogs.com/gif.latex?\inline&space;F_{1}" title="F_{1}" />スコアは、特定の閾値を与えられたグラウンド・トゥルース（Ground Truth）の異常を見つけることがどれだけうまくいっているかを示します。
<img src="https://latex.codecogs.com/gif.latex?\inline&space;\varepsilon" title="\varepsilon" />のさまざまな値に対して、現在の閾値が正しく分類されているかどうかのサンプル数を計算することで、結果の<img src="https://latex.codecogs.com/gif.latex?\inline&space;F_{1}" title="F_{1}" />スコアを計算します。

<img src="https://latex.codecogs.com/gif.latex?\inline&space;F_{1}" title="F_{1}" />スコアは、精度（<img src="https://latex.codecogs.com/gif.latex?\inline&space;prec" title="prec" />）と再現率（<img src="https://latex.codecogs.com/gif.latex?\inline&space;rec" title="rec" />）を用いて計算されます。

![式4](images/ex8/ex8-NF4.png)
 
次のように精度と再現率を計算します。

![式5](images/ex8/ex8-NF5.png)

 - <img src="https://latex.codecogs.com/gif.latex?\inline&space;tp" title="tp" />は真陽性の数です。グラウンド・トゥルース・ラベルは異常であり、アルゴリズムでは正しく異常と分類されています。
 - <img src="https://latex.codecogs.com/gif.latex?\inline&space;fp" title="fp" />は偽陽性の数です：グラウンド・トゥルース・ラベルは異常ではなく、アルゴリズムでは誤って異常として分類されています。
 - <img src="https://latex.codecogs.com/gif.latex?\inline&space;fn" title="fn" />は偽陰性の数です：グラウンド・トゥルース・ラベルは異常ですが、アルゴリズムでは異常ではないと誤って分類しています。
 
提供した`selectThreshold.m`のコードには、すでに<img src="https://latex.codecogs.com/gif.latex?\inline&space;\varepsilon" title="\varepsilon" />の多くの異なる値を試し、<img src="https://latex.codecogs.com/gif.latex?\inline&space;F_{1}" title="F_{1}" />スコアに基づいて最適な<img src="https://latex.codecogs.com/gif.latex?\inline&space;\varepsilon" title="\varepsilon" />を選択するループがあります。
ここで、`selectThreshold.m`のコードを完成する必要があります。
forループを使用して、すべてのクロス・バリデーション・サンプル（<img src="https://latex.codecogs.com/gif.latex?\inline&space;tp" title="tp" />、<img src="https://latex.codecogs.com/gif.latex?\inline&space;fp" title="fp" />、<img src="https://latex.codecogs.com/gif.latex?\inline&space;fn" title="fn" />の値を計算する）を使用して、<img src="https://latex.codecogs.com/gif.latex?\inline&space;F_{1}" title="F_{1}" />スコアの計算を実装できます。
約`8.99e-05`の`epsilon`の値が表示されます。

----

**実装上の注意：**

<img src="https://latex.codecogs.com/gif.latex?\inline&space;tp" title="tp" />、<img src="https://latex.codecogs.com/gif.latex?\inline&space;fp" title="fp" />、<img src="https://latex.codecogs.com/gif.latex?\inline&space;fn" title="fn" />を計算するために、すべてのサンプルをループするのではなく、ベクトル化された実装を使用できます。
これは、Octave/MATLABのベクトルと単一数値間の同等性テストによって実装できます。
<img src="https://latex.codecogs.com/gif.latex?\inline&space;n" title="n" />次元バイナリー（二値）・ベクトル<img src="https://latex.codecogs.com/gif.latex?\inline&space;v&space;\in&space;\left&space;\{&space;0,&space;1&space;\right&space;\}^{n}" title="v \in \left \{ 0, 1 \right \}^{n}" />に複数のバイナリー値がある場合、`sum(v == 0)`を使用すると、このベクトルに0がいくつあるか分かります。
また、そのようなバイナリー・ベクトルに論理演算子を適用することもできます。
たとえば、`cvPredictions`をクロス・バリデーション・セットと同じサイズのバイナリー・ベクトルで、<img src="https://latex.codecogs.com/gif.latex?\inline&space;i" title="i" />番目の要素は、アルゴリズムが<img src="https://latex.codecogs.com/gif.latex?\inline&space;x_{cv}^{(i)}" title="x_{cv}^{(i)}" />を異常とみなす場合は1であり、そうでない場合は0であるとします。
このようなとき、以下を使用して偽陽性の数を計算することができます。

`fp = sum((cvPredictions == 1) & (yval  ==  0))`
 
----

![図3：分類された異常](images/ex8/ex8-F3.png)

&nbsp;&ensp;&nbsp;&ensp; 図3：分類された異常

`selectThreshold.m`のコードを完成すると、`ex8.m`の次のステップで異常検出コードが実行され、プロット内の異常を丸で囲みます（図3）。

*ここで解答を提出する必要があります。*

### 1.4. 高次元データセット

スクリプト`ex8.m`の最後のパートは、より現実的ではるかに難しいデータセットで実装した異常検出アルゴリズムを実行します。
このデータセットでは、各サンプルが11のフィーチャーで記述されています（サーバーの多くのプロパティーをキャプチャーされています）。

このスクリプトでは、実装したコードを使用してガウス・パラメーター（<img src="https://latex.codecogs.com/gif.latex?\inline&space;\mu&space;_{i}" title="\mu _{i}" />と<img src="https://latex.codecogs.com/gif.latex?\inline&space;\sigma_{i}^{2}" title="\sigma_{i}^{2}" />）を推定し、ガウス・パラメーターを推定したトレーニング・データ`X`とクロス・バリデーション・セット`Xval`の両方の確率を評価します。
最後に、`selectThreshold`を使用して最も高い閾値<img src="https://latex.codecogs.com/gif.latex?\inline&space;\varepsilon" title="\varepsilon" />を探します。
約`1.38e-18`の`epsilon`値と`117`個の異常値が見つかるはずです。

## 2. レコメンダー・システム

この演習では、協調フィルタリングの学習アルゴリズムを実装し、映画の評価のデータセットに適用します。
このデータセットは、1〜5の尺度による評価から構成されます（※2）。
データセットは、<img src="https://latex.codecogs.com/gif.latex?\inline&space;n_{u}&space;=&space;94" title="n_{u} = 94" />人のユーザーと<img src="https://latex.codecogs.com/gif.latex?\inline&space;n_{m}&space;=&space;1682" title="n_{m} = 1682" />本の映画です。
演習のこのパートでは、スクリプト`ex8_cofi.m`を使用して作業します。

この演習の次のパートでは、協調フィルタリングの目的関数と勾配を計算する関数`cofiCostFunc.m`を実装します。
コスト関数と勾配を実装した後、`fmincg.m`を使用して協調フィルタリングのパラメーターを学習します。

※2：GroupLens Researchからの[MovieLens 100k Dataset](www.grouplens.org/node/73/)です。

### 2.1. 映画評価のデータセット

スクリプト`ex8_cofi.m`の最初のパートは、データセット`ex8_movies.mat`をロードし、Octave/MATLAB環境に変数`Y`と`R`を提供します。

行列`Y`（`num movies` × `num_users`の行列）は、1〜5の映画の評価<img src="https://latex.codecogs.com/gif.latex?\inline&space;y^{(i,&space;j)}" title="y^{(i, j)}" />を格納します。
行列`R`は、ユーザー<img src="https://latex.codecogs.com/gif.latex?\inline&space;j" title="j" />が映画<img src="https://latex.codecogs.com/gif.latex?\inline&space;i" title="i" />に評価を与えた場合には<img src="https://latex.codecogs.com/gif.latex?\inline&space;R(i,&space;j)=&space;1" title="R(i, j)= 1" />であり、そうでない場合には<img src="https://latex.codecogs.com/gif.latex?\inline&space;R(i,&space;j)=&space;0" title="R(i, j)= 0" />であるバイナリーの指標行列です。
協調フィルタリングの目的は、ユーザーがまだ評価していない映画、すなわち<img src="https://latex.codecogs.com/gif.latex?\inline&space;R(i,&space;j)=&space;0" title="R(i, j)= 0" />の映画の評価を予測することです。
これにより、予測される評価が最も高い映画をユーザーに推薦することができます。

行列`Y`を理解するために、スクリプト`ex8_cofi.m`は、最初の映画（Toy Story）の評価の平均を計算し、それを画面に出力します。

この演習のこのパートでは、行列`X`、`Theta`を使って作業することになります。

![式6](images/ex8/ex8-NF6.png)

`X`の<img src="https://latex.codecogs.com/gif.latex?\inline&space;i" title="i" />行目は<img src="https://latex.codecogs.com/gif.latex?\inline&space;i" title="i" />番目の映画のフィーチャー・ベクトル<img src="https://latex.codecogs.com/gif.latex?\inline&space;x^{(i)}" title="x^{(i)}" />に対応し、`Theta`の<img src="https://latex.codecogs.com/gif.latex?\inline&space;j" title="j" />番目の行は（<img src="https://latex.codecogs.com/gif.latex?\inline&space;j" title="j" />番目のユーザーの）1つのパラメーター・ベクトル<img src="https://latex.codecogs.com/gif.latex?\inline&space;\theta&space;^{(j)}" title="\theta ^{(j)}" />に対応します。
<img src="https://latex.codecogs.com/gif.latex?\inline&space;x^{(i)}" title="x^{(i)}" />と<img src="https://latex.codecogs.com/gif.latex?\inline&space;\theta&space;^{(j)}" title="\theta ^{(j)}" />はともに<img src="https://latex.codecogs.com/gif.latex?\inline&space;n" title="n" />次元ベクトルです。
この演習では、<img src="https://latex.codecogs.com/gif.latex?\inline&space;n&space;=&space;100" title="n = 100" />を使用するため、<img src="https://latex.codecogs.com/gif.latex?\inline&space;x^{(i)}&space;\in&space;\mathbb{R}^{100}" title="x^{(i)} \in \mathbb{R}^{100}" />、<img src="https://latex.codecogs.com/gif.latex?\inline&space;\theta&space;^{(j)}&space;\in&space;\mathbb{R}^{100}" title="\theta ^{(j)} \in \mathbb{R}^{100}" />となります。
それに対応して、`X`は<img src="https://latex.codecogs.com/gif.latex?\inline&space;n_{m}&space;\times&space;100" title="n_{m} \times 100" />の行列であり、`Theta`は<img src="https://latex.codecogs.com/gif.latex?\inline&space;n_{u}&space;\times&space;100" title="n_{u} \times 100" />の行列です。

### 2.2. 協調フィルタリングの学習アルゴリズム

ここから、協調フィルタリングの学習アルゴリズムの実装を開始します。
コスト関数（正則化なし）を実装することから始めます。

映画推薦の設定における協調フィルタリングのアルゴリズムは、<img src="https://latex.codecogs.com/gif.latex?\inline&space;n" title="n" />次元パラメーター・ベクトル<img src="https://latex.codecogs.com/gif.latex?\inline&space;x^{(1)},&space;...,&space;x^{(n_{m})}" title="x^{(1)}, ..., x^{(n_{m})}" />および<img src="https://latex.codecogs.com/gif.latex?\inline&space;\theta^{(1)},&space;...,&space;\theta^{(n_{n})}" title="\theta^{(1)}, ..., \theta^{(n_{n})}" />の集合を考えます。
ここで、モデルはユーザー<img src="https://latex.codecogs.com/gif.latex?\inline&space;j" title="j" />による映画<img src="https://latex.codecogs.com/gif.latex?\inline&space;i" title="i" />の評価を<img src="https://latex.codecogs.com/gif.latex?\inline&space;y^{(i,j)}&space;=&space;(\theta^{(j)})^{T}&space;x^{(i)}" title="y^{(i,j)} = (\theta^{(j)})^{T} x^{(i)}" />として予測します。
いくつかのユーザーによって生成されたいくつかの映画に対する評価の集合からなるデータセットが与えられた場合に、最も適合する（二乗誤差を最小限に抑える）パラメーター・ベクトル<img src="https://latex.codecogs.com/gif.latex?\inline&space;x^{(1)},&space;...,&space;x^{(n_{m})}" title="x^{(1)}, ..., x^{(n_{m})}" />、<img src="https://latex.codecogs.com/gif.latex?\inline&space;\theta^{(1)},&space;...,&space;\theta^{(n_{n})}" title="\theta^{(1)}, ..., \theta^{(n_{n})}" />を学習することが目的です。

`cofiCostFunc.m`のコードを完成させて、協調フィルタリングのコスト関数と勾配を計算します。
関数のパラメーター（つまり、学習しようとしている値）は`X`と`Theta`です。
`fmincg`のような既製のミニマイザーを使用するために、パラメーターを単一のベクトル`params`にアンロールするようにコスト関数が設定されています。
以前、ニューラル・ネットワークのプログラミング演習で同じベクトル・アンローリングの方法を使用していました。

#### 2.2.1. 協調フィルタリングのコスト関数

協調フィルタリングのコスト関数（正則化なし）は、以下で与えられます。

![式7](images/ex8/ex8-NF7.png)

変数`J`でこのコストを返すように、`cofiCostFunc.m`を変更する必要があります。
<img src="https://latex.codecogs.com/gif.latex?\inline&space;R(i,&space;j)&space;=&space;1" title="R(i, j) = 1" />の場合にのみ、ユーザー<img src="https://latex.codecogs.com/gif.latex?\inline&space;j" title="j" />と映画<img src="https://latex.codecogs.com/gif.latex?\inline&space;i" title="i" />のコストを累積する必要があります。
関数を完了すると、スクリプト`ex8_cofi.m`によってコスト関数が実行されます。
`22.22`が出力されるはずです。

*ここで解答を提出する必要があります。*

----

**実装上の注意：**

後で最適化パッケージ`fmincg`によって何度も呼び出されるため、ベクトル化された実装を使用して<img src="https://latex.codecogs.com/gif.latex?\inline&space;J" title="J" />を計算することを強くお勧めします。
いつものように、（正しい答えが得られることを確認するため）最初にベクトル化されていない実装を書いて、ベクトル化された実装に変更する方が簡単かもしれません（ベクトル化のステップがアルゴリズムの出力を変更しないことを確認してください）。
ベクトル化された実装を考え出すには、次のヒントを参考にしてください。
行列`R`を使用して、選択したエントリーを0に設定できます。
たとえば、`R .* M`は`M`と`R`の間で要素ごとの乗算を行います。
`R`は0または1のいずれかの値を持つ要素しか持たないので、`R`の対応する値が0の場合にのみ`M`の要素を0に設定するという効果があります。
したがって、`sum(sum(R.*M))`は、`R`の対応する要素が1に等しい`M`のすべての要素の合計です。

----

#### 2.2.2. 協調フィルタリングの勾配

ここで、（正規化なしで）勾配を実装する必要があります。
具体的には、`cofiCostFunc.m`のコードを完成させ、`X_grad`と`Theta_grad`の変数を返します。
`X_grad`は`X`と同じ大きさの行列でなければならず、同様に`Theta_grad`は`Theta`と同じ大きさの行列でなければなりません。
コスト関数の勾配は、以下で与えられます。

![式8](images/ex8/ex8-NF8.png)

この関数は、両方の変数の集合を1つのベクトルにアンロールすることによって、それらの勾配を返します。
勾配を計算するコードを完成させた後、スクリプト`ex8_cofi.m`は勾配チェック（`checkCostFunction`）を実行し、勾配の実装を数値で確認します（※3）。
実装が正しい場合は、解析的勾配と数値的勾配が完全に一致することが分かります。

*ここで解答を提出する必要があります。*

※3：これは、ニューラル・ネットワークの演習で使用した数値チェックに似ています。

----

**実装上の注意：**

ベクトル化された実装を使用しなくても、この課題の完全な評価を得ることができますが、コードははるかに遅く（数時間かけて）実行されるため、実装をベクトル化することをお勧めします。

まず、（<img src="https://latex.codecogs.com/gif.latex?\inline&space;\frac{\partial&space;J}{\partial&space;x_{k}^{(i)}}" title="\frac{\partial J}{\partial x_{k}^{(i)}}" />を計算する）映画のforループと（<img src="https://latex.codecogs.com/gif.latex?\inline&space;\frac{\partial&space;J}{\partial&space;x_{k}^{(j)}}" title="\frac{\partial J}{\partial x_{k}^{(j)}}" />を計算する）ユーザーのforループを使って、勾配を実装できます。
最初に勾配を実装するときは、ベクトル化されていないバージョンから開始することができます。これは、集計の各要素を計算する別の内部forループを実装することで実現します。
このように勾配の計算を完了したら、実装をベクトル化（forループの内側をベクトル化）して、forループを二つだけ残すようにする必要があります（一つは映画ごとに<img src="https://latex.codecogs.com/gif.latex?\inline&space;\frac{\partial&space;J}{\partial&space;x_{k}^{(i)}}" title="\frac{\partial J}{\partial x_{k}^{(i)}}" />を計算するためのループで、もう一つはユーザーごとに<img src="https://latex.codecogs.com/gif.latex?\inline&space;\frac{\partial&space;J}{\partial&space;x_{k}^{(j)}}" title="\frac{\partial J}{\partial x_{k}^{(j)}}" />を計算するためのループです）。

----

----

**実装のヒント：**

ベクトル化を実行するには、次の情報が役立ちます。
<img src="https://latex.codecogs.com/gif.latex?\inline&space;x_{1}^{(i)},&space;x_{2}^{(i)},&space;...,&space;x_{n}^{(i)}" title="x_{1}^{(i)}, x_{2}^{(i)}, ..., x_{n}^{(i)}" />に関するすべての導関数（すなわち、フィーチャー・ベクトル<img src="https://latex.codecogs.com/gif.latex?\inline&space;x^{(i)}" title="x^{(i)}" />に関する導関数）を同時に計算する方法を考え出すべきです。
<img src="https://latex.codecogs.com/gif.latex?\inline&space;i" title="i" />番目の映画のフィーチャー・ベクトルの導関数を次のように定義します。

![式9](images/ex8/ex8-NF9.png)

上記の式をベクトル化するには、`Theta`と`Y`にインデックスを付けて、関心のある要素(つまり<img src="https://latex.codecogs.com/gif.latex?\inline&space;r(i,&space;j)&space;=&space;1" title="r(i, j) = 1" />の要素)のみを選択します。
直感的に、<img src="https://latex.codecogs.com/gif.latex?\inline&space;i" title="i" />番目の映画のフィーチャーを検討するときは、映画に評価を与えたユーザーの関心だけが必要です。
これにより、他のすべてのユーザーを`Theta`と`Y`から取り除くことができます。

具体的には、`idx = find(R(i、：)== 1)`を映画<img src="https://latex.codecogs.com/gif.latex?\inline&space;i" title="i" />を評価したすべてのユーザーのリストに設定できます。
これにより、`Theatatemp = Theta(idx、:)`と`Ytemp = Y(i、idx)`を作成して、`Theta`と`Y`にインデックスを付けて、<img src="https://latex.codecogs.com/gif.latex?\inline&space;i" title="i" />番目の映画を評価したユーザーの集合のみを与えることができます。
これにより、以下のように導関数を実装することができます：

![式10](images/ex8/ex8-NF10.png)

(注：上記のベクトル化された計算は、代わりに行ベクトルを返します。)

導関数の計算を<img src="https://latex.codecogs.com/gif.latex?\inline&space;x^{(i)}" title="x^{(i)}" />に関してベクトル化した後、同様の方法を使って<img src="https://latex.codecogs.com/gif.latex?\inline&space;\theta&space;^{(j)}" title="\theta ^{(j)}" />に関してもベクトル化する必要があります。

----

#### 2.2.3. 正則化されたコスト関数

正則化を伴う協調フィルタリングのコスト関数は、以下の通りです。
 
![式11](images/ex8/ex8-NF11.png)

ここで、コスト関数<img src="https://latex.codecogs.com/gif.latex?\inline&space;J" title="J" />の元の計算に正規化を追加する必要があります。
完成後に、スクリプト`ex8_cofi.m`は正則化されたコスト関数を実行すると、約`31.34`のコストとなるはずです。

*ここで解答を提出する必要があります。*

#### 2.2.4. 正則化された勾配

正則化されたコスト関数を実装したので、勾配の正則化を実装する必要があります。
正則化項からの寄与を加えることによって正則化された勾配を戻すように、`cofiCostFunc.m`の実装に追加する必要があります。
正則化されたコスト関数の勾配は、以下で与えられることに注意してください。

![式12](images/ex8/ex8-NF12.png)

これは先ほど説明した変数`X_grad(i,:)`に<img src="https://latex.codecogs.com/gif.latex?\inline&space;\lambda&space;x&space;^{(i)}" title="\lambda x ^{(i)}" />を加え、前述の`Theta_grad(j,:)`変数に<img src="https://latex.codecogs.com/gif.latex?\inline&space;\lambda&space;\theta&space;^{(j)}" title="\lambda \theta ^{(j)}" />を加えるだけでよいことを意味します。
勾配を計算するためのコードを完成すると、スクリプト`ex8_cofi.m`は勾配の実装を数値で確認するために別の勾配チェック（`checkCostFunction`）を実行します。

*ここで解答を提出する必要があります。*

### 2.3. 映画のお勧めを学ぶ

協調フィルタリングのコスト関数と勾配の実装が完了したら、アルゴリズムのトレーニングを開始して映画のおすすめを自分で作成できます。
`ex8_cofi.m`スクリプトの次のパートでは、独自の映画設定を入力することができます。
その結果、アルゴリズムが実行された後で、自分の映画のお勧めを得ることができます。
私たちは自分の好みに応じていくつかの値を記入しましたが、あなたの好みに応じてこれを変更する必要があります。
データセット内のすべての映画のリストとその番号は、ファイル`movie_idx.txt`にリストされています。

#### 2.3.1. お勧め

```
Top recommendations for you:
Predicting rating 9.0 for movie Titanic (1997)
Predicting rating 8.9 for movie Star Wars (1977)
Predicting rating 8.8 for movie Shawshank Redemption, The (1994)
Predicting rating 8.5 for movie As Good As It Gets (1997)
Predicting rating 8.5 for movie Good Will Hunting (1997)
Predicting rating 8.5 for movie Usual Suspects, The (1995)
Predicting rating 8.5 for movie Schindler's List (1993)
Predicting rating 8.4 for movie Raiders of the Lost Ark (1981)
Predicting rating 8.4 for movie Empire Strikes Back, The (1980)
Predicting rating 8.4 for movie Braveheart (1995)
Original ratings provided:
Rated 4 for Toy Story (1995)
Rated 3 for Twelve Monkeys (1995)
Rated 5 for Usual Suspects, The (1995)
Rated 4 for Outbreak (1995)
Rated 5 for Shawshank Redemption, The (1994)
Rated 3 for While You Were Sleeping (1995)
Rated 5 for Forrest Gump (1994)
Rated 2 for Silence of the Lambs, The (1991)
Rated 4 for Alien (1979)
Rated 5 for Die Hard 2 (1990)
Rated 5 for Sphere (1998)
```

&nbsp;&ensp;&nbsp;&ensp; 図4：映画のお勧め

評価がデータセットに追加されると、スクリプトは協調フィルタリングのモデルをトレーニングします。
これにより、パラメーター`X`と`Theta`を学習します。
ユーザー<img src="https://latex.codecogs.com/gif.latex?\inline&space;j" title="j" />の映画<img src="https://latex.codecogs.com/gif.latex?\inline&space;i" title="i" />に対する評価を予測するには、<img src="https://latex.codecogs.com/gif.latex?\inline&space;(\theta^{(j)})^{T}&space;x^{(i)}" title="(\theta^{(j)})^{T} x^{(i)}" />を計算する必要があります。
スクリプトの次のパートでは、すべての映画とユーザーの評価が計算され、スクリプトで先に入力された評価に従って、推薦する映画が表示されます（図4）。
ランダムな初期化が異なるため、異なる予測セットが得られる可能性があることに注意してください。

## 提出と採点

この課題が完了したら、送信機能を使用して解答を我々のサーバーに送信してください。
以下は、この演習の各パートの得点の内訳です。

| パート | 提出するファイル | 点数　|
----|----|---- 
| ガウス分布のパラメーターの推定 | `estimateGaussian.m` | 15 点 |
| 閾値の選択 | `selectThreshold.m` | 15 点 |
| 協調フィルタリングのコスト | `cofiCostFunc.m` | 20 点 |
| 協調フィルタリングの勾配 | `cofiCostFunc.m` | 30 点 |
| 正則化されたコスト | `cofiCostFunc.m` | 10 点 |
| 正則化された勾配 | `cofiCostFunc.m` | 10 点 |
| 合計点 |  | 100 点 |

解答を複数回提出することは許可されており、最高のスコアのみを考慮に入れます。
