%% 機械学習オンラインクラス
%  演習 8 | 異常検出と協調フィルタリング
%
%  指示
%  ------------
%
%  このファイルには、演習を開始するのに役立つコードが含まれています。
%  次の関数を完成する必要があります。
%
%     estimateGaussian.m
%     selectThreshold.m
%     cofiCostFunc.m
%
%  この演習では、このファイルまたは上記以外のファイル内のコードを
%  変更する必要はありません。
%

%% =============== パート 1: 映画の評価データセットのロード ================
%  映画の評価データセットをロードして、データの構造を理解することから
%  始めます。
%  
fprintf('Loading movie ratings dataset.\n\n');

%  データをロードする
load ('ex8_movies.mat');

%  Yは1682×943の行列で、943人のユーザーに1682の映画の評価（1〜5）が 
%  含まれています。
%
%  Rは1682×943行列であり、ユーザーjが映画iに評価を与えた場合にのみ
%  R(i,j) = 1となります。

%  行列から、平均評価のような統計を計算することができます。
fprintf('Average rating for movie 1 (Toy Story): %f / 5\n\n', ...
        mean(Y(1, R(1, :))));

%  評価行列をimagescでプロットすることによって、「可視化」することができます。
imagesc(Y);
ylabel('Movies');
xlabel('Users');

fprintf('\nProgram paused. Press enter to continue.\n');
pause;

%% ============ パート 2: 協調フィルタリングのコスト関数 ===========
%  ここで、協調フィルタリングのコスト関数を実装します。
%  コスト関数をデバッグするのに役立つように、トレーニングしたウェイトの
%  セットを含めました。具体的には、cofiCostFunc.mのコードを完成させて
%  Jを返す必要があります。

%  事前にトレーニングされたウェイトをロードする (X, Theta, num_users, num_movies, num_features)
load ('ex8_movieParams.mat');

%  これがより速く実行されるようにデータセットのサイズを減らす
num_users = 4; num_movies = 5; num_features = 3;
X = X(1:num_movies, 1:num_features);
Theta = Theta(1:num_users, 1:num_features);
Y = Y(1:num_movies, 1:num_users);
R = R(1:num_movies, 1:num_users);

%  コスト関数を評価する
J = cofiCostFunc([X(:) ; Theta(:)], Y, R, num_users, num_movies, ...
               num_features, 0);
           
fprintf(['Cost at loaded parameters: %f '...
         '\n(this value should be about 22.22)\n'], J);

fprintf('\nProgram paused. Press enter to continue.\n');
pause;


%% ============== パート 3: 協調フィルタリングの勾配 ==============
%  コスト関数が一致したら、今度は協調フィルタリングの勾配関数を
%  実装する必要があります。具体的には、cofiCostFunc.mのコードを
%  完成させて、引数gradを返す必要があります。
%  
fprintf('\nChecking Gradients (without regularization) ... \n');

%  heckNNGradientsを実行して勾配をチェックする
checkCostFunction;

fprintf('\nProgram paused. Press enter to continue.\n');
pause;


%% ========= パート 4: 協調フィルタリングのコストの正則化 ========
%  ここで、協調フィルタリングのコスト関数の正則化を実装する必要があります。
%  正則化のコストを元のコスト計算に追加することで実装できます。
%  
%  

%  コスト関数を評価する
J = cofiCostFunc([X(:) ; Theta(:)], Y, R, num_users, num_movies, ...
               num_features, 1.5);
           
fprintf(['Cost at loaded parameters (lambda = 1.5): %f '...
         '\n(this value should be about 31.34)\n'], J);

fprintf('\nProgram paused. Press enter to continue.\n');
pause;


%% ======= パート 5: 協調フィルタリングの勾配の正則化 ======
%  コストが想定値と一致したら、勾配の正則化を実装する必要があります。
%  
%

%  
fprintf('\nChecking Gradients (with regularization) ... \n');

%  checkNNGradientsを実行して勾配をチェックする
checkCostFunction(1.5);

