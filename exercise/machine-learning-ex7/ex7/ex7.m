%% 機械学習オンラインクラス
%  演習 7 | 主成分分析とK-Meansクラスタリング
%
%  指示
%  ------------
%
%  このファイルには、演習を開始するのに役立つコードが含まれています。
%  次の関数を完成する必要があります。
%
%     pca.m
%     projectData.m
%     recoverData.m
%     computeCentroids.m
%     findClosestCentroids.m
%     kMeansInitCentroids.m
%
%  この演習では、このファイルまたは上記以外のファイル内のコードを
%  変更する必要はありません。
%

%% 初期化
clear ; close all; clc

%% ================= パート 1: 最も近い重心の検索 ====================
%  K-Meansの実装を支援するため、学習アルゴリズムを次の2つの関数に分けました
%  -- findClosestCentroidsとcomputeCentroids
%  このパートでは、findClosestCentroids関数のコードを完成させる必要があります。
%
fprintf('Finding closest centroids.\n\n');

% 使用するサンプルのデータセットをロードする
load('ex7data2.mat');

% 重心の初期セットを選択する
K = 3; % 3 Centroids
initial_centroids = [3 3; 6 2; 8 5];

% initial_centroidsを使用して、サンプルに最も近い重心を検索する
% 
idx = findClosestCentroids(X, initial_centroids);

fprintf('Closest centroids for the first 3 examples: \n')
fprintf(' %d', idx(1:3));
fprintf('\n(the closest centroids should be 1, 3, 2 respectively)\n');

fprintf('Program paused. Press enter to continue.\n');
pause;

%% ===================== パート 2: 平均の計算 =========================
%  最も近い重心を検索する関数を実装した後は、computeCentroids関数を
%  完成させる必要があります。
%
fprintf('\nComputing centroids means.\n\n');

%  前のパートで見つかった最も近い重心に基づいて平均を計算します。
centroids = computeCentroids(X, idx, K);

fprintf('Centroids computed after initial finding of closest centroids: \n')
fprintf(' %f %f \n' , centroids');
fprintf('\n(the centroids should be\n');
fprintf('   [ 2.428301 3.157924 ]\n');
fprintf('   [ 5.813503 2.633656 ]\n');
fprintf('   [ 7.119387 3.616684 ]\n\n');

fprintf('Program paused. Press enter to continue.\n');
pause;


%% =================== パート 3: K-Meansクラスタリング ======================
%  computeCentroidsとfindClosestCentroidsの2つの関数を完成させると、
%  K-Meansアルゴリズムを実行するために必要なすべての要素が得られます。
%  このパートでは、提供したサンプル・データセットを使用して、
%  K-Meansアルゴリズムを実行します。
%
fprintf('\nRunning K-Means clustering on example dataset.\n\n');

% サンプル・データセットをロードする
load('ex7data2.mat');

% K-Meansを実行するための設定
K = 3;
max_iters = 10;

% 一貫性を保つために、ここでは重心に特定の値を設定しますが、実際には、
% ランダムなサンプルが設定されるように、自動的に生成したいと考えるでしょう
% （kMeansInitCentroidsを見ると分かるように）。
% 
initial_centroids = [3 3; 6 2; 8 5];

% K-Meansアルゴリズムを実行してください。関数の最後の引数「true」は、K-Meansの
% 進捗状況をプロットするためのものです。
[centroids, idx] = runkMeans(X, initial_centroids, max_iters, true);
fprintf('\nK-Means Done.\n\n');

fprintf('Program paused. Press enter to continue.\n');
pause;

%% ============= パート 4: ピクセルのK-Meansクラスタリング ===============
%  この演習では、K-Meansを使用して画像を圧縮します。これを行うには、
%  まず画像のピクセルの色についてK-Meansを実行し、次に各ピクセルを最も近い
%  重心にマップします。
%  
%  これで、kMeansInitCentroids.mのコードを完成させるはずです。
%

fprintf('\nRunning K-Means clustering on pixels from an image.\n\n');

%  鳥の画像をロードする
A = double(imread('bird_small.png'));

% あなたの環境でimreadが動作しない場合は、代わりにこれを試すことができます
%   load ('bird_small.mat');

A = A / 255; % すべての値が0〜1の範囲になるように255で割ります

% 画像のサイズ
img_size = size(A);

% 画像をNx3の行列に変形する。ここでNはピクセル数。
% 各行には赤、緑、青のピクセル値が含まれます。
% これにより、K-Meansで使用するデータセット行列Xが得られます。
X = reshape(A, img_size(1) * img_size(2), 3);

% このデータに対してK-Meansアルゴリズムを実行します。
% ここで、Kとmax_itersの異なる値を試してみるべきです。
K = 16; 
max_iters = 10;

% K-Meansを使用する場合、重心をランダムに初期化することが重要です。
% 
% 続行する前に、kMeansInitCentroids.mのコードを完成させる必要があります。
initial_centroids = kMeansInitCentroids(X, K);

% K-Meansを実行する
[centroids, idx] = runkMeans(X, initial_centroids, max_iters);

fprintf('Program paused. Press enter to continue.\n');
pause;


%% ================= パート 5: 画像の圧縮 ======================
%  この演習では、K-Meansのクラスターを使用して画像を圧縮します。
%  これを行うために、最初に各サンプルに最も近いクラスターを見つけます。
%  

fprintf('\nApplying K-Means to compress an image.\n\n');

% 最も近いクラスター・メンバーを見つける
idx = findClosestCentroids(X, centroids);

% 本質的には、idxのインデックスの項で画像Xを表現しています。
% 

% （idxのインデックスで指定された）各ピクセルを重心の値にマッピングすることによって、
% インデックス（idx）から画像を復元できます。
X_recovered = centroids(idx,:);

% 回復した画像を適切な大きさに整形し直します。
X_recovered = reshape(X_recovered, img_size(1), img_size(2), 3);

% 元の画像を表示する
subplot(1, 2, 1);
imagesc(A); 
title('Original');

% 圧縮画像を並べて表示する
subplot(1, 2, 2);
imagesc(X_recovered)
title(sprintf('Compressed, with %d colors.', K));


fprintf('Program paused. Press enter to continue.\n');
pause;

