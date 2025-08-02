Record1 = [];
Co = 10;
Cw = 1;
c = 20;
for lambdau = 1:0.1: 2
    [ExpCost, hh1, hh2] = OptimalTwoCutoffPolicy(Co, Cw, lambdau, 20-lambdau, c);
    tmp = ExpCost;
    y = CostDP(Co, Cw, lambdau, 20-lambdau, c);
    tmp = [tmp y];
    lambdau
    Record1 = [Record1; tmp]
end
save("R1_1-2")
