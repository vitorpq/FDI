function [out1] = FiringLevel1(antecedentes, MFpar)
    y = 0:0.001:2;
    j = 0:1:19;
    % Para zerar a agregacao dos antecedentes
    A_1 = 1;
    
    for a = 1:20
        input = antecedentes(a);
        
        [m1 s1]=parfunc1(MFpar, a, j(a));

%         m1 = MFpar(1, a+2+j(a));
%         s1 = MFpar(1, a+3+j(a));

        mf1 = gaussmf(input, [s1 m1]);
        A_1(a) = mf1;
    end
    % Firing Level
    fl1 = prod(A_1);
    dom = MFpar(1,2);
    % Consequents
    G = trimf(y, [dom-0.5 dom dom+0.5]);
            
    % Implication
    out1 = (fl1 .* G);
end