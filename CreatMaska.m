%�������� ����� �� �����������
%I - ����������� �����������
%porog - ����� ����������� ������� ��������
%scale - ������� ���������� - ���������� �������� � ����� ��
%s - ����������� ������ ��������

function Maska = CreatMaska(I, porog, scale, s)

%������ �����������
I = imopen(I, strel('disk', round(scale/2)));

Maska = I>porog;

%��������� ������� ������ ��

Maska=bwareaopen(Maska, scale^2);

if and(s ~= 0, ~isnan(s))
    %����� ������ �������� �������
    Maska=bwareaopen(Maska, s*scale^2);    
end

end