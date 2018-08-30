
# プログラミング演習4: ニューラル・ネットワークの学習

機械学習

## はじめに

この演習では、ニューラル・ネットワークのバックプロパゲーションのアルゴリズムを実装し、それを手書き数字の認識のタスクに適用します。
プログラミング演習を始める前に、ビデオ講義を見て、関連トピックの復習の問題を完了することを強くお勧めします。

演習を開始するには、スターター・コードをダウンロードし、演習を終了するディレクトリーにその内容を解凍する必要があります。
必要に応じて、この演習を開始する前にOctave/MATLABの`cd`コマンドを使用してこのディレクトリーに移動してください。

また、コースウェブサイトの「環境設定手順」にOctave/MATLABをインストールするための手順も記載されています。

## この演習に含まれるファイル

 - `ex4.m` - 演習の手順を示すOctave/MATLABスクリプト
 - `ex4data1.mat` - 手書きの数字のトレーニング・セット
 - `ex4weights.mat` - 演習4のニューラル・ネットワーク・パラメーター
 - `submit.m` - 解答を我々のサーバーに送信する送信スクリプト
 - `displayData.m` - データセットを可視化するための関数
 - `fmincg.m` - 最小化ルーチンの関数(`fminunc`と同様)
 - `sigmoid.m` - シグモイド関数
 - `computeNumericalGradient.m` - 数値的に勾配を計算する
 - `checkNNGradients.m` - 勾配の確認に役立つ機能
 - `debugInitializeWeights.m` - ウェイトを初期化する関数
 - `predict.m` - ニューラル・ネットワーク予測関数
 - [*] `sigmoidGradient.m` - シグモイド関数の勾配を計算する
 - [*] `randInitializeWeights.m` - ランダムにウェイトを初期化する
 - [*] `nnCostFunction.m` - ニューラル・ネットワークのコスト関数
 
 \* はあなたが完了する必要があるものを示しています

演習では、スクリプト`ex4.m`を使用します。
このスクリプトは、問題に対するデータセットをセットアップし、あなたが実装する関数を呼び出します。
このスクリプトを変更する必要はありません。
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

## 1. ニューラル・ネットワーク

前回の演習では、ニューラル・ネットワーク用のフィードフォワード・プロパゲーションを実装し、手書き数字の予測のために、それを与えられたウェイトとともに使用しました。
この演習では、バックプロパゲーションのアルゴリズムを実装して、ニューラル・ネットワークのパラメーターを学習します。

提供されたスクリプト`ex4.m`は、この演習を段階的に手助けします。

### 1.1. データの可視化

`ex4.m`の最初のパートでは、関数`displayData`を呼び出すことによって、コードがデータをロードし、2次元プロット上（図1）に表示します。

![図1:データセットのサンプル](images/ex4/ex4-F1.png)

&nbsp;&ensp;&nbsp;&ensp; 図1：データセットのサンプル

これは、前の演習で使用したのと同じデータセットです。
`ex4data1.mat`には5000個のトレーニング・サンプルがあり、各トレーニング・サンプルは数字の20×20ピクセルのグレースケール画像です。
各ピクセルは、その位置におけるグレースケール強度を示す浮動小数点数によって表されます。
20×20グリッドのピクセルは、400次元のベクトルに「アンロール」(展開)されます。
これらのトレーニング・サンプルはそれぞれ、データ行列<img src="https://latex.codecogs.com/gif.latex?\inline&space;X" title="X" />の1行になります。
これは5000×400の行列`X`を与え、各行は手書きの数字の画像のトレーニング・サンプルです。

![式1](images/ex4/ex4-NF1.png)

トレーニング・セットの第2のパートは、トレーニング・セットのラベルを含む5000次元のベクトルyです。
ゼロインデックスがないOctave/MATLABインデックスとの互換性を高めるために、数字の0を10にマッピングしました。
したがって、数字の「0」は「10」とラベル付けされ、数字の「1」〜「9」はそのままの順序で「1」〜「9」とラベル付けされます。

### 1.2. モデルの表現

