% Создадим картинку из кусков
% Pic - массив с кусками и размерами этих кусков
% a - структура       
%       a.empty - учитывание пропусков
%           0 - нет пропусков
%           1 - есть пропуски
%       a.size - размер объекта
%       a.space - размер пропусков
%       a.line - кол-во объектов в ряду


function Picture = EditObjectPicture(Pic, a)

%есть ли пропуски
empty = a.empty;

if empty == 0
    l = length(Pic);
    i = 1;
    while i <= l
        if isempty(Pic(i).size)
            Pic(i) = [];
            l = length(Pic);
        else
            i = i + 1;
        end
    end
end


% определим размеры кусков

if isfield(a, 'size')
    size = a.size;
else
    size = cat(1, Pic.size);
    size = max(size); %теперь есть размеры окна для одного кусочка
end

%настроим пропуски
if isfield(a, 'space')
   space = a.space;
   size = size + space;
else
    size = size + 5;
end



%опредилим кол-во рядов

if isfield(a, 'line')
    %значит х задан
    x = a.line;
    %теперь найдём кол-во рядов
    %всего элементов
    l = length(Pic);
    y = round(l/x);
    if x*y < l;
        y = y + 1;
    end
    
else
    %всего элементов
    l = length(Pic);
    %кол-во рядов
    y = round((length(Pic)*size(2)/size(1))^0.5);
    %кол-во объектов в ряду
    x = round(length(Pic)/y);
    %проверим хватит ли этой сетки для всех объектов
    if x * y < length(Pic)
        %найдём оптимальную поправку
        %достаточность
        e(1) = length(Pic) - ((y-1)*(x+1));
        e(2) = length(Pic) - ((y+1)*(x-1));
        e(3) = length(Pic) - ((y+1)*(x));
        e(4) = length(Pic) - ((y)*(x+1));
        %необходимость
        w(1) = 1 - ((y-1)*size(1))/((x+1)*size(2));
        w(2) = 1 - ((y+1)*size(1))/((x-1)*size(2));
        w(3) = 1 - ((y+1)*size(1))/((x)*size(2));
        w(4) = 1 - (y*size(1))/((x+1)*size(2));
        
        %сортировка
        [~, q] = sort(abs(w));
        
        es = e<0;
        es = q(es(q));
        es = es(1);
        
        if es == 1
            y = y - 1;
            x = x + 1;
        elseif es == 2
            y = y + 1;
            x = x - 1;
        elseif es == 3
            y = y + 1;
        else
            x = x + 1;
        end
        
    end
    
end


%теперь распределим в циклах 
z = 1; %счётчик
%Пустой холст
Picture = zeros(size(1) * y, size(2) * x);

%Угловые координаты
xPoint = 1;
yPoint = 1;

for i = 1:y
    xPoint = 1;
    for j = 1:x
        I = Pic(z).pic;
        s = Pic(z).size;
        
        if sum(sum(I)) ~= 0            
            Picture(yPoint:yPoint+s(1)-1, xPoint:xPoint+s(2)-1)=I;
        end
        
        xPoint = xPoint + size(2);
        z = z + 1;
        if z > length(Pic)
            break
        end
    end
    
    
    yPoint = yPoint + size(1);
end

Picture = uint8(Picture);
