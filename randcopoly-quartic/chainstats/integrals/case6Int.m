function valeq=case6Int(E1,E12,E3,NM)

    MIN=10^-4;
    vec=[E1,E12,E3];
    nzeros=sum(abs(vec)<MIN);
    if nzeros==3
        valeq=NM^4*(2*NM*E1-NM*E12+6)/12;
    elseif nzeros==2
        if max(abs([E1,E12]))<MIN
            valeq=NM^2*exp(NM*E3)*expl(1,-NM*E3)*(3*(E12+E3)*expl(2,-NM*E3)-3*NM*E3^2 ...
                  +NM*(E1+E12)*E3*expl(1,-NM*E3))/(6*E3^3);
        elseif max(abs([E12,E3]))<MIN
            valeq=(NM^2/(E1^3))*((E1+E12)*expl(2,NM*E1)-0.5*NM*E1*E12*expl(1,NM*E1));
        elseif max(abs([E1,E3]))<MIN
            valeq=(NM/(2*E12^4))*(2*(E1+E12+E3)*...
                   (expl(3,NM*E12)+expl(3,-NM*E12)+NM*E12*expl(2,-NM*E12))+...
                   NM^2*(E1+E3)*E12^2*expl(1,-NM*E12)+...
                   NM*E12*E3*(expl(2,-NM*E12)-expl(2,NM*E12)));
        else
            error('not an option')
        end
    elseif nzeros==1
        if abs(E1-E12)<MIN && abs(E3)<MIN
            valeq=NM^2*expl(2,NM*E1)/(E1^2) - 2*NM*coshl(4,NM*E1)/(E1^3);
        elseif abs(E12-E3)<MIN && abs(E1)<MIN
            valeq=-NM*expl(1,-NM*E12)*expl(2,NM*E12)/(E12^3);
        elseif abs(E1-E3)<MIN && abs(E12)<MIN
            valeq=(expl(2,NM*E1)+expl(2,-NM*E1))*expl(2,NM*E1)/(E1^4);
        elseif abs(E1)<MIN
            valeq=(expl(1,NM*E3)*(expl(2,-NM*E12)+NM*E12*expl(1,-NM*E12))...
                -expl(1,-NM*E3)*expl(2,NM*E12))/(E12^2*E3*(E12-E3));
        elseif abs(E12)<MIN   
            valeq=-expl(1,NM*E3)*expl(1,-NM*E3)*expl(2,NM*E1)/(E1^2*E3^2);
        elseif abs(E3)<MIN
            valeq=NM*(E1*expl(2,NM*E12)+E1*expl(2,-NM*E12)...
                  +E12*expl(1,NM*E1)*expl(1,-NM*E12))...
                  /(E1*E12^2*(E12-E1));
        else
            error('not an option')
        end
    else
        if(abs(E1-E12)<MIN && abs(E12-E3)<MIN) 
           valeq=(exp(1).^E1).^((-1).*NM).*((-1)+(exp(1).^E1).^NM).*NM.*log(exp(1) ...
           .^E1).^(-3).*(1+(exp(1).^E1).^NM.*((-1)+NM.*log(exp(1).^E1)));
        elseif abs(E1-E12)<MIN
           valeq=(exp(1).^E1).^((-1).*NM).*(1+(-1).*(exp(1).^E3).^((-1).*NM)).*(( ...
           exp(1).^E1).^NM+(-1).*(exp(1).^E3).^NM).*log(exp(1).^E1).^(-2).*( ...
           1+(exp(1).^E1).^NM.*((-1)+NM.*log(exp(1).^E1))).*(log(exp(1).^E1)+ ...
           (-1).*log(exp(1).^E3)).^(-1).*log(exp(1).^E3).^(-1);
        elseif abs(E1-E3)<MIN
           valeq=(exp(1).^E12).^((-1).*NM).*(1+(-1).*(exp(1).^E1).^((-1).*NM)).*(( ...
           exp(1).^E1).^NM+(-1).*(exp(1).^E12).^NM).*log(exp(1).^E1).^(-2).*( ...
           log(exp(1).^E1)+(-1).*log(exp(1).^E12)).^(-2).*log(exp(1).^E12).^( ...
           -1).*((-1).*((-1)+(exp(1).^E12).^NM).*log(exp(1).^E1)+((-1)+(exp( ...
           1).^E1).^NM).*log(exp(1).^E12));
        elseif abs(E12-E3)<MIN
           valeq=(1+(-1).*(exp(1).^E12).^((-1).*NM)).*NM.*log(exp(1).^E1).^(-1).*( ...
           log(exp(1).^E1)+(-1).*log(exp(1).^E12)).^(-1).*log(exp(1).^E12).^( ...
           -2).*((-1).*((-1)+(exp(1).^E12).^NM).*log(exp(1).^E1)+((-1)+(exp( ...
           1).^E1).^NM).*log(exp(1).^E12));
        else
    %         valeq=z*expl(1,NM*E1)*(expl(1,-NM*E1)-expl(1,-NM*E12))*...
    %               ( expl(2,NM*E3)*E12 - expl(2,NM*E12)*E3 )/...
    %               (E1*E12*E3*(E12-E3)*(E1-E12)); %appears to be incorrect
           valeq=(-1).*(exp(1).^E12).^((-1).*NM).*(1+(-1).*(exp(1).^E3).^((-1).*NM) ...
           ).*((exp(1).^E12).^NM+(-1).*(exp(1).^E3).^NM).*log(exp(1).^E1).^( ...
           -1).*(log(exp(1).^E1)+(-1).*log(exp(1).^E12)).^(-1).*log(exp(1) ...
           .^E12).^(-1).*(((-1)+(exp(1).^E12).^NM).*log(exp(1).^E1)+(-1).*(( ...
           -1)+(exp(1).^E1).^NM).*log(exp(1).^E12)).*(log(exp(1).^E12)+(-1).* ...
           log(exp(1).^E3)).^(-1).*log(exp(1).^E3).^(-1);
        end
    end 

    if real(E1)>0 || real(E12)>0 || real(E3) > 0
        error('shouldnt the real part of the eigenvalues be negitive?')
    end
    if valeq<0 && isreal(E1) && isreal(E12) && isreal(E3)
        sprintf('a=%g, b=%g, c=%g, valeq=%g, flag=%d',E1,E12,E3,valeq,flag)
        error('valeq<0')
    end
end