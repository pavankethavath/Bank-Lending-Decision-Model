%
%   Name: Kethavath Pavan Chandra
%   Roll No: 19IM30012
%   Subject: Term Project (Optimization of Bank Lending Decisions)
%   Genetic Algorithm

%--------------------------  --------------------------

clear
clc
%GA Parameters
Pop_size = 10;
crossover_prob=0.8;
mutation_prob=0.006;
maximum_iterations=50;% Maximum No. of iterations

%Initialisation
lc = 10; %length of chomosome as there are 10 customers
K = 0.15; %Reserved_ratio
D = 60; %Available deposit
r_D = 0.009; %Weighted average of all deposits
Loan_size = [10,25,4,11,18,3,17,15,9,10]; %L
Interest = [0.021,0.022,0.021,0.027,0.025,0.026,0.023,0.021,0.028,0.022]; %r_L
Loss = [0.0002,0.0058,0.001,0.0003,0.0024,0.0002,0.0058,0.0002,0.001,0.001]; %lambda
Beta = r_D*D;

%GA validation process and fitness value
Init_sol = [];
fitness_val = [];
while height(Init_sol) < Pop_size
    temp = randi([0 1],1,lc);
    temp_Value = dot(temp,Loan_size);
    if temp_Value <= (1-K)*D
        Init_sol = [Init_sol;temp];
        fitness_val = [fitness_val,-1*fitness(temp)]; 
    end
end

%To find the best solution
[h,k]=max(fitness_val);
%To store the Best solution
Best_sol = [Init_sol(k,:),h];
Parents = Init_sol; %To perform crossover
Generation = Init_sol; %To have the data of the actual parents

%Iterations
for q=1:maximum_iterations
    %Roulette Wheel Selection
    f_total=sum(fitness_val);
    cum_fitness_val=[];
    cum_fitness_val(1)=fitness_val(1);
    for j=2:Pop_size
        cum_fitness_val(j)=fitness_val(j)+cum_fitness_val(j-1);
    end
    Roulette_val=cum_fitness_val/f_total;
    %Random selction of 2 parents for crossover and mutation
    selected = zeros(1,2);
    Offsprings = [];
    while (height(Offsprings)<= Pop_size)
        for i = 1:2
            r = rand;
            z = 1;
            while (r>Roulette_val(z))
                z = z+1;               
            end
            selected(i) = z;
        end
        %Crossover
        crossover_rn=rand; %random number is generated for a selected parent pair
        if crossover_rn<=crossover_prob %Crossover takes place
            Point_rn=randi(lc-1); %randomly select a point for crossover
            Parents(selected(1),(Point_rn+1):lc)=Parents(selected(2),(Point_rn+1):lc);
            Parents(selected(2),(Point_rn+1):lc)=Parents(selected(1),(Point_rn+1):lc);
        else %No crossover which means parents are smae as offsprings
        end
        %Mutation
        for i=1:2
            for y=1:lc
                mutation_rn=rand; %random number is generated for yth bit of nth individual
                if (mutation_rn<mutation_prob) %mutation takes place
                    Parents(selected(i),y)=abs(Parents(selected(i),y)-1);% to flip the entries of solution
                end
            end
        end
        for i = 1:2
            temp_Value = dot(Parents(selected(i),:),Loan_size);
            if (temp_Value <= (1-K)*D) && (height(Offsprings) <Pop_size)
                Offsprings = [Offsprings;Parents(selected(i),:)];
            end
        end
        
        Parents = Generation;
        if height(Offsprings) == Pop_size
            break;
        end
    end
    Parents = Offsprings;
    Generation = Offsprings;
    
    %To find fitness of next generation
    for i = 1:Pop_size
        fitness_val(i) = -1*fitness(Offsprings(i,:));
    end
    
    %To find best solution
    [h,k]=max(fitness_val);
    Best_sol = [Best_sol;Offsprings(k,:),h];
end
[t,c] = max(Best_sol(:,lc+1));
Loan_amount_sanctioned_GA = dot(Best_sol(c,1:lc),Loan_size)
for i = 1:10
    if Best_sol(c,i) == 1
        fprintf('Bank has lent a loan amount of %d to customer %d\n',Loan_size(i),i);
    end
end
fprintf('The nearest optimal decision is (%d,%d,%d,%d,%d,%d,%d,%d,%d,%d)\nAnd fitness value %f\n',Best_sol(c,1:10),Best_sol(c,lc+1));
