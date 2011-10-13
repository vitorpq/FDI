function mf = gaussmf1(x, param)
%% Versao mais rapida
    s1 = param.s1;
    m1 = param.m1;
    
    y1 = gaussmf(x, [s1 m1]);
             
    mf.u = u;
    mf.l = l;
end