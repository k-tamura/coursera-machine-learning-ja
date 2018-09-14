function p = multivariateGaussian(X, mu, Sigma2)
% MULTIVARIATEGAUSSIAN 多変量ガウス分布の確率密度関数を計算する。
% 
%    p = MULTIVARIATEGAUSSIAN(X, mu, Sigma2) は、パラメーターmuとSigma2を持つ
%    多変量ガウス分布の下でのサンプルXの確率密度関数を計算します。
%    Sigma2が行列の場合は、共分散行列として扱われます。
%    Sigma2がベクトルの場合は、各次元の分散sigma^2の値（対角共分散行列）として
%    扱われます。
%    
%

k = length(mu);

if (size(Sigma2, 2) == 1) || (size(Sigma2, 1) == 1)
    Sigma2 = diag(Sigma2);
end

X = bsxfun(@minus, X, mu(:)');
p = (2 * pi) ^ (- k / 2) * det(Sigma2) ^ (-0.5) * ...
    exp(-0.5 * sum(bsxfun(@times, X * pinv(Sigma2), X), 2));

end