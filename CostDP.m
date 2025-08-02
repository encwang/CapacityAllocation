function y = CostDP(Co, Cw, lambdau, lambdar, c)
% clear
% clc
% lambdau = 2;
% lambdar = 18;
K = 50; % poisson limit for urgent 
N = 120; % poisson limit for routine 
% c = 20; % c is the total capacity
% Co = 10;
% Cw = 1;
cStarU = 1;
cStarL = 0;
A = zeros(N+1,1);
Vpre = zeros(N+1,1);
V = randn(N+1,1);
cStarU = max(V-Vpre);
cStarL = min(V-Vpre);
while ((cStarU - cStarL)> 0.0001)
    Vpre = V;
    clear Q
    Q = cell(1,N+1);
    for q = 0:N
        for a = 0:q
            if a < c % if the number of assigned routine customers 
                ctmp = (Co * sum(poisspdf(c-a:K,lambdau).*(0:K-(c-a))) ...
                    + Cw * (q-a)...
                    + poisspdf(0:N,lambdar) * ([Vpre(q-a+1:N+1); ones(q-a,1)*Vpre(N+1)])); % +(1:q-a)' must use Vpre!!! in this average cost case!!!
            else
                ctmp = (Co * sum(poisspdf(0:K,lambdau).*((a-c):(K+(a-c)))) ...
                    + Cw * (q-a) ...
                    + poisspdf(0:N,lambdar) * ([Vpre(q-a+1:N+1); ones(q-a,1)*Vpre(N+1)])); % +(1:q-a)' must use Vpre!!! in this average cost case!!!
            end
%             ctmp = ctmp + poisspdf(0:N-(q-a),lambdar) * (V(q-a+1:N+1) + Cw * (q-a:N)');
            Q{1, q+1} = [Q{1, q+1} ctmp];
        end
        [V(q+1), A(q+1)] = min(Q{q+1});
        A(q+1) = A(q+1) - 1;
    end
    cStarU = max(V-Vpre);
    cStarL = min(V-Vpre);
    V = V-V(1);
end
y = cStarU;
% plot(V)
% hold on
plot(0:100, A(1:101),'.-')
xlabel('Queue length $q$', Interpreter='latex', FontSize=17)
ylabel('The number of routine patients to serve', FontSize=15)
% xlabel('queue size')
% ylabel('the number to be served today')
ylim([0,100])
% hold on
% line([0,100],[20,20],'linestyle','-','color','r')