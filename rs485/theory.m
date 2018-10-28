lamdaHardware=-1/94500;
lamdaSoftware=-1/4700;
lamdaRepair=-1/10;
lamdaWatchdog=-1/1;
available=zeros(1,5);

%no mearsures
hardwareState1=(1-exp(lamdaRepair))/(1-exp(lamdaHardware)+1-exp(lamdaRepair));
hardwareState2=(1-exp(lamdaHardware))/(1-exp(lamdaHardware)+1-exp(lamdaRepair));
softwareState1=(1-exp(lamdaRepair))/(1-exp(lamdaSoftware)+1-exp(lamdaRepair));
softwareState2=(1-exp(lamdaSoftware))/(1-exp(lamdaSoftware)+1-exp(lamdaRepair));
hubState1=hardwareState1^15;
hubState2=1-hubState1;
controlState1=hardwareState1^48;
controlState2=1-controlState1;
interfaceState1=hardwareState1^25;
interfaceState3=1-(1-hardwareState2*0.4)^25;
interfaceState2=1-interfaceState1-interfaceState3;
machineState1=softwareState1*controlState1*interfaceState1;
machineState3=interfaceState3;
machineState2=1-machineState1-machineState3;
available(1)=hubState1*machineState1*(machineState1^3+machineState1^2*machineState2*3);

%measure 1
softwareState1=1/(0.013/(1-exp(-0.1))+1/(1-exp(-1))+1/(1-exp(-1/4700)))/(1-exp(-1/4700));
softwareState2=1-softwareState1;
machineState1=softwareState1*controlState1*interfaceState1;
machineState3=interfaceState3;
machineState2=1-machineState1-machineState3;
available(2)=hubState1*machineState1*(machineState1^3+machineState1^2*machineState2*3);

%measure 2
softwareState1=(1-exp(lamdaRepair))/(1-exp(lamdaSoftware)+1-exp(lamdaRepair));
softwareState2=(1-exp(lamdaSoftware))/(1-exp(lamdaSoftware)+1-exp(lamdaRepair));
interfaceState1=hardwareState1^32;
interfaceState2=1-interfaceState1;
machineState1=softwareState1*controlState1*interfaceState1;
machineState2=1-machineState1;
available(3)=hubState1*machineState1*(machineState1^3+machineState1^2*machineState2*3);

%measure 3
interfaceState1=hardwareState1^25;
interfaceState3=1-(1-hardwareState2*0.4)^25;
interfaceState2=1-interfaceState1-interfaceState3;
machineState1=softwareState1*controlState1*interfaceState1;
machineState3=interfaceState3;
machineState2=1-machineState1-machineState3;
available(4)=hubState1*(machineState1^2+machineState1*machineState2*2)*(machineState1^3+machineState1^2*machineState2*3);

%measures 1, 2 and 3
softwareState1=1/(0.013/(1-exp(-0.1))+1/(1-exp(-1))+1/(1-exp(-1/4700)))/(1-exp(-1/4700));
softwareState2=1-softwareState1;
interfaceState1=hardwareState1^32;
interfaceState2=1-interfaceState1;
machineState1=softwareState1*controlState1*interfaceState1;
machineState2=1-machineState1;
available(5)=hubState1*(machineState1^2+machineState1*machineState2*2)*(machineState1^3+machineState1^2*machineState2*3);

disp('plot 1: no measures:');
disp(available(1));
disp('plot 2: measure 1:');
disp(available(2));
disp('plot3: measure 2:');
disp(available(3));
disp('plot 4: measure 3:');
disp(available(4));
disp('plot 5: measures 1, 2 and 3:');
disp(available(5));
