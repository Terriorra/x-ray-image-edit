%������ ���������� � ��������
%I - ���������� �����������
%M - ����� �������� ��������

function [x, y] = CreatOutline(M)
M = bwmorph(M, 'remove');
[x, y] = find(M);


% %�������� ������ �������
% R = zeros(size(I));
% R = cat(3, R, R, R);
%
% %�������� ����������� ����������� � RGB
% I = cat(3, I, I, I);
%
% %����� ������
% M = bwmorph(M, 'remove');
% M = M.*255;
% %��������
% R(:,:,1) = M;
% R = uint8(R);
%
% %������ ����������
%
% M = I + R;

end
