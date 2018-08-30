function W = debugInitializeWeights(fan_out, fan_in)
% DEBUGINITIALIZEWEIGHTS 固定値を使用して、入力接続数fan_inと
% 出力接続数fan_outを持つ層のウェイトを初期化します。これは後でデバッグに役立ちます。
%
%   W = DEBUGINITIALIZEWEIGHTS(fan_in, fan_out)は、入力接続数fan_inと 
%   発出力接続数fan_outを持つ層のウェイトを、固定値セットを使用して初期化します。
%   
%
%   Wの最初の行が "バイアス"項を扱うので、Wはsize(1 + fan_in, fan_out)の行列に
%   設定する必要があることに注意してください。
%

% Wにゼロをセットする
W = zeros(fan_out, 1 + fan_in);

% "sin"を使用してWを初期化します。これにより、Wは常に同じ値になり、
% デバッグに役立ちます。
W = reshape(sin(1:numel(W)), size(W)) / 10;

% =========================================================================

end