この課題のニューラル・ネットワークを図2に示します。
3つの層（入力層、隠れ層および出力層）を有します。
入力は、数字の画像のピクセル値であることを思い出してください。
イメージのサイズは20×20であるため、入力層ユニットは400個となります（常に+1を出力する追加のバイアスユニットは数えません）。
トレーニング・データは、`ex4.m`スクリプトによって変数`X`および`y`にロードされます。
すでにトレーニングされた一連のネットワーク・パラメーター（<img src="https://latex.codecogs.com/gif.latex?\inline&space;\Theta&space;^{(1)}" title="\Theta ^{(1)}" />、<img src="https://latex.codecogs.com/gif.latex?\inline&space;\Theta&space;^{(2)}" title="\Theta ^{(2)}" />）が提供されています。
これらは`ex4weights.mat`に格納され、`ex4.m`によって`Theta1`と`Theta2`にロードされます。
パラメーターは、第2層に25ユニット、出力ユニット10個（10桁のクラスに対応）のニューラル・ネットワーク用にサイズが決められています。

```
% ファイルから保存された行列をロードする
load('ex4weights.mat');
% 行列Theta1とTheta2がワークスペースにロードされます
% Theta1のサイズは25 x 401です
% Theta2のサイズは10 x 26です
```

![図2: ニューラル・ネットワークモデル](images/ex4/ex4-F2.png)

&nbsp;&ensp;&nbsp;&ensp; 図2: ニューラル・ネットワークモデル

### 1.3. フィードフォワードおよびコスト関数

ここでは、ニューラル・ネットワークのコスト関数と勾配を実装します。
まず、コストを返すために`nnCostFunction.m`のコードを完成させます。
ニューラル・ネットワークのコスト関数（正則化なし）は、以下であることを思い出してください。

![式2](images/ex4/ex4-NF2.png)

ここで、図2に示すように<img src="https://latex.codecogs.com/gif.latex?\inline&space;h_{\theta&space;}(x^{(i)})" title="h_{\theta }(x^{(i)})" />が計算され、<img src="https://latex.codecogs.com/gif.latex?\inline&space;K&space;=&space;10" title="K = 10" />は可能なラベルの総数です。
なお、<img src="https://latex.codecogs.com/gif.latex?\inline&space;h_{\theta&space;}(x^{(i)})_{k}&space;=&space;a_{k}^{(3)}" title="h_{\theta }(x^{(i)})_{k} = a_{k}^{(3)}" />は<img src="https://latex.codecogs.com/gif.latex?\inline&space;k" title="k" />番目の出力ユニットのアクティベーション（出力値）です。
また、元のラベル（変数`y`内の）は<img src="https://latex.codecogs.com/gif.latex?\inline&space;1,&space;2,&space;...,&space;10" title="1, 2, ..., 10" />であるのに対して、ニューラル・ネットワークをトレーニングする目的で、値0または1だけを含むベクトルとしてラベルを再コード化する必要があることを思い出してください。
つまり、

![式3](images/ex4/ex4-NF3.png)

たとえば、<img src="https://latex.codecogs.com/gif.latex?\inline&space;x^{(i)}" title="x^{(i)}" />が数字5の画像である場合、対応する<a href="https://www.codecogs.com/eqnedit.php?latex=\inline&space;y^{(i)}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?\inline&space;y^{(i)}" title="y^{(i)}" /></a>（コスト関数とともに使用する必要があります）は、<img src="https://latex.codecogs.com/gif.latex?\inline&space;y_{5}&space;=&space;1" title="y_{5} = 1" />の10次元ベクトルであり、他の要素は全て0です。 
すべてのサンプル<img src="https://latex.codecogs.com/gif.latex?\inline&space;i" title="i" />に対して<img src="https://latex.codecogs.com/gif.latex?\inline&space;h_{\theta&space;}(x^{(i)})" title="h_{\theta }(x^{(i)})" />を計算し、コストを合計するフィードフォワード計算を実装する必要があります。
あなたのコードは、任意の数のラベルを持つ任意のサイズのデータセットに対しても機能するはずです
（少なくとも<img src="https://latex.codecogs.com/gif.latex?\inline&space;K&space;\geq&space;3" title="K \geq 3" />のラベルがあると仮定することができます）。

----

#### 実装上の注意：

