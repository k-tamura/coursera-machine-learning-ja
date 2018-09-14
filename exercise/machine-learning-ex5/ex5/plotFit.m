function plotFit(min_x, max_x, mu, sigma, theta, p)
% PLOTFIT 既存の図に対して学習された多項式回帰近似をプロットします。
% 線形回帰でも動作します。
%   PLOTFIT(min_x, max_x, mu, sigma, theta, p) は、累乗pとフィーチャーの
%   正規化（mu、sigma）で学習された多項式近似をプロットします。

% 既存の図をホールド
hold on;

% データ点の範囲外で近似がどのように変化するかを知るために、最小値と最大値より
% 少し大きい範囲をプロットします。
x = (min_x - 15: 0.05 : max_x + 25)';

% X値をマッピングする
X_poly = polyFeatures(x, p);
X_poly = bsxfun(@minus, X_poly, mu);
X_poly = bsxfun(@rdivide, X_poly, sigma);

% １を追加
X_poly = [ones(size(x, 1), 1) X_poly];

% プロット
plot(x, X_poly * theta, '--', 'LineWidth', 2)

% 既存の図のホールド解除
hold off

end
