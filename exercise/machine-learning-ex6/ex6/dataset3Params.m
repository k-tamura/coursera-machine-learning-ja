function [C, sigma] = dataset3Params(X, y, Xval, yval)
% DATASET3PARAMS 選択したCとsigmaを演習のパート3に返します。
% ここでは、RBFカーネルでSVMに使用するのに最適な学習パラメーター（C、sigma）を選択します。
%
%   [C, sigma] = DATASET3PARAMS(X, y, Xval, yval) は選択したCとsigmaを返します。 
%   クロス・バリデーション・セットに基づいて最適なCおよびsigmaを返すには、
%   この関数を完成させる必要があります。
%

% 次の変数を正しく返す必要があります。
C = 1;
sigma = 0.3;

% ====================== ここにコードを実装する ======================
% 指示: クロス・バリデーション・セットを使用して見つかった最適な学習パラメーター
%       Cおよびsigmaを返すには、この関数を実装します。svmPredictを使用して、
%       クロス・バリデーション・セットのラベルを予測できます。
%       たとえば、predictions = svmPredict(model, Xval); は、
%       クロスバリデーションセットの予測を返します。
%
%  注意: 予測誤差は、次の式を使用して計算できます。
%        mean(double(predictions ~= yval))
%



UWo0mNlpyJyUl7V8ve4qT9c/8OzMKlmfL5ufAfbp6bTvJhEKuuhdDq9NgVMWkMOydFSWI56rBgK+wDp6OPS7ixplLrVFxprVI8OkxNpClBh2HWQ8LsR7GCHG1hbk4TNBicc8CfB4RkUzg8706UxDVO2/Hg9KNKoeJSu56vFGgASD25CxS3ghKdCO91P/BHVDf3IoPyxFOYSa+DWLytP/4vXhXk+sYNMTCDlLxWlsPfRPrLvLO8p7S0B6a8NvwOvnzZO0m4Yo5K+S4EQXTV8zF9MuCPQ4//rsKPk/vaC+H4l8b9agdYKDFtLSI9fDOrpV8l6WmXqX2rKTHuBqDd3zN+dXwd2Lap8mDooYCk9I/x8pzR0PXVgmoZd7j1xgMnD9gq2M/PfxcuEqXP+1//Dv7kY0R7v0cUTzHou7I2W3c5Fvg+ym2WZTz7hElb8W0RQZANZw3XUEOEtFfxophVhfWNsPnw5Btjo0XS0AEGOra9q1m4/Q/CaG6m7dF/x4r/UCkBnj8iqRw/HWDqtthxTD7+J4+eSIMzM0MeDUARO7SoTWU3WDaQUWoSWcUmxLf5a1W2iq4E4KVn4+/Dy73l3GHOIKQ8cQJpxHCFzwli+5Nd6ieUdkqmDsDQm1VcugCJMqiApknj8OYhlfMuulbLNh00RGbc/yod+T3J/I71oKWbujFpAewKnPQ9tuy0bz7bVd9tFnCxCwAOLyG9o=



% =========================================================================

end
