clear all;
close all;
myPoints=[4 19 28 75 87];
file=dlmread('dataform20160902.csv');
data=zeros(size(file,1)/2,size(file,2));
for i = 1:size(data,1)
    data(i,:)=file(2*i,:);
end
t=1:90;
costOfSon=0;
numOfPoints=size(myPoints,2);
error=zeros(size(data,2));
for i=1:size(data,1)
    v=data(i,myPoints);
    curveFitting=interp1(v,myPoints,data(i,:),'spline');
    error=abs(t-curveFitting);
    sum_a=sum(error>0.5);
    sum_b=sum(error>1.0);
    sum_c=sum(error>1.5);
    sum_d=sum(error>2.0);
    costOfSon=costOfSon+sum_a*1+sum_b*3+sum_c*6+sum_d*9990;
end
costOfSon=costOfSon/500+numOfPoints*50;
disp (costOfSon);