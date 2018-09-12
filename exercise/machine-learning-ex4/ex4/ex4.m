%% 機械学習オンラインクラス - 演習 4 ニューラルネットワークの学習

%  指示
%  ------------
% 
%  このファイルには、演習を開始するのに役立つコードが含まれています。
%  この演習では、次の関数を完成する必要があります。
% 
%
%     sigmoidGradient.m
%     randInitializeWeights.m
%     nnCostFunction.m
%
%  この演習では、このファイルまたは上記以外のファイル内のコードを
%  変更する必要はありません。
%

%% 初期化
clear ; close all; clc

%% この演習で使用するパラメーターをセットアップする
input_layer_size  = 400;  % 20x20入力の数字画像
hidden_layer_size = 25;   % 25 隠れユニット
num_labels = 10;          % 10ラベル（1～10）
                          % （ラベル10に "0"をマッピングしていることに注意してください）

%% =========== パート 1: データのロードと可視化 =============
%  最初にデータセットを読み込んで可視化することから始めます。
%  手書き数字を含むデータセットを使用して作業します。
%

% トレーニングデータをロードする
fprintf('Loading and Visualizing Data ...\n')

load('ex4data1.mat');
m = size(X, 1);

% 表示するデータ点をランダムに100個選択する
sel = randperm(size(X, 1));
sel = sel(1:100);

displayData(X(sel, :));

fprintf('Program paused. Press enter to continue.\n');
pause;


%% ================ パート 2: パラメータのロード ================
% この演習では、初期化されたニューラル・ネットワークのパラメーターを
% ロードします。

fprintf('\nLoading Saved Neural Network Parameters ...\n')

% 変数Theta1とTheta2にウェイトをロードする
load('ex4weights.mat');

% パラメータのアンロール
nn_params = [Theta1(:) ; Theta2(:)];

%% ================ パート 3: コストの計算（フィードフォワード） ================
%  ニューラル・ネットワークに、コストのみを返すニューラル・ネットワークの
%  フィードフォワード部分を実装することから始めてください。
%  コストを返すには、nnCostFunction.mのコードを完成させる必要があります。
%  コストを計算するためにフィードフォワードを実装した後、
%  固定値のデバッグ・パラメーターと同じコストを得ることを検証して、
%  実装が正しいことを検証できます。
%  
%  最初に正則化せずに、フィードフォワードのコストを実装することをお勧めします。
%  これにより、デバッグが容易になります。その後、パート4では、正則化のコストを
%  導入することになります。
%
fprintf('\nFeedforward Using Neural Network ...\n')

% ウェイトを正則化パラメーターに設定します（ここでは0に設定します）。
lambda = 0;

J = nnCostFunction(nn_params, input_layer_size, hidden_layer_size, ...
                   num_labels, X, y, lambda);

fprintf(['Cost at parameters (loaded from ex4weights): %f '...
         '\n(this value should be about 0.287629)\n'], J);

fprintf('\nProgram paused. Press enter to continue.\n');
pause;

%% =============== パート 4: 正則化の実装 ===============
%  コスト関数の実装が正しければ、今度は正則化をコストに
%  実装する必要があります。
%

fprintf('\nChecking Cost Function (w/ Regularization) ... \n')

% ウェイトを正則化パラメーターに設定します（ここでは1に設定します）。
lambda = 1;

J = nnCostFunction(nn_params, input_layer_size, hidden_layer_size, ...
                   num_labels, X, y, lambda);

fprintf(['Cost at parameters (loaded from ex4weights): %f '...
         '\n(this value should be about 0.383770)\n'], J);

fprintf('Program paused. Press enter to continue.\n');
pause;


%% ================ パート 5: シグモイド勾配  ================
%  ニューラルネットワークの実装を開始する前に、まずシグモイド関数の勾配を実装します。
%  sigmoidGradient.mファイルのコードを完成させる必要があります。
%  
%

fprintf('\nEvaluating sigmoid gradient...\n')

g = sigmoidGradient([-1 -0.5 0 0.5 1]);
fprintf('Sigmoid gradient evaluated at [-1 -0.5 0 0.5 1]:\n  ');
fprintf('%f ', g);
fprintf('\n\n');

