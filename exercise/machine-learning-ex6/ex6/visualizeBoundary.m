function visualizeBoundary(X, y, model, varargin)
%VISUALIZEBOUNDARY SVMによって学習された非線形決定境界をプロットする
%   VISUALIZEBOUNDARYLINEAR(X, y, model)は、SVMによって学習された非線形の 
%   決定境界線をプロットし、その上にデータを重ねます

% 境界の上にトレーニング・データをプロットする
plotData(X, y)

% 値のグリッド上で分類予測を行う
x1plot = linspace(min(X(:,1)), max(X(:,1)), 100)';
x2plot = linspace(min(X(:,2)), max(X(:,2)), 100)';
[X1, X2] = meshgrid(x1plot, x2plot);
vals = zeros(size(X1));
for i = 1:size(X1, 2)
   this_X = [X1(:, i), X2(:, i)];
   vals(:, i) = svmPredict(model, this_X);
end

% SVM境界をプロットする
hold on
contour(X1, X2, vals, [0.5 0.5], 'b');
hold off;

end
