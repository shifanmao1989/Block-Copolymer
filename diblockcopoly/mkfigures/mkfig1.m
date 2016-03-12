% Plot density correlations at FA=0.5 (transition to LAM phase)
% Correspond to Figure 2 in the manuscript "Diblock Phase Behavior: chain semiflexibility and density fluctuation effects"

cd ..
addpath('functions/')

FA = 0.5;
C = 100;
figure(10);hold;set(gca,'fontsize',20)

NV = [1e3,1];
colv = ['k','b'];
p=[];
for ii = 1:length(NV)
    N = NV(ii);
    col = colv(ii);
    [chis,chit,CHIV,Smf,Sfh,sinvmf,sinvfh]=densityRG(N,C,FA);
    figure(10);
    p=[p,plot(CHIV*chis*N,1./Sfh,'-','linewidth',2,'color',col)];
    p=[p,plot(CHIV*chis*N,1./Smf,'--','linewidth',2,'color',col)];
    plot(chis*N,1./sinvmf,'o','color',col,...
        'MarkerSize',8,'MarkerFaceColor',col);
    plot(chit*N,1./sinvfh,'s','color',col,...
        'MarkerSize',8,'MarkerFaceColor',col);
end

figure(10);
legend(p,{'N=10^3 Renormalized','N=10^3 Mean-field','N=1 Renormalized','N=1 Mean-field'})
xlim([1,17]);ylim([0,20]);box on
xlabel('\chi N');ylabel('<\psi(q^*)\psi(-q^*)>^{-1}')
savename = sprintf('mkfigures/figure1.eps');
saveas(gcf,savename,'epsc')

cd mkfigures