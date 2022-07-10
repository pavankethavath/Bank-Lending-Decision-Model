%
%   Name: Kethavath Pavan Chandra
%   Roll No: 19IM30012
%   Subject: Term Project (Optimization of Bank Lending Decisions)
%
%--------------------------  --------------------------


function q=DoAction(p,a)
    if a(1)==1
        q=DoSwap(p,a(2),a(3));
    end
    if a(1)==2
        q=DoReversion(p,a(2),a(3));
    end       
    if a(1)==3
        q=DoInsertion(p,a(2),a(3));
    end   
end