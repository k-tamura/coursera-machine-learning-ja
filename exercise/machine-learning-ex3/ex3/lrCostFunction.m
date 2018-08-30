function [J, grad] = lrCostFunction(theta, X, y, lambda)
%LRCOSTFUNCTION 正則化されたロジスティック回帰のコストと勾配を計算する
%
%   J = LRCOSTFUNCTION(theta, X, y, lambda) は、正則化された
%   ロジスティック回帰のパラメーターとしてthetaを使用するコストと、
%   パラメーターを参照したコストの勾配を計算します。

% いくつかの有用な値を初期化する
m = length(y); % トレーニング・サンプルの数

% 次の変数を正しく返す必要があります
J = 0;
grad = zeros(size(theta));

% ====================== ここにコードを実装する ======================
% 指示: 選択されたthetaのコストを計算します。
%          Jにコストを設定する必要があります。
%          偏微分を計算し、thetaの各パラメーターを参照してコストの偏微分を
%          gradに設定します
%
% ヒント: コスト関数および勾配の計算を効率的にベクトル化することができます。
%            例えば、
%
%            sigmoid(X * theta)
%
%            結果の行列の各行には、そのサンプルの予測値が格納されます。
%            これを使用して、コスト関数と勾配の計算をベクトル化することができます。
% 
%
% ヒント: 正則化されたコスト関数の勾配を計算するとき、
%            ベクトル化可能な解法はたくさんありますが、1つの解法は次のようになります。
%
%           grad = （正則化されていないロジスティック回帰に対する勾配）
%           temp = theta; 
%           temp(1) = 0;   % j = 0に対して何も追加しないため
%           grad = grad + ここにコードを実装（一時変数を使用）
%




ai99mJcg9MHVzuB01eAwXYNnu6ieI1K7FeSfDPjx/O34KAoK5qkJBvdKlF4Glsq/PF2CI4GrUk3o2CtlYP2hm2h+SfYEndqrI96k1cFo0lwkUWk+I9BZBT/c1QDB4X5Bg4EgDr08XUImpMa7thcbC7OnBltYPbE0D2zrq+EDzlDx1MCxMj19KdTM4QqbDWRpB3szFWsXeMDGr3ya996xr7/8QwOeaMVfBXlJlRAlcu1G4PSgM9hhDg4+YsollA==





% =============================================================

grad = grad(:);

end