行列`X`の行にサンプルが含まれています（つまり、`X(i,:)`は<img src="https://latex.codecogs.com/gif.latex?i" title="i" />番目のトレーニング・サンプル<img src="https://latex.codecogs.com/gif.latex?\inline&space;x^{(i)}" title="x^{(i)}" />で、n×1のベクトルで表されます）。
`nnCostFunction.m`のコードを完成させるには、`X`の行列に1の列を追加する必要があります。
ニューラル・ネットワークの各ユニットのパラメーターは、`Theta1`と`Theta2`の1行で表されます。
特に、`Theta1`の1行目は、2番目の層の最初の隠れユニットに対応します。
サンプルに対してforループを使用すると、コストを計算できます。

----

完了したら、`ex4.m`は、ロードされた`Theta1`と`Theta2`のパラメーターのセットを使用して`nnCostFunction`を呼び出します。
コストは約`0.287629`です。

*ここで解答を提出する必要があります。*

### 1.4. 正則化されたコスト関数

ニューラル・ネットワークの正則化されたコスト関数は、以下によって与えられます。

![式4](images/ex4/ex4-NF4.png)

ニューラル・ネットワークは入力層、隠れ層、出力層の3つの層しか持たないと仮定できます。
しかし、あなたのコードは、任意の数の入力ユニット、隠れユニット、および出力ユニットに対して機能するはずです。
明確にするために上記の指標を<img src="https://latex.codecogs.com/gif.latex?\inline&space;\Theta&space;(1)" title="\Theta (1)" />と<img src="https://latex.codecogs.com/gif.latex?\inline&space;\Theta&space;(2)" title="\Theta (2)" />に明示していますが、コードは一般に<img src="https://latex.codecogs.com/gif.latex?\inline&space;\Theta&space;(1)" title="\Theta (1)" />と<img src="https://latex.codecogs.com/gif.latex?\inline&space;\Theta&space;(2)" title="\Theta (2)" />の任意のサイズで機能するはずです。
バイアスに対応する項を正則化すべきではないことに注意してください。
`Theta1`と`Theta2`が行列の場合、これは各行列の最初の列に対応します。
これで、コスト関数に正則化を追加できたはずです。
まず、既存の`nnCostFunction.m`を使用して非正則化コスト関数Jを計算し、その後正則化項のコストを追加することができます。
完了したら、`ex4.m`は、`Theta1`と`Theta2`、および<img src="https://latex.codecogs.com/gif.latex?\inline&space;\lambda&space;=&space;1" title="\lambda = 1" />のパラメーターのロードセットを使用して`nnCostFunction`を呼び出します。
コストは約`0.383770`です。

## 2. バックプロパゲーション

この演習では、バックプロパゲーションのアルゴリズムを実装して、ニューラル・ネットワークのコスト関数の勾配を計算します。
`grad`に対して適切な値を返すように、`nnCostFunction.m`を完成する必要があります。
勾配を計算すると、`fmincg`などの高度なオプティマイザーを使用してコスト関数<img src="https://latex.codecogs.com/gif.latex?\inline&space;J(\theta)" title="J(\theta)" />を最小化することにより、ニューラル・ネットワークをトレーニングすることができます。
最初にバックプロパゲーションのアルゴリズムを実装して、（正則化されていない）ニューラル・ネットワークのパラメーターの勾配を計算します。
正則化されていないケースの勾配の計算が正しいことを確認したら、正則化されたニューラル・ネットワークの勾配を実装します。

### 2.1. シグモイド勾配

演習のこのパートを始めるために、まずシグモイド勾配関数を実装します。シグモイド関数の勾配は、次のように計算できます。

![式5](images/ex4/ex4-NF5.png)

ここで

![式6](images/ex4/ex4-NF6.png)

完了したら、Octave/MATLABコマンドラインで`sigmoidGradient(z)`を呼び出して、いくつかの値をテストしてみてください。
`z`が大きな値（正と負の両方）であれば勾配は0に近い値に、`z = 0`であれば勾配は正確に`0.25`になるはずです。
あなたのコードはベクトルと行列でも動作する必要があります。
行列の場合、あなたが作成した関数はすべての要素に対してシグモイド勾配関数を実行する必要があります。

*ここで解答を提出する必要があります。*

### 2.2. ランダム初期化

