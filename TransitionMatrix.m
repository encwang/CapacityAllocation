function P = TransitionMatrix(lmbr, lmbu, M, cr)

% M is the truncation level
P = zeros(M+1,M+1);
% for every column
for k = 1:M+1
    qSize = k-1;
    for kLine = 1:M+1
        QSize = kLine-1;
%         cu = CapacityNum(qSize);
        if kLine <= cr + qSize + 1
            if k == 1
                P(kLine,k) = poisscdf(cr - QSize,lmbr);
            else
                P(kLine,k) = poisspdf(qSize - QSize + cr,lmbr);
            end
        end
    end
end

 