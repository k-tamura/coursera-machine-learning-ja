%% 機械学習オンラインクラス - 演習 3 | Part 1: One-vs-all

%  指示
%  ------------
%
%  このファイルには、線形演習を開始するのに役立つコードが含まれています。
%  この演習では、次の関数を完成する必要があります。
%
%
%     lrCostFunction.m (logistic regression cost function)
%     oneVsAll.m
%     predictOneVsAll.m
%     predict.m
%
%  この演習では、このファイルまたは上記以外のファイル内のコードを
%  変更する必要はありません。
%

%% 初期化
clear ; close all; clc

%% この演習で使用するパラメーターをセットアップする
input_layer_size  = 400;  % 20x20入力の数字画像
hidden_layer_size = 25;   % 25 隠れユニット
                          % （ラベル10に "0"をマッピングしていることに注意してください）

%% =========== パート 1: データの読み込みと可視化 =============
%  最初にデータセットを読み込んで可視化することで、この演習を開始します。
%  手書き数字を含むデータセットを使用して作業します。
%

% トレーニングデータを読み込む
fprintf('Loading and Visualizing Data ...\n')

load('ex3data1.mat'); % 配列X、yに格納されたトレーニングデータ
m = size(X, 1);

% 表示するデータ点をランダムに100選択
rand_indices = randperm(m);
sel = X(rand_indices(1:100), :);

displayData(sel);

fprintf('Program paused. Press enter to continue.\n');
pause;

%% ============ パート 2a: ロジスティック回帰をベクトル化する ============
%  この演習では、前回の演習のロジスティック回帰コードを再利用します。
%  ここでの作業は、正規化されたロジスティック回帰の実装が
%  ベクトル化されていることを確認することです。
%  その後、手書きの数字データセットに対して一対全ての分類を実装します。
%  
%

% lrCostFunctionのテストケース
fprintf('\nTesting lrCostFunction() with regularization');

theta_t = [-2; -1; 1; 2];
X_t = [ones(5,1) reshape(1:15,5,3)/10];
y_t = ([1;0;1;0;1] >= 0.5);
lambda_t = 3;
[J grad] = lrCostFunction(theta_t, X_t, y_t, lambda_t);

fprintf('\nCost: %f\n', J);
fprintf('Expected cost: 2.534819\n');
fprintf('Gradients:\n');
fprintf(' %f \n', grad);
fprintf('Expected gradients:\n');
fprintf(' 0.146561\n -0.548558\n 0.724722\n 1.398003\n');

fprintf('Program paused. Press enter to continue.\n');
pause;
%% ============ パート 2b: 1対全てのトレーニング ============
fprintf('\nTraining One-vs-All Logistic Regression...\n')

lambda = 0.1;
[all_theta] = oneVsAll(X, y, num_labels, lambda);

fprintf('Program paused. Press enter to continue.\n');
pause;


%% ================ パート 3: 1対全ての予測 ================

pred = predictOneVsAll(all_theta, X);

fprintf('\nTraining Set Accuracy: %f\n', mean(double(pred == y)) * 100);

