function numgrad = computeNumericalGradient(J, theta)
% COMPUTENUMERICALGRADIENT 「有限差分」を使用して勾配を計算し、勾配の
% 数値的推定を返します。
%   numgrad = COMPUTENUMERICALGRADIENT(J, theta)は、thetaで関数Jの
%   数値的勾配を計算します。y = J(theta)を呼び出すと、thetaでの関数値が
%   返されます。

% 注意: 次のコードは数値的勾配チェックを実装し、数値的勾配を返します。
%       thetaで評価されたi番目の入力引数に関して、Jの偏微分（の数値近似）を
%       numgrad(i)にセットします。（すなわち、numgrad(i)はtheta(i)に関するJの
%       偏微分でなければなりません）。 
%       
%       
%                

numgrad = zeros(size(theta));
perturb = zeros(size(theta));
e = 1e-4;
for p = 1:numel(theta)
    % 摂動ベクトルをセットする
    perturb(p) = e;
    loss1 = J(theta - perturb);
    loss2 = J(theta + perturb);
    % 数値的勾配を計算する
    numgrad(p) = (loss2 - loss1) / (2*e);
    perturb(p) = 0;
end

end
