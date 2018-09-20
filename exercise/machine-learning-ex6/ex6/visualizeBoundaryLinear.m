function visualizeBoundaryLinear(X, y, model)
%VISUALIZEBOUNDARYLINEAR SVMによって学習された線形決定境界をプロットする
%
%   VISUALIZEBOUNDARYLINEAR(X, y, model) は、SVMによって学習された
%   線形決定境界をプロットし、その上にデータを重ねます

w = model.w;
b = model.b;
xp = linspace(min(X(:,1)), max(X(:,1)), 100);
yp = - (w(1)*xp + b)/w(2);
plotData(X, y);
hold on;
plot(xp, yp, '-b'); 
hold off

end
