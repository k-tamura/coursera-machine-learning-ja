function W = randInitializeWeights(L_in, L_out)
%RANDINITIALIZEWEIGHTS Randomly initialize the weights of a layer with L_in
%incoming connections and L_out outgoing connections
%   W = RANDINITIALIZEWEIGHTS(L_in, L_out) randomly initializes the weights 
%   of a layer with L_in incoming connections and L_out outgoing 
%   connections. 
%
%   Note that W should be set to a matrix of size(L_out, 1 + L_in) as
%   the first column of W handles the "bias" terms
%

% 次の変数を正しく返す必要があります
W = zeros(L_out, 1 + L_in);

% ====================== ここにコードを実装する ======================
% 指示: Initialize W randomly so that we break the symmetry while
%               training the neural network.
%
% 注意: The first column of W corresponds to the parameters for the bias unit
%









% =========================================================================

end
