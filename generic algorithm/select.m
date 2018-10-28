function [ next,bestValue,bestSon ] = select( current )
%SELECT 选择下一代个体
volume=[7 4 8 11 20 5 3 9 16 7 8 5 4 4 3 12];
weight=[11 7 9 6 7 8 5 6 18 2 3 6 2 9 5 4];
value=[9 8 7 8 18 7 3 10 19 4 4 11 3 5 4 6];
bestValue=0;
bestSon=zeros(size(current,2));
maxVolume=95;
maxWeight=86;
volumeOfSon=0;
weightOfSon=0;
valueOfSon=0;
next=zeros(size(current,1),size(current,2));
wheel=zeros(size(current,1)+1);
for i = 1:size(current,1)
    volumeOfSon=0;
    weightOfSon=0;
    valueOfSon=0;
    for j = 1:size(current,2)
        volumeOfSon=dot(volume,current(i,:));
        weightOfSon=dot(weight,current(i,:));
        valueOfSon=dot(value,current(i,:));
        if (volumeOfSon>maxVolume)
            valueOfSon=1;
        end
        if (weightOfSon>maxWeight)
            valueOfSon=1;
        end
        if (valueOfSon>bestValue)
            bestValue=valueOfSon;
            bestSon=current(i,:);
        end
        wheel(i+1)=wheel(i)+valueOfSon;
    end
end
next(1,:)=bestSon;
for i=2:size(next,1)
    pointer = rand*wheel(size(current,1)+1);
    for j = 2:size(wheel)
        if pointer < wheel(j)
            next(i,:)=current(j-1,:);
            break;
        end
    end
end
end