%���������� ����� ��� ����������� �����������

function map=MapFinal(I)
%����������� ��������� �����������
h=imhist(I);

%������ ������� ���� ��������� �� ����� ���������
e=1:256;
r=e(h>0);

%�������� ����� �������
x=0:256/length(r):256;
x=x/256;

%��������� �� �� ���
map(r)=x(1:length(r));
map(end+1:256)=1;

%�������� �������� ��������� �� �������������� ����������
if sum(map==0)>1
    %����� ���������
    holes=e(map==0);
    holes(1)=[]; %������ ���������
    a=holes(1)-1;
    b=holes(1)+1;
    while b<holes(end)+2
        if sum(b==holes)>0
            b=b+1;
            while sum(b==holes)>0
                b=b+1;
            end
        end
        holl=map(a):(map(b)-map(a))/(b-a):map(b);
        holl(1)=[]; holl(end)=[];
        map(a+1:b-1)=holl;
        
        holes(holes<b)=[];
        if isempty(holes)
            break
        end
        a=holes(1)-1;
        b=holes(1)+1;
    end
    
end


map=[map', map', map'];
end