clear;close all;
addpath('functions')

% Figure 1: make a mean-field phase diagram
N=1e0;  % number of statistical steps of total chain
FAV=linspace(0.1,0.499,21);  % range of A monomer chemical composition
plotphase(N,FAV);

% Figure 2: make a phase diagram with density fluctuations
N=1e0;  % number of statistical steps of total chain
c=1e4;
Nbar=c^2;  % invariant degree of polymerization
FAV=linspace(0.1,0.5,21);  % range of A monomer chemical composition
plotphaseRG(N,Nbar,FAV);

% Figure 3: spinodal
NV=logspace(-1,3,20);  % number of statistical steps of total chain
FA=0.5;  % range of A monomer chemical composition
[chis,ks,d2gam2]=spinodal(NV,FA);
figure;semilogx(NV,chis.*NV)
figure;loglog(NV,1./ks);

% Figure 4: renormalized spinodal
N=1e6;  % number of statistical steps of total chain
NbarV=logspace(2,8,11);
FA=0.5;  % range of A monomer chemical composition
[chit,phase]=spinodalRG(N,NbarV,FA);
chit=reshape(chit,length(NbarV),1);
figure;semilogx(NbarV,chit*N);

% Figure 5: density-density correlations
N=1e6;  % number of statistical steps of total chain
Nbar=1e4;  % invariant degree of polymerization
FA=0.5;
densityRG(N,Nbar,FA);

% Figure 6: vertex functions
N=1e-1;  % number of statistical steps of total chain
FAV = linspace(0.1,0.5,21);  % invariant degree of polymerization
NQ=1;  % number of wavevector sets in calculating GAM4
[GAM3,GAM4]=calcgamma(N,FAV,NQ);
figure;plot(FAV,-GAM3*N);xlim([0.2,0.5]);xlabel('F_A');ylabel('-\Gamma_3 N')
figure;plot(FAV,GAM4*N);xlim([0.3,0.5]);xlabel('F_A');ylabel('\Gamma_4 N')

% % Savedata
% FAV = linspace(0.1,0.5,21);  % invariant degree of polymerization
% NQ=4;  % number of wavevector sets in calculating GAM4
% NV=logspace(-1,4,6);
% for N=NV
%     [GAM3,GAM4]=calcgamma(N,FAV,NQ);
%     filename=sprintf('data/gam%.2e.mat',N);
%     save(filename,'GAM3','GAM4')
% end