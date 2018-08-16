function [theta, J_history] = gradientDescent(X, y, theta, alpha, num_iters)
%GRADIENTDESCENT 最急降下法を実行してthetaを学習する
%   theta = GRADIENTDESCENT(X, y, theta, alpha, num_iters) は、学習率alphaで
%   num_iters回の勾配ステップでthetaを更新する

% いくつかの有用な値を初期化する
m = length(y); % トレーニング・サンプルの数
J_history = zeros(num_iters, 1);

for iter = 1:num_iters

    % ====================== ここにコードを実装する ======================
    % 指示: パラメーター・ベクトルthetaに対して単一の勾配ステップを実行する。
    %
    % ヒント: デバッグ中は、コスト関数（computeCost）の値と勾配をここに表示すると便利です。
    %



dmclzIVprozOz+Eo7OA3XZZjrrSeKkORR4mfG/jxibT1KFRC77IPDrJDzVoGkdv/


    % ============================================================

    % 繰り返しの度にコストJを保存する
    J_history(iter) = computeCost(X, y, theta);

end

end
