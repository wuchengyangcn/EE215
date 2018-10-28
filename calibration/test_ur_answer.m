%%%%%%% 答案检验程序 2016-9-04 %%%%%%%% 

my_answer=[6    20    35    42    81    88];%把你的选点组合填写在此
my_answer_n=size(my_answer,2);

% 标准样本原始数据读入
minput=dlmread('dataform20160902.csv');
[M,N]=size(minput);
Nsample=M/2; Npoint=N;
volt=zeros(Nsample,Npoint);
tempr=zeros(Nsample,Npoint);
est_tempr=zeros(Nsample,Npoint);
for i=1:Nsample
    volt(i,:)=minput(2*i,:);
    tempr(i,:)=minput(2*i-1,:);
end

% 定标计算
for j=1:Nsample
    premea_volt=volt(j,my_answer);
    premea_tempr=tempr(j,my_answer);
    % 请把你的定标计算方法写入函数mycurvefitting
    est_tempr(j,:)=my_spline(premea_volt,premea_tempr,volt(j,:));
end
    
% 成本计算
Q=50;
errabs=abs(tempr-est_tempr);

le0_5=(errabs<=0.5);
le1_0=(errabs<=1.0);
le1_5=(errabs<=1.5);
le2_0=(errabs<=2);
g2_0=(errabs>2);

sij=1*(le1_0-le0_5)+4*(le1_5-le1_0)+10*(le2_0-le1_5)+10000*g2_0;
si=sum(sij,2)+Q*ones(Nsample,1)*length(my_answer);
cost=sum(si)/Nsample;

% 显示结果
fprintf('\n经计算，你的答案对应的总体成本为%5.2f\n',cost);
