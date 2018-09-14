%% 機械学習オンラインクラス
%  演習 8 | 異常検出と協調フィルタリング
%
%  指示
%  ------------
%
%  このファイルには、演習を開始するのに役立つコードが含まれています。
%  次の関数を完成する必要があります。
%
%     estimateGaussian.m
%     selectThreshold.m
%     cofiCostFunc.m
%
%  この演習では、このファイルまたは上記以外のファイル内のコードを
%  変更する必要はありません。
%

%% 初期化
clear ; close all; clc

%% ================== パート 1: サンプルデータセットのロード  ===================
%  可視化しやすい小さなデータセットを使ってこの演習を開始します。
%  
%
%  このサンプルのケースは、複数のマシン間の2つのネットワーク・サーバーの
%  統計情報（各マシンの待ち時間とスループット）で構成されています。この演習は、
%  おそらく障害のある（または非常に速い）マシンを見つけるのに役立ちます。
%

fprintf('Visualizing example dataset for outlier detection.\n\n');

%  次のコマンドは、データセットをロードします。
%  環境に変数X、Xval、yvalがロードされます。
load('ex8data1.mat');

%  サンプルのデータセットを可視化する
plot(X(:, 1), X(:, 2), 'bx');
axis([0 30 0 30]);
xlabel('Latency (ms)');
ylabel('Throughput (mb/s)');

fprintf('Program paused. Press enter to continue.\n');
pause


%% ================== パート 2: データセットの統計の推定 ===================
%  この演習では、データセットはガウス分布していることを仮定します。
%
%  最初に仮定したガウス分布のパラメーターを推定し、各点の確率を計算し、
%  全体分布と各点がその分布に対してどこにあるかを可視化します。
%  
%  
%
fprintf('Visualizing Gaussian fit.\n\n');

%  muとsigma2を推定する
[mu sigma2] = estimateGaussian(X);

%  Xの各データ点（行）での多変量正規分布の密度を返す
%  
p = multivariateGaussian(X, mu, sigma2);

%  フィットしているかを可視化する
visualizeFit(X,  mu, sigma2);
xlabel('Latency (ms)');
ylabel('Throughput (mb/s)');

fprintf('Program paused. Press enter to continue.\n');
pause;

%% ================== パート 3: 異常値を見つける ===================
%  次は、推定されたガウス分布を考慮したクロス・バリデーション・セットの確率を
%  使用して、適切な閾値epsilonを見つけます。
% 

pval = multivariateGaussian(Xval, mu, sigma2);

[epsilon F1] = selectThreshold(yval, pval);
fprintf('Best epsilon found using cross-validation: %e\n', epsilon);
fprintf('Best F1 on Cross Validation Set:  %f\n', F1);
fprintf('   (you should see a value epsilon of about 8.99e-05)\n');
fprintf('   (you should see a Best F1 value of  0.875000)\n\n');

%  Find the outliers in the training set and plot the
outliers = find(p < epsilon);

%  Draw a red circle around those outliers
hold on
plot(X(outliers, 1), X(outliers, 2), 'ro', 'LineWidth', 2, 'MarkerSize', 10);
hold off

fprintf('Program paused. Press enter to continue.\n');
pause;

%% ================== パート 4: Multidimensional Outliers ===================
%  We will now use the code from the previous part and apply it to a 
%  harder problem in which more features describe each datapoint and only 
%  some features indicate whether a point is an outlier.
%

%  Loads the second dataset. You should now have the
%  variables X, Xval, yval in your environment
load('ex8data2.mat');

%  Apply the same steps to the larger dataset
[mu sigma2] = estimateGaussian(X);

%  Training set 
p = multivariateGaussian(X, mu, sigma2);

%  Cross-validation set
pval = multivariateGaussian(Xval, mu, sigma2);

%  Find the best threshold
[epsilon F1] = selectThreshold(yval, pval);

fprintf('Best epsilon found using cross-validation: %e\n', epsilon);
fprintf('Best F1 on Cross Validation Set:  %f\n', F1);
fprintf('   (you should see a value epsilon of about 1.38e-18)\n');
fprintf('   (you should see a Best F1 value of 0.615385)\n');
fprintf('# Outliers found: %d\n\n', sum(p < epsilon));