fprintf('Program paused. Press enter to continue.\n');
pause;


%% ================ パート 6: パラメーターの初期化 ================
%  演習のこのパートでは、数字を分類する2層のニューラル・ネットワークの実装を始めます。
%  ニューラル・ネットワークのウェイトを初期化する関数を実装することから始めます
%  (randInitializeWeights.m)。
%  

fprintf('\nInitializing Neural Network Parameters ...\n')

initial_Theta1 = randInitializeWeights(input_layer_size, hidden_layer_size);
initial_Theta2 = randInitializeWeights(hidden_layer_size, num_labels);

% パラメーターのアンロール
initial_nn_params = [initial_Theta1(:) ; initial_Theta2(:)];


%% =============== パート 7: バックプロパゲーションの実装 ===============
%  コストが正しい値と一致したら、ニューラル・ネットワークのバックプロパゲーションの
%  アルゴリズムを実装します。nnCostFunction.mに、パラメーターの偏微分を返すコードを
%  追加で実装する必要があります。
%
fprintf('\nChecking Backpropagation... \n');

% checkNNGradientsを実行して、勾配をチェックする
checkNNGradients;

fprintf('\nProgram paused. Press enter to continue.\n');
pause;


%% =============== パート 8: 正則化の実装 ===============
%  バックプロパゲーションの実装が正しければ、次はコストと勾配とともに
%  正則化を実装する必要があります。
%

fprintf('\nChecking Backpropagation (w/ Regularization) ... \n')

% checkNNGradientsを実行してグラデーションをチェックする
lambda = 3;
checkNNGradients(lambda);

% costFunctionデバッグ値も出力する
debug_J  = nnCostFunction(nn_params, input_layer_size, ...
                          hidden_layer_size, num_labels, X, y, lambda);

fprintf(['\n\nCost at (fixed) debugging parameters (w/ lambda = %f): %f ' ...
         '\n(for lambda = 3, this value should be about 0.576051)\n\n'], lambda, debug_J);

fprintf('Program paused. Press enter to continue.\n');
pause;


%% =================== パート 8: ニューラル・ネットワークのトレーニング ===================
%  ニューラル・ネットワークのトレーニングに必要なすべてのコードを実装しました。
%  ニューラル・ネットワークをトレーニングするために、ここでは "fmincg"を使用します。
%  これは "fminunc"と同様に機能します。これらの最適化されたオプティマイザは、
%  それらに勾配計算を提供するように、コスト関数を効率的にトレーニングできることを
%  思い出してください。
%
fprintf('\nTraining Neural Network... \n')

% 課題を完了したら、MaxIterをより大きな値に変更して、トレーニングの
% 効果を確認する。
options = optimset('MaxIter', 50);

% 異なる値のラムダも試すこと
lambda = 1;

% コスト関数を最小化するための「short hand」を作成する
costFunction = @(p) nnCostFunction(p, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, X, y, lambda);

% ここで、costFunctionは引数（ニューラル・ネットワーク・パラメーター）を1つだけ取る
% 関数です。
[nn_params, cost] = fmincg(costFunction, initial_nn_params, options);

% Theta1とTheta2をnn_paramsから取得する
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

fprintf('Program paused. Press enter to continue.\n');
pause;


%% ================= パート 9: ウェイトを可視化 =================
%  データに取り込んでいるフィーチャーが何かを確認するため、隠れユニットを表示することで、
%  ニューラル・ネットワークが学習していることを「可視化」できるようになります。
%  

fprintf('\nVisualizing Neural Network... \n')

displayData(Theta1(:, 2:end));

fprintf('\nProgram paused. Press enter to continue.\n');
pause;

%% ================= パート 10: 予測の実装 =================
%  ニューラルネット・ワークをトレーニングしたら、それを用いてラベルを予測します。
%  トレーニング・セットのラベルを予測するために、ニューラルネット・ネットワークを使用する
%  「予測」機能を実装します。これにより、トレーニング・セットの精度を計算できます。
%  

pred = predict(Theta1, Theta2, X);

fprintf('\nTraining Set Accuracy: %f\n', mean(double(pred == y)) * 100);


