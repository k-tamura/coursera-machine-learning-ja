%% �@�B�w�K�I�����C���N���X - ���K 3 | Part 1: One-vs-all

%  �w��
%  ------------
%
%  ���̃t�@�C���ɂ́A���`���K���J�n����̂ɖ𗧂R�[�h���܂܂�Ă��܂��B
%  ���̉��K�ł́A���̊֐�����������K�v������܂��B
%
%
%     lrCostFunction.m (logistic regression cost function)
%     oneVsAll.m
%     predictOneVsAll.m
%     predict.m
%
%  ���̉��K�ł́A���̃t�@�C���܂��͏�L�ȊO�̃t�@�C�����̃R�[�h��
%  �ύX����K�v�͂���܂���B
%

%% ������
clear ; close all; clc

%% ���̉��K�Ŏg�p����p�����[�^�[���Z�b�g�A�b�v����
input_layer_size  = 400;  % 20x20���͂̐����摜
hidden_layer_size = 25;   % 25 �B�ꃆ�j�b�g
                          % �i���x��10�� "0"���}�b�s���O���Ă��邱�Ƃɒ��ӂ��Ă��������j

%% =========== �p�[�g 1: �f�[�^�̓ǂݍ��݂Ɖ��� =============
%  �ŏ��Ƀf�[�^�Z�b�g��ǂݍ���ŉ������邱�ƂŁA���̉��K���J�n���܂��B
%  �菑���������܂ރf�[�^�Z�b�g���g�p���č�Ƃ��܂��B
%

% �g���[�j���O�f�[�^��ǂݍ���
fprintf('Loading and Visualizing Data ...\n')

load('ex3data1.mat'); % �z��X�Ay�Ɋi�[���ꂽ�g���[�j���O�f�[�^
m = size(X, 1);

% �\������f�[�^�_�������_����100�I��
rand_indices = randperm(m);
sel = X(rand_indices(1:100), :);

displayData(sel);

fprintf('Program paused. Press enter to continue.\n');
pause;

%% ============ �p�[�g 2a: ���W�X�e�B�b�N��A���x�N�g�������� ============
%  ���̉��K�ł́A�O��̉��K�̃��W�X�e�B�b�N��A�R�[�h���ė��p���܂��B
%  �����ł̍�Ƃ́A���K�����ꂽ���W�X�e�B�b�N��A�̎�����
%  �x�N�g��������Ă��邱�Ƃ��m�F���邱�Ƃł��B
%  ���̌�A�菑���̐����f�[�^�Z�b�g�ɑ΂��Ĉ�ΑS�Ă̕��ނ��������܂��B
%  
%

% lrCostFunction�̃e�X�g�P�[�X
fprintf('\nTesting lrCostFunction() with regularization');

theta_t = [-2; -1; 1; 2];
X_t = [ones(5,1) reshape(1:15,5,3)/10];
y_t = ([1;0;1;0;1] >= 0.5);
lambda_t = 3;
[J grad] = lrCostFunction(theta_t, X_t, y_t, lambda_t);

fprintf('\nCost: %f\n', J);
fprintf('Expected cost: 2.534819\n');
fprintf('Gradients:\n');
fprintf(' %f \n', grad);
fprintf('Expected gradients:\n');
fprintf(' 0.146561\n -0.548558\n 0.724722\n 1.398003\n');

fprintf('Program paused. Press enter to continue.\n');
pause;
%% ============ �p�[�g 2b: 1�ΑS�Ẵg���[�j���O ============
fprintf('\nTraining One-vs-All Logistic Regression...\n')

lambda = 0.1;
[all_theta] = oneVsAll(X, y, num_labels, lambda);

fprintf('Program paused. Press enter to continue.\n');
pause;


%% ================ �p�[�g 3: 1�ΑS�Ă̗\�� ================

pred = predictOneVsAll(all_theta, X);

fprintf('\nTraining Set Accuracy: %f\n', mean(double(pred == y)) * 100);

