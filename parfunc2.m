function [pars] = parfunc2(MFpar, a, J)
    %% parfunc2: function to assign the correct parameters for each antecedent
    pars.m1 = MFpar(a+2+J);
    pars.s1 = MFpar(a+3+J);
    pars.m2 = MFpar(a+4+J);
    pars.s2 = MFpar(a+5+J);
end