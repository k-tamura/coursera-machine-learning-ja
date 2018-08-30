%% 機械学習オンラインクラス
%  演習 5 | 正則化された線形回帰とバイアス・分散
%
%  指示
%  ------------
% 
%  このファイルには、演習を開始するのに役立つコードが含まれています。
%  次の関数を完成する必要があります。
%
%     linearRegCostFunction.m
%     learningCurve.m
%     validationCurve.m
%
%  この演習では、このファイルまたは上記以外のファイル内のコードを
%  変更する必要はありません。
%

%% 初期化
clear ; close all; clc

%% =========== パート 1: データのロードと可視化 =============
%  最初にデータセットを読み込んで可視化することから始めます。
%  次のコードは、データセットを環境にロードし、データをプロットします。
%  
%

% トレーニング・データをロードする
fprintf('Loading and Visualizing Data ...\n')

% ex5data1からロードする 
% あなたの環境にはX、Y、Xval、yval、Xtest、ytestができます
load ('ex5data1.mat');

% m = サンプルの数
m = size(X, 1);

% トレーニング・データをプロットする
plot(X, y, 'rx', 'MarkerSize', 10, 'LineWidth', 1.5);
xlabel('Change in water level (x)');
ylabel('Water flowing out of the dam (y)');

fprintf('Program paused. Press enter to continue.\n');
pause;

%% =========== パート 2: 正則化された線形回帰のコスト =============
%  正則化された線形回帰のコスト関数を実装する必要があります。
%  
%

theta = [1 ; 1];
J = linearRegCostFunction([ones(m, 1) X], y, theta, 1);

fprintf(['Cost at theta = [1 ; 1]: %f '...
         '\n(this value should be about 303.993192)\n'], J);

fprintf('Program paused. Press enter to continue.\n');
pause;

%% =========== パート 3:  正則化された線形回帰の勾配 =============
%  ここで、正則化された線形回帰の勾配を実装する必要があります。
%  
%

theta = [1 ; 1];
[J, grad] = linearRegCostFunction([ones(m, 1) X], y, theta, 1);

fprintf(['Gradient at theta = [1 ; 1]:  [%f; %f] '...
         '\n(this value should be about [-15.303016; 598.250744])\n'], ...
         grad(1), grad(2));

fprintf('Program paused. Press enter to continue.\n');
pause;


%% =========== パート 4: 線形回帰をトレーニングする =============
%  コストと勾配を正しく実装すると、trainLinearReg関数はコスト関数を使用して
%  正規化された線形回帰をトレーニングします。
% 
% 
%  注記: データは非線形であるため、これはあまり適合しません。
%
%

%  lambda = 0で線形回帰をトレーニングする
lambda = 0;
[theta] = trainLinearReg([ones(m, 1) X], y, lambda);

%  Plot fit over the data
plot(X, y, 'rx', 'MarkerSize', 10, 'LineWidth', 1.5);
xlabel('Change in water level (x)');
ylabel('Water flowing out of the dam (y)');
hold on;
plot(X, [ones(m, 1) X]*theta, '--', 'LineWidth', 2)
hold off;

fprintf('Program paused. Press enter to continue.\n');
pause;


%% =========== パート 5: 線形回帰の学習曲線 =============
%  次に、learningCurve関数を実装する必要があります。
%
%  注記: モデルがデータに適合していないため、「高バイアス」のグラフが表示されます
%          （図3、ex5.pdf）。
%

lambda = 0;
[error_train, error_val] = ...
    learningCurve([ones(m, 1) X], y, ...
                  [ones(size(Xval, 1), 1) Xval], yval, ...
                  lambda);

plot(1:m, error_train, 1:m, error_val);
title('Learning curve for linear regression')
legend('Train', 'Cross Validation')
xlabel('Number of training examples')
ylabel('Error')
axis([0 13 0 150])

fprintf('# Training Examples\tTrain Error\tCross Validation Error\n');
for i = 1:m
    fprintf('  \t%d\t\t%f\t%f\n', i, error_train(i), error_val(i));
