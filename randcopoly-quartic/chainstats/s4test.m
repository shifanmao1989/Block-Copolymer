%this code tests the calculation of 4-point correlation
clear;

%Chain structural information
NM_GS=1e4;
N=100;

%Chain chemical information
FA=0.9;
LAM=-0.75;

% parameters for WLC calculations
ORDEig=4;
ORDL=5;
NumLayer=500;

%wavevector and structure factor
QM=logspace(2,5,20)';
Q1=zeros(length(QM),1);
Q2=zeros(length(QM),1);
Q3=zeros(length(QM),1);
Q4=zeros(length(QM),1);
ang=pi/3;
for ii=1:length(QM)
    Q1(ii,1:3)=QM(ii)*[1,0,0];
    Q2(ii,1:3)=transpose(rotz(ang)*Q1(ii,1:3)');
    Q3(ii,1:3)=-Q2(ii,1:3);
    Q4(ii,1:3)=-Q1(ii,1:3);
end

%begin making plots
figure;hold;set(gca,'fontsize',15);leg=[];

%%%% Gaussian Chain %%%%
%calculate s4
g4=zeros(length(QM),2,2,2,2);
for ii=1:length(QM)
   ii
   g4(ii,:,:,:,:)=s4gc(N,NM_GS,LAM,FA,Q1(ii,1:3)/(N*NM_GS),...
                                      Q2(ii,1:3)/(N*NM_GS),...
                                      Q3(ii,1:3)/(N*NM_GS),...
                                      Q4(ii,1:3)/(N*NM_GS));
%    g4(ii,:,:,:,:)=s4wlc(N,NM_GS,LAM,FA,...
%                                       Q1(ii,1:3)/(N*NM_GS),...
%                                       Q2(ii,1:3)/(N*NM_GS),...
%                                       Q3(ii,1:3)/(N*NM_GS),...
%                                       Q4(ii,1:3)/(N*NM_GS),ORDEig,ORDL,NumLayer);
%    g4(ii,:,:,:,:)=s4rigid(NM_GS,FA,Q1(ii,1:3)/NM_GS,...
%                                       Q2(ii,1:3)/NM_GS,...
%                                       Q3(ii,1:3)/NM_GS,...
%                                       Q4(ii,1:3)/NM_GS);
end
g4=g4./power(N*NM_GS,4);

%make plots
plot(QM,g4(:,1,1,1,1),'k-',...
     QM,g4(:,1,2,1,2),'r-','linewidth',2);
leg=[leg {'Gaussian'}];

legend(leg);
set(gca,'xscale','log');set(gca,'yscale','linear');ylim([0,1.3]);
xlabel('Normalized Wavevector kL');
ylabel('Normalized Structure Factor S/L^4')