ニューラル・ネットワークをトレーニングする場合、対称性の破壊のためにパラメーターをランダムに初期化することが重要です。
ランダム初期化のための1つの効果的な方策は、<img src="https://latex.codecogs.com/gif.latex?\inline&space;\Theta&space;^{(l)}" title="\Theta ^{(l)}" />の値を<img src="https://latex.codecogs.com/gif.latex?\inline&space;[-\epsilon&space;_{init},&space;\epsilon&space;_{init}]" title="[-\epsilon _{init}, \epsilon _{init}]" />にすることです。
<img src="https://latex.codecogs.com/gif.latex?\inline&space;\epsilon&space;_{init}&space;=&space;0.12" title="\epsilon _{init} = 0.12" />を使うべきです（※2）。
この値の範囲は、パラメーターを小さく保ち、学習をより効率的にします。
あなたがすべきことは、`randInitializeWeights.m`を完成させて<img src="https://latex.codecogs.com/gif.latex?\inline&space;\Theta" title="\Theta" />のウェイトを初期化することです。
ファイルを変更し、次のコードを入力します。

```
% ウェイトを小さい値にランダムに初期化する
epsilon_init = 0.12;
W = rand(L_out, 1 + L_in) * 2 * epsilon_init - epsilon_init;
```

*この演習では、コードを提出する必要はありません。*

※2：<img src="https://latex.codecogs.com/gif.latex?\inline&space;-\epsilon&space;_{init}" title="-\epsilon _{init}" />を選択するための1つの効果的な戦略は、ネットワークのユニット数を基にすることです。
<img src="https://latex.codecogs.com/gif.latex?\inline&space;\epsilon&space;_{init}" title="\epsilon _{init}" />の良い選択は、<img src="https://latex.codecogs.com/gif.latex?\inline&space;\epsilon&space;_{init}&space;=&space;\frac{\sqrt{6}}{\sqrt{L_{in}&space;&plus;&space;L_{out}}}" title="\epsilon _{init} = \frac{\sqrt{6}}{\sqrt{L_{in} + L_{out}}}" />であり、ここで、<img src="https://latex.codecogs.com/gif.latex?\inline&space;L_{in}&space;=&space;s_{l}" title="L_{in} = s_{l}" />と<img src="https://latex.codecogs.com/gif.latex?\inline&space;L_{out}&space;=&space;s_{l&space;&plus;&space;1}" title="L_{out} = s_{l + 1}" />は、<img src="https://latex.codecogs.com/gif.latex?\inline&space;\Theta&space;^{(l)}" title="\Theta ^{(l)}" />に隣接する層のユニットの数です。

### 2.3. バックプロパゲーション

![図3: バックプロパゲーションの更新](images/ex4/ex4-F3.png)

&nbsp;&ensp;&nbsp;&ensp; 図3: バックプロパゲーションの更新

では、バックプロパゲーションのアルゴリズムを実装しましょう。
バックプロパゲーションのアルゴリズムの背後にある直観は、以下の通りであることを思い出してください。
トレーニング・サンプル(<img src="https://latex.codecogs.com/gif.latex?\inline&space;x^{(t)}" title="x^{(t)}" />、<img src="https://latex.codecogs.com/gif.latex?\inline&space;y^{(t)}" title="y^{(t)}" />)が与えられた場合、ネットワーク全体のすべてのアクティベーションを計算するために、まず「フォワードパス（forward pass）」を実行します（仮説<img src="https://latex.codecogs.com/gif.latex?\inline&space;h_{\Theta&space;}(x)" title="h_{\Theta }(x)" />の出力値を含んでいます）。
次に、<img src="https://latex.codecogs.com/gif.latex?l" title="l" />層の各ノード<img src="https://latex.codecogs.com/gif.latex?j" title="j" />に対して、誤差項<img src="https://latex.codecogs.com/gif.latex?\inline&space;\delta&space;_{j}^{(l)}" title="\delta _{j}^{(l)}" />を計算します。
誤差項<img src="https://latex.codecogs.com/gif.latex?\inline&space;\delta&space;_{j}^{(l)}" title="\delta _{j}^{(l)}" />は、出力における誤差についてノードがどれくらい責任を持っていたかを測定するものです。

出力ノードについては、ネットワークのアクティベーションと真の目標値の差を直接測定し、それを使って<img src="https://latex.codecogs.com/gif.latex?\delta&space;_{j}^{(3)}" title="\delta _{j}^{(3)}" />を定義することができます（3層は出力層なので）。
隠れユニットについては、(<img src="https://latex.codecogs.com/gif.latex?l&space;&plus;&space;1" title="l + 1" />)層のノードの誤差項の加重平均に基づいて<img src="https://latex.codecogs.com/gif.latex?\inline&space;\delta&space;_{j}^{(l)}" title="\delta _{j}^{(l)}" />を計算します。

