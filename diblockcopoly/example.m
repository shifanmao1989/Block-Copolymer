clear;close all;
addpath('functions')

N=1e4;  % number of statistical steps of total chain
FAV=linspace(0.1,0.5,41);  % range of A monomer chemical composition
c=1e3;
Nbar=c^2;  % invariant degree of polymerization

% Figure 1: make a mean-field phase diagram
plotphase(N,FAV);

% Figure 2: make a phase diagram with density fluctuations
plotphaseRG(N,Nbar,FAV);

% Figure 3: spinodal and critical wavelength at FA=0.5
NV=logspace(-1,3,20);  % number of statistical steps of total chain
[chis,ks,d2gam2]=spinodal(NV,0.5);
figure;semilogx(NV,chis.*NV)
figure;loglog(NV,1./ks);

% Figure 4: renormalized spinodal
NbarV=logspace(2,8,11);
[chit,phase]=spinodalRG(N,NbarV,0.5);
chit=reshape(chit,length(NbarV),1);
figure;hold
plot(NbarV,chit*N,'kd');
plot(NbarV,10.495+41*power(NbarV,-1/3),'k--')
legend('Renormalized ODT','F-H theory')

% Figure 5: density-density correlations
Nbar=1e4;  % invariant degree of polymerization
[chis,chit]=densityRG(N,Nbar,0.5);

% Figure 6: vertex functions
NQ=1;  % number of wavevector sets in calculating GAM4
[gam3,gam4]=calcgamma(N,FAV,NQ);
figure;plot(FAV,-gam3*N);xlim([0.2,0.5]);xlabel('f_A');ylabel('-\Gamma_3 N')
figure;plot(FAV,gam4*N);xlim([0.3,0.5]);xlabel('f_A');ylabel('\Gamma_4 N')

% % Run and save data
% FAV = linspace(0.1,0.5,41);  % invariant degree of polymerization
% NQ=4;  % number of wavevector sets in calculating GAM4
% NV=logspace(4,6,15);
% 
% % write to file
% filename='data/gamdata';
% if ~exist(filename,'file')
%     outfile = fopen(filename, 'wt');
%     for N=NV
%         for FA=FAV
%             [GAM3,GAM4]=calcgamma(N,FA,NQ);
%             fprintf(outfile,'%.2f, %.2f, %.2f, %.2f, %.2f, %.2f, %.2f\n',...
%                 N,FA,GAM3*N,GAM4(1:4)*N);
%         end
%     end
%     fclose(outfile);
% end