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

%% ================== パート 1: サンプルデータセットのロード  ===================
%  簡単に可視化できる小さなデータセットを使用して、この演習を開始します
%  
%
fprintf('Visualizing example dataset for PCA.\n\n');

%  次のコマンドは、データセットをロードします。
%  環境に変数Xがロードされます。
load ('ex7data1.mat');

%  サンプルのデータセットを可視化する
plot(X(:, 1), X(:, 2), 'bo');
axis([0.5 6.5 2 8]); axis square;

fprintf('Program paused. Press enter to continue.\n');
pause;


%% =============== パート 2: 主成分分析 ===============
%  次元削減の技術であるPCAを実装する必要があります。
%  pca.mのコードを完成させてください。
%
fprintf('\nRunning PCA on example dataset.\n\n');

%  PCAを実行する前に、まずXを正規化することが重要です。
[X_norm, mu, sigma] = featureNormalize(X);

%  PCAを実行する
[U, S] = pca(X_norm);

%  mu（各フィーチャーの平均）を計算する

%  データの平均を中心とする固有ベクトルを描く。
%  これらの線は、データセットの最大変動の方向を示しています。
hold on;
drawLine(mu, mu + 1.5 * S(1,1) * U(:,1)', '-k', 'LineWidth', 2);
drawLine(mu, mu + 1.5 * S(2,2) * U(:,2)', '-k', 'LineWidth', 2);
hold off;

fprintf('Top eigenvector: \n');
fprintf(' U(:,1) = %f %f \n', U(1,1), U(2,1));
fprintf('\n(you should expect to see -0.707107 -0.707107)\n');

fprintf('Program paused. Press enter to continue.\n');
pause;


%% =================== パート 3: 次元削減 ===================
%  ここで、最初のk個の固有ベクトルにデータをマッピングする射影のステップを
%  実装する必要があります。コードは、この削減された次元空間にデータを
%  プロットします。これにより、対応する固有ベクトルのみを使用して再構成した場合に、
%  データがどのように見えるかが分かります。
%
%  projectData.mのコードを完成させる必要があります。
%
fprintf('\nDimension reduction on example dataset.\n\n');

%  （pcaから返される）正規化されたデータセットをプロットする
plot(X_norm(:, 1), X_norm(:, 2), 'bo');
axis([-4 3 -4 3]); axis square

%  データをK = 1次元に射影する
K = 1;
Z = projectData(X_norm, U, K);
fprintf('Projection of the first example: %f\n', Z(1));
fprintf('\n(this value should be about 1.481274)\n\n');

X_rec  = recoverData(Z, U, K);
fprintf('Approximation of the first example: %f %f\n', X_rec(1, 1), X_rec(1, 2));
fprintf('\n(this value should be about  -1.047419 -1.047419)\n\n');

%  投影された点と元の点を結ぶ線を引く
hold on;
plot(X_rec(:, 1), X_rec(:, 2), 'ro');
for i = 1:size(X_norm, 1)
    drawLine(X_norm(i,:), X_rec(i,:), '--k', 'LineWidth', 1);
end
hold off

fprintf('Program paused. Press enter to continue.\n');
pause;

%% =============== パート 4: 顔データのロードと可視化 =============
%  最初にデータセットをロードして可視化することから、この演習を開始します。
%  次のコードは、データセットを環境にロードします
%
fprintf('\nLoading face dataset.\n\n');

%  顔データをロードする
load ('ex7faces.mat')

%  データセットの最初の100個の顔を表示する
displayData(X(1:100, :));

fprintf('Program paused. Press enter to continue.\n');
pause;

%% =========== パート 5: 顔データのPCA：固有顔  ===================
%  PCAを実行し、固有ベクトル（このけーすでは固有顔）を可視化します。
%  最初の36個の固有顔表示します。
%
fprintf(['\nRunning PCA on face dataset.\n' ...
         '(this might take a minute or two ...)\n\n']);

%  PCAを実行する前に、各フィーチャーから平均値を引いて、最初にXを
%  正規化することが重要です。
[X_norm, mu, sigma] = featureNormalize(X);

%  PCAを実行する
[U, S] = pca(X_norm);

%  見つかった上位36個の固有ベクトルを可視化する。
displayData(U(:, 1:36)');

fprintf('Program paused. Press enter to continue.\n');
pause;


%% ============= パート 6: 顔の次元削減 =================
%  機械学習アルゴリズムを適用する場合は、上位k個の固有ベクトルを使用して、
%  固有空間に画像を射影します。
fprintf('\nDimension reduction for face dataset.\n\n');

K = 100;
Z = projectData(X_norm, U, K);

fprintf('The projected data Z has a size of: ')
fprintf('%d ', size(Z));

fprintf('\n\nProgram paused. Press enter to continue.\n');
pause;


%% ==== パート 7: PCA次元削減後の顔の可視化 ====
%  上位k個の固有ベクトルを使用して固有空間に画像を射影し、それらのK次元のみを
%  使用して可視化します。
%  元の入力と比較して表示されます

fprintf('\nVisualizing the projected (reduced dimension) faces.\n\n');

K = 100;
X_rec  = recoverData(Z, U, K);

% 正規化されたデータを表示する
subplot(1, 2, 1);
displayData(X_norm(1:100,:));
title('Original faces');
axis square;

% k個の固有顔からの再構築したデータの表示
subplot(1, 2, 2);
displayData(X_rec(1:100,:));
title('Recovered faces');
axis square;

fprintf('Program paused. Press enter to continue.\n');
pause;


%% === パート 8(a): オプション（非評価）練習：可視化のためのPCA ===
%  PCAの1つの有用な用途は、高次元のデータを可視化するためにそれを使用することです。
%  K-Meansの最後の演習では、画像の3次元ピクセルカラーでK-Meansを実行しました。
%  まずは、この出力を3Dで可視化し、PCAを適用して2Dで可視化します。
%  

close all; close all; clc

% 以前の演習の画像をリロードし、K-Meansを実行します
% これが機能するには、最初にK-Meansの課題を完了する必要があります
A = double(imread('bird_small.png'));

% あなたの環境でimreadが動作しない場合は、代わりにこれを試すことができます
%   load ('bird_small.mat');

A = A / 255;
img_size = size(A);
X = reshape(A, img_size(1) * img_size(2), 3);
K = 16; 
max_iters = 10;
initial_centroids = kMeansInitCentroids(X, K);
[centroids, idx] = runkMeans(X, initial_centroids, max_iters);

%  1000個のランダムなインデックスをサンプリングします（すべてのデータを処理するのは
%  高価すぎるため）。高速なコンピューターを使用している場合は、これを増加できます。
sel = floor(rand(1000, 1) * size(X, 1)) + 1;

%  カラーパレットをセットアップ
palette = hsv(K);
colors = palette(idx(sel), :);

%  データと重心メンバーシップを3Dで可視化する
figure;
scatter3(X(sel, 1), X(sel, 2), X(sel, 3), 10, colors);
title('Pixel dataset plotted in 3D. Color shows centroid memberships');
fprintf('Program paused. Press enter to continue.\n');
pause;

%% === パート 8(b): オプション（非評価）練習：可視化のためのPCA ===
% PCAを使用してこのクラウドを2Dに射影して可視化します。

% PCAを使用するために平均を引く
[X_norm, mu, sigma] = featureNormalize(X);

% PCAでデータを2Dに射影する
[U, S] = pca(X_norm);
Z = projectData(X_norm, U, 2);

% 2Dでプロットする
figure;
plotDataPoints(Z(sel, :), idx(sel), K);
title('Pixel dataset plotted in 2D, using PCA for dimensionality reduction');
fprintf('Program paused. Press enter to continue.\n');
pause;
