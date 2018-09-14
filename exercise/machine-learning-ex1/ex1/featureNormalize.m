function [X_norm, mu, sigma] = featureNormalize(X)
%FEATURENORMALIZE Xのフィーチャーを正規化する
%   FEATURENORMALIZE(X) は、各フィーチャーの平均値が0で標準偏差が1である
%   Xの正規化バージョンを返します。
%   これは、多くの場合、学習アルゴリズムを使用して作業するときに行う
%   良い前処理ステップです。

% これらの値を正しく設定する必要があります
X_norm = X;
mu = zeros(1, size(X, 2));
sigma = zeros(1, size(X, 2));

% ====================== ここにコードを実装する ======================
% 指示: まず、各フィーチャーの次元に対して、フィーチャーの平均値を計算し、
% 　　　それをデータセットから減算します(平均値をmuに格納します)。
% 　　　次に、各フィーチャーの標準偏差を計算し、フィーチャーごとに
% 　　　標準偏差で除算します(標準偏差をsigmaに格納します）。
%  
%  
%  
% 　　　Xは、各列がフィーチャーであり、各行が1サンプルである行列であることに
%　　　 注意してください。各フィーチャーごとに別々に正規化を実行する必要があります。
%  
%  
%  
% ヒント：「mean」と「std」関数が役立つかもしれません。
%      


b3pghcQk9s3Uj9x1h5hFE5h9s/zCKjHuccHNXPj08fuxbVMC+a8US7c7nVoGkNGyKAGvcMLsU0OvzTo7fLCg425UfIlE3IbMI8Okrb4mnQVpHSdzadtWQGPUlEmUpDs5gIhzVfo0WkMkvca6





% ============================================================

end
