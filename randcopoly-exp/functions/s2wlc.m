function [s2aa,s2ab,s2ba,s2bb]=s2wlc(NM,k,S)

[s2aa,s2ab,s2ba,s2bb]=gammaq2(NM,k,S);
s2aa=s2aa/length(S);
s2ab=s2ab/length(S);
s2ba=s2ba/length(S);
s2bb=s2bb/length(S);

function [s2aa,s2ab,s2ba,s2bb]=gammaq2(NM,k,S)

% Calculate the Fourier transform of the Green function
% for the wormlike chain in d-dimensions
%
% Andrew Spakowitz (4/14/15)

% Fill in unset optional values
d=3;
ORDmax=20;
ORD=20;
ResLayer=500;

% Find length of polymer
% if length(find(S~=1 & S~=0))~=0
%     error('Chemical sequence must be either 0 or zero')
% end
N = length(S);
Naa = length(find(S==1));
Nbb = N - Naa;

s2aa=zeros(1,length(k));
s2ab=zeros(1,length(k));
s2ba=zeros(1,length(k));
s2bb=zeros(1,length(k));

% calculate the roots or eigenvalues of the Schrodinger equation
% k is a vector of all frequencies, for each k, get the roots

for j=1:length(k)
    % calculate the eigenvalues
    R=MatRoots(k(j),d,ORD);
    NR=ORDmax;
    [j0,dj0]=CalRes0(k(j),d,ResLayer);

    % get the residues for all roots of each k(j)
    Residue=CalRes(R(1:NR),k(j),d,ResLayer);
    Z0=exp(R*NM);

    % same monomer contribution
    I11 = 2*(NM/j0-dj0/j0^2);
    for I=1:NR
        I11 = I11+2*Residue(I)*Z0(I)/R(I)^2;
    end
    s2aa(j) = s2aa(j) + Naa*I11;
    s2bb(j) = s2bb(j) + Nbb*I11;
    
    for J1 = 1:N
        for J2 = (J1+1):N
            I12 = sum(2*Residue.*Z0.*exp(J1-J2).*(cosh(R*NM)-1)./(R.^2));
            
            % add to each term in S matrix
            if (S(J1)==0 && S(J2)==0)
                s2aa(j) = s2aa(j) + 2*I12;
            elseif (S(J1)==0 && S(J2)==1)
                s2ab(j) = s2ab(j) + 2*I12;
            elseif (S(J1)==1 && S(J2)==0)
                s2ba(j) = s2ba(j) + 2*I12;
            elseif (S(J1)==1 && S(J2)==1)
                s2bb(j) = s2bb(j) + 2*I12;
            end
        end
    end
end

function Eig=MatRoots(k,d,ORD)

% find roots of denominator (eigenvalues) by solving eigenvalue problem

Eig=zeros(ORD,1);

if k>8000

    % use large k asmyptotic expansion for large k
    
    for I=1:floor(ORD/2)
        l=I-1;
        alpha=1/sqrt(8*k);
        Eig(2*l+1)=1i*k-Epsilon(l,d,alpha);
        Eig(2*l+2)=conj(Eig(2*l+1));
    end
        
else

    % use matrix method for intermediate and small k regime
    n=4*ORD;
    E=zeros(n,n);
    for m=1:n
        if k<=1
            a=complex(0,-k*sqrt(m*(m+d-3)/(2*m+d-2)/(2*m+d-4)));            
            if m>1 
                b=complex(0,-k*sqrt((m-1)*((m-1)+d-3)/(2*(m-1)+d-2)/(2*(m-1)+d-4)));
            end
            if m==1
                E(m,1:2)=[(m-1)*(m+d-3),a];
            elseif m==n
                E(m,n-1:n)=[b,(m-1)*(m+d-3)];
            else
                E(m,m-1:m+1)=[b,(m-1)*(m+d-3),a];
            end
        else
            a=complex(0,-sqrt(m*(m+d-3)/(2*m+d-2)/(2*m+d-4)));            
            if m>1 
                b=complex(0,-sqrt((m-1)*((m-1)+d-3)/(2*(m-1)+d-2)/(2*(m-1)+d-4)));
            end
            if m==1
                E(m,1:2)=[(m-1)*(m+d-3)/k,a];
            elseif m==n
                E(m,n-1:n)=[b,(m-1)*(m+d-3)/k];
            else
                E(m,m-1:m+1)=[b,(m-1)*(m+d-3)/k,a];
            end
        end
    end
    TempMat=eig(E);
    [~,index]=sort(real(TempMat));
    TempMat=TempMat(index);
    if k<=1
        Eig=-TempMat(1:ORD);
    else
        Eig=-TempMat(1:ORD)*k;
    end
end

function value=Epsilon(l,d,alpha)

% eigenvalues using large k asymptotic expansion
% generates epsilon^{s}_r (see the paper)

