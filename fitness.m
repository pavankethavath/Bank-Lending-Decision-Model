%
%   Name: Kethavath Pavan Chandra
%   Roll No: 19IM30012
%   Subject: Term Project (Optimization of Bank Lending Decisions)
%
%--------------------------  --------------------------

function z = fitness(temp)
K = 0.15; %Reserved_ratio
D = 60; %Available deposit
r_D = 0.009; %Weighted average of all deposits
Loan_size = [10,25,4,11,18,3,17,15,9,10]; %L
Interest = [0.021,0.022,0.021,0.027,0.025,0.026,0.023,0.021,0.028,0.022]; %r_L
Loss = [0.0002,0.0058,0.001,0.0003,0.0024,0.0002,0.0058,0.0002,0.001,0.001]; %lambda
Beta = r_D*D;

z = -1*(sum((Interest.*Loan_size).*temp) - sum(Loss.*temp) + (1-K)*D*sum(Interest.*temp)-sum((Interest.*Loan_size).*temp) - Beta - sum(Loss.*temp)); 
   
end