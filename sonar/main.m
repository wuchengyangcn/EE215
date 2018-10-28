tic;
clear all;
close all;
numOfSamples=100000;
prEA1=0.23;
prEA2=0.27;
prEA3=0.50;
prEB1=0.73;
prEB2=0.27;
k=4;
numOfNodes=4;
while(numOfNodes<=12)
    totalTime=0;
    reliable=0;
    for i=1:numOfSamples
        nodes=zeros(1,numOfNodes);
        numOfPF=numOfNodes;
        numOfSO=0;
        numOfDM=0;
        numOfMO=0;
        numOfDN=0;
        numOfFB=0;
        time=0;
        master=1;
        gSYS=2;
        timeOfA=ceil(exprnd(95500,1,numOfNodes));
        timeOfB=ceil(exprnd(290000,1,numOfNodes));
        timeOfFail=zeros(1,numOfNodes);
        timeOfFail(:)=min(timeOfA(1,:),timeOfB(1,:));
        for j = 1:numOfNodes
            time=min(timeOfFail);
            if time>75000
                time=75000;
                break;
            end;
            a=0;
            b=0;
            node=find(timeOfFail==time,1);
            if(timeOfFail(node)==timeOfA(1,node))
                state=rand;
                if state<prEA1 a=1;
                elseif state<(prEA1+prEA2) a=2;
                else a=3;
                end;
            end;
            if (timeOfFail(node)==timeOfB(1,node))
                state=rand;
                if state<prEB1 b=1;
                else b=2;
                end;
            end;
            timeOfFail(node)=75001;
            if (a==0)
                if (b==1)
                    nodes(j)=3;
                    numOfPF=numOfPF-1;
                    numOfMO=numOfMO+1;
                elseif (b==2)
                    nodes(j)=1;
                    numOfPF=numOfPF-1;
                    numOfSO=numOfSO+1;
                end;
            elseif (a==1)
                if (b==1)
                    nodes(j)=5;
                    numOfPF=numOfPF-1;
                    numOfFB=numOfFB+1;
                else
                    nodes(j)=1;
                    numOfPF=numOfPF-1;
                    numOfSO=numOfSO+1;
                end;
            elseif (a==2)
                if (b==0)
                    nodes(j)=2;
                    numOfPF=numOfPF-1;
                    numOfDM=numOfDM+1;
                elseif (b==1)
                    nodes(j)=3;
                    numOfPF=numOfPF-1;
                    numOfMO=numOfMO+1;
                else
                    nodes(j)=4;
                    numOfPF=numOfPF-1;
                    numOfDN=numOfDN+1;
                end;
            else
                nodes(j)=4;
                numOfPF=numOfPF-1;
                numOfDN=numOfDN+1;
            end;
            if ((numOfFB>0)||(numOfMO>=2)||(numOfPF+numOfMO+numOfDM==0)||(numOfPF+numOfSO+(numOfMO>0||numOfDM>0))<k)
                gSYS=1;
            elseif (numOfMO==1)&&(numOfPF+numOfSO>=k-1)
                gSYS=2;
                while(nodes(master)~=3)
                    master=ceil(rand*numOfNodes);
                end;
            elseif (numOfMO==0&&numOfPF>=1&&numOfPF+numOfSO>=k)
                gSYS=2;
                while(nodes(master)~=0)
                    master=ceil(rand*numOfNodes);
                end;
            elseif (numOfMO==0&&numOfPF==0&&numOfDM>=1&&numOfSO>=k-1)
                gSYS=2;
                while(nodes(master)~=2)
                    master=ceil(rand*numOfNodes);
                end;
            elseif (numOfFB+numOfMO==0)&&(numOfPF>=1&&numOfPF+numOfSO==k-1&&numOfDM>=1)
                while(nodes(master)~=2&&nodes(master)~=0)
                    master=ceil(rand*numOfNodes);
                    if (nodes(master)==0) gSYS=4;
                    else gSYS=3;
                    end;
                end;
            end;
            if (gSYS==1||gSYS==4) break;
            end;
        end;
        totalTime=totalTime+time;
        if (time>=25000)
            reliable=reliable+1;
        end;
    end;
    disp (numOfNodes);
    disp (reliable/numOfSamples);
    disp (ceil(totalTime/numOfSamples));
    numOfNodes=numOfNodes+1;
end;
toc;