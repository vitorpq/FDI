function [m1 s1 m2 s2] = parfunc(MFpar, a, J)
    m1 = MFpar(a+2+J);
    s1 = MFpar(a+3+J);
    m2 = MFpar(a+4+J);
    s2 = MFpar(a+5+J);
end