function drawLine(p1, p2, varargin)
%DRAWLINE 点p1から点p2に線を引く
%   DRAWLINE(p1, p2)は、点p1から点p2まで線を描き、現在の図形をホールドする
%   

plot([p1(1) p2(1)], [p1(2) p2(2)], varargin{:});

end