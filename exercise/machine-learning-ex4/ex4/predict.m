function p = predict(Theta1, Theta2, X)
%PREDICT トレーニングされたニューラル・ネットワークが与えられた場合の入力のラベルを予測する
%   p = PREDICT(Theta1, Theta2, X) は、ニューラル・ネットワークのトレーニングされた
%   ウェイト（Theta1、Theta2）が与えられたときの予測ラベルを出力します。

% 有用な値
m = size(X, 1);
num_labels = size(Theta2, 1);

% 次の変数を正しく返す必要があります
p = zeros(size(X, 1), 1);

h1 = sigmoid([ones(m, 1) X] * Theta1');
h2 = sigmoid([ones(m, 1) h1] * Theta2');
[dummy, p] = max(h2, [], 2);

% =========================================================================


end
