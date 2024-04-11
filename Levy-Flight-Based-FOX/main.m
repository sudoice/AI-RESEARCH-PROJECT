% %
%%FOX
% LFFOX: A Levy Flight Based Fox-inspired Optimization Algorithm
% Authors: Tripti Gusain, Himanshi, Sanya Garg
%%

clear all 
clc
summ=0;
avg=0;
 for i=1:50
    SearchAgents_no=30; % Number of search agents
    %30, cec01, max it=100
    Function_name='F7'; % Name of the test function that can be from 1 to 10
    
    Max_iteration=2000; % Maximum numbef of iterations
    
    % Load details of the selected benchmark function
    [lb,ub,dim,fobj]=CEC2014(Function_name);
    [Best_score,Best_pos]=FOX_Levy(SearchAgents_no,Max_iteration,lb,ub,dim,fobj);
    
    
    display(num2str(Best_score));
           
    
    summ=summ+Best_score;
 end
 avg=summ/50;
 [avg]
