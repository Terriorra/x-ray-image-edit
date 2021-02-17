%создание стуктуры хранящей отдельные правильноориентированные объекты
% M - разметка изображения
% I - изображение
% map - карта отображения
% numeric - маркировка объектов (реальная нумерация объектов)
% 


function Images = EditObjectMatrix(numeric, M, I, map)
%определим поворот
grad = regionprops(M,'Orientation');
grad = cat(1,grad.Orientation);

%маркируем области
[M, n] = bwlabel(M);

%цикл для заполнения
for i = 1 : n
    index = numeric(i);    
    if index ~= 0        
        Pic = uint8(double(I).*(M==index));
        
        %убедимся в какую сторону вращать
        t = grad(index);
        if t > 0
            r = 90;
        else
            r = -90;
        end
        
        Pic=imrotate(Pic, r - t, 'bilinear');
        Pic(~any(Pic,2),:) = [];
        Pic(:, ~any(Pic)) = [];        
        
        Images(i).pic=Pic;
        Images(i).size = size(Pic);
    else
        Images(i).pic=0;
    end
    
    if i == length(numeric)
        break
    end
    
end

end