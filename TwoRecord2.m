Record2 = [];
lambdau = 3;
lambdar = 20-lambdau;
Cw = 1;
c = 20;
for Co = 1:0.1: 20
    [ExpCost, hh1, hh2] = OptimalTwoCutoffPolicy(Co, Cw, lambdau, lambdar, c);
    tmp = ExpCost;
    y = CostDP(Co, Cw, lambdau, lambdar, c);
    tmp = [tmp y];
    Record2 = [Record2; tmp];
end
save("R2")
