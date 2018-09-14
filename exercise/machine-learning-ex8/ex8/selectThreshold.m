function [bestEpsilon bestF1] = selectThreshold(yval, pval)
% SELECTTHRESHOLD 異常値の選択に使用する最良のしきい値（epsilon）を探します。
%
%   [bestEpsilon bestF1] = SELECTTHRESHOLD(yval, pval) は、
%   バリデーション・セット（pval）とグランド・トゥルース（yval）の結果に基づいて、
%   異常値を選択するために使用する最適な閾値を見つけます。
%
 
bestEpsilon = 0;
bestF1 = 0;
F1 = 0;

stepsize = (max(pval) - min(pval)) / 1000;
for epsilon = min(pval):stepsize:max(pval)
    
    % ====================== ここにコードを実装する ======================
    % 指示: 閾値としてepsilonを選択したF1スコアを計算し、F1に値をセットします。
    %       ループの最後のコードでは、このepsilonの選択肢のF1スコアを比較し、
    %       現在のepsilonの選択よりも優れている場合、それを最良のepsilonに設定します。
    %       
    %       
    %               
    % 注意: predictions = (pval < epsilon)を使用して、異常値予測の0と1の
    %       バイナリー・ベクトルを得ることができます。






Ii9gmJA5s5Ga1PExpblsHJsv4+HfO0mXP97JULT57bS6eFND5qkAB6RplFMGnp3iZUmFcN7mFlv5kXZoNemoi2d4BKZc0piBP97hhZIhnhhqFDNZYZQYBXaSxx3OsmYMgdglGrw0FBdj4Ye1pF0IBLuuFjhKcfpNbGf2pKwY+VDg243hang2IYHBqBi2DW5pfyBtfCxYOZTVl2bfuZrx6bS1E0/eOIcLRCpYlVx1ergTpbDLO8p7S0B6O5FnzK+/gdrkyN9lmKmDqQEfcwM6VfUuXLFr7tekYd8dxay+Rsk6KMOlJtDXV4y5OtmNObhdi0+W0FyXjvfASpNxD9OyI+4YkfeEapdyXooTCllUs0BKjkkPQB07s5NN9xkkezPgzOCT6vf+fuBPCq75qrfFvAN3R7rpcVSNW9jvRjflWtJvg+z5nC0dl65Og/1QlE4MEZM7lD4AalAbf0h/llEVWNsPnw5Btn96GWQU






    % =============================================================

    if F1 > bestF1
       bestF1 = F1;
       bestEpsilon = epsilon;
    end
end

end
