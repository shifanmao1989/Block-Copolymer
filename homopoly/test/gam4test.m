clear;

NM_WLC=1e4;
QM=logspace(-1.5,3.5,100)';
ang = 0;
gam4 = gamma4(QM,ang,NM_WLC);

% % load option
% NM_WLC=1e1;
% filename = sprintf('gam4N1e%d',log10(NM_WLC));
% x = load(filename);
% QM = 10.^(x(:,1));
% gam4 = 10.^(x(:,2));

figure('Position', [100, 100, 1200, 900])
hold;set(gca,'fontsize',50)
plot(QM,gam4,'b-','linewidth',6);
plot(QM,4./power(QM,4),'k--','linewidth',4);
xlim([10^-1.5,10^2]);ylim([1e-6,1]);box on 
set(gca,'xscale','log');set(gca,'yscale','log');
xlabel('Wavevector kR_g');ylabel('Quartic-order Vertex \Gamma^{(4)}')

% save to figure
filename = sprintf('gam4N1e%d',log10(NM_WLC));
saveas(gcf,strcat(filename,'.eps'),'epsc')

% save to data
dlmwrite(filename,[log10(QM*Rg),log10(gam4)],'precision','%.2f')