end

fprintf('Program paused. Press enter to continue.\n');
pause;

%% =========== パート 6: 多項式回帰のフィーチャー・マッピング =============
%  これに対する1つの解決策は、多項式回帰を使用することです。 これで各サンプルを
%  その累乗にマッピングするために、polyFeaturesを完成させる必要があります。

p = 8;

% Xを多項式のフィーチャーにマッピングして正規化する
X_poly = polyFeatures(X, p);
[X_poly, mu, sigma] = featureNormalize(X_poly);  % 正規化
X_poly = [ones(m, 1), X_poly];                   % １を追加

% X_poly_testをマッピングし、正規化する（muとsigmaを使用）
X_poly_test = polyFeatures(Xtest, p);
X_poly_test = bsxfun(@minus, X_poly_test, mu);
X_poly_test = bsxfun(@rdivide, X_poly_test, sigma);
X_poly_test = [ones(size(X_poly_test, 1), 1), X_poly_test];         % １を追加

% X_poly_valをマッピングし、正規化する（muとsigmaを使用）
X_poly_val = polyFeatures(Xval, p);
X_poly_val = bsxfun(@minus, X_poly_val, mu);
X_poly_val = bsxfun(@rdivide, X_poly_val, sigma);
X_poly_val = [ones(size(X_poly_val, 1), 1), X_poly_val];           % １を追加

fprintf('Normalized Training Example 1:\n');
fprintf('  %f  \n', X_poly(1, :));

fprintf('\nProgram paused. Press enter to continue.\n');
pause;



%% =========== パート 7: 多項式回帰の学習曲線 =============
%  次に、複数のlambdaの値を使って多項式回帰を試してみましょう。以下のコードは、
%  lambda = 0の多項式回帰を実行します。lambdaの値を変えてコードを実行して、
%  適合曲線と学習曲線がどのように変化するかを調べる必要があります。
%  
% 

lambda = 0;
[theta] = trainLinearReg(X_poly, y, lambda);

% トレーニングデータをプロットして、フィットさせる
figure(1);
plot(X, y, 'rx', 'MarkerSize', 10, 'LineWidth', 1.5);
plotFit(min(X), max(X), mu, sigma, theta, p);
xlabel('Change in water level (x)');
ylabel('Water flowing out of the dam (y)');
title (sprintf('Polynomial Regression Fit (lambda = %f)', lambda));

figure(2);
[error_train, error_val] = ...
    learningCurve(X_poly, y, X_poly_val, yval, lambda);
plot(1:m, error_train, 1:m, error_val);

title(sprintf('Polynomial Regression Learning Curve (lambda = %f)', lambda));
xlabel('Number of training examples')
ylabel('Error')
axis([0 13 0 100])
legend('Train', 'Cross Validation')

fprintf('Polynomial Regression (lambda = %f)\n\n', lambda);
fprintf('# Training Examples\tTrain Error\tCross Validation Error\n');
for i = 1:m
    fprintf('  \t%d\t\t%f\t%f\n', i, error_train(i), error_val(i));
end

fprintf('Program paused. Press enter to continue.\n');
pause;

%% =========== パート 8: Lambdaを選択するための検証 =============
%  ここでvalidationCurveを実装して、バリデーション・セット上のlambdaのさまざまな値をテストします。
%  これを使用して「最良」のlambda値を選択します。
%  
%

[lambda_vec, error_train, error_val] = ...
    validationCurve(X_poly, y, X_poly_val, yval);

close all;
plot(lambda_vec, error_train, lambda_vec, error_val);
legend('Train', 'Cross Validation');
xlabel('lambda');
ylabel('Error');

fprintf('lambda\t\tTrain Error\tValidation Error\n');
for i = 1:length(lambda_vec)
	fprintf(' %f\t%f\t%f\n', ...
            lambda_vec(i), error_train(i), error_val(i));
end

fprintf('Program paused. Press enter to continue.\n');
pause;
