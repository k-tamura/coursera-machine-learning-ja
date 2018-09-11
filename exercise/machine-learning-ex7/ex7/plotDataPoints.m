function plotDataPoints(X, idx, K)
% PLOTDATAPOINTS Xのデータ点をプロットし、idxの同じインデックス割り当てを持つものが
% 同じ色になるように色付けします。
%   PLOTDATAPOINTS(X, idx, K)は、 Xのデータ点をプロットし、idxの同じ
%   インデックス割り当てを持つものが同じ色になるように色付けします。

% パレットを作成する
palette = hsv(K + 1);
colors = palette(idx, :);

% データをプロットする
scatter(X(:,1), X(:,2), 15, colors);

end
