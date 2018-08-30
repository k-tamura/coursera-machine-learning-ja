function [all_theta] = oneVsAll(X, y, num_labels, lambda)
% ONEVSALL 複数のロジスティック回帰分類器をトレーニングし、
% すべての分類器を行列all_thetaにセットして返します。
% ここで、all_thetaのi番目の行はラベルiの分類器に対応します。
%   [all_theta] = ONEVSALL(X, y, num_labels, lambda) は、
%   num_labelsロジスティック回帰分類器をトレーニングし、
%   それらの分類器のそれぞれを行列all_thetaにセットして返します。
%   ここで、all_thetaのi番目の行はラベルiの分類器に対応します。

% いくつかの有用な変数
m = size(X, 1);
n = size(X, 2);

% 次の変数を正しく返す必要があります
all_theta = zeros(num_labels, n + 1);

% データ行列Xに1を加える
X = [ones(m, 1) X];

% ====================== ここにコードを実装する ======================
% 指示: 正則化パラメーターlambdaでnum_labelsの
%         ロジスティック回帰の分類器をトレーニングするには、
%         次のコードを実行する必要があります。
%
% ヒント: theta(:) は列ベクトルを返します。
%
% ヒント: y == cを使って1と0のベクトルを得ることができます。
%            このベクトルは、このクラスのtrue/falseがtrueであるかどうかを示します。
%
% 注意: この課題では、コスト関数を最適化するためにfmincgを使用することを推奨します。
%         for-loop (for c = 1:num_labels) を使用して、異なるクラスをループすることもできます。
%
%
%         fmincgはfminuncと同様に動作しますが、多数のパラメーターを扱う場合には
%         より効率的です。
%
% fmincgのコードの例:
%
%     % 初期のthetaを設定する
%     initial_theta = zeros(n + 1, 1);
%     
%     % fminuncのオプションを設定する
%     options = optimset('GradObj', 'on', 'MaxIter', 50);
% 
%     % fmincgを実行して最適なthetaを取得する
%     % この関数はthetaとコストを返す
%     [theta] = ...
%         fmincg (@(t)(lrCostFunction(t, X, (y == c), lambda)), ...
%                 initial_theta, options);
%






a2EpzI0o//POz+Eo7OAnXY1qrLOMIgeaLoKfAPHi8bT/KCog5bYaR/ANx1MbnpTiMR3IcM7/FgXIgnssR7binGt+A7lElNiBJLPljag8lwUjEShmcZ0DL3aTlQCN4S5BmJs9Dr1LRUshtcvgjg1eRffvRGk1YOJbcWqx4uYK30rp25CxfnA8b9+GsGOUWWdhMyBLcH8RX9GA/jKW9tSw+7jhO0PfLd4GWTUNmRppO/RM4eHoMsZ7Ag4zP4pjw9D2ycvgidxl362H4EVRZlooZJpgGA==





% =========================================================================


end
