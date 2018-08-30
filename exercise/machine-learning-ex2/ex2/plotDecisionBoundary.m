function plotDecisionBoundary(theta, X, y)
%PLOTDECISIONBOUNDARY �f�[�^�_X��y��theta�ɂ���Ē�`���ꂽ���苫�E�ƂƂ���
%   �V�����}�`�Ƀv���b�g����
%   PLOTDECISIONBOUNDARY(theta, X,y) �́A���̃T���v���ł�+�A
%   ���̃T���v���ł�o�Ńf�[�^�_���v���b�g���܂��B
%   X�́A�ȉ��̂ǂ��炩�Ƃ��܂��B
%   
%   1�jMx3�̍s��B�����ŁA�ŏ��̗�͐ؕЂɂ�����S��1�̗�ł���
%   2�jM�~N�AN>3�̍s��B�����ŁA�ŏ��̗�͑S��1�̗�ł���

% �f�[�^���v���b�g����
plotData(X(:,2:3), y);
hold on

if size(X, 2) <= 3
    % 1�̐����`���邽�߂�2�_�����K�v�Ƃ��Ȃ��̂ŁA2�̒[�_��I������
    plot_x = [min(X(:,2))-2,  max(X(:,2))+2];

    % ���苫�E�����v�Z����
    plot_y = (-1./theta(3)).*(theta(2).*plot_x + theta(1));

    % �v���b�g���A���₷�����邽�߂Ɏ��𒲐�����
    plot(plot_x, plot_y)
    
    % ���K�ŗL�̖}��
    legend('Admitted', 'Not admitted', 'Decision Boundary')
    axis([30, 100, 30, 100])
else
    % �O���b�h�͈̔͂͂���
    u = linspace(-1, 1.5, 50);
    v = linspace(-1, 1.5, 50);

    z = zeros(length(u), length(v));
    % �O���b�h��ŁAz = theta*x��]������
    for i = 1:length(u)
        for j = 1:length(v)
            z(i,j) = mapFeature(u(i), v(j))*theta;
        end
    end
    z = z'; % important to transpose z before calling contour

    % z = 0���v���b�g����
    % [0�A0]�͈̔͂��w�肷��K�v�����邱�Ƃɒ��ӂ��Ă�������
    contour(u, v, z, [0, 0], 'LineWidth', 2)
end
hold off

end
