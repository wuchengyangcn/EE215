function [ current ] = cross( current )
%CROSS ½»»»
for i = 1:2:size(current,1)
    position = ceil(rand*size(current,2));
    for j = 1:position
        tmp=current(i,j);
        current(i,j)=current(i+1,j);
        current(i+1,j)=tmp;
    end
end