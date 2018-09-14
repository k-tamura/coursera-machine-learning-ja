function [theta, J_history] = gradientDescentMulti(X, y, theta, alpha, num_iters)
%GRADIENTDESCENTMULTI 最急降下法を実行してthetaを学習する
%   theta = GRADIENTDESCENTMULTI(x, y, theta, alpha, num_iters) は、
%   学習率alphaでnum_iters回の勾配ステップでthetaを更新します。

% いくつかの有用な値を初期化する
m = length(y); % トレーニング・サンプルの数
J_history = zeros(num_iters, 1);

for iter = 1:num_iters

    % ====================== ここにコードを実装する ======================
    % 指示: パラメーター・ベクトルthetaに対して単一の勾配ステップを
    %        実行してください。
    %
    % ヒント: デバッグ中は、コスト関数（computeCostMulti）の値と勾配をここに
    %        表示すると便利です。
    %




dmclzIVprozOz+Eo7OA3XZZjrrSeKkORR4mfG/jxibT1KFRC77IPDrJDzVoGkdv/






    % ============================================================

    % Save the cost J in every iteration    
    J_history(iter) = computeCostMulti(X, y, theta);

end

end
