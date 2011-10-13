function [MFpar]= mfpars1(Dados, padrao, m, ant, nclusters, indice, teste)
%% MFpars1  U_new1 U_new2 data center1 center2
% Versão com uso do nval.m para encontrar o numero de clusters
% versao usando o fitcurve e sem determinar o max e min do vetor U
    
    t = 0;
    nk = sum(nclusters(padrao+1)); % numero total de clusters
    MFpar = zeros(nk, (ant*2+2));
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
        param.m = m;
        result1 = FCMclust(data, param);
                
        center1 = result1.cluster.v;
        U_new1 = result1.data.f;

        % varrer todos os clusters
        nk = size(center1, 1); % numero de clusters do padrao
         for n_k = 1:nk
            clear x_mf u mf
            t = t + 1;
            na = size(center1, 2); % numero de antecedentes
            pars = zeros(1,2*na);
            j = 0:na-1;
            for n_ant = 1:na
                x_mf = data.X(:, n_ant);
                u = U_new1(:, n_k);
                m1 = center1(n_k, n_ant);
                [s1] = fitcurve(x_mf, u, m1);
                              
                par = [m1 s1];
                pars(1,n_ant+j(n_ant):n_ant+j(n_ant)+1) = par;
            end
            MFpar(t,:) = [idt pd pars];
        end
    end
end