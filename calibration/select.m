function [ next,bestValue,bestSon ] = select( current,data )
%SELECT Ñ¡Ôñ
bestValue=1000000;
bestSon=zeros(size(current,2));
valueOfSon=zeros(size(current,1));
next=zeros(size(current,1),size(current,2));
wheel=zeros(size(current,1)+1);
for i = 1:size(current,1)
    valueOfSon(i)=cost(current(i,:),data);
    if (valueOfSon(i)<bestValue)
        bestValue=valueOfSon(i);
        bestSon=current(i,:);
    end
end
for i = 2:size(wheel,2)
    wheel(i+1)=wheel(i)+(1/valueOfSon(i)^2);
end
next(1,:)=bestSon(1,:);
for i=2:size(next,1)
    pointer = rand*wheel(size(current,1)+1);
    for j = 2:size(wheel,2)
        if pointer < wheel(j)
            next(i,:)=current(j-1,:);
            break;
        end
    end
end
end