function [U, S] = pca(X)
%PCA Run principal component analysis on the dataset X
%   [U, S, X] = pca(X) computes eigenvectors of the covariance matrix of X
%   Returns the eigenvectors U, the eigenvalues (on diagonal) in S
%

% Useful values
[m, n] = size(X);

% 次の変数を正しく返す必要があります。
U = zeros(n);
S = zeros(n);

% ====================== ここにコードを実装する ======================
% 指示: You should first compute the covariance matrix. Then, you
%               should use the "svd" function to compute the eigenvectors
%               and eigenvalues of the covariance matrix. 
%
% 注意: When computing the covariance matrix, remember to divide by m (the
%       number of examples).
%







% =========================================================================

end
