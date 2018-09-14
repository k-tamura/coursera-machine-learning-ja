function [Ynorm, Ymean] = normalizeRatings(Y, R)
% NORMALIZERATINGS すべての映画（すべての行）の平均評価を引いてデータを
% 前処理します。
%   [Ynorm, Ymean] = NORMALIZERATINGS(Y, R)は、各映画の平均評価が0に
%   なるようにYを正規化し、Ymeanに平均評価をセットして返します。
%

[m, n] = size(Y);
Ymean = zeros(m, 1);
Ynorm = zeros(size(Y));
for i = 1:m
    idx = find(R(i, :) == 1);
    Ymean(i) = mean(Y(i, idx));
    Ynorm(i, idx) = Y(i, idx) - Ymean(i);
end

end
