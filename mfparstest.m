function [MFpar]= mfparstest(Dados, padrao, ant, nclusters, indice, teste)
%% MFpars  U_new1 U_new2 data center1 center2
%% Versão com uso do nval.m para encontrar o numero de clusters
% versao usando o fitcurve e sem determinar o max e min do vetor U
    
    addpath ../progs
    addpath /home/vitor/Documents/MATLAB/FUZZCLUST/
 
    t = 0;

    for idt = padrao
        datat = datapd(Dados, idt, ant);
        if idt == teste
            data.X = datat(setdiff(1:size(datat,1), indice),1:end-2);
        else
            data.X = datat(:,1:end-2);
        end
        pd = unique(datat(:,end)); % valor do padrao a ser passado ao
                                   % vetor de parametros
        
        % exponent = 1.5
        param.c = nclusters(idt+1);
        param.m = 1.5;
        result1 = FCMclust(data, param);
%         % exponent = 3
%         param2.c = nclusters(idt+1);
%         param2.m = 3;
%         result2 = FCMclust(data, param2);
        
        center1 = result1.cluster.v;
%         center2 = result2.cluster.v;
        U_new1 = result1.data.f;
%         U_new2 = result2.data.f;
        
        % varrer todos os clusters
        for n_k = 1:size(center1, 1)
            clear x_mf u_d u_e mf
            t = t + 1;
            pars = [];
            for n_ant = 1:size(center1, 2)
                x_mf = data.X(:, n_ant);
                u_d = U_new1(:, n_k);
                u_e = U_new2(:, n_k);
                m1 = center1(n_k, n_ant);
                m2 = center2(n_k, n_ant);
                
                [s1] = fitcurve(x_mf, u_d, m1);
                [s2] = fitcurve(x_mf, u_e, m2);
                
                par = [m1 s1 m2 s2];
                pars = [pars par];
           end
           MFpar(t,:) = [idt pd pars];
        end
    end
end