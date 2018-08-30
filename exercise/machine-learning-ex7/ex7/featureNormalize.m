function [X_norm, mu, sigma] = featureNormalize(X)
%FEATURENORMALIZE Xのフィーチャーを正規化する
%   FEATURENORMALIZE(X) は、各フィーチャーの平均値が0で、標準偏差が1である
%   Xの正規化バージョンを返します。これは、学習アルゴリズムを使用するときに行う
%   良い前処理のステップです。
%   

mu = mean(X);
X_norm = bsxfun(@minus, X, mu);

sigma = std(X_norm);
X_norm = bsxfun(@rdivide, X_norm, sigma);


% ============================================================

end
