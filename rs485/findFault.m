tic;
clear all;
close all;
numOfSamples=1000;
lamdaHardware=94500;
lamdaSoftware=4700;
lamdaRepair=10;
lamdaWatchdog=1;
maxTime=24*365*10;
availableTime=[1,2,8,20,100,1000,24*365,24*365*5,24*365*10];
hold on;

%no measures
timeOfState=zeros(1,3);
numOfRepair=0;
numOfFault=0;
numOfFailure=0;
timeOfContinuousPerfectFunctioning=0;
timeOfContinuousNoFailure=0;
available=zeros(1,9);
faultTime=zeros(1,24*365*10);
for i =1:numOfSamples
    hub=ceil(exprnd(94500,1,15));
    master=zeros(1,74);
    slave1=zeros(1,74);
    slave2=zeros(1,74);
    slave3=zeros(1,74);
    master(1)=ceil(exprnd(lamdaSoftware));
    master(2:74)=ceil(exprnd(lamdaHardware,1,73));
    slave1(1)=ceil(exprnd(lamdaSoftware));
    slave1(2:74)=ceil(exprnd(lamdaHardware,1,73));
    slave2(1)=ceil(exprnd(lamdaSoftware));
    slave2(2:74)=ceil(exprnd(lamdaHardware,1,73));
    slave3(1)=ceil(exprnd(lamdaSoftware));
    slave3(2:74)=ceil(exprnd(lamdaHardware,1,73));
    stateOfHub=ones(1,15);
    stateOfMaster=ones(1,74);
    stateOfSlave1=ones(1,74);
    stateOfSlave2=ones(1,74);
    stateOfSlave3=ones(1,74);
    sysState=1;
    lastEvent=0;
    currentEvent=0;
    while (currentEvent<=maxTime)
        block=0;
        nextEvent=[min(hub),min(master),min(slave1),min(slave2),min(slave3)];
        currentEvent=min(nextEvent);
        if ((lastEvent<=1)&&(currentEvent>=1))
            available(1)=available(1)+(sysState==1);
        end;
        if ((lastEvent<=2)&&(currentEvent>=2))
            available(2)=available(2)+(sysState==1);
        end;
        if ((lastEvent<=8)&&(currentEvent>=8))
            available(3)=available(3)+(sysState==1);
        end;
        if ((lastEvent<=20)&&(currentEvent>=20))
            available(4)=available(4)+(sysState==1);
        end;
        if ((lastEvent<=100)&&(currentEvent>=100))
            available(5)=available(5)+(sysState==1);
        end;
        if ((lastEvent<=1000)&&(currentEvent>=1000))
            available(6)=available(6)+(sysState==1);
        end;
        if ((lastEvent<=24*365)&&(currentEvent>=24*365))
            available(7)=available(7)+(sysState==1);
        end;
        if ((lastEvent<=24*365*5)&&(currentEvent>=24*365*5))
            available(8)=available(8)+(sysState==1);
        end;
        if ((lastEvent<=24*365*10)&&(currentEvent>=24*365*10))
            available(9)=available(9)+(sysState==1);
        end;
        if (currentEvent>maxTime)
            break;
        end;
        if (currentEvent==min(hub))
            pos=find(hub==currentEvent,1);
            if (stateOfHub(pos)==1)
                stateOfHub(pos)=2;
                hub(pos)=hub(pos)+ceil(exprnd(lamdaRepair));
                numOfRepair=numOfRepair+1;
                faultTime(currentEvent)=faultTime(currentEvent)+1;
            else
                stateOfHub(pos)=1;
                hub(pos)=hub(pos)+ceil(exprnd(lamdaHardware));
            end;
        elseif (currentEvent==min(master))
            pos=find(master==currentEvent,1);
            if (stateOfMaster(pos)==1)
                stateOfMaster(pos)=2;
                master(pos)=master(pos)+ceil(exprnd(lamdaRepair));
                numOfRepair=numOfRepair+1;
                faultTime(currentEvent)=faultTime(currentEvent)+1;
                if ((pos>=50)&&(rand<0.4))
                    block=1;
                end;
            else
                stateOfMaster(pos)=1;
                if (pos==1)
                    master(pos)=master(pos)+ceil(exprnd(lamdaSoftware));
                else
                    master(pos)=master(pos)+ceil(exprnd(lamdaHardware));
                end;
            end;
        elseif (currentEvent==min(slave1))
            pos=find(slave1==currentEvent,1);
            if (stateOfSlave1(pos)==1)
                stateOfSlave1(pos)=2;
                slave1(pos)=slave1(pos)+ceil(exprnd(lamdaRepair));
                numOfRepair=numOfRepair+1;
                faultTime(currentEvent)=faultTime(currentEvent)+1;
                if ((pos>=50)&&(rand<0.4))
                    block=1;
                end;
            else
                stateOfSlave1(pos)=1;
                if (pos==1)
                    slave1(pos)=slave1(pos)+ceil(exprnd(lamdaSoftware));
                else
                    slave1(pos)=slave1(pos)+ceil(exprnd(lamdaHardware));
                end;
            end;
        elseif (currentEvent==min(slave2))
            pos=find(slave2==currentEvent,1);
            if (stateOfSlave2(pos)==1)
                stateOfSlave2(pos)=2;
                slave2(pos)=slave2(pos)+ceil(exprnd(lamdaRepair));
                numOfRepair=numOfRepair+1;
                faultTime(currentEvent)=faultTime(currentEvent)+1;
                if ((pos>=50)&&(rand<0.4))
                    block=1;
                end;
            else
                stateOfSlave2(pos)=1;
                if (pos==1)
                    slave2(pos)=slave2(pos)+ceil(exprnd(lamdaSoftware));
                else
                    slave2(pos)=slave2(pos)+ceil(exprnd(lamdaHardware));
                end;
            end;
        elseif (currentEvent==min(slave3))
            pos=find(slave3==currentEvent,1);
            if (stateOfSlave3(pos)==1)
                stateOfSlave3(pos)=2;
                slave3(pos)=slave3(pos)+ceil(exprnd(lamdaRepair));
                numOfRepair=numOfRepair+1;
                faultTime(currentEvent)=faultTime(currentEvent)+1;
                if ((pos>=50)&&(rand<0.4))
                    block=1;
                end;
            else
                stateOfSlave3(pos)=1;
                if (pos==1)
                    slave3(pos)=slave3(pos)+ceil(exprnd(lamdaSoftware));
                else
                    slave3(pos)=slave3(pos)+ceil(exprnd(lamdaHardware));
                end;
            end;
        end;
        timeOfState(sysState)=timeOfState(sysState)+(currentEvent-lastEvent);
        lastEvent=currentEvent;
        if (any(stateOfHub==2)||any(stateOfMaster==2)||any(stateOfSlave1==2)+any(stateOfSlave2==2)+any(stateOfSlave3==2)>=2||block==1)
            if (sysState~=3)
                numOfFailure=numOfFailure+1;
                sysState=3;
            end;
            timeOfContinuousPerfectFunctioning=timeOfState(1);
            timeOfContinuousNoFailure=timeOfState(1)+timeOfState(2);
        elseif (not(any(stateOfHub==2)||any(stateOfMaster==2)||any(stateOfSlave1==2)||any(stateOfSlave2==2)||any(stateOfSlave3==2)))
            sysState=1;
        else
            if (sysState~=2)
                numOfFault=numOfFault+1;
                sysState=2;
            end;
            timeOfContinuousPerfectFunctioning=timeOfState(1);
        end;
    end;
    timeOfState(sysState)=timeOfState(sysState)+(maxTime-lastEvent);
