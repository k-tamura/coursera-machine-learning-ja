function file_contents = readFile(filename)
%READFILE ファイルを読み込み、内容全体を返します。 
%   file_contents = READFILE(filename) はファイルを読み込み、その内容全体を
%   file_contentsに返します
%

% ファイルをロードする
fid = fopen(filename);
if fid
    file_contents = fscanf(fid, '%c', inf);
    fclose(fid);
else
    file_contents = '';
    fprintf('Unable to open %s\n', filename);
end

end