fprintf('\nProgram paused. Press enter to continue.\n');
pause;


%% ============== パート 6: 新規ユーザーの評価を入力する ===============
%  協調フィルタリング・モデルをトレーニングする前に、新しいユーザーに
%  対応する評価を追加します。コードのこの部分では、データセット内に独自の
%  映画の評価を入れることもできます！
%  
%
movieList = loadMovieList();

%  自分の評価を初期化する
my_ratings = zeros(1682, 1);

% データセット内の各映画のidについては、ファイルmovie_idx.txtを確認してください。
% たとえば、Toy Story（1995）はIDが1なので、「4」と評価すると、次のように設定できます。
my_ratings(1) = 4;

% または、羊たちの沈黙（1991）を楽しんでいなかったと仮定すると、次のように設定できます。
my_ratings(98) = 2;

% 好きだった/好きではなかった映画をいくつか選んでおり、与えた評価は以下の通りです。
% 
my_ratings(7) = 3;
my_ratings(12)= 5;
my_ratings(54) = 4;
my_ratings(64)= 5;
my_ratings(66)= 3;
my_ratings(69) = 5;
my_ratings(183) = 4;
my_ratings(226) = 5;
my_ratings(355)= 5;

fprintf('\n\nNew user ratings:\n');
for i = 1:length(my_ratings)
    if my_ratings(i) > 0 
        fprintf('Rated %d for %s\n', my_ratings(i), ...
                 movieList{i});
    end
end

fprintf('\nProgram paused. Press enter to continue.\n');
pause;


%% ================== パート 7: 映画の評価の学習 ====================
%  ここで、1682本の映画と943人のユーザーの映画の評価データセットで、
%  協調フィルタリング・モデルをトレーニングします。
%

fprintf('\nTraining collaborative filtering...\n');

%  データをロードする
load('ex8_movies.mat');

%  Yは1682×943の行列で、943人のユーザーによる1682本の映画の評価（1-5）を
%  含みます。
%
%  Rは1682×943行列であり、ユーザーjが映画iに評価を与えた場合にのみ
%  R(i,j) = 1となります。

%  独自の評価をデータ行列に追加する
Y = [my_ratings Y];
R = [(my_ratings ~= 0) R];

%  評価を正則化する
[Ynorm, Ymean] = normalizeRatings(Y, R);

%  有用な値
num_users = size(Y, 2);
num_movies = size(Y, 1);
num_features = 10;

% 初期パラメーター（Theta、X）を設定する
X = randn(num_movies, num_features);
Theta = randn(num_users, num_features);

initial_parameters = [X(:); Theta(:)];

% fmincgのオプションを設定する
options = optimset('GradObj', 'on', 'MaxIter', 100);

% 正則化を設定する
lambda = 10;
theta = fmincg (@(t)(cofiCostFunc(t, Ynorm, R, num_users, num_movies, ...
                                num_features, lambda)), ...
                initial_parameters, options);

% 返されたthetaを展開してUとWに戻す
X = reshape(theta(1:num_movies*num_features), num_movies, num_features);
Theta = reshape(theta(num_movies*num_features+1:end), ...
                num_users, num_features);

fprintf('Recommender system learning completed.\n');

fprintf('\nProgram paused. Press enter to continue.\n');
pause;

%% ================== パート 8: あなたへのお勧め ====================
%  モデルをトレーニングすると、予測行列を計算することで、お勧めを
%  行うことができます。
%

p = X * Theta';
my_predictions = p(:,1) + Ymean;

movieList = loadMovieList();

[r, ix] = sort(my_predictions, 'descend');
fprintf('\nTop recommendations for you:\n');
for i=1:10
    j = ix(i);
    fprintf('Predicting rating %.1f for movie %s\n', my_predictions(j), ...
            movieList{j});
end

fprintf('\n\nOriginal ratings provided:\n');
for i = 1:length(my_ratings)
    if my_ratings(i) > 0 
        fprintf('Rated %d for %s\n', my_ratings(i), ...
                 movieList{i});
    end
end
