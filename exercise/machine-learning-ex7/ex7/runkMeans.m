function [centroids, idx] = runkMeans(X, initial_centroids, ...
                                      max_iters, plot_progress)
% RUNKMEANS データ行列XでK-Meansアルゴリズムを実行します。ここで、Xの各行は
% 1つのサンプルです。
%   [centroids, idx] = RUNKMEANS(X, initial_centroids, max_iters, ...
%   plot_progress) は、データ行列Xに対してK-Meansアルゴリズムを実行します。
%   ここで、Xの各行は1つのサンプルです。重心の初期値として使用される
%   initial_centroidsを使用します。max_itersは、実行するK-Meansの
%   総実行回数を指定します。plot_progressは、学習の進行とともに関数が
%   プロットする必要があるかどうかを示すtrue/falseのフラグです。
%   デフォルトではfalseに設定されています。
%   runkMeansは、計算された重心のk×n行列centroidsと、重心割り当て
%   （すなわち、範囲[1..K]内の各エントリー）のm×1ベクトルであるidxを返します。
%

% プロットの進行のデフォルト値を設定する
if ~exist('plot_progress', 'var') || isempty(plot_progress)
    plot_progress = false;
end

% 進行状況をプロットしている場合はデータをプロットする
if plot_progress
    figure;
    hold on;
end

% 値を初期化する
[m n] = size(X);
K = size(initial_centroids, 1);
centroids = initial_centroids;
previous_centroids = centroids;
idx = zeros(m, 1);

% K-Meansを実行する
for i=1:max_iters
    
    % 進捗状況の出力
    fprintf('K-Means iteration %d/%d...\n', i, max_iters);
    if exist('OCTAVE_VERSION')
        fflush(stdout);
    end
    
    % Xの各サンプルに対して、最も近い重心にそれを割り当てる
    idx = findClosestCentroids(X, centroids);
    
    % オプションで、ここで進捗状況をプロットします。
    if plot_progress
        plotProgresskMeans(X, centroids, previous_centroids, idx, K, i);
        previous_centroids = centroids;
        fprintf('Press enter to continue.\n');
        pause;
    end
    
    % 与えられたメンバーシップで、新しい重心を計算する
    centroids = computeCentroids(X, idx, K);
end

% 進捗状況をプロットしている場合は、ホールド状態をオフにする
if plot_progress
    hold off;
end

end

