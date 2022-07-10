%
%   Name: Kethavath Pavan Chandra
%   Roll No: 19IM30012
%   Subject: Term Project (Optimization of Bank Lending Decisions)
%
%--------------------------  --------------------------


function q=DoReversion(p,i1,i2)
    
    q=p;
    q(i1:i2)=fliplr(p(i1:i2));
    
end