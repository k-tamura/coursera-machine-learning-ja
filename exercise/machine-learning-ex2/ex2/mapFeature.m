function out = mapFeature(X1, X2)
% MAPFEATURE �������t�B�[�`���[�ւ̃t�B�[�`���[�}�b�s���O�֐�
%
%   MAPFEATURE(X1, X2) �́A���K�����K�Ŏg�p�����2���̃t�B�[�`���[��
%   2�̓��̓t�B�[�`���[���}�b�v���܂��B
%
%   X1, X2, X1.^2, X2.^2, X1*X2, X1*X2.^2, �Ȃǂ́A
%   �V�����t�B�[�`���[�z���Ԃ��܂��B
%
%   ����X1�AX2�͓����T�C�Y�łȂ���΂Ȃ�܂���
%

degree = 6;
out = ones(size(X1(:,1)));
for i = 1:degree
    for j = 0:i
        out(:, end+1) = (X1.^(i-j)).*(X2.^j);
    end
end

end