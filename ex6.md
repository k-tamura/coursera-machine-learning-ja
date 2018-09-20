# プログラミング演習6: サポート・ベクター・マシン

機械学習

## はじめに

この演習では、サポート・ベクター・マシン（SVM）を使用してスパム分類器を作成します。
プログラミング演習を始める前に、ビデオ講義を見て、関連トピックのレビュー質問を完了することを強くお勧めします。

演習を開始するには、スターター・コードをダウンロードし、演習を終了するディレクトリーにその内容を解凍する必要があります。
必要に応じて、この演習を開始する前にOctave/MATLABの`cd`コマンドを使用してこのディレクトリーに移動してください。

また、コースウェブサイトの「環境設定手順」にOctave/MATLABをインストールするための手順も記載されています。

## この演習に含まれるファイル

 - `ex6.m` - 演習の手順を示すOctave/MATLABスクリプト
 - `ex6data1.mat` - サンプルのデータセット1
 - `ex6data2.mat` - サンプルのデータセット2
 - `ex6data3.mat` - サンプルのデータセット3
 - `svmTrain.m` - SVMトレーニング関数
 - `svmPredict.m` - SVM予測関数
 - `plotData.m` - 2Dデータをプロットする
 - `visualizeBoundaryLinear.m` - 線形境界をプロットする
 - `visualizeBoundary.m` - 非線形境界をプロットする
 - `linearKernel.m` - SVM用の線形カーネル
 - [\*] `gaussianKernel.m` - SVM用のガウス・カーネル
 - [\*] `dataset3Params.m` - データセット3に使用するパラメーター
 - `ex6_spam.m` - 演習の後半のOctave/MATLABスクリプト
 - `spamTrain.mat` - スパム・トレーニング・セット
 - `spamTest.mat` - スパム・テスト・セット
 - `emailSample1.txt` - サンプルメール1
 - `emailSample2.txt` - サンプルメール2
 - `spamSample1.txt` - スパムのサンプル1
 - `spamSample2.txt` - スパムのサンプル2
 - `vocab.txt` - 単語の一覧
 - `getVocabList.m` - 単語の一覧をロードする
 - `porterStemmer.m` - ステミング機能
 - `readFile.m` - ファイルを文字列に読み込みます
 - `submit.m` - 解答を我々のサーバーに送信するスクリプト
 - [\*] `processEmail.m` - メールの前処理を行う
 - [\*] `emailFeatures.m` - メールからのフィーチャーを抽出する
 
 \* はあなたが完了する必要があるものを示しています

演習では、スクリプト`ex6.m`を使用します。
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

## 1. サポート・ベクター・マシン

この演習の前半では、サポート・ベクター・マシン（SVM）とさまざまな2Dデータセットのサンプルを使用します。
これらのデータセットを試してみることで、SVMの仕組みやSVMでガウス・カーネルを使用する方法の直感を得ることができます。
演習の後半では、サポート・ベクター・マシンを使用してスパム分類器を作成します。
提供されたスクリプト`ex6.m`は、演習の前半を進めるのに役立ちます。

### 1.1. サンプルデータセット1

線形境界で分離できる2次元のサンプルデータセットから始めましょう。
スクリプト`ex6.m`はトレーニング・データをプロットします（図1）。
このデータセットでは、正のサンプル（+で示される）および負のサンプル（oで示される）の位置は、切れ目によって示される自然な分離を示唆します。
しかし、外れ値の正のサンプル+が左端に約<img src="https://latex.codecogs.com/gif.latex?(0.1,&space;4.1)" title="(0.1, 4.1)" />にあることに注意してください。
この演習の一環として、この異常値がSVMの決定境界にどのように影響するかも分かります。

![図1 サンプルデータセット1](images/ex6/ex6-F1.png "図1 サンプルデータセット1")

&nbsp;&ensp;&nbsp;&ensp; 図1: サンプルデータセット1

