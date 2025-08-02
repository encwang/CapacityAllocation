load(['Record1.mat'])
figure
plot(1:0.1:5, Record1(:,2), 'black')
hold on
plot(1:0.1:5, Record1(:,1), 'black--')
xlabel('$\lambda_u$','Interpreter','latex','FontSize',25)
% legend('$f^*_{c_u}$','$f^*_{dp}$','Interpreter','latex','FontSize',17, 'Location', 'southeast')
legend('$\mathcal{C}^*$','$\mathcal{C}^*_{\mbox{2-cutoff}}$','Interpreter','latex','FontSize',25, 'Location', 'southeast')
xlim([1,5])

figure
plot(1:0.1:5, Record1(:,2)./Record1(:,1), 'black')
xlabel('$\lambda_u$','Interpreter','latex','FontSize',25)
ylabel('$\mathcal{C}^*/\mathcal{C}^*_{\mbox{2-cutoff}}$','Interpreter','latex','FontSize',25)
xlim([1,5])
ylim([0.84,1])

load('Record2.mat')
figure
plot(1:0.1:20, Record2(:,2), 'black')
hold on
plot(1:0.1:20, Record2(:,1), 'black--')
xlabel('$C_o$','Interpreter','latex','FontSize',25)
% legend('$f^*_{c_u}$','$f^*_{dp}$','Interpreter','latex','FontSize',17, 'Location', 'southeast')
legend('$\mathcal{C}^*$','$\mathcal{C}^*_{\mbox{2-cutoff}}$','Interpreter','latex','FontSize',25, 'Location', 'southeast')
xlim([1,20])

figure
plot(1:0.1:20, Record2(:,2)./Record2(:,1), 'black')
xlabel('$C_o$','Interpreter','latex','FontSize',25)
ylabel('$\mathcal{C}^*/\mathcal{C}^*_{\mbox{2-cutoff}}$','Interpreter','latex','FontSize',25)
xlim([1,20])
ylim([0.65,1])