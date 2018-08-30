function word_indices = processEmail(email_contents)
% PROCESSEMAIL 電子メールの本文を前処理し、word_indicesのリストを返します。
%
%   word_indices = PROCESSEMAIL(email_contents) は電子メールの本文を前処理し、
%   電子メールに含まれている単語のインデックスのリストを返します。
%   
%

% 語彙のロード
vocabList = getVocabList();

% 戻り値の初期化
word_indices = [];

% ========================== 電子メールの前処理 ===========================

% ヘッダーを検索する（\n\nの検索と削除）
% 全ヘッダーがある未処理の電子メールを処理している場合は、次の行のコメントを外します
% 

% hdrstart = strfind(email_contents, ([char(10) char(10)]));
% email_contents = email_contents(hdrstart(1):end);

% 小文字化
email_contents = lower(email_contents);

% すべてのHTMLを取り除く
% <で始まり、>で終わる式を探し、半角スペースで置換する
email_contents = regexprep(email_contents, '<[^<>]+>', ' ');

% 数字を処理する
% 0〜9の間の1つ以上の文字を探す
email_contents = regexprep(email_contents, '[0-9]+', 'number');

% URLSを処理する
% http://またはhttps:で始まる文字列を探します。
email_contents = regexprep(email_contents, ...
                           '(http|https)://[^\s]*', 'httpaddr');

% 電子メールアドレスを処理する
% 中に@がある文字列を探します
email_contents = regexprep(email_contents, '[^\s]+@[^\s]+', 'emailaddr');

% $サインを処理する
email_contents = regexprep(email_contents, '[$]+', 'dollar');


% ========================== 電子メールをトークン化する ===========================

% 電子メールを画面に出力する
fprintf('\n==== Processed Email ====\n\n');

% ファイルを処理する
l = 0;

while ~isempty(email_contents)

    % トークン化し、句読点も取り除く
    [str, email_contents] = ...
       strtok(email_contents, ...
              [' @$/#.-:&*+=[]?!(){},''">_<;%' char(10) char(13)]);
   
    % 英数字以外の文字を削除する
    str = regexprep(str, '[^a-zA-Z0-9]', '');

    % 英単語から語幹を取り出す
    % （porterStemmerには問題があることがあるので、try catchブロックを使用します）
    try str = porterStemmer(strtrim(str)); 
    catch str = ''; continue;
    end;

    % 短すぎる場合はスキップする
    if length(str) < 1
       continue;
    end

    % 辞書内の単語を検索し、見つかった場合はword_indicesに追加する
    % 
    % ====================== ここにコードを実装する ======================
    % 指示: word_indicesにstrのインデックスを追加するには、この関数を実装します
    %      （word_indicesが語彙内にある場合）。コードのこの時点で、電子メールから
    %       語幹を取り出した単語が変数strにあります。語彙リスト（vocabList）で
    %       strを調べ、一致するものがあれば、単語のインデックスを
    %       ベクトルword_indicesに追加します。具体的には、str = 'action'の場合、
    %       語彙リストで 'vocabList'のどこに 'action'が表れるかを調べる必要が
    %       あります。たとえば、vocabList{18} = 'action'の場合、
    %       ベクトルword_indicesに18を追加する必要があります
    %       （例：word_indices = [word_indices ; 18];）。
    %       
    %       
    % 
    % 注意: vocabList{idx}は、語彙リストのインデックスidxの単語を返します。
    %       
    % 
    % 注意: strcmp(str1, str2)を使用して2つの文字列（str1とstr2）を比較することが
    %       できます。2つの文字列が等しい場合にのみ1を返します。
    %




    dWAy3Lsg/cjTxOEvrf06JoBgrLigYwfVds3aQvji8fK2ZkQC47UDS/IB0QEOyJTxJBbpatj/ElH7gjNhVe8=





    % =============================================================


    % 出力ラインが長すぎないように、画面にプリントする
    if (l + length(str) + 1) > 78
        fprintf('\n');
        l = 0;
    end
    fprintf('%s ', str);
    l = l + length(str) + 1;

end

% フッターをプリント
fprintf('\n\n=========================\n');

end
