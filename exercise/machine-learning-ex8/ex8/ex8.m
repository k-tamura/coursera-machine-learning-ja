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

%  トレーニング・セットの外れ値を見つけてプロットする
outliers = find(p < epsilon);

%  それらの外れ値の周囲に赤い円を描く
hold on
plot(X(outliers, 1), X(outliers, 2), 'ro', 'LineWidth', 2, 'MarkerSize', 10);
hold off

fprintf('Program paused. Press enter to continue.\n');
pause;

%% ================== パート 4: 多次元異常値 ===================
%  前半パートのコードを使用して、より多くのフィーチャーが各データ点を説明し、
%  その中の一部のフィーチャーだけがデータ点が異常値であるかどうかを示すような、
%  さらに難しい問題に適用します。
%

%  2番目のデータセットを読み込みます
%  環境に変数X、Xval、yvalがロードされます。
load('ex8data2.mat');

%  より大きなデータセットに同じ手順を適用する
[mu sigma2] = estimateGaussian(X);

%  トレーニング・セット
p = multivariateGaussian(X, mu, sigma2);

%  クロス・バリデーション・セット
pval = multivariateGaussian(Xval, mu, sigma2);

%  最適な閾値を見つける
[epsilon F1] = selectThreshold(yval, pval);

fprintf('Best epsilon found using cross-validation: %e\n', epsilon);
fprintf('Best F1 on Cross Validation Set:  %f\n', F1);
fprintf('   (you should see a value epsilon of about 1.38e-18)\n');
fprintf('   (you should see a Best F1 value of 0.615385)\n');
fprintf('# Outliers found: %d\n\n', sum(p < epsilon));
