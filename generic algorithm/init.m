numOfItems=16;
numOfSons=200;
numOfIterations=150;
current=zeros(numOfSons,numOfItems);
currentBestValue=0;
currentBestSon=zeros(numOfItems);
bestValue=0;
bestSon=zeros(numOfItems);
tic;
for i = 1:numOfSons
    for j =1:numOfItems;
        if rand>0.2
            current(i,j)=1;
        else
            current(i,j)=0;
        end
    end
end
for i = 1:numOfIterations
    [current,bestValue,bestSon]=select(current);
    if bestValue >currentBestValue
        currentBestSon=bestSon;
        currentBestValue=bestValue;
    end
    current=cross(current);
    current=change(current);
end
disp (currentBestSon);
disp (currentBestValue);
disp (toc);