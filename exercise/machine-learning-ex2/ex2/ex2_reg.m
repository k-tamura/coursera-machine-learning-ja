%% �@�B�w�K�I�����C���N���X - ���K 2: Logistic Regression
%
%  �w��
%  ------------
%
%  ���̃t�@�C���ɂ́A���W�X�e�B�b�N��A�̐�������ΏۂƂ��鉉�K��
%  �Q�Ԗڂ̃p�[�g���J�n����̂ɖ𗧂R�[�h���܂܂�Ă��܂��B
%  
%  ���̉��K�ł́A�ȉ��̊֐�����������K�v������܂��F
%
%     sigmoid.m
%     costFunction.m
%     predict.m
%     costFunctionReg.m
%
%  ���̃t�@�C���܂��͏�L�ȊO�̃t�@�C�����̃R�[�h��
%  �ύX����K�v�͂���܂���B
%

%% ������
clear ; close all; clc

%% �f�[�^�����[�h
%  �ŏ���2�̗�ɂ�X�l���܂܂�A3�ڂ̗�ɂ̓��x���iy�j��
%  �܂܂�܂��B

data = load('ex2data2.txt');
X = data(:, [1, 2]); y = data(:, 3);

plotData(X, y);

% �������̃��x����t����
hold on;

% ���x���Ɩ}��
xlabel('Microchip Test 1')
ylabel('Microchip Test 2')

% �v���b�g���Ŏw��
legend('y = 1', 'y = 0')
hold off;


%% =========== �p�[�g 1: ���������ꂽ���W�X�e�B�b�N��A ============
%  ���̃p�[�g�ł́A���`�ɕ����ł��Ȃ��f�[�^�_�����f�[�^�Z�b�g��
%  �^�����܂��B�������A���W�X�e�B�b�N��A���g�p���ăf�[�^�_��
%  ���ނ������ƍl���Ă��܂��B
%  
%  ������s���ɂ́A��葽���̃t�B�[�`���[���g�p����K�v������܂��B
%  ���ɁA�f�[�^�s��ɑ������t�B�[�`���[��ǉ����܂�
%  �i��������A�Ɠ��l�j�B
%

% �������̃t�B�[�`���[��ǉ�����

% mapFeature��1�̗��ǉ�����̂ŁA�ؕЍ�����������邱�Ƃ�
% ���ӂ��Ă��������B
X = mapFeature(X(:,1), X(:,2));

% �t�B�b�e�B���O�E�p�����[�^�[������������
initial_theta = zeros(size(X, 2), 1);

% �������p�����[�^�[lambda��1�ɐݒ肷��
lambda = 1;

% ���������ꂽ���W�X�e�B�b�N��A�̏����R�X�g�ƌ��z���v�Z���A
% �\������
[cost, grad] = costFunctionReg(initial_theta, X, y, lambda);

fprintf('Cost at initial theta (zeros): %f\n', cost);
fprintf('Expected cost (approx): 0.693\n');
fprintf('Gradient at initial theta (zeros) - first five values only:\n');
fprintf(' %f \n', grad(1:5));
fprintf('Expected gradients (approx) - first five values only:\n');
fprintf(' 0.0085\n 0.0188\n 0.0001\n 0.0503\n 0.0115\n');

fprintf('\nProgram paused. Press enter to continue.\n');
pause;

% ���ׂ�1��theta��lambda= 10�ŃR�X�g�ƌ��z���v�Z���A
% �\������
test_theta = ones(size(X,2),1);
[cost, grad] = costFunctionReg(test_theta, X, y, 10);

fprintf('\nCost at test theta (with lambda = 10): %f\n', cost);
fprintf('Expected cost (approx): 3.16\n');
fprintf('Gradient at test theta - first five values only:\n');
fprintf(' %f \n', grad(1:5));
fprintf('Expected gradients (approx) - first five values only:\n');
fprintf(' 0.3460\n 0.1614\n 0.1948\n 0.2269\n 0.0922\n');

fprintf('\nProgram paused. Press enter to continue.\n');
pause;

%% ============= �p�[�g 2: �������Ɛ��x =============
%  �I�v�V�����̉��K:
%  ���̃p�[�g�ł́Alambda�̂��܂��܂Ȓl�������āA�����������E����ɂǂ̂悤��
%  �e����^���邩�����Ă݂܂��傤�B
%  
%  lambda�Ɏ��̒l�������Ă��������F0�A1�A10�A100
%  
%  lambda��ς���Ƃ��Ɍ��苫�E�͂ǂ̂悤�ɕω�����ł��傤���H 
%  �g���[�j���O�Z�b�g�̐��x�͂ǂ̂悤�ɕω�����ł��傤���H
%

% �t�B�b�e�B���O�E�p�����[�^�[������������
initial_theta = zeros(size(X, 2), 1);

% �������p�����[�^�[�ɂ�1�ɐݒ肵�܂��i����͕ς���K�v������܂��j
lambda = 1;

% �I�v�V������ݒ肷��
options = optimset('GradObj', 'on', 'MaxIter', 400);

% �œK������
[theta, J, exit_flag] = ...
	fminunc(@(t)(costFunctionReg(t, X, y, lambda)), initial_theta, options);

% ���E���v���b�g����
plotDecisionBoundary(theta, X, y);
hold on;
title(sprintf('lambda = %g', lambda))

% ���x���Ɩ}��
xlabel('Microchip Test 1')
ylabel('Microchip Test 2')

legend('y = 1', 'y = 0', 'Decision boundary')
hold off;

% �g���[�j���O�Z�b�g�̐��x���v�Z����
p = predict(theta, X);

fprintf('Train Accuracy: %f\n', mean(double(p == y)) * 100);
fprintf('Expected accuracy (with lambda = 1): 83.1 (approx)\n');