演習のこのパートでは、SVMでさまざまな値のパラメーター<img src="https://latex.codecogs.com/gif.latex?C" title="C" />を使用してみます。
簡単に言うと、パラメーター<img src="https://latex.codecogs.com/gif.latex?C" title="C" />は、誤って分類されたトレーニング・サンプルのペナルティーを制御する正の値です。
大きなパラメーター<img src="https://latex.codecogs.com/gif.latex?C" title="C" />は、すべてのサンプルを正しく分類するようにSVMに指示します。
<img src="https://latex.codecogs.com/gif.latex?C" title="C" />は<img src="https://latex.codecogs.com/gif.latex?\inline&space;\frac{1}{\lambda&space;}" title="\frac{1}{\lambda }" />と同様の役割を果たします。
ここで、<img src="https://latex.codecogs.com/gif.latex?\inline&space;\lambda" title="\lambda" />はロジスティック回帰にこれまで使用していた正則化パラメーターです。

![図2 C=1でのSVM決定境界（サンプルデータセット1](images/ex6/ex6-F2.png "図2 C=1でのSVM決定境界（サンプルデータセット1")

&nbsp;&ensp;&nbsp;&ensp; 図2: <img src="https://latex.codecogs.com/gif.latex?C&space;=&space;1" title="C = 1" />でのSVM決定境界（サンプルデータセット1）

![図3 C=100でのSVM決定境界（サンプルデータセット1）](images/ex6/ex6-F3.png "図3 C=100でのSVM決定境界（サンプルデータセット1）")

&nbsp;&ensp;&nbsp;&ensp; 図3: <img src="https://latex.codecogs.com/gif.latex?C&space;=&space;100" title="C = 100" />でのSVM決定境界（サンプルデータセット1）

`ex6.m`の次のパートでは、`svmTrain.m`（※2）に含まれているSVMソフトウェアを使用して、<img src="https://latex.codecogs.com/gif.latex?C&space;=&space;1" title="C = 1" />でSVMトレーニングを実行します。
<img src="https://latex.codecogs.com/gif.latex?C&space;=&space;1" title="C = 1" />の場合、SVMは2つのデータセット間の切れ目に決定境界を引き、一番左のデータ点を誤って分類することが分かります（図2）。

