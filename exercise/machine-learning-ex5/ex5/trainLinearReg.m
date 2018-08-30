function [theta] = trainLinearReg(X, y, lambda)
% TRAINLINEARREG データセット(X, y)と正則化パラメーターlambdaを
% 与えられた線形回帰をトレーニングする
%   [theta] = TRAINLINEARREG (X, y, lambda) は、データセット(X, y)
%   および正則化パラメーターlambdaを用いて線形回帰をトレーニングします。
%   そして、トレーニングされたパラメーターthetaを返します。
%

% シータを初期化する
initial_theta = zeros(size(X, 2), 1); 

% コスト関数を最小化するための「short hand」を作成する
costFunction = @(t) linearRegCostFunction(X, y, t, lambda);

% costFunctionは1つの引数しか取らない関数
options = optimset('MaxIter', 200, 'GradObj', 'on');

% fmincgを使用して最小化
theta = fmincg(costFunction, initial_theta, options);

end
