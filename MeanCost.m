function [y MeanQ MeanO] = MeanCost(Co, Cw, lmbu, lmbr, c, cu)

% clear
% clc
% Co = 10;
% Cw = 1;
M = 1000; % M is the truncation level for the queue size
N = 50; % N is the truncation level for urgent patients
% lmbr = 15;
% lmbu = 5;
% c = 20; % total capacity
% cu = 2; 
cr = c- cu;
P = TransitionMatrix(lmbr, lmbu, M, cr);
A = eye(M+1)-P; A(:,end)=ones(M+1,1); b = [zeros(1,M) 1];
PI = b*inv(A); % PI is the stationary distribution of the queue

PoverflowRecord = [];
for indQ = 1:M+1 
    Poverflow = zeros(1,N-cu); % store the probability for every overlow number from 1:M-cu
    q = indQ-1;
    if q <= cr
        QLeft = cr-q;
        for OverFlowNum = 1:N-cu
            for RoutineNum = 0:QLeft
                if RoutineNum < QLeft
                    Poverflow(OverFlowNum) = Poverflow(OverFlowNum) + poisspdf(RoutineNum, lmbr)*poisspdf(QLeft-RoutineNum+cu+OverFlowNum, lmbu);
                else
                    Poverflow(OverFlowNum) = Poverflow(OverFlowNum) + (1-poisscdf(RoutineNum-1, lmbr))*poisspdf(cu+OverFlowNum, lmbu);
                end
            end
        end
    else
        for OverFlowNum = 1:N-cu
            Poverflow(OverFlowNum) = Poverflow(OverFlowNum) + poisspdf(cu+OverFlowNum, lmbu);
        end
    end
    PoverflowRecord = [PoverflowRecord; Poverflow];
end

MeanQ = sum(PI.*(0:M));
MeanO = 0;
for k = 1:M+1
    MeanO = MeanO + sum(PoverflowRecord(k,:).*(1:N-cu))*PI(k);
end
% MeanQ
% MeanO
% MeanCost = MeanQ + H * MeanO
y = Cw * MeanQ + Co * MeanO;