※2：Octave/MATLABの互換性を保証するために、このSVM学習アルゴリズムの実装を含めました。
しかし、この特殊な実装は、互換性を最大限にするために選ばれており、あまり効率的ではありません。
実際の問題でSVMをトレーニングする場合（特に大きなデータセットに拡張する必要がある場合）は、[LIBSVM](http://www.csie.ntu.edu.tw/%7Ecjlin/libsvm/)などの高度に最適化されたSVMツールボックスを使用することを強くお勧めします。

----

**実装上の注意：**

ほとんどのSVMソフトウェア・パッケージ（`svmTrain.m`を含む）は、自動的に別のフィーチャー<img src="https://latex.codecogs.com/gif.latex?\inline&space;x_{0}&space;=&space;1" title="x_{0} = 1" />を追加し、自動的に切片項<img src="https://latex.codecogs.com/gif.latex?\inline&space;\theta&space;_{0}" title="\theta _{0}" />を学習します。
したがって、トレーニング・データをSVMソフトウェアに渡すときには、このフィーチャー<img src="https://latex.codecogs.com/gif.latex?\inline&space;x_{0}&space;=&space;1" title="x_{0} = 1" />を自分で追加する必要はありません。
特に、Octave/MATLABでは、コードはトレーニング・サンプル<img src="https://latex.codecogs.com/gif.latex?x&space;\in&space;\mathbb{R}^{n}" title="x \in \mathbb{R}^{n}" />（<img src="https://latex.codecogs.com/gif.latex?x&space;\in&space;\mathbb{R}^{n&plus;1}" title="x \in \mathbb{R}^{n+1}" />ではなく）で動作する必要があります。
たとえば、最初のサンプルのデータセットは<img src="https://latex.codecogs.com/gif.latex?x&space;\in&space;\mathbb{R}^{2}" title="x \in \mathbb{R}^{2}" />です。

----

あなたがすべきことは、このデータセット上で異なる値の<img src="https://latex.codecogs.com/gif.latex?C" title="C" />を試すことです。
具体的には、スクリプトの<img src="https://latex.codecogs.com/gif.latex?C" title="C" />の値を<img src="https://latex.codecogs.com/gif.latex?C&space;=&space;100" title="C = 100" />に変更し、SVMトレーニングを再度実行する必要があります。
<img src="https://latex.codecogs.com/gif.latex?C&space;=&space;100" title="C = 100" />の場合、SVMはすべての単一のサンプルを正しく分類するようになりますが、データに自然に適合するような決定境界にはなりません（図3）。

### 1.2. ガウス・カーネルを用いたSVM

この演習では、非線形分類を行うためにSVMを使用します。
特に、線形に分離できないデータセットでは、ガウス・カーネルを用いたSVMを使用することになります。

#### 1.2.1. ガウス・カーネル

SVMで非線形の決定境界を見つけるには、最初にガウス・カーネルを実装する必要があります。
ガウス・カーネルは、一対のサンプル<img src="https://latex.codecogs.com/gif.latex?\inline&space;(x^{(i)},&space;x^{(j)})" title="(x^{(i)}, x^{(j)})" />の間の「距離」を測定する類似関数として考えることができます。
ガウス・カーネルはまた、バンド幅パラメーター<img src="https://latex.codecogs.com/gif.latex?\sigma" title="\sigma" />によってパラメーター化されます。
このパラメーターはサンプルが離れていくにつれて、類似度メトリックがどれだけ速く（0に）減少するかを決定します。

`gaussianKernel.m`のコードを完成させて、2つのサンプル<img src="https://latex.codecogs.com/gif.latex?\inline&space;(x^{(i)},&space;x^{(j)})" title="(x^{(i)}, x^{(j)})" />の間のガウス・カーネルを計算する必要があります。
ガウス・カーネル関数は、以下のように定義されます。

![式1](images/ex6/ex6-NF1.png)

`gaussianKernel.m`関数を完成させたら、`ex6.m`スクリプトは与えられた2つのサンプルでカーネル関数をテストします。
実装が正しければ、`0.324652`が出力されるはずです。

*ここで解答を提出する必要があります。*

#### 1.2.2. サンプルデータセット2

![図4 サンプルデータセット2](images/ex6/ex6-F4.png "図4 サンプルデータセット2")

&nbsp;&ensp;&nbsp;&ensp; 図4: サンプルデータセット2

`ex6.m`の次のパートでは、データセット2をロードしてプロットします（図4）。
図から、このデータセットの正のサンプルと負のサンプルを分ける線形の決定境界が無いことを理解できます。
ただし、SVMでガウス・カーネルを使用することで、データセットに対して合理的にうまく分割可能な非線形の決定境界を学習することができます。

ガウス・カーネル関数を正しく実装していれば、`ex6.m`はこのデータセット上のガウス・カーネルを使ってSVMをトレーニングします。

![図5 SVM（ガウス・カーネル）決定境界（サンプルデータセット2）](images/ex6/ex6-F5.png "図5 SVM（ガウス・カーネル）決定境界（サンプルデータセット2）")

&nbsp;&ensp;&nbsp;&ensp; 図5: SVM（ガウス・カーネル）決定境界（サンプルデータセット2）

図5は、ガウス・カーネルを用いたSVMによって見出された決定境界を示しています。
決定境界は、正と負のサンプルのほとんどを正しく分離し、データセットの輪郭によく従っています。

#### 1.2.3. サンプルデータセット3

この演習では、ガウス・カーネルを用いたSVMを使用する方法について、より実践的なスキルを身に付けることになります。
`ex6.m`の次のパートがロードされ、3番目のデータセットが表示されます（図6）。
このデータセットとともにガウス・カーネルを用いたSVMを使用します。

![図6 サンプルデータセット3](images/ex6/ex6-F6.png "図6 サンプルデータセット3")

&nbsp;&ensp;&nbsp;&ensp; 図6 サンプルデータセット3

提供されたデータセット（`ex6data3.mat`）により、変数`X`、`y`、`Xval`、`yval`が与えられます。
`ex6.m`で提供されたコードは、`dataset3Params.m`からロードされたパラメーターを使用して、トレーニング・セット`(X, y)`でSVM分類器をトレーニングします。

あなたがすべきことは、クロス・バリデーション・セット`Xval`、`yval`を使用して、使用する最良の<img src="https://latex.codecogs.com/gif.latex?C" title="C" />および<img src="https://latex.codecogs.com/gif.latex?\sigma" title="\sigma" />パラメーターを決定することです。
パラメーター<img src="https://latex.codecogs.com/gif.latex?C" title="C" />と<img src="https://latex.codecogs.com/gif.latex?\sigma" title="\sigma" />を見つけるのに役立つ追加のコードを書く必要があります。
<img src="https://latex.codecogs.com/gif.latex?C" title="C" />と<img src="https://latex.codecogs.com/gif.latex?\sigma" title="\sigma" />の両方について、乗法的なステップで値を試すことをお勧めします（例：<img src="https://latex.codecogs.com/gif.latex?0.01,&space;0.03,&space;0.1,&space;0.3,&space;1,&space;3,&space;10,&space;30" title="0.01, 0.03, 0.1, 0.3, 1, 3, 10, 30" />）。
<img src="https://latex.codecogs.com/gif.latex?C" title="C" />と<img src="https://latex.codecogs.com/gif.latex?\sigma" title="\sigma" />のすべての可能な値のペア（たとえば、<img src="https://latex.codecogs.com/gif.latex?C&space;=&space;0.3" title="C = 0.3" />と<img src="https://latex.codecogs.com/gif.latex?\sigma&space;=&space;0.1" title="\sigma = 0.1" />）を試してください。
たとえば、<img src="https://latex.codecogs.com/gif.latex?C" title="C" />と<img src="https://latex.codecogs.com/gif.latex?\sigma^{2}" title="\sigma^{2}" />に対して上記の8つの値をそれぞれ試してみると、合計で<img src="https://latex.codecogs.com/gif.latex?8^{2}&space;=&space;64" title="8^{2} = 64" />の異なるモデルをトレーニングし、評価することになります（クロス・バリデーション・セットで）。

使用する最適なパラメーター<img src="https://latex.codecogs.com/gif.latex?C" title="C" />および<img src="https://latex.codecogs.com/gif.latex?\sigma" title="\sigma" />を決定して、それを返すように`dataset3Params.m`のコードを変更してください。
最適のパラメーターで、SVMが返す決定境界を図7に示します。

![図7 SVM（ガウス・カーネル）決定境界（サンプルデータセット3）](images/ex6/ex6-F7.png "図7 SVM（ガウス・カーネル）決定境界（サンプルデータセット3）")

&nbsp;&ensp;&nbsp;&ensp; 図7: SVM（ガウス・カーネル）決定境界（サンプルデータセット3）

----

**実装のヒント：**

使用する最適なパラメーター<img src="https://latex.codecogs.com/gif.latex?C" title="C" />および<img src="https://latex.codecogs.com/gif.latex?\sigma" title="\sigma" />を選択するためにクロス・バリデーションを実装する際は、クロス・バリデーション・セットの誤差を評価する必要があります。
分類において、誤差は、誤って分類されたクロス・バリデーション・サンプルの割合として定義されることを思い出してください。
Octave/MATLABでは、`mean(double(predictions ~= yval))`を使用してこの誤差を計算できます。
ここで、`prediction`はSVMからのすべての予測を含むベクトルで、`yval`はクロス・バリデーション・セットから取得した真のラベルです。
`svmPredict`関数を使用して、クロス・バリデーション・セットの予測を生成することができます。

----

*ここで解答を提出する必要があります。*

## 2. スパム分類

現在、多くの電子メールサービスには、電子メールを迷惑メールと非迷惑メールに高い精度で分類できる迷惑メールフィルターが用意されています。
この演習では、SVMを使用して独自のスパムフィルターを構築します。
特定の電子メール<img src="https://latex.codecogs.com/gif.latex?x" title="x" />がスパム（<img src="https://latex.codecogs.com/gif.latex?\inline&space;y&space;=&space;1" title="y = 1" />）であるか、非スパム（<img src="https://latex.codecogs.com/gif.latex?\inline&space;y&space;=&space;0" title="y = 0" />）であるかを分類するために分類器をトレーニングします。
特に、各電子メールをフィーチャー・ベクトル<img src="https://latex.codecogs.com/gif.latex?x&space;\in&space;\mathbb{R}^{n}" title="x \in \mathbb{R}^{n}" />に変換する必要があります。
以下の演習では、このようなフィーチャー・ベクトルを電子メールからどのように構築するかについて説明します。
この演習の残りのパートでは、スクリプト`ex6_spam.m`を使用します。
この演習に含まれるデータセットは、SpamAssassin Public Corpus（※3）のサブセットに基づいています。
この演習の目的においては、電子メールの本文（電子メールのヘッダーを除く）のみを使用します。

※3：http://spamassassin.apache.org/old/publiccorpus/

### 2.1. 電子メールの前処理

```
> Anyone knows how much it costs to host a web portal ?
>
Well, it depends on how many visitors youre expecting. This can be 
anywhere from less than 10 bucks a month to a couple of $100. You 
should checkout http://www.rackspace.com/ or perhaps Amazon EC2 if 
youre running something big..

To unsubscribe yourself from this mailing list, send an email to: 
groupname-unsubscribe@egroups.com
```

&nbsp;&ensp;&nbsp;&ensp; 図8: サンプルの電子メール

機械学習のタスクを開始する前に、データセットのサンプルを見てみるのが賢明です。
図8は、URL、電子メールアドレス（最後の）、数字、および金額を含むサンプルの電子メールを示しています。
多くの電子メールには、同じような種類のエンティティー（数字、他のURLや電子メールアドレスなど）が含まれますが、具体的なエンティティー（具体的なURLや金額など）はほぼすべての電子メールで異なります。
したがって、電子メールの処理によく使用される方法の1つは、これらの値を「標準化」（normalize）することで、すべてのURLが同じ扱いとなり、すべての数字が同じ扱いになります。
たとえば、電子メール内の各URLを一意の文字列「httpaddr」に置き換えて、URLが存在することを示すことができます。

これは、具体的なURLが存在するかどうかではなく、何らかのURLが存在するかどうかに基づいて分類を決定する効果があります。
スパマーはURLをランダム化することが多く、新しいスパムで特定のURLを再び見る確率は非常に低いため、通常、スパム分類器のパフォーマンスが向上します。
`processEmail.m`では、以下の電子メールの事前処理と標準化の手順を実装しました。

 - 小文字変換：電子メール全体が小文字に変換されるため、大文字の使用は無視されます（たとえば、IndIcaTEはIndicateと同じように扱われます）。
 - HTMLタグの削除：すべてのHTMLタグが電子メールから削除されます。多くの電子メールにはHTML形式が付いていることがよくあります。すべてのHTMLタグが削除されるので、コンテンツのみが残ります。
 - URLの標準化：すべてのURLは「httpaddr」というテキストに置き換えられます。
 - 電子メールアドレスの標準化：すべての電子メールアドレスは「emailaddr」というテキストに置き換えられます。
 - 数値の標準化：すべての数値はテキスト「number」に置き換えられます。
 - ドルの標準化：すべてのドル記号（$）はテキスト「dollar」に置き換えられます。
 - 単語のステミング：言葉はその語幹の形に縮小されます。たとえば、「discount」、「discounts」、「discounted」、「discounting」はすべて「discount」に置き換えられます。 ステマーは実際に最後から文字を取り除くことがあるので、「include」、「includes」、「included」、「including」はすべて「includ」に置き換えられます。
 - 非単語の削除：単語や句読点が削除されます。すべての空白（タブ、改行、空白）は、すべて1つの空白文字に切り詰められます。

これらの前処理の結果を図9に示します。
前処理では単語の断片や単語以外のものが残っていますが、この形式はフィーチャー抽出を実行するよりはるかに簡単です。

```
anyon know how much it cost to host a web portal well it depend on how
mani visitor your expect thi can be anywher from less than number buck
a month to a coupl of dollarnumb you should checkout httpaddr or perhap 
amazon ecnumb if your run someth big to unsubscrib yourself from thi 
mail list send an email to emailaddr
```

&nbsp;&ensp;&nbsp;&ensp; 図9: 前処理後のサンプルの電子メール

<table style="border-style: none;vertical-align: bottom"><tr><td>
 
```
1 aa
2 ab
3 abil
...
86 anyon
...
916 know
...
1898 zero
1899 zip
```

&nbsp;&ensp;&nbsp;&ensp; 図10: 語彙のリスト
</td><td>

```
86 916 794 1077 883
370 1699 790 1822
1831 883 431 1171
794 1002 1893 1364
592 1676 238 162 89
688 945 1663 1120
1062 1699 375 1162
479 1893 1510 799
1182 1237 810 1895
1440 1547 181 1699
1758 1896 688 1676
992 961 1477 71 530
1699 531
```

&nbsp;&ensp;&nbsp;&ensp; 図11: サンプル電子メールの単語のインデックス
</td></tr></table>

#### 2.1.1. 語彙リスト

電子メールを前処理すると、図9のような電子メールごとの単語リストが表示されます。
次のステップは、分類器で使用したい単語と、除外したい単語を選択することです。

この演習では、最も頻繁に現れる単語のみを、重視する単語のセット（語彙リスト）として選択しました。
トレーニング・セットにはめったに現れる単語は少数の電子メールにしか含まれていないため、モデルがトレーニング・セットにオーバーフィットする可能性があります。
完全な語彙リストは、ファイル`vocab.txt`にあり、図10にも示されています。
語彙リストは、スパムコーパスで少なくとも100回現れるすべての単語を選択することで選出され、1899語のリストになりました。
実際には、約10,000〜50,000語の語彙リストがよく使われます。

語彙リストが与えられると、図9のような事前処理された電子メールの各単語を、語彙リスト内の単語のインデックスを含む単語インデックスのリストにマッピングすることができます。
図11は、サンプルの電子メールのマッピングを示しています。
具体的には、サンプルの電子メールでは、「anyone」という単語が最初に「anyon」に正規化されてから、語彙リストのインデックス86にマッピングされました。

あなたがすべきことは、このマッピングを実行するために`processEmail.m`のコードを完成させることです。
コード内で、処理された電子メールから取得した単一の単語は、文字列`str`で与えられます。
語彙リスト`vocabList`の中を調べ、この単語が存在するかどうかを調べてください。
単語が存在する場合は、その単語のインデックスを変数`word_indices`に追加する必要があります。
単語が存在しない場合は、単語をスキップできます。

`processEmail.m`を実装すると、スクリプト`ex6_spam.m`は電子メールサンプルでコードを実行し、図9および図11のような出力が表示されます。

----

#### Octave/MATLABのヒント:

Octave/MATLABでは、`strcmp`関数で2つの文字列を比較できます。
たとえば、`strcmp(str1, str2)`は、両方の文字列が等しい場合にのみ1を返します。
提供されているスターター・コードでは、`vocabList`は語彙内の単語を含む「セル配列」です。
Octave/MATLABでは、セル配列は通常の配列（つまりベクトル）と似ていますが、その要素は文字列で（通常のOctave/MATLABの行列やベクトルではできません） 、角括弧の代わりに中括弧を使用してそれらに入力します。
具体的には、インデックス`i`で単語を取得するには、`vocabList{i}`を使用します。
`length(vocabList)`を使用して、語彙の単語数を取得することもできます。

----

*ここで解答を提出する必要があります。*

### 2.2　電子メールからのフィーチャーの抽出

次に各電子メールを<img src="https://latex.codecogs.com/gif.latex?\mathbb{R}^{n}" title="\mathbb{R}^{n}" />のベクトルに変換するフィーチャーの抽出処理を実装します。
この演習では、語彙リストで<img src="https://latex.codecogs.com/gif.latex?n&space;=&space;\&hash;" title="n = \#" />の単語を使用します。
具体的には、電子メールのフィーチャー<img src="https://latex.codecogs.com/gif.latex?\inline&space;x_{i}&space;\in&space;\left&space;\{&space;0,&space;1&space;\right&space;\}" title="x_{i} \in \left \{ 0, 1 \right \}" />は、辞書内の<img src="https://latex.codecogs.com/gif.latex?i" title="i" />番目の単語が電子メール内に出現するかどうかに対応します。
つまり、電子メールに<img src="https://latex.codecogs.com/gif.latex?i" title="i" />番目の単語がある場合は<img src="https://latex.codecogs.com/gif.latex?x^{(i)}&space;=&space;1" title="x^{(i)} = 1" />、電子メールに<img src="https://latex.codecogs.com/gif.latex?i" title="i" />番目の単語がない場合は<img src="https://latex.codecogs.com/gif.latex?x^{(i)}&space;=&space;0" title="x^{(i)} = 0" />となります。
したがって、一般的な電子メールでは、このフィーチャーは次のようになります。

![式2](images/ex6/ex6-NF4.png)

`emailFeatures.m`のコードを完成させて、電子メールのためのフィーチャー・ベクトルを生成する必要があります。

`emailFeatures.m`を実装すると、`ex6_spam.m`の次のパートが電子メールサンプルでコードを実行します。
フィーチャー・ベクトルの長さは1899で、ゼロではないエントリーは45であることが分かります。

*ここで解答を提出する必要があります。*

### 2.3. スパム分類のためのSVMトレーニング

フィーチャーの抽出機能が完成したら、`ex6_spam.m`の次のステップで、SVM分類器をトレーニングするために使用される前処理されたトレーニング・データセットを読み込みます。
`spamTrain.mat`には、スパムメールと非スパムメールのトレーニング・サンプルが4000件含まれていますが、`spamTest.mat`には1000件のテストサンプルが含まれています。
オリジナルの電子メールは、それぞれ`processEmail`関数と`emailFeatures`関数を使用して処理され、ベクトル<img src="https://latex.codecogs.com/gif.latex?x^{(i)}&space;\in&space;\mathbb{R}^{1899}" title="x^{(i)} \in \mathbb{R}^{1899}" />に変換されました。

データセットをロードした後、`ex6_spam.m`はSVMをトレーニングしてスパム(<img src="https://latex.codecogs.com/gif.latex?\inline&space;y&space;=&space;1" title="y = 1" />)と非スパム(<img src="https://latex.codecogs.com/gif.latex?\inline&space;y&space;=&space;0" title="y = 0" />)の電子メールを分類します。
トレーニングが完了すると、分類器が約`99.8`％のトレーニング精度と約`98.5`％のテスト精度を得ることが分かります。

### 2.4. スパムの上位予測

```
our click remov guarante visit basenumb dollar will price pleas nbsp
most lo ga dollarnumb
```

&nbsp;&ensp;&nbsp;&ensp; 図12: 迷惑メールの上位予測
 
スパム分類器の仕組みをよりよく理解するために、パラメーターを検査して、分類器が最もスパムと予測していると考えられる単語を確認することができます。
`ex6_spam.m`の次のステップでは、分類器で最大の正の値を持つパラメーターが検索され、対応する単語が表示されます（図12）。
したがって、電子メールに「guarantee」、「remove」、「dollar」、「price」など（図12で示された上位予測）の単語が含まれていると、スパムとして分類される可能性があります。

### 2.5. オプション（非評価）の演習：自分のメールを試してみる

スパム分類器をトレーニングしたので、自分のメールでそれを試してみることができます。
スターター・コードには、2つの電子メールのサンプル（`emailSample1.txt`と`emailSample2.txt`）と2つのスパムのサンプル（`spamSample1.txt`と`spamSample2.txt`）が含まれています。
`ex6_spam.m`の最後のパートは、最初のスパムのサンプルにスパム分類器を実行し、学習したSVMを使用して分類します。
ここで提供している他のサンプルで、分類器が正しいかどうかを確認してみてください。
また、サンプル（プレーン・テキスト・ファイル）を自分のメールに置き換えることで、自分のメールを試すこともできます。

*このオプションの（非評価）演習は、解答を提出する必要はありません。*

### 2.6. オプション（非評価）の演習：独自のデータセットを構築する

この演習では、前処理されたトレーニング・セットとテスト・セットを提供しました。
これらのデータセットは、今完成させた同じ関数（`processEmail.m`と`emailFeatures.m`）を使用して作成されました。
このオプション（非評価）の演習では、SpamAssassin Pubic Corpusの元の電子メールを使用して、独自のデータセットを構築します。

このオプション（非評価）の演習で、あなたがすべきことは、[パブリックコーパス](http://spamassassin.apache.org/old/publiccorpus/)からオリジナルのファイルをダウンロードし、それらを抽出することです。
それらを抽出したら、それぞれの電子メールで`processEmail`（※4）および`emailFeatures`関数を実行して、各電子メールからフィーチャー・ベクトルを抽出する必要があります。
これにより、サンプルのデータセット`X`、`y`を構築できます。
その後、データセットを無作為にトレーニング・セット、クロス・バリデーション・セット、テスト・セットに分割する必要があります。

独自のデータセットを作成する際には、（データセット内に出現する高頻度の単語を選択して）独自の語彙リストを作成し、役立つと思われるフィーチャーを追加することをお勧めします。
最後に、[LIBSVM](http://www.csie.ntu.edu.tw/%7Ecjlin/libsvm/)など高度に最適化されたSVMツールボックスを使用することもお勧めします。

*このオプションの（非評価）演習は、解答を提出する必要はありません。*

※4：オリジナルの電子メールには、削除したいと思われる電子メールヘッダーがあります。
これらのヘッダーを削除するのに役立つコードを`processEmail`に含めています。

## 提出と採点

この課題が完了したら、送信機能を使用して解答を我々のサーバーに送信してください。
以下は、この演習の各パートの得点の内訳です。

| パート | 提出するファイル | 点数　|
----|----|---- 
| ガウス・カーネル | `gaussianKernel.m` | 25 点 |
| データセット3のパラメーター（<img src="https://latex.codecogs.com/gif.latex?C" title="C" />、<img src="https://latex.codecogs.com/gif.latex?\sigma" title="\sigma" />） | `dataset3Params.m` | 25 点 |
| 電子メール前処理 | `processEmail.m` | 25 点 |
| メールフィーチャーの抽出 | `emailFeatures.m` | 25 点 |
| 合計点 |  | 100 点 |

解答を複数回提出することは許可されており、最高のスコアのみを考慮に入れます。
