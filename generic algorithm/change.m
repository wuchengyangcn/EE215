function [ current ] = change( current )
%CHANGE ²úÉú±äÒì
rateOfChange=0.05;
for i=1:size(current,1)
    if rand < rateOfChange
        position = ceil(rand*size(current,2));
        current(i,position)=1-current(i,position);
    end
end
end