詳細については、ここにバックプロパゲーションのアルゴリズムがあります（図3にも示されています）。
一度に1つのサンプルを処理するループ内に、手順1～4を実装する必要があります。
具体的には、<img src="https://latex.codecogs.com/gif.latex?\inline&space;t" title="t" />番目のトレーニング・サンプル(<img src="https://latex.codecogs.com/gif.latex?\inline&space;x^{(t)}" title="x^{(t)}" />、<img src="https://latex.codecogs.com/gif.latex?\inline&space;y^{(t)}" title="y^{(t)}" />)の計算を実行するforループ（`for t = 1:m`）の中に、以下の手順1～4を実装します。
手順5は、累積された勾配を<img src="https://latex.codecogs.com/gif.latex?m" title="m" />で除算して、ニューラル・ネットワークのコスト関数の勾配を得ます。

1. 入力層の値(<img src="https://latex.codecogs.com/gif.latex?a(1)" title="a(1)" />)を<img src="https://latex.codecogs.com/gif.latex?\inline&space;t" title="t" />番目のトレーニング・サンプル<img src="https://latex.codecogs.com/gif.latex?\inline&space;x^{(t)}" title="x^{(t)}" />に設定します。
フィードフォワード・パスを実行し、2層と3層のアクティベーション(<img src="https://latex.codecogs.com/gif.latex?z^{(2)}" title="z^{(2)}" />、<img src="https://latex.codecogs.com/gif.latex?a^{(2)}" title="a^{(2)}" />、<img src="https://latex.codecogs.com/gif.latex?z^{(3)}" title="z^{(3)}" />、<img src="https://latex.codecogs.com/gif.latex?a^{(3)}" title="a^{(3)}" />)を計算します。
<img src="https://latex.codecogs.com/gif.latex?a^{(1)}" title="a^{(1)}" />層と<img src="https://latex.codecogs.com/gif.latex?a^{(2)}" title="a^{(2)}" />層のアクティベーションのベクトルにもバイアスユニットが含まれていることを保証するために、+1の項を追加する必要があります。 
Octave/MATLABでは、`a_1`が列ベクトルの場合、1を加算すると`a_1 = [1; a_1]`です。

2. 第3層（出力層）の各出力ユニット<img src="https://latex.codecogs.com/gif.latex?m" title="m" />に対して、

    ![式7](images/ex4/ex4-NF7.png)

    ここで、<img src="https://latex.codecogs.com/gif.latex?y_{k}&space;\in&space;\left&space;\{&space;0,&space;1&space;\right&space;\}" title="y_{k} \in \left \{ 0, 1 \right \}" />は、現在のトレーニング・サンプルがクラス<img src="https://latex.codecogs.com/gif.latex?k" title="k" />(<img src="https://latex.codecogs.com/gif.latex?y_{k}&space;=&space;1" title="y_{k} = 1" />)に属するか、またはそれが異なるクラス(<img src="https://latex.codecogs.com/gif.latex?y_{k}&space;=&space;0" title="y_{k} = 0" />)に属するかを示します。
    このタスクに役立つ論理的な配列があります（前回のプログラミング演習で説明しました）。

3. 隠れ層<img src="https://latex.codecogs.com/gif.latex?l&space;=&space;2" title="l = 2" />については、次を設定します。

    ![式8](images/ex4/ex4-NF8.png)

4. 次の式を使用して、このサンプルの勾配を累積します。 

    <img src="https://latex.codecogs.com/gif.latex?\delta&space;_{0}^{(2)}" title="\delta _{0}^{(2)}" />をスキップまたは削除する必要があることに注意してください。
    Octave/MATLABでは、<img src="https://latex.codecogs.com/gif.latex?\delta&space;_{0}^{(2)}" title="\delta _{0}^{(2)}" />を削除すると、`delta_2 = delta_2(2：end)`に相当します。

    ![式9](images/ex4/ex4-NF9.png)

5. 累積された勾配を<img src="https://latex.codecogs.com/gif.latex?m" title="m" />で割ることにより、（規則化されていない）ニューラル・ネットワークのコスト関数の勾配を得ることができます。

    ![式10](images/ex4/ex4-NF10.png)

----
#### Octave/MATLABのヒント:

