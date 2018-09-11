%% 機械学習オンラインクラス - 演習 1: 線形回帰

%  指示
%  ------------
%
%
%  このファイルには、線形演習を開始するのに役立つコードが含まれています。
%  この演習では、次の機能を完了する必要があります。
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
%  この演習では、このファイルまたは上記以外のファイル内のコードを
%  変更する必要はありません。
%
% xは10,000人単位の人口サイズを指します
% yは10,000ドル単位の利益を指します
%

%% 初期化
clear ; close all; clc

%% ==================== パート 1: 基本機能 ====================
% warmUpExercise.mを完成する
fprintf('Running warmUpExercise ... \n');
fprintf('5x5 Identity Matrix: \n');
warmUpExercise()

fprintf('Program paused. Press enter to continue.\n');
pause;


%% ======================= パート 2: プロット =======================
fprintf('Plotting Data ...\n')
data = load('ex1data1.txt');
X = data(:, 1); y = data(:, 2);
m = length(y); % トレーニング・サンプルの数

% データのプロット
% 注意: plotData.mのコードを完成させる必要があります。
plotData(X, y);

fprintf('Program paused. Press enter to continue.\n');
pause;

%% =================== パート 3: コストと最急降下法 ===================

X = [ones(m, 1), data(:,1)]; % 1の列をxに追加する
theta = zeros(2, 1); % フィッティングパラメータを初期化する

% 最急降下法の設定
iterations = 1500;
alpha = 0.01;

fprintf('\nTesting the cost function ...\n')
% 初期コストを計算して表示する
J = computeCost(X, y, theta);
fprintf('With theta = [0 ; 0]\nCost computed = %f\n', J);
fprintf('Expected cost value (approx) 32.07\n');

% さらにコスト関数をテストする
J = computeCost(X, y, [-1 ; 2]);
fprintf('\nWith theta = [-1 ; 2]\nCost computed = %f\n', J);
fprintf('Expected cost value (approx) 54.24\n');

fprintf('Program paused. Press enter to continue.\n');
pause;

fprintf('\nRunning Gradient Descent ...\n')
% 最急降下法を実行する
theta = gradientDescent(X, y, theta, alpha, iterations);

% thetaをスクリーンにプリントする
fprintf('Theta found by gradient descent:\n');
fprintf('%f\n', theta);
fprintf('Expected theta values (approx)\n');
fprintf(' -3.6303\n  1.1664\n\n');

% 線形フィットをプロットする
hold on; % 前のプロットを見えるようにする
plot(X(:,2), X*theta, '-')
legend('Training data', 'Linear regression')
hold off % この図の上にそれ以上プロットを重ね合わせない

% 人口サイズ35,000と70,000の予測値
predict1 = [1, 3.5] *theta;
fprintf('For population = 35,000, we predict a profit of %f\n',...
    predict1*10000);
predict2 = [1, 7] * theta;
fprintf('For population = 70,000, we predict a profit of %f\n',...
    predict2*10000);

fprintf('Program paused. Press enter to continue.\n');
pause;

%% ============= パート 4: J(theta_0, theta_1)の可視化 =============
fprintf('Visualizing J(theta_0, theta_1) ...\n')

% Jを計算するグリッド
theta0_vals = linspace(-10, 10, 100);
theta1_vals = linspace(-1, 4, 100);

% J_valsを0の行列で初期化する
J_vals = zeros(length(theta0_vals), length(theta1_vals));

% J_valsに値を設定する
for i = 1:length(theta0_vals)
    for j = 1:length(theta1_vals)
	  t = [theta0_vals(i); theta1_vals(j)];
	  J_vals(i,j) = computeCost(X, y, t);
    end
end


% surfコマンドでメッシュグリッドが動作する方法のために、surfを呼び出す前に
% J_valsを転置する必要があります。そうしないと、軸が反転します
J_vals = J_vals';
% Surfaceプロット
figure;
surf(theta0_vals, theta1_vals, J_vals)
xlabel('\theta_0'); ylabel('\theta_1');

% 等高線図
figure;
% 対数的に0.01と100の間の15の等高線としてJ_valsをプロットする
contour(theta0_vals, theta1_vals, J_vals, logspace(-2, 3, 20))
xlabel('\theta_0'); ylabel('\theta_1');
hold on;
plot(theta(1), theta(2), 'rx', 'MarkerSize', 10, 'LineWidth', 2);
