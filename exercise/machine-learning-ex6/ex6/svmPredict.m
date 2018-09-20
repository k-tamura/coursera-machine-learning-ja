function pred = svmPredict(model, X)
% SVMPREDICT トレーニングされたSVMモデル（svmTrain）を使用して予測ベクトルを返す。
%
%   pred = SVMPREDICT(model, X) は、トレーニングされたSVMモデル（svmTrain）を
%   使用して予測ベクトルを返します。Xはmxn行列であり、その1行が各サンプルです。
%   modelはsvmTrainから返されるsvmモデルです。
%   予測predは、{0, 1}値の予測のm×1列ベクトルです。
%

% 列ベクトルを取得しているかどうかを確認し、その場合は、単一のサンプルについて
% 予測を行うだけでよいと仮定します
if (size(X, 2) == 1)
    % サンプルは行にする必要があります
    X = X';
end

% データセット 
m = size(X, 1);
p = zeros(m, 1);
pred = zeros(m, 1);

if strcmp(func2str(model.kernelFunction), 'linearKernel')
    % 線形カーネルを扱う場合は、直接、重みとバイアスを使用することができます
    % 
    p = X * model.w + model.b;
elseif strfind(func2str(model.kernelFunction), 'gaussianKernel')
    % ベクトル化されたRBFカーネル
    % これは、すべてのサンプルのペアでカーネルを計算するのと同じです
    X1 = sum(X.^2, 2);
    X2 = sum(model.X.^2, 2)';
    K = bsxfun(@plus, X1, bsxfun(@plus, X2, - 2 * X * model.X'));
    K = model.kernelFunction(1, 0) .^ K;
    K = bsxfun(@times, model.y', K);
    K = bsxfun(@times, model.alphas', K);
    p = sum(K, 2);
else
    % その他の非線形カーネル
    for i = 1:m
        prediction = 0;
        for j = 1:size(model.X, 1)
            prediction = prediction + ...
                model.alphas(j) * model.y(j) * ...
                model.kernelFunction(X(i,:)', model.X(j,:)');
        end
        p(i) = prediction + model.b;
    end
end

% 予測を0/1に変換する
pred(p >= 0) =  1;
pred(p <  0) =  0;

end