バックプロパゲーションのアルゴリズムは、フィードフォワードおよびコスト関数を正常に完了した後にのみ実装する必要があります。
バックプロパゲーションのアルゴリズムを実装する際に、`size`関数を使用して、次元の不一致エラー（Octave/MATLABの「nonconformant arguments」エラー）が発生した場合は、作業している変数のサイズを出力すると便利です。

----

バックプロパゲーションのアルゴリズムを実装すると、スクリプト`ex4.m`は、実装上の勾配チェックを実行します。
勾配チェックでは、コードが勾配を正しく計算しているという自信を高めることができます。

### 2.4. 勾配チェック

ニューラル・ネットワークで、コスト関数<img src="https://latex.codecogs.com/gif.latex?\inline&space;J(\theta)" title="J(\theta)" />を最小にしています。
パラメーターの勾配チェックを実行するために、パラメーター<img src="https://latex.codecogs.com/gif.latex?\inline&space;\Theta&space;(1)" title="\Theta (1)" />、<img src="https://latex.codecogs.com/gif.latex?\inline&space;\Theta&space;(2)" title="\Theta (2)" />を長いベクトル<img src="https://latex.codecogs.com/gif.latex?\inline&space;\theta" title="\theta" />に「アンロール」することが考えられます。
そうすることで、コスト関数を<img src="https://latex.codecogs.com/gif.latex?\inline&space;J(\theta)" title="J(\theta)" />と考えることができ、次の勾配チェックの手順を使用することができます。
 
確証はないけれど<img src="https://latex.codecogs.com/gif.latex?\inline&space;\frac{\partial&space;}{\partial&space;\theta&space;_{i}}J(\theta&space;)" title="\frac{\partial }{\partial \theta _{i}}J(\theta )" />を計算するはずの関数<img src="https://latex.codecogs.com/gif.latex?\inline&space;f_{i}(\theta&space;)" title="f_{i}(\theta )" />があり、
<img src="https://latex.codecogs.com/gif.latex?f_{i}" title="f_{i}" />が正しい微分値を出力しているかどうかを確認したいとします。

![式11](images/ex4/ex4-NF11.png)
 
したがって、<img src="https://latex.codecogs.com/gif.latex?\inline&space;\theta^{(i&plus;)}" title="\theta^{(i+)}" />は<img src="https://latex.codecogs.com/gif.latex?\inline&space;\theta" title="\theta" />と同じで、<img src="https://latex.codecogs.com/gif.latex?\inline&space;i" title="i" />番目の要素は<img src="https://latex.codecogs.com/gif.latex?\inline&space;\epsilon" title="\epsilon" />だけ増分されます。
同様に、<img src="https://latex.codecogs.com/gif.latex?\inline&space;\theta^{(i&minus;)}" title="\theta^{(i-)}" />は、<img src="https://latex.codecogs.com/gif.latex?\inline&space;i" title="i" />番目の要素が<img src="https://latex.codecogs.com/gif.latex?\inline&space;\epsilon" title="\epsilon" />だけ減少した対応するベクトルです。
各<img src="https://latex.codecogs.com/gif.latex?i" title="i" />について、<img src="https://latex.codecogs.com/gif.latex?\inline&space;f_{i}(\theta&space;)" title="f_{i}(\theta )" />の正しさを次のように数値で検証することができます。

![式12](images/ex4/ex4-NF12.png)

これらの2つの値が互いに近似する程度は、<img src="https://latex.codecogs.com/gif.latex?J" title="J" />の詳細に依存します。
しかし、<img src="https://latex.codecogs.com/gif.latex?\inline&space;\epsilon&space;=&space;10^{-4}" title="\epsilon = 10^{-4}" />と仮定すると、通常、上記の左右の辺は少なくとも4桁の有効数字に一致します(そして多くの場合、さらに多く)。
`computeNumericalGradient.m`の数値的勾配を計算する関数を実装しました。
ファイルを変更する必要はありませんが、どのように動作するかを理解するために、コードを確認してください。
`ex4.m`の次のステップでは、与えられた関数`checkNNGradients.m`を実行します。
この関数は、勾配のチェックに使用される小さなニューラル・ネットワークとデータセットを作成します。
バックプロパゲーションの実装が正しい場合は、1e-9より小さい相対的な差があるはずです。

----

#### 実際のヒント：

