function [J, grad] = linearRegCostFunction(X, y, theta, lambda)
%LINEARREGCOSTFUNCTION 複数の変数を用いた正則化された線形回帰のコストと
% 勾配を計算します。
%   [J, grad] = LINEARREGCOSTFUNCTION(X, y, theta, lambda)は、Xとyにデータ点を
%   フィットさせる線形回帰のパラメーターとしてthetaを使用したコストを計算します。
%   コストをJで、勾配をgradで返します。

% いくつかの有用な値を初期化する
m = length(y); % トレーニング・サンプルの数

% 次の変数を正しく返す必要があります
J = 0;
grad = zeros(size(theta));

% ====================== ここにコードを実装する ======================
% 指示: 選択されたthetaに対して、正則化された線形回帰のコストと勾配を計算します。
%         
%
%          Jにコストを、gradに勾配を設定する必要があります。
%




dmotyMR0s/eKnKQo5aVuHN895LmRbkDsJKT1EeX58byHKAoK/q4LWv5DmVNfl9yyb1SNW4uhHlbnlW4pKPmowm5+C/YCgdSLI5Ot1cponhZpX2wyYZ4YUXWRlwfO6zMVzMwjW/80ARhj+of+rRZ0AqXvTCVXNNIZJSG54t0D2VC0k8jleT14IcXIuAycQG5ifz5pcm4BeITEvTKa9Mq4oLSsWA==







% =========================================================================

grad = grad(:);

end
