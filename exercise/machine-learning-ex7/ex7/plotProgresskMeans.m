function plotProgresskMeans(X, centroids, previous, idx, K, i)
% PLOTPROGRESSKMEANS 実行中のk-Meansの進行状況を表示するヘルパー関数です。
% 2Dデータでの使用のみを目的としています。
%   PLOTPROGRESSKMEANS(X, centroids, previous, idx, K, i)は、各重心に
%   割り当てられた色でデータ点をプロットします。以前の重心とともに、
%   以前の重心の位置と現在の重心の位置を結ぶ線もプロットします。
%   
%

% サンプルをプロットする
plotDataPoints(X, idx, K);

% 重心を黒のxとしてプロットする
plot(centroids(:,1), centroids(:,2), 'x', ...
     'MarkerEdgeColor','k', ...
     'MarkerSize', 10, 'LineWidth', 3);

% 重心の履歴を線でプロットする
for j=1:size(centroids,1)
    drawLine(centroids(j, :), previous(j, :));
end

% タイトル付けする
title(sprintf('Iteration number %d', i))

end

