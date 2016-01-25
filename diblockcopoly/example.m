clear;close all;
addpath('functions')

N=1e4;  % number of statistical steps of total chain
FAV=linspace(0.1,0.5,41);  % range of A monomer chemical composition
Nbar=1e6;  % invariant degree of polymerization
C=sqrt(Nbar);  % dimensionless excluded volume parameter in the Gaussian limit

% Figure 1: make a mean-field phase diagram
plotphase(N,FAV);

% Figure 2: make a phase diagram with density fluctuations
plotphaseRG(N,C,FAV);

% Figure 3: spinodal and critical wavelength at FA=0.5
NV=logspace(-1,3,20);  % number of statistical steps of total chain
[chis,ks,d2gam2]=spinodal(NV,0.5);
figure;semilogx(NV,chis.*NV);xlabel('N');ylabel('\chiN')
figure;loglog(NV,1./ks);xlabel('N');ylabel('1/q^*')

% Figure 4: renormalized spinodal
CV=logspace(1,4,11);
[chit,phase]=spinodalRG(N,CV,0.5);
chit=reshape(chit,length(CV),1);

figure;hold
NbarV=CV.^2;
plot(NbarV,chit*N,'kd');
plot(NbarV,10.495+41*power(NbarV,-1/3),'k-')
plot(NbarV,ones(length(CV),1)*spinodal(N,0.5)*N,'k--')
set(gca,'xscale','log');xlabel('Nbar');ylabel('\chiN')
legend('Renormalized ODT','F-H theory')

% Figure 5: density-density correlations
Nbar=1e4;  % invariant degree of polymerization
[chis,chit]=densityRG(N,Nbar,0.5);

% Figure 6: vertex functions
NQ=1;  % number of wavevector sets in calculating GAM4
[gam3,gam4]=calcgamma(N,FAV,NQ);
figure;plot(FAV,-gam3*N);xlim([0.2,0.5]);xlabel('f_A');ylabel('-\Gamma_3 N')
figure;plot(FAV,gam4*N);xlim([0.3,0.5]);xlabel('f_A');ylabel('\Gamma_4 N')