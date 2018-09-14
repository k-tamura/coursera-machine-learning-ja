%% 機械学習オンラインクラス - 演習 2: Logistic Regression
%
%  指示
%  ------------
%
%  このファイルには、ロジスティック回帰の正則化を対象とする演習の
%  ２番目のパートを開始するのに役立つコードが含まれています。
%  
%  この演習では、以下の関数を完成する必要があります：
%
%     sigmoid.m
%     costFunction.m
%     predict.m
%     costFunctionReg.m
%
%  このファイルまたは上記以外のファイル内のコードを
%  変更する必要はありません。
%

%% 初期化
clear ; close all; clc

%% データをロード
%  最初の2つの列にはX値が含まれ、3つ目の列にはラベル（y）が
%  含まれます。

data = load('ex2data2.txt');
X = data(:, [1, 2]); y = data(:, 3);

plotData(X, y);

% いくつかのラベルを付ける
hold on;

% ラベルと凡例
xlabel('Microchip Test 1')
ylabel('Microchip Test 2')

% プロット順で指定
legend('y = 1', 'y = 0')
hold off;


%% =========== パート 1: 正則化されたロジスティック回帰 ============
%  このパートでは、線形に分離できないデータ点を持つデータセットが
%  与えられます。しかし、ロジスティック回帰を使用してデータ点を
%  分類したいと考えています。
%  
%  これを行うには、より多くのフィーチャーを使用する必要があります。
%  特に、データ行列に多項式フィーチャーを追加します
%  （多項式回帰と同様）。
%

% 多項式のフィーチャーを追加する

% mapFeatureも1の列を追加するので、切片項が処理されることに
% 注意してください。
X = mapFeature(X(:,1), X(:,2));

% フィッティング・パラメーターを初期化する
initial_theta = zeros(size(X, 2), 1);

% 正則化パラメーターlambdaを1に設定する
lambda = 1;

% 正則化されたロジスティック回帰の初期コストと勾配を計算し、
% 表示する
[cost, grad] = costFunctionReg(initial_theta, X, y, lambda);

fprintf('Cost at initial theta (zeros): %f\n', cost);
fprintf('Expected cost (approx): 0.693\n');
fprintf('Gradient at initial theta (zeros) - first five values only:\n');
fprintf(' %f \n', grad(1:5));
fprintf('Expected gradients (approx) - first five values only:\n');
fprintf(' 0.0085\n 0.0188\n 0.0001\n 0.0503\n 0.0115\n');

fprintf('\nProgram paused. Press enter to continue.\n');
pause;

% すべて1のthetaとlambda= 10でコストと勾配を計算し、
% 表示する
test_theta = ones(size(X,2),1);
[cost, grad] = costFunctionReg(test_theta, X, y, 10);

fprintf('\nCost at test theta (with lambda = 10): %f\n', cost);
fprintf('Expected cost (approx): 3.16\n');
fprintf('Gradient at test theta - first five values only:\n');
fprintf(' %f \n', grad(1:5));
fprintf('Expected gradients (approx) - first five values only:\n');
fprintf(' 0.3460\n 0.1614\n 0.1948\n 0.2269\n 0.0922\n');

fprintf('\nProgram paused. Press enter to continue.\n');
pause;

%% ============= パート 2: 正則化と精度 =============
%  オプションの演習:
%  このパートでは、lambdaのさまざまな値を試して、正則化が境界決定にどのように
%  影響を与えるかを見てみましょう。
%  
%  lambdaに次の値を試してください：0、1、10、100
%  
%  lambdaを変えるときに決定境界はどのように変化するでしょうか？ 
%  トレーニング・セットの精度はどのように変化するでしょうか？
%

% フィッティング・パラメーターを初期化する
initial_theta = zeros(size(X, 2), 1);

% 正則化パラメーターλを1に設定します（これは変える必要があります）
lambda = 1;

% オプションを設定する
options = optimset('GradObj', 'on', 'MaxIter', 400);

% 最適化する
[theta, J, exit_flag] = ...
	fminunc(@(t)(costFunctionReg(t, X, y, lambda)), initial_theta, options);

% 境界をプロットする
plotDecisionBoundary(theta, X, y);
hold on;
title(sprintf('lambda = %g', lambda))

% ラベルと凡例
xlabel('Microchip Test 1')
ylabel('Microchip Test 2')

legend('y = 1', 'y = 0', 'Decision boundary')
hold off;

% トレーニング・セットの精度を計算する
p = predict(theta, X);

fprintf('Train Accuracy: %f\n', mean(double(p == y)) * 100);
fprintf('Expected accuracy (with lambda = 1): 83.1 (approx)\n');