end;
disp('plot 1: no measures');
disp('average number of repair:');
disp(numOfRepair/numOfSamples);
disp('average number of fault:');
disp((numOfFault+numOfFailure)/numOfSamples);
disp('average number of failure:');
disp(numOfFailure/numOfSamples);
disp('average time of perfect functioning:');
disp(timeOfState(1)/numOfSamples);
disp('average time of continuous perfect functioning:');
disp(timeOfContinuousPerfectFunctioning/(numOfFault+numOfFailure));
disp('average time of continuous no failure:');
disp(timeOfContinuousNoFailure/numOfFailure);
figure(1);subplot(1,2,1),semilogx(availableTime,available/numOfSamples);
title('plot 1: no measures');
figure(1);subplot(1,2,2),semilogx(1:24*365*10,faultTime,'LineWidth',5);
title('fault time of plot 1');

%measure 1
timeOfState=zeros(1,3);
numOfRepair=0;
numOfFault=0;
numOfFailure=0;
timeOfContinuousPerfectFunctioning=0;
timeOfContinuousNoFailure=0;
available=zeros(1,9);
faultTime=zeros(1,24*365*10);
for i =1:numOfSamples
    hub=ceil(exprnd(94500,1,15));
    master=zeros(1,74);
    slave1=zeros(1,74);
    slave2=zeros(1,74);
    slave3=zeros(1,74);
    master(1)=ceil(exprnd(lamdaSoftware));
    master(2:74)=ceil(exprnd(lamdaHardware,1,73));
    slave1(1)=ceil(exprnd(lamdaSoftware));
    slave1(2:74)=ceil(exprnd(lamdaHardware,1,73));
    slave2(1)=ceil(exprnd(lamdaSoftware));
    slave2(2:74)=ceil(exprnd(lamdaHardware,1,73));
    slave3(1)=ceil(exprnd(lamdaSoftware));
    slave3(2:74)=ceil(exprnd(lamdaHardware,1,73));
    stateOfHub=ones(1,15);
    stateOfMaster=ones(1,74);
    stateOfSlave1=ones(1,74);
    stateOfSlave2=ones(1,74);
    stateOfSlave3=ones(1,74);
    sysState=1;
    lastEvent=0;
    currentEvent=0;
    while (currentEvent<=maxTime)
        block=0;
        nextEvent=[min(hub),min(master),min(slave1),min(slave2),min(slave3)];
        currentEvent=min(nextEvent);
        if ((lastEvent<=1)&&(currentEvent>=1))
            available(1)=available(1)+(sysState==1);
        end;
        if ((lastEvent<=2)&&(currentEvent>=2))
            available(2)=available(2)+(sysState==1);
        end;
        if ((lastEvent<=8)&&(currentEvent>=8))
            available(3)=available(3)+(sysState==1);
        end;
        if ((lastEvent<=20)&&(currentEvent>=20))
            available(4)=available(4)+(sysState==1);
        end;
        if ((lastEvent<=100)&&(currentEvent>=100))
            available(5)=available(5)+(sysState==1);
        end;
        if ((lastEvent<=1000)&&(currentEvent>=1000))
            available(6)=available(6)+(sysState==1);
        end;
        if ((lastEvent<=24*365)&&(currentEvent>=24*365))
            available(7)=available(7)+(sysState==1);
        end;
        if ((lastEvent<=24*365*5)&&(currentEvent>=24*365*5))
            available(8)=available(8)+(sysState==1);
        end;
        if ((lastEvent<=24*365*10)&&(currentEvent>=24*365*10))
            available(9)=available(9)+(sysState==1);
        end;
        if (currentEvent>maxTime)
            break;
        end;
        if (currentEvent==min(hub))
            pos=find(hub==currentEvent,1);
            if (stateOfHub(pos)==1)
                stateOfHub(pos)=2;
                hub(pos)=hub(pos)+ceil(exprnd(lamdaRepair));
                numOfRepair=numOfRepair+1;
                faultTime(currentEvent)=faultTime(currentEvent)+1;
            else
                stateOfHub(pos)=1;
                hub(pos)=hub(pos)+ceil(exprnd(lamdaHardware));
            end;
        elseif (currentEvent==min(master))
            pos=find(master==currentEvent,1);
            if (stateOfMaster(pos)==1)
                stateOfMaster(pos)=2;
                if (pos==1)
                    if (rand<0.987)
                        master(pos)=master(pos)+ceil(exprnd(lamdaWatchdog));
                    else
                        master(pos)=master(pos)+ceil(exprnd(lamdaWatchdog))+ceil(exprnd(lamdaRepair));
                        numOfRepair=numOfRepair+1;
                        faultTime(currentEvent)=faultTime(currentEvent)+1;
                    end;
                else
                    master(pos)=master(pos)+ceil(exprnd(lamdaRepair));
                    numOfRepair=numOfRepair+1;
                    faultTime(currentEvent)=faultTime(currentEvent)+1;
                    if ((pos>=50)&&(rand<0.4))
                        block=1;
                    end;
                end;
            else
                stateOfMaster(pos)=1;
                if (pos==1)
                    master(pos)=master(pos)+ceil(exprnd(lamdaSoftware));
                else
                    master(pos)=master(pos)+ceil(exprnd(lamdaHardware));
                end;
            end;
        elseif (currentEvent==min(slave1))
            pos=find(slave1==currentEvent,1);
            if (stateOfSlave1(pos)==1)
                stateOfSlave1(pos)=2;
                if (pos==1)
                    if (rand<0.987)
                        slave1(pos)=slave1(pos)+ceil(exprnd(lamdaWatchdog));
                    else
                        slave1(pos)=slave1(pos)+ceil(exprnd(lamdaWatchdog))+ceil(exprnd(lamdaRepair));
                        numOfRepair=numOfRepair+1;
                        faultTime(currentEvent)=faultTime(currentEvent)+1;
                    end;
                else
                    slave1(pos)=slave1(pos)+ceil(exprnd(lamdaRepair));
                    numOfRepair=numOfRepair+1;
                    faultTime(currentEvent)=faultTime(currentEvent)+1;
                    if ((pos>=50)&&(rand<0.4))
                        block=1;
                    end;
                end;
            else
                stateOfSlave1(pos)=1;
                if (pos==1)
                    slave1(pos)=slave1(pos)+ceil(exprnd(lamdaSoftware));
                else
                    slave1(pos)=slave1(pos)+ceil(exprnd(lamdaHardware));
                end;
            end;
        elseif (currentEvent==min(slave2))
            pos=find(slave2==currentEvent,1);
            if (stateOfSlave2(pos)==1)
                stateOfSlave2(pos)=2;
                if (pos==1)
                    if (rand<0.987)
                        slave2(pos)=slave2(pos)+ceil(exprnd(lamdaWatchdog));
                    else
                        slave2(pos)=slave2(pos)+ceil(exprnd(lamdaWatchdog))+ceil(exprnd(lamdaRepair));
                        numOfRepair=numOfRepair+1;
                        faultTime(currentEvent)=faultTime(currentEvent)+1;
                    end;
                else
                    slave2(pos)=slave2(pos)+ceil(exprnd(lamdaRepair));
                    numOfRepair=numOfRepair+1;
                    faultTime(currentEvent)=faultTime(currentEvent)+1;
                    if ((pos>=50)&&(rand<0.4))
                        block=1;
                    end;
                end;
            else
                stateOfSlave2(pos)=1;
                if (pos==1)
                    slave2(pos)=slave2(pos)+ceil(exprnd(lamdaSoftware));
                else
                    slave2(pos)=slave2(pos)+ceil(exprnd(lamdaHardware));
                end;
            end;
        elseif (currentEvent==min(slave3))
            pos=find(slave3==currentEvent,1);
            if (stateOfSlave3(pos)==1)
                stateOfSlave3(pos)=2;
                if (pos==1)
                    if (rand<0.987)
                        slave3(pos)=slave3(pos)+ceil(exprnd(lamdaWatchdog));
                    else
                        slave3(pos)=slave3(pos)+ceil(exprnd(lamdaWatchdog))+ceil(exprnd(lamdaRepair));
                        numOfRepair=numOfRepair+1;
                        faultTime(currentEvent)=faultTime(currentEvent)+1;
                    end;
                else
                    slave3(pos)=slave3(pos)+ceil(exprnd(lamdaRepair));
                    numOfRepair=numOfRepair+1;
                    faultTime(currentEvent)=faultTime(currentEvent)+1;
                    if ((pos>=50)&&(rand<0.4))
                        block=1;
                    end;
                end;
            else
                stateOfSlave3(pos)=1;
                if (pos==1)
                    slave3(pos)=slave3(pos)+ceil(exprnd(lamdaSoftware));
                else
                    slave3(pos)=slave3(pos)+ceil(exprnd(lamdaHardware));
                end;
            end;
        end;
        timeOfState(sysState)=timeOfState(sysState)+(currentEvent-lastEvent);
        lastEvent=currentEvent;
        if (any(stateOfHub==2)||any(stateOfMaster==2)||any(stateOfSlave1==2)+any(stateOfSlave2==2)+any(stateOfSlave3==2)>=2||block==1)
            if (sysState~=3)
                numOfFailure=numOfFailure+1;
                sysState=3;
            end;
            timeOfContinuousPerfectFunctioning=timeOfState(1);
            timeOfContinuousNoFailure=timeOfState(1)+timeOfState(2);
        elseif (not(any(stateOfHub==2)||any(stateOfMaster==2)||any(stateOfSlave1==2)||any(stateOfSlave2==2)||any(stateOfSlave3==2)))
            sysState=1;
        else
            if (sysState~=2)
                numOfFault=numOfFault+1;
                sysState=2;
            end;
            timeOfContinuousPerfectFunctioning=timeOfState(1);
        end;
    end;
    timeOfState(sysState)=timeOfState(sysState)+(maxTime-lastEvent);
