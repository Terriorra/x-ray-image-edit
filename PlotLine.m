% нарисовать линию по двум точкам
% L - массив для рисования
% x - координаты х
% y - координаты у

function Line = PlotLine(L, x, y)
%Определим кол-во точек
dx = x(2) - x(1);
dy = y(2) - y(1);

if abs(dx) + abs(dy) == 0
    e = (x(1) - 1) * size(L ,1) + y(1);
    
elseif dx == 0
    c = round(min(y) : max(y));
    d = ones(size(c)).*x(1);
    %пересчёт на координаты
    e = (d - 1).* size(L ,1) + c;
    
elseif dy == 0
    c = round(min(x) : max(x));
    d = ones(size(c)).*y(1);
    %пересчёт на координаты
    e = (c - 1).* size(L ,1) + d;  

elseif abs(dx) > abs(dy)
    c = round(min(x) : max(x));
    d = round (dy.*(c - x(1))./dx + y(1));
    %пересчёт на координаты
    e = (c - 1).* size(L ,1) + d;
else
    c = round(min(y) : max(y));
    d = round(dx.*(c-y(1))./dy + x(1));
    %пересчёт на координаты
    e = (d - 1).* size(L ,1) + c;   
end        


L(e) = 1;
Line = bwmorph(L, 'diag');  

end