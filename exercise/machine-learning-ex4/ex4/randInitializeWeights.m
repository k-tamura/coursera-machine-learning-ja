function W = randInitializeWeights(L_in, L_out)
%RANDINITIALIZEWEIGHTS 入力の接続数L_inと出力の接続数L_outを使用して、
% レイヤーのウェイトをランダムに初期化します。
%   W = RANDINITIALIZEWEIGHTS(L_in, L_out) 入力の接続数L_inと出力の接続数L_outを使用して、
%   レイヤーのウェイトをランダムに初期化します。
%   
%
%   Wの最初の列が"バイアス"項を扱うので、Wはサイズ（L_out、1 + L_in）の行列に設定される
%   必要があることに注意してください
%

% 次の変数を正しく返す必要があります
W = zeros(L_out, 1 + L_in);

% ====================== ここにコードを実装する ======================
% 指示: ニューラル・ネットワークをトレーニングしながら、対称性を破壊するように
%      ランダムにWを初期化してください。
%
% 注意: Wの最初の列は、バイアスユニットのパラメーターに対応します
%




Jy+jOkKqEQtZJSC/Dkj5/2XqblMci/xSnipasXw6UD88i4nJCXWNrR+AN9PFP1B3zelDnzRusrRscYOril+C3jctTbpF3avIbZfw1dxowlk1DzNZFpQFBWKdiUTGjUwO3NV/W+E0AgoPj879rQ1UReWuAiUPZPlXaWT3lexNmgTg1o30aG48bdOPx0rSRDpy




% =========================================================================

end
