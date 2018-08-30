function [J, grad] = linearRegCostFunction(X, y, theta, lambda)
%LINEARREGCOSTFUNCTION Compute cost and gradient for regularized linear 
%regression with multiple variables
%   [J, grad] = LINEARREGCOSTFUNCTION(X, y, theta, lambda) computes the 
%   cost of using theta as the parameter for linear regression to fit the 
%   data points in X and y. Returns the cost in J and the gradient in grad

% �������̗L�p�Ȓl������������
m = length(y); % �g���[�j���O�E�T���v���̐�

% ���̕ϐ��𐳂����Ԃ��K�v������܂�
J = 0;
grad = zeros(size(theta));

% ====================== �����ɃR�[�h���������� ======================
% �w��: Compute the cost and gradient of regularized linear 
%               regression for a particular choice of theta.
%
%               You should set J to the cost and grad to the gradient.
%












% =========================================================================

grad = grad(:);

end
