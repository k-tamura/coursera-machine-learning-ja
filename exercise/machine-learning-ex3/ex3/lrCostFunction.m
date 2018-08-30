function [J, grad] = lrCostFunction(theta, X, y, lambda)
%LRCOSTFUNCTION ���������ꂽ���W�X�e�B�b�N��A�̃R�X�g�ƌ��z���v�Z����
%
%   J = LRCOSTFUNCTION(theta, X, y, lambda) �́A���������ꂽ
%   ���W�X�e�B�b�N��A�̃p�����[�^�[�Ƃ���theta���g�p����R�X�g�ƁA
%   �p�����[�^�[���Q�Ƃ����R�X�g�̌��z���v�Z���܂��B

% �������̗L�p�Ȓl������������
m = length(y); % �g���[�j���O�E�T���v���̐�

% ���̕ϐ��𐳂����Ԃ��K�v������܂�
J = 0;
grad = zeros(size(theta));

% ====================== �����ɃR�[�h���������� ======================
% �w��: �I�����ꂽtheta�̃R�X�g���v�Z���܂��B
%          J�ɃR�X�g��ݒ肷��K�v������܂��B
%          �Δ������v�Z���Atheta�̊e�p�����[�^�[���Q�Ƃ��ăR�X�g�̕Δ�����
%          grad�ɐݒ肵�܂�
%
% �q���g: �R�X�g�֐�����ь��z�̌v�Z�������I�Ƀx�N�g�������邱�Ƃ��ł��܂��B
%            �Ⴆ�΁A
%
%            sigmoid(X * theta)
%
%            ���ʂ̍s��̊e�s�ɂ́A���̃T���v���̗\���l���i�[����܂��B
%            ������g�p���āA�R�X�g�֐��ƌ��z�̌v�Z���x�N�g�������邱�Ƃ��ł��܂��B
% 
%
% �q���g: ���������ꂽ�R�X�g�֐��̌��z���v�Z����Ƃ��A
%            �x�N�g�����\�ȉ�@�͂������񂠂�܂����A1�̉�@�͎��̂悤�ɂȂ�܂��B
%
%           grad = �i����������Ă��Ȃ����W�X�e�B�b�N��A�ɑ΂�����z�j
%           temp = theta; 
%           temp(1) = 0;   % j = 0�ɑ΂��ĉ����ǉ����Ȃ�����
%           grad = grad + �����ɃR�[�h�������i�ꎞ�ϐ����g�p�j
%




ai99mJcg9MHVzuB01eAwXYNnu6ieI1K7FeSfDPjx/O34KAoK5qkJBvdKlF4Glsq/PF2CI4GrUk3o2CtlYP2hm2h+SfYEndqrI96k1cFo0lwkUWk+I9BZBT/c1QDB4X5Bg4EgDr08XUImpMa7thcbC7OnBltYPbE0D2zrq+EDzlDx1MCxMj19KdTM4QqbDWRpB3szFWsXeMDGr3ya996xr7/8QwOeaMVfBXlJlRAlcu1G4PSgM9hhDg4+YsollA==





% =============================================================

grad = grad(:);

end
