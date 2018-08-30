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

% ���̕ϐ��𐳂����Ԃ��K�v������܂�
W = zeros(L_out, 1 + L_in);

% ====================== �����ɃR�[�h���������� ======================
% �w��: Initialize W randomly so that we break the symmetry while
%               training the neural network.
%
% ����: The first column of W corresponds to the parameters for the bias unit
%









% =========================================================================

end
