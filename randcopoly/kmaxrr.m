function [kval,sval]=kmaxrr(N,NM,FA,LAM)

R2=NM^2;

NK=50;
KV=transpose(logspace(-2,2,NK))/sqrt(R2);

S=s2invrr(N,NM,FA,LAM,KV);
[~,IND]=min(S);

if IND ==1
    kval=1e-2/sqrt(R2);
    sval=s2invrr(N,NM,FA,LAM,kval);
    kval=0;
else

    KV2=transpose(linspace(KV(IND-1),KV(IND+1),NK));
    DK=KV2(2)-KV2(1);
    S=s2invrr(N,NM,FA,LAM,KV2);
    [~,IND]=min(S);
    K=KV2(IND);
    
    A=s2invrr(N,NM,FA,LAM,K-DK);
    B=s2invrr(N,NM,FA,LAM,K);
    C=s2invrr(N,NM,FA,LAM,K+DK);
    KAP=(A+C-2*B)/DK^2;
    kval=(A-C)/(2*KAP*DK)+K;

    sval=s2invrr(N,NM,FA,LAM,kval);

end

