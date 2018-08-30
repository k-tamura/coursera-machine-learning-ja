%% 機械学習オンラインクラス - 演習 3 | パート 2: ニューラル・ネットワーク

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
num_labels = 10;          % 10ラベル（1～10）
                          % （ラベル10に "0"をマッピングしていることに注意してください）

%% =========== パート 1: データの読み込みと可視化 =============
%  最初にデータセットを読み込んで可視化することで、この演習を開始します。
%  手書き数字を含むデータセットを使用して作業します。
%

% トレーニングデータを読み込む
fprintf('Loading and Visualizing Data ...\n')

load('ex3data1.mat');
m = size(X, 1);

% 表示するデータ点をランダムに100選択
sel = randperm(size(X, 1));
sel = sel(1:100);

displayData(X(sel, :));

fprintf('Program paused. Press enter to continue.\n');
pause;

%% ================ パート 2: パラメーターの読み込み ================
% この演習では、初期化されたニューラル・ネットワークのパラメーターを
% 読み込みます。

fprintf('\nLoading Saved Neural Network Parameters ...\n')

% 変数Theta1とTheta2にウェイトをロードする
load('ex3weights.mat');

%% ================= パート 3: 予測の実装 =================
% ニューラル・ネットワークをトレーニングした後、それを用いてラベルを
% 予測します。ニューラル・ネットワークを使用してトレーニング・セットの
% ラベルを予測する「predict」関数を実装することになります。
% これにより、トレーニング・セットの精度を計算できます。

pred = predict(Theta1, Theta2, X);

fprintf('\nTraining Set Accuracy: %f\n', mean(double(pred == y)) * 100);

fprintf('Program paused. Press enter to continue.\n');
pause;

%  ネットワークの出力を知るために、1度に1つのサンプルを実行して、
%  何を予測するかを確認することもできます。

%  サンプルをランダムに並べ替える
rp = randperm(m);

for i = 1:m
    % Display 
    fprintf('\nDisplaying Example Image\n');
    displayData(X(rp(i), :));

    pred = predict(Theta1, Theta2, X(rp(i),:));
    fprintf('\nNeural Network Prediction: %d (digit %d)\n', pred, mod(pred, 10));
    
    % Pause with quit option
    s = input('Paused - press enter to continue, q to exit:','s');
    if s == 'q'
      break
    end
end

