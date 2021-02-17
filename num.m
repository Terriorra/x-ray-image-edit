function numeric=num(Maska)
numeric=[];
M=bwlabel(Maska);
s = regionprops(Maska,'centroid',  'BoundingBox');
BoundingBox=cat(1, s.BoundingBox);
s = cat(1,s.Centroid);
while sum(sum(M))>0
[y, l]=min(s(:,2));
y=round(y);
l=round(BoundingBox(l, 4)/3);
a = y-l;
if a < 0
    a = 1;
end

b = y+l;
if b > size(M, 1)
    b = size(M, 1);
end

if a < 1
    a = 1;
end

if b > size(M ,1)
    b = size(M ,1);
end

ind=M(a:b,:);
ind=unique(ind);
ind(1)=[];
[~, r]=sort(s(ind,1));
ind=ind(r);
numeric=cat(1, numeric, ind);
M=~ismember(M, ind).*M;
s(ind,:)=max(max(s));
end
end