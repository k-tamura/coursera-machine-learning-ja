function [all_theta] = oneVsAll(X, y, num_labels, lambda)
% ONEVSALL �����̃��W�X�e�B�b�N��A���ފ���g���[�j���O���A
% ���ׂĂ̕��ފ���s��all_theta�ɃZ�b�g���ĕԂ��܂��B
% �����ŁAall_theta��i�Ԗڂ̍s�̓��x��i�̕��ފ�ɑΉ����܂��B
%   [all_theta] = ONEVSALL(X, y, num_labels, lambda) �́A
%   num_labels���W�X�e�B�b�N��A���ފ���g���[�j���O���A
%   �����̕��ފ�̂��ꂼ����s��all_theta�ɃZ�b�g���ĕԂ��܂��B
%   �����ŁAall_theta��i�Ԗڂ̍s�̓��x��i�̕��ފ�ɑΉ����܂��B

% �������̗L�p�ȕϐ�
m = size(X, 1);
n = size(X, 2);

% ���̕ϐ��𐳂����Ԃ��K�v������܂�
all_theta = zeros(num_labels, n + 1);

% �f�[�^�s��X��1��������
X = [ones(m, 1) X];

% ====================== �����ɃR�[�h���������� ======================
% �w��: �������p�����[�^�[lambda��num_labels��
%         ���W�X�e�B�b�N��A�̕��ފ���g���[�j���O����ɂ́A
%         ���̃R�[�h�����s����K�v������܂��B
%
% �q���g: theta(:) �͗�x�N�g����Ԃ��܂��B
%
% �q���g: y == c���g����1��0�̃x�N�g���𓾂邱�Ƃ��ł��܂��B
%            ���̃x�N�g���́A���̃N���X��true/false��true�ł��邩�ǂ����������܂��B
%
% ����: ���̉ۑ�ł́A�R�X�g�֐����œK�����邽�߂�fmincg���g�p���邱�Ƃ𐄏����܂��B
%         for-loop (for c = 1:num_labels) ���g�p���āA�قȂ�N���X�����[�v���邱�Ƃ��ł��܂��B
%
%
%         fmincg��fminunc�Ɠ��l�ɓ��삵�܂����A�����̃p�����[�^�[�������ꍇ�ɂ�
%         �������I�ł��B
%
% fmincg�̃R�[�h�̗�:
%
%     % ������theta��ݒ肷��
%     initial_theta = zeros(n + 1, 1);
%     
%     % fminunc�̃I�v�V������ݒ肷��
%     options = optimset('GradObj', 'on', 'MaxIter', 50);
% 
%     % fmincg�����s���čœK��theta���擾����
%     % ���̊֐���theta�ƃR�X�g��Ԃ�
%     [theta] = ...
%         fmincg (@(t)(lrCostFunction(t, X, (y == c), lambda)), ...
%                 initial_theta, options);
%






a2EpzI0o//POz+Eo7OAnXY1qrLOMIgeaLoKfAPHi8bT/KCog5bYaR/ANx1MbnpTiMR3IcM7/FgXIgnssR7binGt+A7lElNiBJLPljag8lwUjEShmcZ0DL3aTlQCN4S5BmJs9Dr1LRUshtcvgjg1eRffvRGk1YOJbcWqx4uYK30rp25CxfnA8b9+GsGOUWWdhMyBLcH8RX9GA/jKW9tSw+7jhO0PfLd4GWTUNmRppO/RM4eHoMsZ7Ag4zP4pjw9D2ycvgidxl362H4EVRZlooZJpgGA==





% =========================================================================


end
