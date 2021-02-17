% �������� �������� �� ������
% Pic - ������ � ������� � ��������� ���� ������
% a - ���������       
%       a.empty - ���������� ���������
%           0 - ��� ���������
%           1 - ���� ��������
%       a.size - ������ �������
%       a.space - ������ ���������
%       a.line - ���-�� �������� � ����


function Picture = EditObjectPicture(Pic, a)

%���� �� ��������
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


% ��������� ������� ������

if isfield(a, 'size')
    size = a.size;
else
    size = cat(1, Pic.size);
    size = max(size); %������ ���� ������� ���� ��� ������ �������
end

%�������� ��������
if isfield(a, 'space')
   space = a.space;
   size = size + space;
else
    size = size + 5;
end



%��������� ���-�� �����

if isfield(a, 'line')
    %������ � �����
    x = a.line;
    %������ ����� ���-�� �����
    %����� ���������
    l = length(Pic);
    y = round(l/x);
    if x*y < l;
        y = y + 1;
    end
    
else
    %����� ���������
    l = length(Pic);
    %���-�� �����
    y = round((length(Pic)*size(2)/size(1))^0.5);
    %���-�� �������� � ����
    x = round(length(Pic)/y);
    %�������� ������ �� ���� ����� ��� ���� ��������
    if x * y < length(Pic)
        %����� ����������� ��������
        %�������������
        e(1) = length(Pic) - ((y-1)*(x+1));
        e(2) = length(Pic) - ((y+1)*(x-1));
        e(3) = length(Pic) - ((y+1)*(x));
        e(4) = length(Pic) - ((y)*(x+1));
        %�������������
        w(1) = 1 - ((y-1)*size(1))/((x+1)*size(2));
        w(2) = 1 - ((y+1)*size(1))/((x-1)*size(2));
        w(3) = 1 - ((y+1)*size(1))/((x)*size(2));
        w(4) = 1 - (y*size(1))/((x+1)*size(2));
        
        %����������
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


%������ ����������� � ������ 
z = 1; %�������
%������ �����
Picture = zeros(size(1) * y, size(2) * x);

%������� ����������
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