end;
disp('plot 2: measure 1');
disp('average number of repair:');
disp(numOfRepair/numOfSamples);
disp('average number of fault:');
disp((numOfFault+numOfFailure)/numOfSamples);
disp('average number of failure:');
disp(numOfFailure/numOfSamples);
disp('average time of perfect functioning:');
disp(timeOfState(1)/numOfSamples);
disp('average time of continuous perfect functioning:');
disp(timeOfContinuousPerfectFunctioning/(numOfFault+numOfFailure));
disp('average time of continuous no failure:');
disp(timeOfContinuousNoFailure/numOfFailure);
figure(2);subplot(1,2,1),semilogx(availableTime,available/numOfSamples);
title('plot 2: measure 1');
figure(2);subplot(1,2,2),semilogx(1:24*365*10,faultTime,'LineWidth',5);
title('fault time of plot 2');

%measure 2
timeOfState=zeros(1,3);
numOfRepair=0;
numOfFault=0;
numOfFailure=0;
timeOfContinuousPerfectFunctioning=0;
timeOfContinuousNoFailure=0;
available=zeros(1,9);
faultTime=zeros(1,24*365*10);
for i =1:numOfSamples
    hub=ceil(exprnd(94500,1,15));
    master=zeros(1,81);
    slave1=zeros(1,81);
    slave2=zeros(1,81);
    slave3=zeros(1,81);
    master(1)=ceil(exprnd(lamdaSoftware));
    master(2:81)=ceil(exprnd(lamdaHardware,1,80));
    slave1(1)=ceil(exprnd(lamdaSoftware));
    slave1(2:81)=ceil(exprnd(lamdaHardware,1,80));
    slave2(1)=ceil(exprnd(lamdaSoftware));
    slave2(2:81)=ceil(exprnd(lamdaHardware,1,80));
    slave3(1)=ceil(exprnd(lamdaSoftware));
    slave3(2:81)=ceil(exprnd(lamdaHardware,1,80));
    stateOfHub=ones(1,15);
    stateOfMaster=ones(1,81);
    stateOfSlave1=ones(1,81);
    stateOfSlave2=ones(1,81);
    stateOfSlave3=ones(1,81);
    sysState=1;
    lastEvent=0;
    currentEvent=0;
    while (currentEvent<=maxTime)
        nextEvent=[min(hub),min(master),min(slave1),min(slave2),min(slave3)];
        currentEvent=min(nextEvent);
        if ((lastEvent<=1)&&(currentEvent>=1))
            available(1)=available(1)+(sysState==1);
        end;
        if ((lastEvent<=2)&&(currentEvent>=2))
            available(2)=available(2)+(sysState==1);
        end;
        if ((lastEvent<=8)&&(currentEvent>=8))
            available(3)=available(3)+(sysState==1);
        end;
        if ((lastEvent<=20)&&(currentEvent>=20))
            available(4)=available(4)+(sysState==1);
        end;
        if ((lastEvent<=100)&&(currentEvent>=100))
            available(5)=available(5)+(sysState==1);
        end;
        if ((lastEvent<=1000)&&(currentEvent>=1000))
            available(6)=available(6)+(sysState==1);
        end;
        if ((lastEvent<=24*365)&&(currentEvent>=24*365))
            available(7)=available(7)+(sysState==1);
        end;
        if ((lastEvent<=24*365*5)&&(currentEvent>=24*365*5))
            available(8)=available(8)+(sysState==1);
        end;
        if ((lastEvent<=24*365*10)&&(currentEvent>=24*365*10))
            available(9)=available(9)+(sysState==1);
        end;
        if (currentEvent>maxTime)
            break;
        end;
        if (currentEvent==min(hub))
            pos=find(hub==currentEvent,1);
            if (stateOfHub(pos)==1)
                stateOfHub(pos)=2;
                hub(pos)=hub(pos)+ceil(exprnd(lamdaRepair));
                numOfRepair=numOfRepair+1;
                faultTime(currentEvent)=faultTime(currentEvent)+1;
            else
                stateOfHub(pos)=1;
                hub(pos)=hub(pos)+ceil(exprnd(lamdaHardware));
            end;
        elseif (currentEvent==min(master))
            pos=find(master==currentEvent,1);
            if (stateOfMaster(pos)==1)
                stateOfMaster(pos)=2;
                master(pos)=master(pos)+ceil(exprnd(lamdaRepair));
                numOfRepair=numOfRepair+1;
                faultTime(currentEvent)=faultTime(currentEvent)+1;
            else
                stateOfMaster(pos)=1;
                if (pos==1)
                    master(pos)=master(pos)+ceil(exprnd(lamdaSoftware));
                else
                    master(pos)=master(pos)+ceil(exprnd(lamdaHardware));
                end;
            end;
        elseif (currentEvent==min(slave1))
            pos=find(slave1==currentEvent,1);
            if (stateOfSlave1(pos)==1)
                stateOfSlave1(pos)=2;
                slave1(pos)=slave1(pos)+ceil(exprnd(lamdaRepair));
                numOfRepair=numOfRepair+1;
                faultTime(currentEvent)=faultTime(currentEvent)+1;
            else
                stateOfSlave1(pos)=1;
                if (pos==1)
                    slave1(pos)=slave1(pos)+ceil(exprnd(lamdaSoftware));
                else
                    slave1(pos)=slave1(pos)+ceil(exprnd(lamdaHardware));
                end;
            end;
        elseif (currentEvent==min(slave2))
            pos=find(slave2==currentEvent,1);
            if (stateOfSlave2(pos)==1)
                stateOfSlave2(pos)=2;
                slave2(pos)=slave2(pos)+ceil(exprnd(lamdaRepair));
                numOfRepair=numOfRepair+1;
                faultTime(currentEvent)=faultTime(currentEvent)+1;
            else
                stateOfSlave2(pos)=1;
                if (pos==1)
                    slave2(pos)=slave2(pos)+ceil(exprnd(lamdaSoftware));
                else
                    slave2(pos)=slave2(pos)+ceil(exprnd(lamdaHardware));
                end;
            end;
        elseif (currentEvent==min(slave3))
            pos=find(slave3==currentEvent,1);
            if (stateOfSlave3(pos)==1)
                stateOfSlave3(pos)=2;
                slave3(pos)=slave3(pos)+ceil(exprnd(lamdaRepair));
                numOfRepair=numOfRepair+1;
                faultTime(currentEvent)=faultTime(currentEvent)+1;
            else
                stateOfSlave3(pos)=1;
                if (pos==1)
                    slave3(pos)=slave3(pos)+ceil(exprnd(lamdaSoftware));
                else
                    slave3(pos)=slave3(pos)+ceil(exprnd(lamdaHardware));
                end;
            end;
        end;
        timeOfState(sysState)=timeOfState(sysState)+(currentEvent-lastEvent);
        lastEvent=currentEvent;
        if (any(stateOfHub==2)||any(stateOfMaster==2)||any(stateOfSlave1==2)+any(stateOfSlave2==2)+any(stateOfSlave3==2)>=2)
            if (sysState~=3)
                numOfFailure=numOfFailure+1;
                sysState=3;
            end;
            timeOfContinuousPerfectFunctioning=timeOfState(1);
            timeOfContinuousNoFailure=timeOfState(1)+timeOfState(2);
        elseif (not(any(stateOfHub==2)||any(stateOfMaster==2)||any(stateOfSlave1==2)||any(stateOfSlave2==2)||any(stateOfSlave3==2)))
            sysState=1;
        else
            if (sysState~=2)
                numOfFault=numOfFault+1;
                sysState=2;
            end;
            timeOfContinuousPerfectFunctioning=timeOfState(1);
        end;
    end;
    timeOfState(sysState)=timeOfState(sysState)+(maxTime-lastEvent);
