function [y yind] = Costcu(Co, Cw, lmbu, lmbr, c)
% this is the optimal cost 

CostRecord = [];
for cu = 0:floor(c/2)
    tmp = MeanCost(Co, Cw, lmbu, lmbr, c, cu);
    CostRecord = [CostRecord tmp];
end

[y yind] = min(CostRecord);
yind = yind - 1;