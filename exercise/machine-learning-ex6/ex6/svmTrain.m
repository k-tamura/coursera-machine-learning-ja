function [model] = svmTrain(X, Y, C, kernelFunction, ...
                            tol, max_passes)
% SVMTRAIN SMOアルゴリズムの簡略化されたバージョンを使用してSVM分類器を
% トレーニングします。
%   [model] = SVMTRAIN(X, Y, C, kernelFunction, tol, max_passes) は、
%   SVM分類器をトレーニングし、トレーニングされたモデルを返します。 
%   Xは、トレーニング・サンプルの行列です。各行はトレーニング・サンプルであり、 
%   j番目の列はj番目のフィーチャーを保持します。Yは、正のサンプルでは1、 
%   負のサンプルでは0となる列行列です。Cは標準のSVMの正則化パラメーターです。
%   tolは、浮動小数点数の等価性を判定するために使用される許容値です。
%   max_passesは、アルゴリズムが終了する前に、（アルファに変更を加えずに）
%   データセットに対する反復回数を制御します。
%
% 注意: これは、SVMをトレーニングするためのSMOアルゴリズムの簡略版です。 
%      実際には、SVM分類器をトレーニングする場合は、次のような最適化された
%      パッケージを使用することをお勧めします。 
%
%           LIBSVM   (http://www.csie.ntu.edu.tw/~cjlin/libsvm/)
%           SVMLight (http://svmlight.joachims.org/)
%
%

if ~exist('tol', 'var') || isempty(tol)
    tol = 1e-3;
end

if ~exist('max_passes', 'var') || isempty(max_passes)
    max_passes = 5;
end

% データ・パラメーター
m = size(X, 1);
n = size(X, 2);

% 0を-1にマッピングする
Y(Y==0) = -1;

% 変数
alphas = zeros(m, 1);
b = 0;
E = zeros(m, 1);
passes = 0;
eta = 0;
L = 0;
H = 0;

% 今回扱うデータセットは小さいので、カーネル行列を事前に計算します
% （実際には、大きなデータセットを扱う最適化されたSVMパッケージでは、
% これを行うことはありません）。
% 
% ここでカーネルのベクトル化バージョンを最適化して、SVMのトレーニングを
% 高速化します。
if strcmp(func2str(kernelFunction), 'linearKernel')
    % 線形カーネルのベクトル化された計算
    % これは、すべてのサンプルのペアでカーネルを計算することと同じです。
    K = X*X';
elseif strfind(func2str(kernelFunction), 'gaussianKernel')
    % ベクトル化されたRBFカーネル
    % これは、すべてのサンプルのペアでカーネルを計算することと同じです。
    X2 = sum(X.^2, 2);
    K = bsxfun(@plus, X2, bsxfun(@plus, X2', - 2 * (X * X')));
    K = kernelFunction(1, 0) .^ K;
else
    % カーネル行列の事前計算
    % ベクトル化の欠如のために、以下が遅くなる可能性があります。
    K = zeros(m);
    for i = 1:m
        for j = i:m
             K(i,j) = kernelFunction(X(i,:)', X(j,:)');
             K(j,i) = K(i,j); % 行列は対称
        end
    end
end

% トレーニングする
fprintf('\nTraining ...');
dots = 12;
while passes < max_passes,
            
    num_changed_alphas = 0;
    for i = 1:m,
        
        % (2)を使って、Ei = f(x(i)) - y(i)を計算する
        % E(i) = b + sum (X(i, :) * (repmat(alphas.*Y,1,n).*X)') - Y(i);
        E(i) = b + sum (alphas.*Y.*K(:,i)) - Y(i);
        
        if ((Y(i)*E(i) < -tol && alphas(i) < C) || (Y(i)*E(i) > tol && alphas(i) > 0)),
            
            % 実際には、iとjを選択するために使用できるヒューリスティックが多数あります。 
            % この単純化されたコードでは、それらをランダムに選択します。
            j = ceil(m * rand());
            while j == i,  % Make sure i \neq j
                j = ceil(m * rand());
            end

            % (2)を使って、Ej = f(x(j)) - y(j)を計算する
            E(j) = b + sum (alphas.*Y.*K(:,j)) - Y(j);

            % 古いアルファを保存する
            alpha_i_old = alphas(i);
            alpha_j_old = alphas(j);
            
            % LとHを(10)または(11)で計算する 
            if (Y(i) == Y(j)),
                L = max(0, alphas(j) + alphas(i) - C);
                H = min(C, alphas(j) + alphas(i));
            else
                L = max(0, alphas(j) - alphas(i));
                H = min(C, C + alphas(j) - alphas(i));
            end
           
            if (L == H),
                % continue to next i. 
                continue;
            end

            % (14)によってetaを計算する。
            eta = 2 * K(i,j) - K(i,i) - K(j,j);
            if (eta >= 0),
                % 次のiへ進む。
                continue;
            end
            
            % (12)と(15)を使って、alphas(j)の新しい値を計算し、クリップします。
            alphas(j) = alphas(j) - (Y(j) * (E(i) - E(j))) / eta;
            
            % クリップ
            alphas(j) = min (H, alphas(j));
            alphas(j) = max (L, alphas(j));
            
            % alphaの変化が大きいかどうかを調べる
            if (abs(alphas(j) - alpha_j_old) < tol),
                % continue to next i. 
                % replace anyway
                alphas(j) = alpha_j_old;
                continue;
            end
            
            % (16)を用いてalphas(i)の値を決定する。
            alphas(i) = alphas(i) + Y(i)*Y(j)*(alpha_j_old - alphas(j));
            
            % (17)と(18)をそれぞれ使ってb1とb2を計算する。
            b1 = b - E(i) ...
                 - Y(i) * (alphas(i) - alpha_i_old) *  K(i,j)' ...
                 - Y(j) * (alphas(j) - alpha_j_old) *  K(i,j)';
            b2 = b - E(j) ...
                 - Y(i) * (alphas(i) - alpha_i_old) *  K(i,j)' ...
                 - Y(j) * (alphas(j) - alpha_j_old) *  K(j,j)';

            % (19)で計算する 
            if (0 < alphas(i) && alphas(i) < C),
                b = b1;
            elseif (0 < alphas(j) && alphas(j) < C),
                b = b2;
            else
                b = (b1+b2)/2;
            end

            num_changed_alphas = num_changed_alphas + 1;

        end
        
    end
    
    if (num_changed_alphas == 0),
        passes = passes + 1;
    else
        passes = 0;
    end

    fprintf('.');
    dots = dots + 1;
    if dots > 78
        dots = 0;
        fprintf('\n');
    end
    if exist('OCTAVE_VERSION')
        fflush(stdout);
    end
end
fprintf(' Done! \n\n');

% モデルを保存する
idx = alphas > 0;
model.X= X(idx,:);
model.y= Y(idx);
model.kernelFunction = kernelFunction;
model.b= b;
model.alphas= alphas(idx);
model.w = ((alphas.*Y)'*X)';

end
