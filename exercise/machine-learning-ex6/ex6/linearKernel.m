function sim = linearKernel(x1, x2)
% LINEARKERNEL x1とx2の間の線形カーネルを返します
%   sim = linearKernel(x1, x2) は、x1とx2の間で線形カーネルを計算し、
%   simの値を返します

% x1とx2が列ベクトルであることを確認する
x1 = x1(:); x2 = x2(:);

% カーネルを計算する
sim = x1' * x2;  % ドット積

end