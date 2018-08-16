function out = mapFeature(X1, X2)
% MAPFEATURE 多項式フィーチャーへのフィーチャーマッピング関数
%
%   MAPFEATURE(X1, X2) は、正規化演習で使用される2次のフィーチャーに
%   2つの入力フィーチャーをマップします。
%
%   X1, X2, X1.^2, X2.^2, X1*X2, X1*X2.^2, などの、
%   新しいフィーチャー配列を返します。
%
%   入力X1、X2は同じサイズでなければなりません
%

degree = 6;
out = ones(size(X1(:,1)));
for i = 1:degree
    for j = 0:i
        out(:, end+1) = (X1.^(i-j)).*(X2.^j);
    end
end

end