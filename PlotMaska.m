%Отрисовать вывод на экран
function PlotMaska(handles, I, map)

Maska = handles.figure1.UserData.Maska;

[x, y] = CreatOutline(Maska);
axes(handles.axes1)
imshow(I, map)
hold on
gscatter(y,x)

%Пронумеруем объекты
numeric=num(Maska);
s = regionprops(Maska,'centroid');
s = cat(1,s.Centroid);
%вывести подписанные
for j=1:length(numeric)
    text(s(numeric(j),1), s(numeric(j),2), num2str(j), 'Color', 'g', 'FontSize', 14 )
end
hold off

handles.text6.String = strcat('Найдено объектов:_', num2str(max(numeric)));

%Выведем вес
Area=regionprops(Maska, 'Area');
Area=cat(1, Area.Area);

scale = handles.figure1.UserData.Scale;
Area = Area/scale^2;

axes(handles.axes3)
hist(Area, 50)

D = uint8(double(I).*Maska);
axes(handles.axes2)
h = imhist(D, map);
h(1) = 0;
bar(h)

end