function [ current ] = change( current )
%CHANGE ��������
posOfSon=ceil(rand*size(current,1));
posOfPoint=ceil(rand*size(current,2));
current(posOfSon,posOfPoint)=1-current(posOfSon,posOfPoint);
end