%% 機械学習オンラインクラス
%  演習 6 | SVMによるスパム分類
%
%  指示
%  ------------
% 
%  このファイルには、演習を開始するのに役立つコードが含まれています。
%  次の関数を完成する必要があります。
%
%     gaussianKernel.m
%     dataset3Params.m
%     processEmail.m
%     emailFeatures.m
%
%  この演習では、このファイルまたは上記以外のファイル内のコードを
%  変更する必要はありません。
%

%% 初期化
clear ; close all; clc

%% ==================== パート 1: 電子メール前処理 ====================
%  SVMを使用して電子メールをスパムとノンスパムに分類するには、
%  まず各電子メールを機能ベクトルに変換する必要があります。 
%  このパートでは、各電子メールの前処理ステップを実装します。
%  与えられた電子メールの単語インデックスのベクトルを生成するには、
%  processEmail.mのコードを完成させる必要があります。

fprintf('\nPreprocessing sample email (emailSample1.txt)\n');

% フィーチャーの抽出
file_contents = readFile('emailSample1.txt');
word_indices  = processEmail(file_contents);

% 統計情報をプリントする
fprintf('Word Indices: \n');
fprintf(' %d', word_indices);
fprintf('\n\n');

fprintf('Program paused. Press enter to continue.\n');
pause;

%% ==================== パート 2: フィーチャーの抽出 ====================
%  今度は、各電子メールをR^nのフィーチャー・ベクトルに変換します。
%  emailFeatures.mにコードを入力して、与えられたメールのフィーチャー・ベクトルを
%  生成する必要があります。

fprintf('\nExtracting features from sample email (emailSample1.txt)\n');

% フィーチャーの抽出
file_contents = readFile('emailSample1.txt');
word_indices  = processEmail(file_contents);
features      = emailFeatures(word_indices);

% 統計情報をプリントする
fprintf('Length of feature vector: %d\n', length(features));
fprintf('Number of non-zero entries: %d\n', sum(features > 0));

fprintf('Program paused. Press enter to continue.\n');
pause;

%% =========== パート 3: スパム分類のための線形SVMのトレーニング ========
%  このセクションでは、電子メールがスパムメールか否かを判断するために線形分類器を
%  トレーニングします。

% スパムメールのデータセットをロード
% 環境にX、Yがロードされます
load('spamTrain.mat');

fprintf('\nTraining Linear SVM (Spam Classification)\n')
fprintf('(this may take 1 to 2 minutes) ...\n')

C = 0.1;
model = svmTrain(X, y, C, @linearKernel);

p = svmPredict(model, X);

fprintf('Training Accuracy: %f\n', mean(double(p == y)) * 100);

%% =================== パート 4: スパム分類のテスト ================
%  分類器をトレーニングした後、テストセットで評価することができます。 
%  spamTest.matにテストセットを含めました。

% テスト・データセットをロード
% 環境にXtest, ytestがロードされます
load('spamTest.mat');

fprintf('\nEvaluating the trained Linear SVM on a test set ...\n')

p = svmPredict(model, Xtest);

fprintf('Test Accuracy: %f\n', mean(double(p == ytest)) * 100);
pause;


%% ================= パート 5: スパムの上位予測 ====================
%  Since the model we are training is a linear SVM, we can inspect the
%  weights learned by the model to understand better how it is determining
%  whether an email is spam or not. The following code finds the words with
%  the highest weights in the classifier. Informally, the classifier
%  'thinks' that these words are the most likely indicators of spam.
%

% Sort the weights and obtin the vocabulary list
[weight, idx] = sort(model.w, 'descend');
vocabList = getVocabList();

fprintf('\nTop predictors of spam: \n');
for i = 1:15
    fprintf(' %-15s (%f) \n', vocabList{idx(i)}, weight(i));
end

fprintf('\n\n');
fprintf('\nProgram paused. Press enter to continue.\n');
pause;

%% =================== パート 6: あなた自身のメールを試す =====================
%  Now that you've trained the spam classifier, you can use it on your own
%  emails! In the starter code, we have included spamSample1.txt,
%  spamSample2.txt, emailSample1.txt and emailSample2.txt as examples. 
%  The following code reads in one of these emails and then uses your 
%  learned SVM classifier to determine whether the email is Spam or 
%  Not Spam

% Set the file to be read in (change this to spamSample2.txt,
% emailSample1.txt or emailSample2.txt to see different predictions on
% different emails types). Try your own emails as well!
filename = 'spamSample1.txt';

% Read and predict
file_contents = readFile(filename);
word_indices  = processEmail(file_contents);
x             = emailFeatures(word_indices);
p = svmPredict(model, x);

fprintf('\nProcessed %s\n\nSpam Classification: %d\n', filename, p);
fprintf('(1 indicates spam, 0 indicates not spam)\n\n');