勾配チェックを実行する場合、比較的少数の入力ユニットと隠れユニットを持つ小さなニューラル・ネットワークを使用する方がはるかに効率的です。
<img src="https://latex.codecogs.com/gif.latex?\inline&space;\theta" title="\theta" />の各次元はコスト関数の2つの評価を必要とし、これは高価になる可能性があります。
関数`checkNNGradients`で、コードは小さなランダムなモデルとデータセットを作成します。
これは、勾配チェックのために`computeNumericalGradient`で使用されます。
さらに、勾配計算が正しいことを確信したら、学習アルゴリズムを実行する前に勾配チェックをオフにする必要があります。

----

----

#### 実用的なヒント：

勾配チェックは、コストと勾配を計算しているすべての関数で機能します。
具体的には、同じ`computeNumericalGradient.m`関数を使用して、他の演習の勾配の実装が正しいかどうかを確認することもできます
（ロジスティック回帰のコスト関数など）。

----

*コスト関数が（正則化されていない）ニューラル・ネットワークコスト関数の勾配チェックをパスしたら、ニューラル・ネットワーク勾配関数（バックプロパゲーション）を提出する必要があります。*

### 2.5. 正則化されたニューラル・ネットワーク

バックプロパゲーションのアルゴリズムを正常に実装したら、勾配に正則化を追加します。
正則化を説明するために、バックプロパゲーションを使用して勾配を計算した後で、これを追加項として追加することができます。
 
具体的には、バックプロパゲーションを使用して<img src="https://latex.codecogs.com/gif.latex?\inline&space;\Delta&space;_{ij}^{(l)}" title="\Delta _{ij}^{(l)}" />を計算した後、以下を使用して正則化を追加する必要があります。

![式13](images/ex4/ex4-NF13.png)

バイアス項に使用される<img src="https://latex.codecogs.com/gif.latex?\inline&space;\Theta&space;^{(l)}" title="\Theta ^{(l)}" />の最初の列を正則化すべきではないことに注意してください。
さらに、パラメーター<img src="https://latex.codecogs.com/gif.latex?\Theta&space;_{ij}^{(l)}" title="\Theta _{ij}^{(l)}" />において、<img src="https://latex.codecogs.com/gif.latex?i" title="i" />は1からインデックスされ、<img src="https://latex.codecogs.com/gif.latex?j" title="j" />は0からインデックス付けされます。したがって、

![式14](images/ex4/ex4-NF14.png)

少し紛らわしいですが、Octave/MATLABでのインデックス付けは1から始まります（<img src="https://latex.codecogs.com/gif.latex?\inline&space;i" title="i" />と<img src="https://latex.codecogs.com/gif.latex?\inline&space;j" title="j" />の両方で）。
したがって、`Theta1(2,1)`は実際に<img src="https://latex.codecogs.com/gif.latex?\inline&space;\Theta&space;_{2,&space;0}^{(l)}" title="\Theta _{2, 0}^{(l)}" />に対応します（つまり、上記行列<img src="https://latex.codecogs.com/gif.latex?\inline&space;\Theta" title="\Theta" />の第2行、第1列）。

今度は、正則化を考慮に入れて、`nnCostFunction`の`grad`を計算するコードを修正してください。
完了後、`ex4.m`スクリプトは、実装の勾配チェックを実行します。
コードが正しければ、1e-9より小さい相対的な差異が見られるはずです。
 
*ここで解答を提出する必要があります。*

### 2.6. `fmincg`を使用した学習パラメーター

ニューラル・ネットワークのコスト関数と勾配の計算を正常に実装した後の、`ex4.m`スクリプトの次のステップでは、`fmincg`を使用して適切なパラメーターを学習します。

トレーニングが完了したら、`ex4.m`スクリプトは適切なサンプルの割合を計算することによって、分類器のトレーニング精度を報告します。
実装が正しい場合、報告されたトレーニングの精度は約`95.3`％です（これは、ランダム初期化のために約1％変化する可能性があります）。
より多くの反復でニューラル・ネットワークをトレーニングすることにより、より高いトレーニング精度を得ることが可能です。
反復回数を増やしたり（たとえば、`MaxIter`を400に設定）、正規化パラメーター<img src="https://latex.codecogs.com/gif.latex?\inline&space;\lambda" title="\lambda" />を変更して、ニューラル・ネットワークをトレーニングすることをお勧めします。
正しい学習設定であれば、ニューラル・ネットワークをトレーニング・セットに完全にフィットさせることができます。

