function movieList = loadMovieList()
% GETMOVIELIST movie.txt内の固定の映画リストを読み込み、その単語のセル配列を
% 返します。
%   movieList = GETMOVIELIST()は、movie.txt内の固定の映画リストを読み込み、
%   その単語のセル配列を返します。


%% 固定の映画リストを読み込む
fid = fopen('movie_ids.txt');

% すべての映画をセル配列movie{}に保存する
n = 1682;  % Total number of movies 

movieList = cell(n, 1);
for i = 1:n
    % 行を読み込む
    line = fgets(fid);
    % 単語のインデックス（= iになるので、無視することができます）
    [idx, movieName] = strtok(line, ' ');
    % 実際の単語
    movieList{i} = strtrim(movieName);
end
fclose(fid);

end
