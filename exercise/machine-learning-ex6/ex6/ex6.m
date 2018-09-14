%% 機械学習オンラインクラス
%  演習 6 | サポート・ベクター・マシン
%
%  指示
%  ------------
% 
%  このファイルには、演習を開始するのに役立つコードが含まれています。
%  次の関数を完成する必要があります。
%
%     gaussianKernel.m
%     dataset3Params.m
%     processEmail.m
%     emailFeatures.m
%
%  この演習では、このファイルまたは上記以外のファイル内のコードを
%  変更する必要はありません。
%

%% 初期化
clear ; close all; clc

%% =============== パート 1: データのロードと可視化 ================
%  最初にデータセットを読み込んで可視化することから始めます。
%  次のコードは、データセットを環境にロードし、データをプロットします。
%  
%

fprintf('Loading and Visualizing Data ...\n')

% ex6data1からロード
% 環境にX, yがロードされる
load('ex6data1.mat');

% トレーニング・データをプロットする
plotData(X, y);

fprintf('Program paused. Press enter to continue.\n');
pause;

%% ==================== パート 2: 線形SVMのトレーニング ====================
%  次のコードは、データセット上の線形SVMをトレーニングし、学習された決定境界を
%  プロットします。
%

% ex6data1からロード
% 環境にX, yがロードされる
load('ex6data1.mat');

fprintf('\nTraining Linear SVM ...\n')

% 下記のCの値を変更し、決定境界がどのように変化するかを確認する必要があります
% （たとえば、C = 1000を試してみてください）
C = 1;
model = svmTrain(X, y, C, @linearKernel, 1e-3, 20);
visualizeBoundaryLinear(X, y, model);

fprintf('Program paused. Press enter to continue.\n');
pause;

%% =============== パート 3: ガウスカーネルの実装 ===============
%  ここで、SVMで使用するガウスカーネルを実装します。 
%  gaussianKernel.mのコードを完成させる必要があります。
%
fprintf('\nEvaluating the Gaussian Kernel ...\n')

x1 = [1 2 1]; x2 = [0 4 -1]; sigma = 2;
sim = gaussianKernel(x1, x2, sigma);

fprintf(['Gaussian Kernel between x1 = [1; 2; 1], x2 = [0; 4; -1], sigma = %f :' ...
         '\n\t%f\n(for sigma = 2, this value should be about 0.324652)\n'], sigma, sim);

fprintf('Program paused. Press enter to continue.\n');
pause;

%% =============== パート 4: データセット2の可視化 ================
%  次のコードは、データセットを環境にロードし、データをプロットします。
%  
%

fprintf('Loading and Visualizing Data ...\n')

% ex6data2からロード
% 環境にX、yがロードされます
load('ex6data2.mat');

% トレーニング・データをプロットする
plotData(X, y);

fprintf('Program paused. Press enter to continue.\n');
pause;

%% ========== パート 5: RBFカーネルによるSVMのトレーニング (データセット2) ==========
%  カーネルを実装したら、これを使ってSVM分類器をトレーニングすることができます。
%  
% 
fprintf('\nTraining SVM with RBF Kernel (this may take 1 to 2 minutes) ...\n');

% ex6data2からロード
% 環境にX、yがロードされます
load('ex6data2.mat');

% SVMパラメーター
C = 1; sigma = 0.1;

% ここで許容値とmax_passesを低く設定して、コードがより速く実行されるようにしています。
% ただし、実際には、トレーニングを収束するように実行する必要があります。
% 
model= svmTrain(X, y, C, @(x1, x2) gaussianKernel(x1, x2, sigma)); 
visualizeBoundary(X, y, model);

fprintf('Program paused. Press enter to continue.\n');
pause;

%% =============== パート 6: データセット3の可視化 ================
%  以下のコードは、次のデータセットを環境にロードし、データをプロットします。
%  
%

fprintf('Loading and Visualizing Data ...\n')

% ex6data3からロード
% 環境にX、yがロードされます
load('ex6data3.mat');

% トレーニング・データをプロットする
plotData(X, y);

fprintf('Program paused. Press enter to continue.\n');
pause;

%% ========== パート 7: RBFカーネルによるSVMのトレーニング (データセット3) ==========

%  これは実験に使用できる別のデータセットです。ここではCとsigmaの異なる値を
%  試してみてください。
% 

% ex6data3からロード
% 環境にX、yがロードされます
load('ex6data3.mat');

% ここで異なるSVMパラメーターを試してみてください
[C, sigma] = dataset3Params(X, y, Xval, yval);

% SVMをトレーニングする
model= svmTrain(X, y, C, @(x1, x2) gaussianKernel(x1, x2, sigma));
visualizeBoundary(X, y, model);

fprintf('Program paused. Press enter to continue.\n');
pause;

