function mf = gauss4mf(x, param)
%% gauss4mf: generates a type-2 two-sided gaussian membership function
% Faster version
% Last modification: 06/10/2011
% @author: Vítor Emmanuel Andrade
% @e-mail: vitor.e.a@gmail.com

    s1 = param.s1;
    s2 = param.s2;
    m1 = param.m1;
    m2 = param.m2;

    y1 = gaussmf(x, [s1 m1]);
    y2 = gaussmf(x, [s2 m2]);


    u = max(y1, y2);
    l = min(y1, y2);
    idx = x >= m1 & x <= m2;
    u(idx) = 1;
    
    mf.u = u;
    mf.l = l;
end