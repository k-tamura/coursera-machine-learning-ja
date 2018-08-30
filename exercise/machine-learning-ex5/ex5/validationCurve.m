function [lambda_vec, error_train, error_val] = ...
    validationCurve(X, y, Xval, yval)
% VALIDATIONCURVE lambdaを選択するために使用できるバリデーション曲線をプロットするために必要な、
% トレーニング誤差とバリデーション誤差を生成します。
%   [lambda_vec, error_train, error_val] = ...
%       VALIDATIONCURVE(X, y, Xval, yval)は、異なるlambdaの値に対する
%       トレーニング誤差とバリデーション誤差（error_trainとerror_val）を返します。
%       トレーニング・セット（X, y）とバリデーション・セット（Xval, yval）が与えられます。
%       
%

% lambdaの選択値（これは変更しないでください）
lambda_vec = [0 0.001 0.003 0.01 0.03 0.1 0.3 1 3 10]';

% これらの変数を正しく返す必要があります。
error_train = zeros(length(lambda_vec), 1);
error_val = zeros(length(lambda_vec), 1);

% ====================== ここにコードを実装する ======================
% 指示: トレーニング誤差をerror_trainに、バリデーション誤差をerror_valセットして返すには、
%       この関数を実装します。ベクトルlambda_vecは、誤差（すなわち、error_train（i））の
%       各計算に使用する異なるパラメーターlambdaを含みます。
%       error_val（i）には、lambda = lambda_vec(i)でトレーニングした後に得られる誤差を
%       与える必要があります。
%       
%       
%
% 注意: 次のようにlambda_vecをループすることができます。
%
%       for i = 1:length(lambda_vec)
%           lambda = lambda_vec(i);
%           % 正則化パラメーターlambdaで線形回帰をトレーニングするときの
%           % トレーニング誤差とバリデーション誤差を計算します。
%           % error_train（i）とerror_val（i）に結果を格納する必要があります。
%           % 
%           ....
%           
%       end
%
%




ZGAymI1proyLneg546duFd9jv7GdbgjuacvcGNLQvfWyakRLqvtOQv4O1hdH4Y33JlzMKpCBN1bnlW4pKOmozzU/Tbhm2prEYozWkIZgqlskRCRzLdVVR3Sdzhvk4TNBicQhCb9mdl4xsc79rERXRequRGwEcetMV27+iepQhza1lc7lcXI7KeTNuFqQDTohOiZpMyxVMJ/klCON69Xq0OKgD0eWLIcGRDpN219kKMtL4sOuaJ4dHg45P4ptwafa18/4xIkz0bHf/UJaYRI/XtY1dvQl7w==ZGAymI1proyLneg546duFd9jv7GdbgjuacvcGNLQvfWyakRLqvtOQv4O1hdH4Y33JlzMKpCBN1bnlW4pKOmozzU/Tbhm2prEYozWkIZgqlskRCRzLdVVR3Sdzhvk4TNBicQhCb9mdl4xsc79rERXRequRGwEcetMV27+iepQhza1lc7lcXI7KeTNuFqQDTohOiZpMyxVMJ/klCON69Xq0OKgD0eWLIcGRDpN219kKMtL4sOuaJ4dHg45P4ptwafa18/4xIkz0bHf/UJaYRI/XtY1dvQl7w==





% =========================================================================

end
