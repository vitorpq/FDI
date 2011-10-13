function [m1 s1] = parfunc1(MFpar, a, J)
    m1 = MFpar(a+2+J);
    s1 = MFpar(a+3+J);
end