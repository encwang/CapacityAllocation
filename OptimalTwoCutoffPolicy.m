function [ExpCost, hh1, hh2] = OptimalTwoCutoffPolicy(Co, Cw, lambdau, lambdar, c)

ExpCostRecord = [];
h1List = 1:c;
LengthH1 = length(h1List);
h2List = c+1:40;
LengthH2 = length(h2List);
for ind1 = 1:LengthH1
    h1 = h1List(ind1);
    a = [];
    for ind2 = 1:LengthH2
        h2 = h2List(ind2);
        ExpCost = TwoCutoffPolicy(Co, Cw, lambdau, lambdar, c, h1, h2);
        a = [a ExpCost];
    end
    ExpCostRecord = [ExpCostRecord; a];
end

[row, col] = find(ismember(ExpCostRecord, min(ExpCostRecord(:))));
hh1 = h1List(row);
hh2 = h2List(col);
ExpCost = min(min(ExpCostRecord(:)));
end