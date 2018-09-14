function visualizeFit(X, mu, sigma2)
%VISUALIZEFIT データセットとその推定分布を可視化します。
%   VISUALIZEFIT(X, p, mu, sigma2) この可視化は、ガウス分布の確率密度関数を
%   示します。各サンプルは、そのフィーチャー値に依存する位置(x1, x2)を有します。
%   
% 

[X1,X2] = meshgrid(0:.5:35); 
Z = multivariateGaussian([X1(:) X2(:)],mu,sigma2);
Z = reshape(Z,size(X1));

plot(X(:, 1), X(:, 2),'bx');
hold on;
% 無限の場合はプロットしない
if (sum(isinf(Z)) == 0)
    contour(X1, X2, Z, 10.^(-20:3:0)');
end
hold off;

end