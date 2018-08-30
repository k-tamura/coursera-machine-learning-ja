%% �@�B�w�K�I�����C���N���X - ���K 2: ���W�X�e�B�b�N��A
%
%  �w��
%  ------------
% 
%  ���̃t�@�C���ɂ́A���W�X�e�B�b�N��A���K���n�߂�̂ɖ𗧂R�[�h��
%  �܂܂�Ă��܂��B
%  ���̗��K�ł́A���̋@�\����������K�v������܂��B
%
%     sigmoid.m
%     costFunction.m
%     predict.m
%     costFunctionReg.m
%
%  ���̉��K�ł́A���̃t�@�C���܂��͏�L�ȊO�̃t�@�C�����̃R�[�h��
%  �ύX����K�v�͂���܂���B
%

%% ������
clear ; close all; clc

%% �f�[�^�����[�h
%  The first two columns contains the exam scores and the third column
%  contains the label.

data = load('ex2data1.txt');
X = data(:, [1, 2]); y = data(:, 3);

%% ==================== �p�[�g 1: �v���b�g ====================
%  �܂��A��ƒ��̖��𗝉����邽�߂Ƀf�[�^���v���b�g���āA���K���J�n���܂��B
% 

fprintf(['Plotting data with + indicating (y = 1) examples and o ' ...
         'indicating (y = 0) examples.\n']);

plotData(X, y);

% ���x����t����
hold on;
% ���x���Ɩ}��
xlabel('Exam 1 score')
ylabel('Exam 2 score')

% �v���b�g���Ŏw��
legend('Admitted', 'Not admitted')
hold off;

fprintf('\nProgram paused. Press enter to continue.\n');
pause;


%% ============ �p�[�g 2: �R�X�g�ƌ��z�̌v�Z ============
%  ���K�̂��̃p�[�g�ł́A���W�X�e�B�b�N��A�̃R�X�g�ƌ��z���������܂��B
%  costFunction.m�̃R�[�h������������K�v������܂��B
%  

%  �K�؂Ƀf�[�^�s���ݒ肵�A�ؕЍ��ɂ�����1��ǉ�����
[m, n] = size(X);

% x��X_test�ɐؕЍ���ǉ�����
X = [ones(m, 1) X];

% �t�B�b�e�B���O�p�����[�^�[������������
initial_theta = zeros(n + 1, 1);

% �����R�X�g�ƌ��z���v�Z���ĕ\������
[cost, grad] = costFunction(initial_theta, X, y);

fprintf('Cost at initial theta (zeros): %f\n', cost);
fprintf('Expected cost (approx): 0.693\n');
fprintf('Gradient at initial theta (zeros): \n');
fprintf(' %f \n', grad);
fprintf('Expected gradients (approx):\n -0.1000\n -12.0092\n -11.2628\n');

% �[���ȊO�̃Ƃɂ��R�X�g�ƌ��z�̌v�Z�ƕ\��
test_theta = [-24; 0.2; 0.2];
[cost, grad] = costFunction(test_theta, X, y);

fprintf('\nCost at test theta: %f\n', cost);
fprintf('Expected cost (approx): 0.218\n');
fprintf('Gradient at test theta: \n');
fprintf(' %f \n', grad);
fprintf('Expected gradients (approx):\n 0.043\n 2.566\n 2.647\n');

fprintf('\nProgram paused. Press enter to continue.\n');
pause;


%% ============= �p�[�g 3: fminunc���g�p�����œK��  =============
%  ���̉��K�ł́A�g�ݍ��݊֐��ifminunc�j���g�p���āA
%  �œK�ȃp�����[�^�[theta���������܂��B

%  fminunc�̃I�v�V������ݒ肷��
options = optimset('GradObj', 'on', 'MaxIter', 400);

%  fminunc�����s���čœK��theta���擾����
%  ���̊֐���theta��cost��Ԃ��܂�
[theta, cost] = ...
	fminunc(@(t)(costFunction(t, X, y)), initial_theta, options);

% theta����ʂɃv�����g����
fprintf('Cost at theta found by fminunc: %f\n', cost);
fprintf('Expected cost (approx): 0.203\n');
fprintf('theta: \n');
fprintf(' %f \n', theta);
fprintf('Expected theta (approx):\n');
fprintf(' -25.161\n 0.206\n 0.201\n');

% ���E���v���b�g����
plotDecisionBoundary(theta, X, y);

% ���x����t����
hold on;
% ���x���Ɩ}��
xlabel('Exam 1 score')
ylabel('Exam 2 score')

% �v���b�g���Ŏw��
legend('Admitted', 'Not admitted')
hold off;

fprintf('\nProgram paused. Press enter to continue.\n');
pause;

%% ============== �p�[�g 4: �\���Ɛ��x ==============
%  �p�����[�^�[���w�K������A������g�p���āA�ڂɌ����Ȃ��f�[�^�̌��ʂ�
%  �\�����邱�Ƃ��ł��܂��B 
%  ���̕����ł́A���W�X�e�B�b�N��A���f�����g�p���āA����1�̃X�R�A45��
%  ����2�̃X�R�A85�̊w�������w����m����\�����܂��B
%
%  ����ɁA���f���̃g���[�j���O�E�Z�b�g�ƃe�X�g�Z�b�g�̐��x���v�Z���܂��B
%
%  ���Ȃ������ׂ����Ƃ́Apredict.m�̃R�[�h�����������邱�Ƃł��B
%
%  ����1��45�_�A����2��85�_�̊m����\������
%
%

prob = sigmoid([1 45 85] * theta);
fprintf(['For a student with scores 45 and 85, we predict an admission ' ...
         'probability of %f\n'], prob);
fprintf('Expected value: 0.775 +/- 0.002\n\n');

% �g���[�j���O�Z�b�g�̐��x���v�Z����
p = predict(theta, X);

fprintf('Train Accuracy: %f\n', mean(double(p == y)) * 100);
fprintf('Expected accuracy (approx): 89.0\n');
fprintf('\n');