end;
disp('plot3: measure 2');
disp('average number of repair:');
disp(numOfRepair/numOfSamples);
disp('average number of fault:');
disp((numOfFault+numOfFailure)/numOfSamples);
disp('average number of failure:');
disp(numOfFailure/numOfSamples);
disp('average time of perfect functioning:');
disp(timeOfState(1)/numOfSamples);
disp('average time of continuous perfect functioning:');
disp(timeOfContinuousPerfectFunctioning/(numOfFault+numOfFailure));
disp('average time of continuous no failure:');
disp(timeOfContinuousNoFailure/numOfFailure);
figure(3);subplot(1,2,1),semilogx(availableTime,available/numOfSamples);
title('plot 3: measure 2');
figure(3);subplot(1,2,2),semilogx(1:24*365*10,faultTime,'LineWidth',5);
title('fault time of plot 3');

%measure 3
timeOfState=zeros(1,3);
numOfRepair=0;
numOfFault=0;
numOfFailure=0;
timeOfContinuousPerfectFunctioning=0;
timeOfContinuousNoFailure=0;
available=zeros(1,9);
faultTime=zeros(1,24*365*10);
for i =1:numOfSamples
    hub=ceil(exprnd(94500,1,15));
    master1=zeros(1,74);
    master2=zeros(1,74);
    slave1=zeros(1,74);
    slave2=zeros(1,74);
    slave3=zeros(1,74);
    master1(1)=ceil(exprnd(lamdaSoftware));
    master1(2:74)=ceil(exprnd(lamdaHardware,1,73));
    master2(1)=ceil(exprnd(lamdaSoftware));
    master2(2:74)=ceil(exprnd(lamdaHardware,1,73));
    slave1(1)=ceil(exprnd(lamdaSoftware));
    slave1(2:74)=ceil(exprnd(lamdaHardware,1,73));
    slave2(1)=ceil(exprnd(lamdaSoftware));
    slave2(2:74)=ceil(exprnd(lamdaHardware,1,73));
    slave3(1)=ceil(exprnd(lamdaSoftware));
    slave3(2:74)=ceil(exprnd(lamdaHardware,1,73));
    stateOfHub=ones(1,15);
    stateOfMaster1=ones(1,74);
    stateOfMaster2=ones(1,74);
    stateOfSlave1=ones(1,74);
    stateOfSlave2=ones(1,74);
    stateOfSlave3=ones(1,74);
    sysState=1;
    lastEvent=0;
    currentEvent=0;
    while (currentEvent<=maxTime)
        block=0;
        nextEvent=[min(hub),min(master),min(slave1),min(slave2),min(slave3)];
        currentEvent=min(nextEvent);
        if ((lastEvent<=1)&&(currentEvent>=1))
            available(1)=available(1)+(sysState==1);
        end;
        if ((lastEvent<=2)&&(currentEvent>=2))
            available(2)=available(2)+(sysState==1);
        end;
        if ((lastEvent<=8)&&(currentEvent>=8))
            available(3)=available(3)+(sysState==1);
        end;
        if ((lastEvent<=20)&&(currentEvent>=20))
            available(4)=available(4)+(sysState==1);
        end;
        if ((lastEvent<=100)&&(currentEvent>=100))
            available(5)=available(5)+(sysState==1);
        end;
        if ((lastEvent<=1000)&&(currentEvent>=1000))
            available(6)=available(6)+(sysState==1);
        end;
        if ((lastEvent<=24*365)&&(currentEvent>=24*365))
            available(7)=available(7)+(sysState==1);
        end;
        if ((lastEvent<=24*365*5)&&(currentEvent>=24*365*5))
            available(8)=available(8)+(sysState==1);
        end;
        if ((lastEvent<=24*365*10)&&(currentEvent>=24*365*10))
            available(9)=available(9)+(sysState==1);
        end;
        if (currentEvent>maxTime)
            break;
        end;
        if (currentEvent==min(hub))
            pos=find(hub==currentEvent,1);
            if (stateOfHub(pos)==1)
                stateOfHub(pos)=2;
                hub(pos)=hub(pos)+ceil(exprnd(lamdaRepair));
                numOfRepair=numOfRepair+1;
                faultTime(currentEvent)=faultTime(currentEvent)+1;
            else
                stateOfHub(pos)=1;
                hub(pos)=hub(pos)+ceil(exprnd(lamdaHardware));
            end;
        elseif (currentEvent==min(master1))
            pos=find(master1==currentEvent,1);
            if (stateOfMaster1(pos)==1)
                stateOfMaster1(pos)=2;
                master1(pos)=master1(pos)+ceil(exprnd(lamdaRepair));
                numOfRepair=numOfRepair+1;
                faultTime(currentEvent)=faultTime(currentEvent)+1;
                if ((pos>=50)&&(rand<0.4))
                    block=1;
                end;
            else
                stateOfMaster1(pos)=1;
                if (pos==1)
                    master1(pos)=master1(pos)+ceil(exprnd(lamdaSoftware));
                else
                    master1(pos)=master1(pos)+ceil(exprnd(lamdaHardware));
                end;
            end;
        elseif (currentEvent==min(master2))
            pos=find(master2==currentEvent,1);
            if (stateOfMaster2(pos)==1)
                stateOfMaster2(pos)=2;
                master2(pos)=master2(pos)+ceil(exprnd(lamdaRepair));
                numOfRepair=numOfRepair+1;
                faultTime(currentEvent)=faultTime(currentEvent)+1;
                if ((pos>=50)&&(rand<0.4))
                    block=1;
                end;
            else
                stateOfMaster2(pos)=1;
                if (pos==1)
                    master2(pos)=master2(pos)+ceil(exprnd(lamdaSoftware));
                else
                    master2(pos)=master2(pos)+ceil(exprnd(lamdaHardware));
                end;
            end;
        elseif (currentEvent==min(slave1))
            pos=find(slave1==currentEvent,1);
            if (stateOfSlave1(pos)==1)
                stateOfSlave1(pos)=2;
                slave1(pos)=slave1(pos)+ceil(exprnd(lamdaRepair));
                numOfRepair=numOfRepair+1;
                faultTime(currentEvent)=faultTime(currentEvent)+1;
                if ((pos>=50)&&(rand<0.4))
                    block=1;
                end;
            else
                stateOfSlave1(pos)=1;
                if (pos==1)
                    slave1(pos)=slave1(pos)+ceil(exprnd(lamdaSoftware));
                else
                    slave1(pos)=slave1(pos)+ceil(exprnd(lamdaHardware));
                end;
            end;
        elseif (currentEvent==min(slave2))
            pos=find(slave2==currentEvent,1);
            if (stateOfSlave2(pos)==1)
                stateOfSlave2(pos)=2;
                slave2(pos)=slave2(pos)+ceil(exprnd(lamdaRepair));
                numOfRepair=numOfRepair+1;
                faultTime(currentEvent)=faultTime(currentEvent)+1;
                if ((pos>=50)&&(rand<0.4))
                    block=1;
                end;
            else
                stateOfSlave2(pos)=1;
                if (pos==1)
                    slave2(pos)=slave2(pos)+ceil(exprnd(lamdaSoftware));
                else
                    slave2(pos)=slave2(pos)+ceil(exprnd(lamdaHardware));
                end;
            end;
        elseif (currentEvent==min(slave3))
            pos=find(slave3==currentEvent,1);
            if (stateOfSlave3(pos)==1)
                stateOfSlave3(pos)=2;
                slave3(pos)=slave3(pos)+ceil(exprnd(lamdaRepair));
                numOfRepair=numOfRepair+1;
                faultTime(currentEvent)=faultTime(currentEvent)+1;
                if ((pos>=50)&&(rand<0.4))
                    block=1;
                end;
            else
                stateOfSlave3(pos)=1;
                if (pos==1)
                    slave3(pos)=slave3(pos)+ceil(exprnd(lamdaSoftware));
                else
                    slave3(pos)=slave3(pos)+ceil(exprnd(lamdaHardware));
                end;
            end;
        end;
        timeOfState(sysState)=timeOfState(sysState)+(currentEvent-lastEvent);
        lastEvent=currentEvent;
        if (any(stateOfHub==2)||any(stateOfMaster1==2)+any(stateOfMaster2==2)>=2||any(stateOfSlave1==2)+any(stateOfSlave2==2)+any(stateOfSlave3==2)>=2||block==1)
            if (sysState~=3)
                numOfFailure=numOfFailure+1;
                sysState=3;
            end;
            timeOfContinuousPerfectFunctioning=timeOfState(1);
            timeOfContinuousNoFailure=timeOfState(1)+timeOfState(2);
        elseif (not(any(stateOfHub==2)||any(stateOfMaster1==2)||any(stateOfMaster2==2)||any(stateOfSlave1==2)||any(stateOfSlave2==2)||any(stateOfSlave3==2)))
            sysState=1;
        else
            if (sysState~=2)
                numOfFault=numOfFault+1;
                sysState=2;
            end;
            timeOfContinuousPerfectFunctioning=timeOfState(1);
        end;
    end;
    timeOfState(sysState)=timeOfState(sysState)+(maxTime-lastEvent);
