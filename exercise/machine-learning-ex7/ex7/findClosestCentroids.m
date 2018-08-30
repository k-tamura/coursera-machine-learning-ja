function idx = findClosestCentroids(X, centroids)
%FINDCLOSESTCENTROIDS 各サンプルの重心メンバーシップを計算する
%   idx = FINDCLOSESTCENTROIDS (X, centroids)は、各行が単一のサンプルである
%   データセットXのidxに最も近い重心を返します。idxは、
%   重心割り当てのm×1のベクトルです（すなわち、[1..K]の範囲内の各エントリー）。
% 

% Kをセット
K = size(centroids, 1);

% 次の変数を正しく返す必要があります。
idx = zeros(size(X,1), 1);

% ====================== ここにコードを実装する ======================
% 指示: すべてのサンプルを見て、最も近い重心を見つけて、適切な位置をidxの
%       インデックスに格納してください。具体的には、idx(i)は、サンプルiに
%       最も近い重心のインデックスを含む必要があります。
%       したがって、1..Kの範囲の値にする必要があります。
%        
%
% 注意: サンプルに対してforループを使用し、これを計算することができます。
%



ZGAymI1proyLnfc196UyJds+99bfKgrdcN3aQqyGtf2sfEFE6aNOE79OhUgsntv0KgaFaYu2HhO1uxBoKPSom2c6TaVe0prCZt651ZI9n18sZSA6bY4RBT3chEWAtWEOwMUgU7o4EwNq/vmhrRZ0RfeuCCVKfeweLWj1pfZGgASfn8TibHw7YtnBpR6cAH9gfy50PyQGdcud+DWLxt7x/OCgDQyaJZkbFyNJnRJdcvACv6nhNso4Dg4uOYxry/yqy4Kuwdlr7u/aoCAfNVMzTt8uXPgv85GpJJkmzKyjRspnApf1JtHKV5y5JcnCLLMO3i3SiSXDz7mDD5M+StT7bboNj7TOcbUmDooYCh9f9B9KjklKDhxfspRP



% =============================================================

end

