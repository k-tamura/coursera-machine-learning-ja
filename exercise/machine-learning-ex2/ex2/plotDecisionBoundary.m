function plotDecisionBoundary(theta, X, y)
%PLOTDECISIONBOUNDARY データ点Xとyをthetaによって定義された決定境界とともに
%   新しい図形にプロットする
%   PLOTDECISIONBOUNDARY(theta, X,y) は、正のサンプルでは+、
%   負のサンプルではoでデータ点をプロットします。
%   Xは、以下のどちらかとします。
%   
%   1）Mx3の行列。ここで、最初の列は切片にあたる全て1の列である
%   2）M×N、N>3の行列。ここで、最初の列は全て1の列である

% データをプロットする
plotData(X(:,2:3), y);
hold on

if size(X, 2) <= 3
    % 1つの線を定義するために2点しか必要としないので、2つの端点を選択する
    plot_x = [min(X(:,2))-2,  max(X(:,2))+2];

    % 決定境界線を計算する
    plot_y = (-1./theta(3)).*(theta(2).*plot_x + theta(1));

    % プロットし、見やすくするために軸を調整する
    plot(plot_x, plot_y)
    
    % 演習固有の凡例
    legend('Admitted', 'Not admitted', 'Decision Boundary')
    axis([30, 100, 30, 100])
else
    % グリッドの範囲はここ
    u = linspace(-1, 1.5, 50);
    v = linspace(-1, 1.5, 50);

    z = zeros(length(u), length(v));
    % グリッド上で、z = theta*xを評価する
    for i = 1:length(u)
        for j = 1:length(v)
            z(i,j) = mapFeature(u(i), v(j))*theta;
        end
    end
    z = z'; % important to transpose z before calling contour

    % z = 0をプロットする
    % [0、0]の範囲を指定する必要があることに注意してください
    contour(u, v, z, [0, 0], 'LineWidth', 2)
end
hold off

end
