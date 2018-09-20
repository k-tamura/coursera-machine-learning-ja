function plotData(X, y)
%PLOTDATA データ点Xとyを新しい図にプロットする
%   PLOTDATA(x,y) は、正のサンプルでは+、負のサンプルではoでデータ点を
%   プロットします。XはM×2の行列とします。
%
% 注意: これは、y = 1またはy = 0となるように若干修正されています。

% 正と負のサンプルのインデックスを見つける。
pos = find(y == 1); neg = find(y == 0);

% サンプルのプロット
plot(X(pos, 1), X(pos, 2), 'k+','LineWidth', 1, 'MarkerSize', 7)
hold on;
plot(X(neg, 1), X(neg, 2), 'ko', 'MarkerFaceColor', 'y', 'MarkerSize', 7)
hold off;

end