end;
disp('plot 4: measure 3');
disp('average number of repair:');
disp(numOfRepair/numOfSamples);
disp('average number of fault:');
disp((numOfFault+numOfFailure)/numOfSamples);
disp('average number of failure:');
disp(numOfFailure/numOfSamples);
disp('average time of perfect functioning:');
disp(timeOfState(1)/numOfSamples);
disp('average time of continuous perfect functioning:');
disp(timeOfContinuousPerfectFunctioning/(numOfFault+numOfFailure));
disp('average time of continuous no failure:');
disp(timeOfContinuousNoFailure/numOfFailure);
figure(4);subplot(1,2,1),semilogx(availableTime,available/numOfSamples);
title('plot 4: measure 3');
figure(4);subplot(1,2,2),semilogx(1:24*365*10,faultTime,'LineWidth',5);
title('fault time of plot 4');

%measures 1, 2 and 3
timeOfState=zeros(1,3);
numOfRepair=0;
numOfFault=0;
numOfFailure=0;
timeOfContinuousPerfectFunctioning=0;
timeOfContinuousNoFailure=0;
available=zeros(1,9);
faultTime=zeros(1,24*365*10);
for i =1:numOfSamples
    hub=ceil(exprnd(94500,1,15));
    master1=zeros(1,81);
    master2=zeros(1,81);
    slave1=zeros(1,81);
    slave2=zeros(1,81);
    slave3=zeros(1,81);
    master1(1)=ceil(exprnd(lamdaSoftware));
    master1(2:81)=ceil(exprnd(lamdaHardware,1,80));
    master2(1)=ceil(exprnd(lamdaSoftware));
    master2(2:81)=ceil(exprnd(lamdaHardware,1,80));
    slave1(1)=ceil(exprnd(lamdaSoftware));
    slave1(2:81)=ceil(exprnd(lamdaHardware,1,80));
    slave2(1)=ceil(exprnd(lamdaSoftware));
    slave2(2:81)=ceil(exprnd(lamdaHardware,1,80));
    slave3(1)=ceil(exprnd(lamdaSoftware));
    slave3(2:81)=ceil(exprnd(lamdaHardware,1,80));
    stateOfHub=ones(1,15);
    stateOfMaster1=ones(1,81);
    stateOfMaster2=ones(1,81);
    stateOfSlave1=ones(1,81);
    stateOfSlave2=ones(1,81);
    stateOfSlave3=ones(1,81);
    sysState=1;
    lastEvent=0;
    currentEvent=0;
    while (currentEvent<=maxTime)
        nextEvent=[min(hub),min(master),min(slave1),min(slave2),min(slave3)];
        currentEvent=min(nextEvent);
        if ((lastEvent<=1)&&(currentEvent>=1))
            available(1)=available(1)+(sysState==1);
        end;
        if ((lastEvent<=2)&&(currentEvent>=2))
            available(2)=available(2)+(sysState==1);
        end;
        if ((lastEvent<=8)&&(currentEvent>=8))
            available(3)=available(3)+(sysState==1);
        end;
        if ((lastEvent<=20)&&(currentEvent>=20))
            available(4)=available(4)+(sysState==1);
        end;
        if ((lastEvent<=100)&&(currentEvent>=100))
            available(5)=available(5)+(sysState==1);
        end;
        if ((lastEvent<=1000)&&(currentEvent>=1000))
            available(6)=available(6)+(sysState==1);
        end;
        if ((lastEvent<=24*365)&&(currentEvent>=24*365))
            available(7)=available(7)+(sysState==1);
        end;
        if ((lastEvent<=24*365*5)&&(currentEvent>=24*365*5))
            available(8)=available(8)+(sysState==1);
        end;
        if ((lastEvent<=24*365*10)&&(currentEvent>=24*365*10))
            available(9)=available(9)+(sysState==1);
        end;
        if (currentEvent>maxTime)
            break;
        end;
        if (currentEvent==min(hub))
            pos=find(hub==currentEvent,1);
            if (stateOfHub(pos)==1)
                stateOfHub(pos)=2;
                hub(pos)=hub(pos)+ceil(exprnd(lamdaRepair));
                numOfRepair=numOfRepair+1;
                faultTime(currentEvent)=faultTime(currentEvent)+1;
            else
                stateOfHub(pos)=1;
                hub(pos)=hub(pos)+ceil(exprnd(lamdaHardware));
            end;
        elseif (currentEvent==min(master1))
            pos=find(master1==currentEvent,1);
            if (stateOfMaster1(pos)==1)
                stateOfMaster1(pos)=2;
                if (pos==1)
                    if (rand<0.987)
                        master1(pos)=master1(pos)+ceil(exprnd(lamdaWatchdog));
                    else
                        master1(pos)=master1(pos)+ceil(exprnd(lamdaWatchdog))+ceil(exprnd(lamdaRepair));
                        numOfRepair=numOfRepair+1;
                        faultTime(currentEvent)=faultTime(currentEvent)+1;
                    end;
                else
                    master1(pos)=master1(pos)+ceil(exprnd(lamdaRepair));
                    numOfRepair=numOfRepair+1;
                    faultTime(currentEvent)=faultTime(currentEvent)+1;
                end;
            else
                stateOfMaster1(pos)=1;
                if (pos==1)
                    master1(pos)=master1(pos)+ceil(exprnd(lamdaSoftware));
                else
                    master1(pos)=master1(pos)+ceil(exprnd(lamdaHardware));
                end;
            end;
        elseif (currentEvent==min(master2))
            pos=find(master2==currentEvent,1);
            if (stateOfMaster2(pos)==1)
                stateOfMaster2(pos)=2;
                if (pos==1)
                    if (rand<0.987)
                        master2(pos)=master2(pos)+ceil(exprnd(lamdaWatchdog));
                    else
                        master2(pos)=master2(pos)+ceil(exprnd(lamdaWatchdog))+ceil(exprnd(lamdaRepair));
                        numOfRepair=numOfRepair+1;
                        faultTime(currentEvent)=faultTime(currentEvent)+1;
                    end;
                else
                    master2(pos)=master2(pos)+ceil(exprnd(lamdaRepair));
                    numOfRepair=numOfRepair+1;
                    faultTime(currentEvent)=faultTime(currentEvent)+1;
                end;
            else
                stateOfMaster2(pos)=1;
                if (pos==1)
                    master2(pos)=master2(pos)+ceil(exprnd(lamdaSoftware));
                else
                    master2(pos)=master2(pos)+ceil(exprnd(lamdaHardware));
                end;
            end;
        elseif (currentEvent==min(slave1))
            pos=find(slave1==currentEvent,1);
            if (stateOfSlave1(pos)==1)
                stateOfSlave1(pos)=2;
                if (pos==1)
                    if (rand<0.987)
                        slave1(pos)=slave1(pos)+ceil(exprnd(lamdaWatchdog));
                    else
                        slave1(pos)=slave1(pos)+ceil(exprnd(lamdaWatchdog))+ceil(exprnd(lamdaRepair));
                        numOfRepair=numOfRepair+1;
                        faultTime(currentEvent)=faultTime(currentEvent)+1;
                    end;
                else
                    slave1(pos)=slave1(pos)+ceil(exprnd(lamdaRepair));
                    numOfRepair=numOfRepair+1;
                    faultTime(currentEvent)=faultTime(currentEvent)+1;
                end;
            else
                stateOfSlave1(pos)=1;
                if (pos==1)
                    slave1(pos)=slave1(pos)+ceil(exprnd(lamdaSoftware));
                else
                    slave1(pos)=slave1(pos)+ceil(exprnd(lamdaHardware));
                end;
            end;
        elseif (currentEvent==min(slave2))
            pos=find(slave2==currentEvent,1);
            if (stateOfSlave2(pos)==1)
                stateOfSlave2(pos)=2;
                if (pos==1)
                    if (rand<0.987)
                        slave2(pos)=slave2(pos)+ceil(exprnd(lamdaWatchdog));
                    else
                        slave2(pos)=slave2(pos)+ceil(exprnd(lamdaWatchdog))+ceil(exprnd(lamdaRepair));
                        numOfRepair=numOfRepair+1;
                        faultTime(currentEvent)=faultTime(currentEvent)+1;
                    end;
                else
                    slave2(pos)=slave2(pos)+ceil(exprnd(lamdaRepair));
                    numOfRepair=numOfRepair+1;
                    faultTime(currentEvent)=faultTime(currentEvent)+1;
                end;
            else
                stateOfSlave2(pos)=1;
                if (pos==1)
                    slave2(pos)=slave2(pos)+ceil(exprnd(lamdaSoftware));
                else
                    slave2(pos)=slave2(pos)+ceil(exprnd(lamdaHardware));
                end;
            end;
        elseif (currentEvent==min(slave3))
            pos=find(slave3==currentEvent,1);
            if (stateOfSlave3(pos)==1)
                stateOfSlave3(pos)=2;
                if (pos==1)
                    if (rand<0.987)
                        slave3(pos)=slave3(pos)+ceil(exprnd(lamdaWatchdog));
                    else
                        slave3(pos)=slave3(pos)+ceil(exprnd(lamdaWatchdog))+ceil(exprnd(lamdaRepair));
                        numOfRepair=numOfRepair+1;
                        faultTime(currentEvent)=faultTime(currentEvent)+1;
                    end;
                else
                    slave3(pos)=slave3(pos)+ceil(exprnd(lamdaRepair));
                    numOfRepair=numOfRepair+1;
                    faultTime(currentEvent)=faultTime(currentEvent)+1;
                end;
            else
                stateOfSlave3(pos)=1;
                if (pos==1)
                    slave3(pos)=slave3(pos)+ceil(exprnd(lamdaSoftware));
                else
                    slave3(pos)=slave3(pos)+ceil(exprnd(lamdaHardware));
                end;
            end;
        end;
        timeOfState(sysState)=timeOfState(sysState)+(currentEvent-lastEvent);
        lastEvent=currentEvent;
        if (any(stateOfHub==2)||any(stateOfMaster1==2)+any(stateOfMaster2==2)>=2||any(stateOfSlave1==2)+any(stateOfSlave2==2)+any(stateOfSlave3==2)>=2)
            if (sysState~=3)
                numOfFailure=numOfFailure+1;
                sysState=3;
            end;
            timeOfContinuousPerfectFunctioning=timeOfState(1);
            timeOfContinuousNoFailure=timeOfState(1)+timeOfState(2);
        elseif (not(any(stateOfHub==2)||any(stateOfMaster1==2)||any(stateOfMaster2==2)||any(stateOfSlave1==2)||any(stateOfSlave2==2)||any(stateOfSlave3==2)))
            sysState=1;
        else
            if (sysState~=2)
                numOfFault=numOfFault+1;
                sysState=2;
            end;
            timeOfContinuousPerfectFunctioning=timeOfState(1);
        end;
    end;
    timeOfState(sysState)=timeOfState(sysState)+(maxTime-lastEvent);
end;
disp('plot 5: measures 1, 2 and 3');
disp('average number of repair:');
disp(numOfRepair/numOfSamples);
disp('average number of fault:');
disp((numOfFault+numOfFailure)/numOfSamples);
disp('average number of failure:');
disp(numOfFailure/numOfSamples);
disp('average time of perfect functioning:');
disp(timeOfState(1)/numOfSamples);
disp('average time of continuous perfect functioning:');
disp(timeOfContinuousPerfectFunctioning/(numOfFault+numOfFailure));
disp('average time of continuous no failure:');
disp(timeOfContinuousNoFailure/numOfFailure);
figure(5);subplot(1,2,1),semilogx(availableTime,available/numOfSamples);
title('plot 5: measures 1, 2 and 3');
figure(5);subplot(1,2,2),semilogx(1:24*365*10,faultTime,'LineWidth',5);
title('fault time of plot 5');

hold off;
toc;