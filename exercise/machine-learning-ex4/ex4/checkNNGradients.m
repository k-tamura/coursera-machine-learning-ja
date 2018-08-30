function checkNNGradients(lambda)
%CHECKNNGRADIENTS バックプロパゲーションの勾配をチェックするために、
%小さなニューラル・ネットワークを作成します。
%   CHECKNNGRADIENTS(lambda) は、バックプロパゲーション勾配をチェックする
%   小さなニューラルネットワークを作成し、バックプロパゲーションのコードと
%   数値的勾配（computeNumericalGradientを使用して計算された）によって生成された
%   解析的勾配を出力します。これらの2つの勾配計算は、非常に類似した値になるはずです。
%   
%

if ~exist('lambda', 'var') || isempty(lambda)
    lambda = 0;
end

input_layer_size = 3;
hidden_layer_size = 5;
num_labels = 3;
m = 5;

% いくつかの「ランダム」なテストデータを生成する
Theta1 = debugInitializeWeights(hidden_layer_size, input_layer_size);
Theta2 = debugInitializeWeights(num_labels, hidden_layer_size);
% debugInitializeWeightsを再利用してXを生成する
X  = debugInitializeWeights(m, input_layer_size - 1);
y  = 1 + mod(1:m, num_labels)';

% パラメーターのアンロール
nn_params = [Theta1(:) ; Theta2(:)];

% コスト関数の省略形
costFunc = @(p) nnCostFunction(p, input_layer_size, hidden_layer_size, ...
                               num_labels, X, y, lambda);

[cost, grad] = costFunc(nn_params);
numgrad = computeNumericalGradient(costFunc, nn_params);

% 2つの勾配計算を視覚的に調べます。
% 2つの列は非常に似ているはずです。
disp([numgrad grad]);
fprintf(['The above two columns you get should be very similar.\n' ...
         '(Left-Your Numerical Gradient, Right-Analytical Gradient)\n\n']);

% 2つの解のノルムの差を評価する。 
% 正しい実装であり、computeNumericalGradient.mでEPSILON = 0.0001を使用していると仮定すると、
% 以下のdiffは1e-9より小さくなるはずです
diff = norm(numgrad-grad)/norm(numgrad+grad);

fprintf(['If your backpropagation implementation is correct, then \n' ...
         'the relative difference will be small (less than 1e-9). \n' ...
         '\nRelative Difference: %g\n'], diff);

end
