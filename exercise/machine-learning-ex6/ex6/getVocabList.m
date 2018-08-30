function vocabList = getVocabList()
% GETVOCABLIST vocab.txt内の固定値の語彙リストを読み込み、単語のセル配列を返します
%
%   vocabList = GETVOCABLIST() は、vocab.txtの固定値の語彙リストを読み込み、
%   単語のセル配列をvocabListにセットして返します。


%% 固定値の語彙リストを読む
fid = fopen('vocab.txt');

% すべての辞書単語をセル配列のvocab{}に格納する
n = 1899;  % 辞書内の総単語数

% 実装を簡単にするために、構造体を使用して文字列=>整数にマッピングします
% 実際には、何らかの形のハッシュマップを使いたいと思うでしょう
vocabList = cell(n, 1);
for i = 1:n
    % 単語のインデックス（= iになるので、無視することができます）
    fscanf(fid, '%d', 1);
    % 実際の単語
    vocabList{i} = fscanf(fid, '%s', 1);
end
fclose(fid);

end
