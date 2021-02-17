%Создание Маски из изображения
%I - полутоновое изображение
%porog - порог минимальной яркости объектов
%scale - масштаб иображения - количество пикселей в одном мм
%s - минимальный размер объектов

function Maska = CreatMaska(I, porog, scale, s)

%Рамажу изображение
I = imopen(I, strel('disk', round(scale/2)));

Maska = I>porog;

%уничтожим объекты меньше мм

Maska=bwareaopen(Maska, scale^2);

if and(s ~= 0, ~isnan(s))
    %Уберём слшком маленкие объекты
    Maska=bwareaopen(Maska, s*scale^2);    
end

end