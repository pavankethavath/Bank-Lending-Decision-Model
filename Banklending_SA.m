%
%   Name: Kethavath Pavan Chandra
%   Roll No: 19IM30012
%   Subject: Term Project (Optimization of Bank Lending Decisions)
%   Simulated Annealing

%--------------------------  --------------------------
clear
clc
%Converting the maximizing problem into minimizing problem
%SA Parameters
T_init = 1000; %Initial Temperature 
max_iterations = 50; %Maximum Number of iterations at each temperature 
k = 1; %Boltzman constant
T_min = 0.1; %Minimum temperature for cooling
alpha= 0.9; %cooling factor

%Initialization
max_rej= 250; %Maximum Number of Rejections
max_accept= 80; %Maximum Number of Acceptions
lc = 10; %length of chomosome as there are 10 customers
K = 0.15; %Reserved_ratio
D = 60; %Available deposit
r_D = 0.009; %Weighted average of all deposits
Loan_size = [10,25,4,11,18,3,17,15,9,10]; %L
Interest = [0.021,0.022,0.021,0.027,0.025,0.026,0.023,0.021,0.028,0.022]; %r_L
Loss = [0.0002,0.0058,0.001,0.0003,0.0024,0.0002,0.0058,0.0002,0.001,0.001]; %lambda
Beta = r_D*D;
Init_sol = [];
fitness_val = [];

%Random initial solution
while height(Init_sol) < 10
    temp = randi([0 1],1,lc);
    temp_Value = dot(temp,Loan_size);
    if temp_Value <= (1-K)*D
        Init_sol = [Init_sol;temp];
        fitness_val = [fitness_val,fitness(temp)]; 
    end
end

%Best among those initialised solutions
[h,k] = min(fitness_val);
Action_list = Set_Actionlist(lc);
list_size = numel(Action_list);
Parent_sol = Init_sol(k,:);
Parent_fitness = fitness_val(k);
Best_sol = [Parent_sol,Parent_fitness];
i = 1; accept = 0; reject = 0; T = T_init;

while(T > T_min)
    %Finding the neighborhood solution 
    r = randi(list_size);
    nbd_sol = DoAction(Parent_sol,Action_list{r});
    Delta_fitness = fitness(nbd_sol) - Parent_fitness ;
    
    %To check for feasibility
    if (dot(nbd_sol,Loan_size) <= (1-K)*D)
        if Delta_fitness < 0
            Parent_sol = nbd_sol;
            accept = accept+1;
        end
        if (Delta_fitness >= 0 && exp(-(Delta_fitness)/(k*T)) > rand)
            Parent_sol = nbd_sol;
            accept = accept +1;
        else
            reject = reject +1;
        end
        i = i+1;
    end
    if Parent_fitness > fitness(Parent_sol)
        Parent_fitness = fitness(Parent_sol);
        Best_sol = [Parent_sol,Parent_fitness];
    end
    if((i>=max_iterations) || (accept<max_accept) )
        %reset counters
        i=1;
        accept =0;
        %cooling according to cooling schedule
        T=alpha*T;
    end
end
Loan_amount_sanctioned_SA = dot(Best_sol(1:10),Loan_size)
for i = 1:10
    if Best_sol(i) == 1
        fprintf('Bank has lent a loan amount of %d to customer %d\n',Loan_size(i),i);
    end
end
fprintf('The nearest optimal decision is (%d,%d,%d,%d,%d,%d,%d,%d,%d,%d)\nAnd fitness value %f\n',Best_sol(1:10),-Best_sol(lc+1));
