%% 機械学習オンラインクラス
%  演習1: 複数変数による線形回帰
%
%  指示
%  ------------
% 
%  このファイルには、線形回帰の演習を開始するのに役立つコードが含まれています。
%
%
%  この練習では、次の機能を完了する必要があります。
%
%     warmUpExercise.m
%     plotData.m
%     gradientDescent.m
%     computeCost.m
%     gradientDescentMulti.m
%     computeCostMulti.m
%     featureNormalize.m
%     normalEqn.m
%
%  この演習では、さまざまな実験（学習率の変更など）のために、
%  以下のコードの一部を変更する必要があります。
%
%
%

%% 初期化

%% ================ パート 1: フィーチャーの正規化 ================

%% クリアして、図をクローズする
clear ; close all; clc

fprintf('Loading data ...\n');

%% データをロードする
data = load('ex1data2.txt');
X = data(:, 1:2);
y = data(:, 3);
m = length(y);

% いくつかのデータ点をプリントアウトする
fprintf('First 10 examples from the dataset: \n');
fprintf(' x = [%.0f %.0f], y = %.0f \n', [X(1:10,:) y(1:10,:)]');

fprintf('Program paused. Press enter to continue.\n');
pause;

% フィーチャーをスケーリングし、ゼロ平均に設定する
fprintf('Normalizing Features ...\n');

[X mu sigma] = featureNormalize(X);

% Xに切片項を追加
X = [ones(m, 1) X];


%% ================ パート 2: 最急降下法 ================

% ====================== ここにコードを実装する ======================
% 指示: 特定の学習率（alpha）で最急降下法を実行する次のスターターコードを
%       提供しました。
%
%       まずあなたがすべきことは、関数computeCostとgradientDescentが
%       既にこのスターターコードで動作し、複数の変数をサポートしていることを
%       確認することです。
%
%       その後、異なるアルファ値で最急降下法を実行して、どちらが最良の結果を
%       もたらすか確認してください。
%
%       最後に、最下部にコードを実装して、1650平方フィート、3BR (Bed Room)の
%       住宅の価格を予測する必要があります。
%
%
%
% ヒント: 'hold on'コマンドを使うと、同じ図の上に複数のグラフを
%        プロットすることができます。
%
% ヒント: 予測では、同じフィーチャーの正規化を行ってください。
%

fprintf('Running gradient descent ...\n');

% いくつかのアルファ値を選択する
alpha = 0.01;
num_iters = 400;

% thetaを初期化し、最急降下法を実行する
theta = zeros(3, 1);
[theta, J_history] = gradientDescentMulti(X, y, theta, alpha, num_iters);

% 収束グラフをプロットする
figure;
plot(1:numel(J_history), J_history, '-b', 'LineWidth', 2);
xlabel('Number of iterations');
ylabel('Cost J');

% 最急降下法の結果を表示する
fprintf('Theta computed from gradient descent: \n');
fprintf(' %f \n', theta);
fprintf('\n');

% 1650平方フィートの3BRの住宅の価格を見積もる
% ====================== ここにコードを実装する ======================
% Xの最初の列はすべて1であることを思い出してください。
% したがって、正規化する必要はありません。
price = WT5gkL94pZmKh7cBoK1vVNkgrbWYZwiRQo6VEayxtOC+Mw== % You should change this


% ============================================================

fprintf(['Predicted price of a 1650 sq-ft, 3 br house ' ...
         '(using gradient descent):\n $%f\n'], price);

fprintf('Program paused. Press enter to continue.\n');
pause;

%% ================ パート 3: 正規方程式 ================

fprintf('Solving with normal equations...\n');

% ====================== ここにコードを実装する ======================
% 指示: 次のコードは、正規方程式を使用した線形回帰の閉形式解を計算します。
% normalEqn.mのコードを完成させる必要があります。
%
% その後、このコードを入力して、1650平方フィートの3BRの住宅の価格を
% 予測する必要があります。
%
% 
% 

%% データをロード
data = csvread('ex1data2.txt');
X = data(:, 1:2);
y = data(:, 3);
m = length(y);

% Xに切片項を追加
X = [ones(m, 1) X];

% 正規方程式からパラメータを計算する
theta = normalEqn(X, y);

% 正規方程式の結果を表示する
fprintf('Theta computed from the normal equations: \n');
fprintf(' %f \n', theta);
fprintf('\n');


% 1650平方フィートの3BRの住宅の価格を見積もる
% ====================== ここにコードを実装する ======================
price = WT5gidJ8o4yJ+qR2rbRyGINu5Q== % You should change this


% ============================================================

fprintf(['Predicted price of a 1650 sq-ft, 3 br house ' ...
         '(using normal equations):\n $%f\n'], price);

