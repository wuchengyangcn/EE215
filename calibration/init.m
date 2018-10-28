clear all;
close all;
file=dlmread('dataform20160902.csv');
data=zeros(size(file,1)/2,size(file,2));
for i = 1:size(data,1)
    data(i,:)=file(2*i,:);
end
numOfItems=90;
numOfSons=10;
numOfIterations=10;
current=zeros(numOfSons,numOfItems);
currentBestValue=1000000;
currentBestSon=zeros(numOfItems);
bestValue=1000000;
bestSon=zeros(numOfItems);
tic;
for i = 1:numOfSons
    for j =1:numOfItems;
        if rand<0.06
            current(i,j)=1;
        else
            current(i,j)=0;
        end
    end
end
for i = 1:numOfIterations
    [current,bestValue,bestSon]=select(current,data);
    if bestValue <currentBestValue
        currentBestSon=bestSon;
        currentBestValue=bestValue;
    end
    disp(i);
    current=cross(current);
    current=change(current);
end
disp (find(currentBestSon==1));
disp (currentBestValue);
toc;