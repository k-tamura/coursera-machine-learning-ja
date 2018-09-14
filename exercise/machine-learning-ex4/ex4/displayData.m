function [h, display_array] = displayData(X, example_width)
%DISPLAYDATA グリッドに2Dデータを表示する
%   [h, display_array] = DISPLAYDATA(X, example_width)は、
%   Xに格納された2Dデータをグリッドに表示します。要求された場合は、
%   フィギュアー・ハンドルhと表示された配列を返します。

% 渡されない場合は、example_widthを自動的に設定します
if ~exist('example_width', 'var') || isempty(example_width) 
	example_width = round(sqrt(size(X, 2)));
end

% グレーイメージ
colormap(gray);

% 行、列を計算する
[m n] = size(X);
example_height = (n / example_width);

% 表示するアイテム数を計算する
display_rows = floor(sqrt(m));
display_cols = ceil(m / display_rows);

% 画像間のパディング
pad = 1;

% 空白の表示を設定する
display_array = - ones(pad + display_rows * (example_height + pad), ...
                       pad + display_cols * (example_width + pad));

% 各サンプルをディスプレイ配列上のパッチにコピーします。
curr_ex = 1;
for j = 1:display_rows
	for i = 1:display_cols
		if curr_ex > m, 
			break; 
		end
		% パッチをコピーする
		
		% パッチの最大値を取得する
		max_val = max(abs(X(curr_ex, :)));
		display_array(pad + (j - 1) * (example_height + pad) + (1:example_height), ...
		              pad + (i - 1) * (example_width + pad) + (1:example_width)) = ...
						reshape(X(curr_ex, :), example_height, example_width) / max_val;
		curr_ex = curr_ex + 1;
	end
	if curr_ex > m, 
		break; 
	end
end

% 画像を表示する
h = imagesc(display_array, [-1 1]);

% 軸を表示しない
axis image off

drawnow;

end
