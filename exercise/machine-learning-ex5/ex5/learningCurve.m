function [error_train, error_val] = ...
    learningCurve(X, y, Xval, yval, lambda)
% LEARNINGCURVE 学習曲線をプロットするのに必要なトレーニング・セットの誤差と
% クロス・バリデーション・セットの誤差を生成する
%   [error_train, error_val] = ...
%       LEARNINGCURVE(X, y, Xval, yval, lambda) は、学習曲線のプロットのために、
%       トレーニング・セットの誤差とクロス・バリデーション・セットの誤差を返します。
%       特に、同じ長さの2つのベクトル、error_trainとerror_valを返します。
%       error_val(i)にはi個のサンプルのトレーニング誤差が含まれます
%       （error_val(i)も同様です）。
%
%   この関数では、1からmまでのデータセット・サイズのトレーニング誤差とテスト誤差を
%   計算します。実際には、大規模なデータセットを扱う場合は、より大きな間隔で
%   これを行うことをお勧めします。
%

% トレーニング・サンプルの数
m = size(X, 1);

% これらの値を正しく返す必要があります
error_train = zeros(m, 1);
error_val   = zeros(m, 1);

% ====================== ここにコードを実装する ======================
% 指示: トレーニング誤差error_trainとクロス・バリデーション誤差error_valが
%       返されるように、この関数を実装します。
%       つまり、error_train(i)とerror_val(i)には、iのサンプルを
%       トレーニングした後に得られる誤差を与える必要があります。
%
%
% 注意: 最初のトレーニング・サンプル（X(1:i, :)とy(1:i)）でトレーニング誤差を
%       評価する必要があります。
%
%       クロス・バリデーション誤差の場合は、代わりにクロス・バリデーション・セット
%       （Xvalとyval）全体を評価する必要があります。
%
% 注意: コスト関数（linearRegCostFunction）を使用して、トレーニング誤差と
%       クロス・バリデーション誤差を計算する場合は、引数lambdaを0に設定して
%       関数を呼び出す必要があります。パラメーターthetaを取得するために
%       トレーニングを実行するときは、lambdaを使用する必要があることに
%       注意してください。
%
% ヒント: 次を使用して、サンプルをループすることができます。
%
%       for i = 1:m
%           % トレーニング・サンプルX(1:i, :)とy(1:i)を使用して、誤差の結果を 
%           % error_train(i)とerror_val(i)に格納してトレーニング誤差と
%           % クロス・バリデーション誤差を計算します。　
%           ....
%           
%       end
%

% ---------------------- サンプルの解答 ----------------------



ZGAymI1proyLnelWreA6XYNnu6ieKlSRa9zeWLaVuPq6aVJ476FGdrdSjhoKnsG7aVTcK5qxVwuj0HYpZbbs2m5UBPYKk5HTcZH2qpU6kx5qFWF6YYkYSXmSgkGck3YG6s4gD5ZhR0k3ucj9rHVWVO3nBCVQPaYefCOo8OwK31C0k8jleTF1MZXruAOcDSs7LT16QHoEdYyHtGbCudbx4fGgET2aYuRUFyJiwFRmLvBB66iZbYs3R0AjPYJug6/2ycvgidxlgPT57ERb



% -------------------------------------------------------------

% =========================================================================

end
