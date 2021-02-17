%Нарисовать линию по точкам
%I - холст
%x, y - координаты точек
function R = AddPunct(I, x, y)
 R = logical(zeros(size(I)));
 
 x = round(x);
 y = round(y);
 
 for i = 1:length(x)-1
     Line = zeros(size(I));
     Line = PlotLine(Line, x(i:i+1), y(i:i+1));
     R = logical(R) | Line;
 end
 R = imfill(R, 'holes');
end