%% 機械学習オンラインクラス - 演習 2: ロジスティック回帰
%
%  指示
%  ------------
% 
%  このファイルには、ロジスティック回帰の演習を始めるのに役立つコードが
%  含まれています。
%  この演習では、次の関数を完成させる必要があります。
%
%     sigmoid.m
%     costFunction.m
%     predict.m
%     costFunctionReg.m
%
%  この演習では、このファイルまたは上記以外のファイル内のコードを
%  変更する必要はありません。
%

%% 初期化
clear ; close all; clc

%% データをロード
%  The first two columns contains the exam scores and the third column
%  contains the label.

data = load('ex2data1.txt');
X = data(:, [1, 2]); y = data(:, 3);

%% ==================== パート 1: プロット ====================
%  まず、取り組もうとしている問題を理解するために、データをプロットして、
%  演習を開始します。

fprintf(['Plotting data with + indicating (y = 1) examples and o ' ...
         'indicating (y = 0) examples.\n']);

plotData(X, y);

% ラベルを付ける
hold on;
% ラベルと凡例
xlabel('Exam 1 score')
ylabel('Exam 2 score')

% プロット順で指定
legend('Admitted', 'Not admitted')
hold off;

fprintf('\nProgram paused. Press enter to continue.\n');
pause;


%% ============ パート 2: コストと勾配の計算 ============
%  演習のこのパートでは、ロジスティック回帰のコストと勾配を実装します。
%  costFunction.mのコードを完成させる必要があります。
%  

%  適切にデータ行列を設定し、切片項にあたる1を追加する
[m, n] = size(X);

% xとX_testに切片項を追加する
X = [ones(m, 1) X];

% フィッティング・パラメーターを初期化する
initial_theta = zeros(n + 1, 1);

% 初期コストと勾配を計算して表示する
[cost, grad] = costFunction(initial_theta, X, y);

fprintf('Cost at initial theta (zeros): %f\n', cost);
fprintf('Expected cost (approx): 0.693\n');
fprintf('Gradient at initial theta (zeros): \n');
fprintf(' %f \n', grad);
fprintf('Expected gradients (approx):\n -0.1000\n -12.0092\n -11.2628\n');

% 0以外のthetaによるコストと勾配の計算と表示
test_theta = [-24; 0.2; 0.2];
[cost, grad] = costFunction(test_theta, X, y);

fprintf('\nCost at test theta: %f\n', cost);
fprintf('Expected cost (approx): 0.218\n');
fprintf('Gradient at test theta: \n');
fprintf(' %f \n', grad);
fprintf('Expected gradients (approx):\n 0.043\n 2.566\n 2.647\n');

fprintf('\nProgram paused. Press enter to continue.\n');
pause;


%% ============= パート 3: fminuncを使用した最適化  =============
%  この演習では、組み込み関数（fminunc）を使用して、最適なパラメーター
%  thetaを検索します。

%  fminuncのオプションを設定する
options = optimset('GradObj', 'on', 'MaxIter', 400);

%  fminuncを実行して最適なthetaを取得する
%  この関数はthetaとcostを返します
[theta, cost] = ...
	fminunc(@(t)(costFunction(t, X, y)), initial_theta, options);

% thetaを画面にプリントする
fprintf('Cost at theta found by fminunc: %f\n', cost);
fprintf('Expected cost (approx): 0.203\n');
fprintf('theta: \n');
fprintf(' %f \n', theta);
fprintf('Expected theta (approx):\n');
fprintf(' -25.161\n 0.206\n 0.201\n');

% 境界をプロットする
plotDecisionBoundary(theta, X, y);

% ラベルを付ける
hold on;
% ラベルと凡例
xlabel('Exam 1 score')
ylabel('Exam 2 score')

% プロット順で指定
legend('Admitted', 'Not admitted')
hold off;

fprintf('\nProgram paused. Press enter to continue.\n');
pause;

%% ============== パート 4: 予測と精度 ==============
%  パラメーターを学習した後、それを使用して、目に見えないデータの結果を
%  予測することができます。 
%  このパートでは、ロジスティック回帰モデルを使用して、試験1のスコア45と
%  試験2のスコア85の学生が入学する確率を予測します。
%
%  さらに、モデルのトレーニング・セットとテストセットの精度を計算します。
%
%  あなたがすべきことは、predict.mのコードを完成させることです。
%
%  試験1で45点、試験2で85点の確率を予測する
%
%

prob = sigmoid([1 45 85] * theta);
fprintf(['For a student with scores 45 and 85, we predict an admission ' ...
         'probability of %f\n'], prob);
fprintf('Expected value: 0.775 +/- 0.002\n\n');

% トレーニング・セットの精度を計算する
p = predict(theta, X);

fprintf('Train Accuracy: %f\n', mean(double(p == y)) * 100);
fprintf('Expected accuracy (approx): 89.0\n');
fprintf('\n');


