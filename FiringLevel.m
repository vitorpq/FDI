function [out1, out2] = FiringLevel(antecedentes, MFpar)
    y = 0:0.001:2;
    j = 0:3:57;
    % Para zerar a agregacao dos antecedentes
    A_1 = 1;
    A_2 = 1;
    for a = 1:20
        input = antecedentes(a);
        
        [m1 s1 m2 s2]=parfunc(MFpar, a, j(a));

%         m1 = MFpar(1, a+2+j(a));
%         s1 = MFpar(1, a+3+j(a));
% 
%         m2 = MFpar(1, a+4+j(a));
%         s2 = MFpar(1, a+5+j(a));

        mf1 = gaussmf(input, [s1 m1]);
        mf2 = gaussmf(input, [s2 m2]);

        A_1(a) = mf1;
        A_2(a) = mf2;
    end
    % Firing Level
    fl1 = prod(A_1);
    fl2 = prod(A_2);
    dom = MFpar(1,2);
    % Consequents
    G = trimf(y, [dom-0.5 dom dom+0.5]);
            
    % Implication
    out1 = (fl1 .* G);
    out2 = (fl2 .* G);
end