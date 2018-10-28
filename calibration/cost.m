function [ costOfSon ] = cost(currentSon,data)
%COST 
t=1:90;
q=50;
costOfSon=0;
error=zeros(size(data,2));
points=find(currentSon==1);
numOfPoints=size(points,2);
if numOfPoints < 2
    costOfSon=500000000;
else
    for i=1:size(data,1)
        v=data(i,points);
        curveFitting=interp1(v,points,data(i,:),'spline');
        error=abs(curveFitting-t);
        costOfSon=costOfSon+sum((error>0.5))*1+sum((error>1.0))*3+sum((error>1.5))*6+sum((error>2))*9990;
    end
end
costOfSon=costOfSon/500+q*numOfPoints;
end