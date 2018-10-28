clear all;
close all;
file=dlmread('dataform20160902.csv');
data=zeros(size(file,1)/2,size(file,2));
for i = 1:size(data,1)
    data(i,:)=file(2*i,:);
end
numOfItems=90;
numOfSons=200;
numOfIterations=50;
current=zeros(numOfSons,numOfItems);
currentBestValue=1000000;
currentBestSon=zeros(numOfItems);
bestValue=1000000;
bestSon=zeros(numOfItems);
tic;
for i = 1:numOfSons
    for j =1:numOfItems;
        if rand<0.05
            current(i,j)=1;
        else
            current(i,j)=0;
        end
    end
end
for i = 1:numOfIterations
    bestValue=1000000;
    bestSon=zeros(size(current,2));
    valueOfSon=zeros(size(current,1));
    next=zeros(size(current,1),size(current,2));
    wheel=zeros(size(current,1)+1);
    for j = 1:size(current,1)
        t=1:90;
        q=50;
        costOfSon=0;
        error=zeros(size(data,2));
        points=find(current(j,:)==1);
        numOfPoints=size(points,2);
        if numOfPoints < 2
            costOfSon=500000000;
        else
            for k=1:size(data,1)
                v=data(k,points);
                curveFitting=interp1(v,points,data(k,:),'spline');
                error=abs(curveFitting-t);
                costOfSon=costOfSon+sum((error>0.5))*1+sum((error>1.0))*3+sum((error>1.5))*6+sum((error>2))*9990;
            end
        end
        costOfSon=costOfSon/500+q*numOfPoints;
        valueOfSon(j)=costOfSon;
        if (valueOfSon(j)<bestValue)
            bestValue=valueOfSon(j);
            bestSon=current(j,:);
        end
    end
    for j = 2:size(wheel,2)
        wheel(j+1)=wheel(j)+(1/valueOfSon(j)^2);
    end
    next(1,:)=bestSon(1,:);
    for j=2:size(next,1)
        pointer = rand*wheel(size(current,1)+1);
        for k = 2:size(wheel,2)
            if pointer < wheel(k)
                next(j,:)=current(k-1,:);
                break;
            end
        end
    end
    current=next;
    if bestValue <currentBestValue
        currentBestSon=bestSon;
        currentBestValue=bestValue;
    end
    disp(i);
    for j = 1:2:size(current,1)
        position = ceil(rand*size(current,2));
        for k = 1:position
            tmp=current(j,k);
            current(j,k)=current(j+1,k);
            current(j+1,k)=tmp;
        end
    end
    posOfSon=ceil(rand*size(current,1));
    posOfPoint=ceil(rand*size(current,2));
    current(posOfSon,posOfPoint)=1-current(posOfSon,posOfPoint);
end
disp (find(currentBestSon==1));
disp (currentBestValue);
toc;