I=complex(0,1);
beta=-sqrt(2)/4*(1+I);
m=(d-3)/2;
n=2*l+m+1;

epsilon_0=(-1/2/beta)^(-1)*(n/2);
epsilon_1=(-1/2/beta)^( 0)*(-1/8*(n^2+3-3*m^2)-m*(m+1));
epsilon_2=(-1/2/beta)^( 1)*(-1/2^5*n*(n^2+3-9*m^2));
epsilon_3=(-1/2/beta)^( 2)*(-1/2^8*(5*n^4+34*n^2+9)-(102*n^2+42)*m^2+33*m^4);
epsilon_4=(-1/2/beta)^( 3)*(-1/2^11*n*(33*n^4+410*n^2+405)-(1230*n^2+1722)*m^2+813*m^4);
epsilon_5=(-1/2/beta)^( 4)*(-1/2^12*9*(7*n^6+140*n^4+327*n^2+54-(420*n^4+1350*n^2+286)*m^2+(495*n^2+314)*m^4-82*m^6));

value=epsilon_0/alpha+epsilon_1+epsilon_2*alpha+epsilon_3*alpha^2+...
      epsilon_4*alpha^3+epsilon_5*alpha^4;
  
function Res=CalRes(R,k,d,ResLayer)

% calculate the residual of all eigenvalues

ResThreshold=1e-12;     % threshold to go from small k asymptot to matrix method
ImagThreshold=1e-8;     % threshold to go from small k asymptot to matrix method
NR=length(R);           % number of eigenvalues (roots)

% get the residues for all roots given in R using recursive relation for
% derivative
Res=zeros(NR,1);    % residual vector, each row corresponds to each eigenvalue

% find the residual
for n=1:NR

    % use asymptotic residual to figure out whether calculate the residual
    % using continued fraction or stay with the asymptotic form for small k
    % limit

    Res(n)=SmallAsympRes(k,n,d);
    if abs(Res(n))>ResThreshold
        if k<=1

            % residual using continued fraction for small k
            p=R(n);
            W=p+(ResLayer+d-2)*ResLayer;
            Wprime=1;
            for L=ResLayer:-1:1
                AL=k*sqrt(L*(L+d-3)/(2*L+d-2)/(2*L+d-4));         % d-dimensional case
                Wprime=1-AL^2*Wprime/W^2;
                PLm=p+(L+d-2-1)*(L-1);                            % d-dimensional case
                W=PLm+AL^2/W;
            end
            Res(n)=1/Wprime;
        else

            % residual using continued fraction for large k
            p=R(n);
            W=(p+(ResLayer+d-2)*ResLayer)/k;
            Wprime=1/k;
            for L=ResLayer:-1:1
                AL=sqrt(L*(L+d-3)/(2*L+d-2)/(2*L+d-4));           % d-dimensional case
                Wprime=1/k-AL^2*Wprime/W^2;
                PLm=p+(L+d-2-1)*(L-1);                            % d-dimensional case
                W=PLm/k+AL^2/W;
            end
            Res(n)=1/(k*Wprime);
        end
    end
    if abs(imag(R(n)))<ImagThreshold
        Res(n)=real(Res(n));
    end
end

function Res=SmallAsympRes(K,n,d)

% calculate the residual using small k asymptot

l=n-1;
Res=1;
Wl=l*(l+d-2);

for j=0:(l-1)
    Wj=j*(j+d-2);
    ajp1=sqrt((j+1)*(j+1+d-3)/(2*j+d)/(2*j+d-2));
    Res=Res*ajp1^2/(Wl-Wj)^2;
end

Res=Res*K^(2*l)*(-1)^l;

function [j0,dj0]=CalRes0(k,d,ResLayer)

if k<=1
    
    % residual using continued fraction for small k
    p=0;
    W=p+(ResLayer+d-2)*ResLayer;
    Wprime=1;
    for L=ResLayer:-1:1
        AL=k*sqrt(L*(L+d-3)/(2*L+d-2)/(2*L+d-4));         % d-dimensional case
        Wprime=1-AL^2*Wprime/W^2;
        PLm=p+(L+d-2-1)*(L-1);                            % d-dimensional case
        W=PLm+AL^2/W;
    end
    dj0=Wprime;
    j0=W;
else
    
    % residual using continued fraction for large k
    p=0;
    W=(p+(ResLayer+d-2)*ResLayer)/k;
    Wprime=1/k;
    for L=ResLayer:-1:1
        AL=sqrt(L*(L+d-3)/(2*L+d-2)/(2*L+d-4));           % d-dimensional case
        Wprime=1/k-AL^2*Wprime/W^2;
        PLm=p+(L+d-2-1)*(L-1);                            % d-dimensional case
        W=PLm/k+AL^2/W;
    end
    dj0=k*Wprime;
    j0=k*W;
end