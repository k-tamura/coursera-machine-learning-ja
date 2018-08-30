function g = sigmoid(z)
%SIGMOID シグモイド関数を計算する
%   J = SIGMOID(z) は、zのシグモイドを計算します。

g = 1.0 ./ (1.0 + exp(-z));
end
