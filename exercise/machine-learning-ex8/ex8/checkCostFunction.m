function checkCostFunction(lambda)
% CHECKCOSTFUNCTION 協調フィルタリングの問題を作成して、コスト関数と勾配を
% チェックします。
%   CHECKCOSTFUNCTION(lambda)は、コスト関数と勾配をチェックするための
%   協調フィルタリングの問題を作成し、コードによって生成された解析的勾配と
%   （computeNumericalGradientを使用して計算された）数値的勾配を出力します。
%   これらの2つの勾配の計算は、非常に近い値になるはずです。
%   

% lambdaをセットする
if ~exist('lambda', 'var') || isempty(lambda)
    lambda = 0;
end

%% 小さな問題を作成する
X_t = rand(4, 3);
Theta_t = rand(5, 3);

% ほとんどのエントリーを削除する
Y = X_t * Theta_t';
Y(rand(size(Y)) > 0.5) = 0;
R = zeros(size(Y));
R(Y ~= 0) = 1;

%% 勾配チェックを実行する
X = randn(size(X_t));
Theta = randn(size(Theta_t));
num_users = size(Y, 2);
num_movies = size(Y, 1);
num_features = size(Theta_t, 2);

numgrad = computeNumericalGradient( ...
                @(t) cofiCostFunc(t, Y, R, num_users, num_movies, ...
                                num_features, lambda), [X(:); Theta(:)]);

[cost, grad] = cofiCostFunc([X(:); Theta(:)],  Y, R, num_users, ...
                          num_movies, num_features, lambda);

disp([numgrad grad]);
fprintf(['The above two columns you get should be very similar.\n' ...
         '(Left-Your Numerical Gradient, Right-Analytical Gradient)\n\n']);

diff = norm(numgrad-grad)/norm(numgrad+grad);
fprintf(['If your cost function implementation is correct, then \n' ...
         'the relative difference will be small (less than 1e-9). \n' ...
         '\nRelative Difference: %g\n'], diff);

end