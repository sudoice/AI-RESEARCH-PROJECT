%------------------------------------
% Balanced Teaching Learning Based Optimization (BTLBO)
% 
%------------------------------------
clear;
clc;
%%            settings 

   nPop=50;         % Population Size
   D = 30;               % Dim
   MaxFEs= 300000;       % Maximum number of function evaluations
   NumofExper = 2;   % Number of test
  % Benchmark = 3;  % 1:Classic 2:CEC2005 3:CEC2014 
   Func_id = 1; % CEC2014 1~30 / CEC2005 1~25 / Classic 1~22
   %FileName = [ FileName ' D30_NFE300K_30t ']; 

% =====================================================================================

Opt = zeros(1,30); % 
 global initial_flag
  initial_flag = 0;
%% 
Function_name=['F' num2str(Func_id)];
%========== CEC2014 ==========
fhd=str2func('cec14_func');
CostFunction=Func_id;
LB=-100;%lb;
UB=100;%ub;
Opt = 100:100:3000;
%================
 

% Empty Solution Structure
empty_Solution.Position=[];
empty_Solution.Cost=[];

% Initialize Harmony Memory
Population=repmat(empty_Solution,nPop,1);


%% TLBO
SumBestCostBTLBO_=zeros(MaxFEs,1);
BestSolCostBTLBO= []; %zeros(MaxFEs,1);
SumBestCostTLBO_=zeros(MaxFEs,1);
BestSolCostTLBO= []; %zeros(MaxFEs,1);

%===================================================

for ii=1:NumofExper
    
 
   rand('state',sum(100*clock));
  initial_flag = 0; % should set the flag to 0 for each run, each function
  
   % Create Initial Population
for i=1:nPop
   
    Population(i).Position=LB+rand(1,D).*(UB-LB);
    
    Population(i).Cost= feval(fhd,Population(i).Position',CostFunction) -  (CostFunction*100); % CEC2014 F(X) - F(X*)
   
end  
    
   %% 

[BestCostRTLBO_,BestSolCostBTLBO(ii)]=BTLBO_Algorithm(D,MaxFEs,LB,UB,Population,nPop,CostFunction);  
SumBestCostBTLBO_=SumBestCostBTLBO_+ BestCostRTLBO_(1:MaxFEs);

end


AveBestCostTLBO_=SumBestCostTLBO_ ./ NumofExper;
AveBestCostBTLBO_=SumBestCostBTLBO_ ./ NumofExper;
%% 
% Mean(1,1) = mean(BestSolCostTLBO);
Mean(1,2)=mean(BestSolCostBTLBO);

% SD(1,1)=std(BestSolCostTLBO);
SD(1,2)=std(BestSolCostBTLBO);

%filename=['BTLBO Result ' FileName ' _' Function_name '.mat']
%save(filename);
f1=figure;
semilogy(AveBestCostBTLBO_,'r-','LineWidth',2);
%hold on;
%semilogy(AveBestCostTLBO_,'b-','LineWidth',2);
grid on;
hold off;
xlabel('FEs');
str=['F(x) = ' Function_name];
ylabel(str);
%legend('BTLBO','TLBO');
legend('BTLBO');