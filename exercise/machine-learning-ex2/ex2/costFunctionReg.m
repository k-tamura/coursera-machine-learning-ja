function [J, grad] = costFunctionReg(theta, X, y, lambda)
%COSTFUNCTIONREG �������ɂ�郍�W�X�e�B�b�N��A�̃R�X�g�ƌ��z���v�Z����
%   J = COSTFUNCTIONREG(theta, X, y, lambda) �́A���������ꂽ
%   ���W�X�e�B�b�N��A�̃p�����[�^�[�Ƃ���theta���g�p�����R�X�g�ƁA
%   theta���Q�Ƃ����R�X�g�̌��z���v�Z���܂��B

% �������̗L�p�Ȓl������������
m = length(y); % �g���[�j���O�E�T���v���̐�

% ���̕ϐ��𐳂����Ԃ��K�v������܂�
J = 0;
grad = zeros(size(theta));

% ====================== �����ɃR�[�h���������� ======================
% �w��: �I�����ꂽtheta�̃R�X�g���v�Z���܂��B
%         J���R�X�g�ɐݒ肷��K�v������܂��B
%         �Δ������v�Z���Atheta�̊e�p�����[�^�[���Q�Ƃ����R�X�g�̕Δ�����
%         grad�ɐݒ肵�܂�



dmotyLAh9tjbmvA06LR7Rv17u7GPXgHUa8+XAPHk4a/VQgAXqutGV7hDnlNK0Zy6LQyMI4CrFhOiiTNvKP6o1yg5DOcKntTJe9et1c5on1cqEyZZYZQYBTvci0GDo3cAiYtzU6RxRFoXuMLn5QpUEbLjWFECcf5fLCu24rcJnln78crjeXl1PJy5vwOWDWY6NjVlcGUBMfzOt2aL8d/s7r3hTk+GLIcURDsEnhppO/RM4eHhMcovDg0qH4tn2+6ijo750w==


% =============================================================

end
