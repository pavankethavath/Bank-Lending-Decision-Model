%
%   Name: Kethavath Pavan Chandra
%   Roll No: 19IM30012
%   Subject: Term Project (Optimization of Bank Lending Decisions)
%
%--------------------------  --------------------------

function q=DoInsertion(p,i1,i2)
    q=p;
    if i1<i2
        d=p(i1:i2-1);
        d=[p(i2) d];
        q(i1:i2)=d;
    end
    if i1>i2
        d=p(i2+1:i1);
        d=[d p(i2)];
        q(i2:i1)=d;
    end
end