function ExpCost = TwoCutoffPolicy(Co, Cw, lambdau, lambdar, c, h1, h2)

% %%%%%%%% Set the two thresholds %%%%%%%%
% c = 20;
% h1 = c-3;
% h2 = c+5;
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

A = [];
% lambdar = 19;
% lambdau = 1;
Ku = 100;
Kr = 100;
% Cw = 1;
% Co = 10;
%%%%%%%% The Transition matrix %%%%%%%%
for k = 0:h2-h1
    a = [];
    a = poisscdf(h1-k , lambdar);
    for kk = 1:h2-h1-1
        a = [a poisspdf(h1-k+kk , lambdar)];
    end
    a = [a 1-poisscdf(h2-k-1 , lambdar)];
    A = [A ; a];
end

B = eye(h2-h1+1)-A; B(:,end) = ones(h2-h1+1,1); b = [zeros(1,h2-h1) 1];
PI = b*inv(B);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% Calculate the expected cost %%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

overflowRecord = [];
qCostRecord = [];
for q = 0 : h1
    overflow = 0;
    qCost = 0;

    for nr = 0 : h1-q
        overflow = overflow + poisspdf(nr,lambdar) * sum(poisspdf(c-nr-q:Ku,lambdau).* (0:nr+q-c+Ku));
    end

    for nr = h1-q+1 : h2-q
        overflow = overflow + poisspdf(nr,lambdar) * sum(poisspdf(c-h1:Ku,lambdau).* (0:h1-c+Ku));
        qCost = qCost + poisspdf(nr,lambdar) * (nr+q-h1);
    end

    for nr = h2-q+1:Kr
        overflow = overflow + poisspdf(nr,lambdar) * sum(poisspdf(0:Ku,lambdau).* (nr+q-h2:nr+q-h2+Ku));
        qCost = qCost + poisspdf(nr,lambdar) * (h2-h1);
    end

    overflowRecord  = [overflowRecord overflow];
    qCostRecord = [qCostRecord qCost];

end

for q = h1+1 : h2
    overflow = 0;

    for nr = 0 : h2-q
        overflow = overflow + poisspdf(nr,lambdar) * sum(poisspdf(c-h1:Ku,lambdau).* (0:h1-c+Ku));
        qCost = qCost + poisspdf(nr,lambdar) * (nr+q-h1);
    end

    for nr = h2-q+1 : Kr
        overflow = overflow + poisspdf(nr,lambdar) * sum(poisspdf(0:Ku,lambdau).* (nr+q-h2:nr+q-h2+Ku));
        qCost = qCost + poisspdf(nr,lambdar) * (h2-h1);
    end

    overflowRecord  = [overflowRecord overflow];
    qCostRecord = [qCostRecord qCost];

end

overflowRecordCut = overflowRecord(1:h2-h1+1);
qCostRecordCut = qCostRecord(1:h2-h1+1);

% ExpCost = Co * sum(PI.*overflowRecordCut) + Cw * sum(PI.*qCostRecordCut);

ExpCost = Co * sum(PI.*overflowRecordCut) + Cw * sum(PI.*(0:h2-h1));