### 3. 隠れ層の可視化

ニューラル・ネットワークが何を学習しているかを理解する方法の一つは、隠れユニットによってどのような表現がキャプチャーされたかを可視化することです。
平たく言えば、特定の隠れユニットが与えられた場合、それが何を計算するかを可視化する1つの方法は、それが活性化する（すなわち、アクティベーション値<img src="https://latex.codecogs.com/gif.latex?i" title="i" />を1に近づける）入力<img src="https://latex.codecogs.com/gif.latex?x" title="x" />を見つけることです。
トレーニングしたニューラル・ネットワークでは、<img src="https://latex.codecogs.com/gif.latex?\inline&space;\Theta&space;(1)" title="\Theta (1)" />の<img src="https://latex.codecogs.com/gif.latex?\inline&space;i" title="i" />番目の行は、<img src="https://latex.codecogs.com/gif.latex?\inline&space;i" title="i" />番目の隠れユニットのパラメーターを表す401次元ベクトルです。
バイアス項を破棄すると、各入力ピクセルから隠れユニットまでの重みを表す400次元のベクトルが得られます。

したがって、隠れユニットによって捕捉された「表現」を可視化する1つの方法は、この400次元ベクトルを20×20画像に再形成して表示することです（※3）。
`ex4.m`の次のステップでは、`displayData`関数を使用してこれを行い、25個のユニットを持つ画像（図4と同様）を表示します。
各ユニットは、ネットワーク内の1つの隠れユニットに対応しています。

トレーニングされたネットワークでは、隠れユニットは入力のストロークやその他のパターンを探す検出器に大まかに対応していることが分かります。

![図4：隠れユニットの可視化](images/ex4/ex4-F4.png)

&nbsp;&ensp;&nbsp;&ensp; 図4：隠れユニットの可視化

※3：これは、入力に対して「ノルム」制約が与えられていること（すなわち、<img src="https://latex.codecogs.com/gif.latex?\left&space;\|&space;x&space;\right&space;\|_{2}&space;\leq&space;1" title="\left \| x \right \|_{2} \leq 1" />）と、隠れユニットに対して最も高いアクティベーションを与える入力を見つけることと等価であることが分かります。

### 3.1. オプションの（非評価）演習

この演習では、ニューラル・ネットワークのさまざまな学習設定を試して、正則化パラメーター<img src="https://latex.codecogs.com/gif.latex?\inline&space;\lambda" title="\lambda" />とトレーニングステップ数（`fmincg`を使用する場合の`MaxIter`オプション）によってニューラル・ネットワークのパフォーマンスがどのように変化するかを確認します。

ニューラル・ネットワークは非常に複雑な決定境界を形成することができる非常に強力なモデルです。
正則化がなければ、ニューラル・ネットワークはトレーニング・セットを「オーバーフィット」する可能性があり、トレーニング・セットの100％に近い精度を得ることができますが、それまで見たことのない新しいサンプルには適合しません。
正則化<img src="https://latex.codecogs.com/gif.latex?\inline&space;\lambda" title="\lambda" />を小さな値に、`MaxIter`パラメーターをより多くの反復回数に設定して、確認ができます。

学習パラメーター<img src="https://latex.codecogs.com/gif.latex?\inline&space;\lambda" title="\lambda" />と`MaxIter`を変更すると、隠れユニットの可視化の変化を自分で確認することもできます。

*これらのオプション（非評価）の演習問題の解答を提出する必要はありません。*

## 提出と採点

この課題が完了したら、送信機能を使用して解答を我々のサーバーに送信してください。
以下は、この演習の各パートの得点の内訳です。

 パート | 提出するファイル | 点数　
----|----|---- 
 フィードフォワードとコスト関数 | `nnCostFunction.m` | 30 点 
 正則化コスト関数 | `nnCostFunction.m` | 15 点 
 シグモイド勾配 | `sigmoidGradient.m` | 5 点 
 ニューラルネット勾配関数（バックプロパゲーション） | `nnCostFunction.m` | 40 点 
 正則化勾配 | `nnCostFunction.m` | 10 点 
 合計点 |  | 100 点 

解答を複数回提出することは許可されており、最高のスコアのみを考慮に入れます。
