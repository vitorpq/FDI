% jackknife bias and variance
clear all

load Dados_Sist01v7_2.mat
load Results_T1a20m2l1out.mat

function rmse()
    sqrt(sum((Resultado - Esperado').^2)/n)
end

for idt = 0%[0 1 7 8 9 10 11 12 13]
    
    Resultado = Results(idt+1).estado(1,:);
    n = length(Resultado);
    mhat = mean(Resultado);
    y = mhat * ones(1,n);
       
%     % média de cada teste leave-one-out
%     
%     for i = 1:size(Resultado,2)
%         clear dados_i
%         dados_i = Resultado(setdiff(1:size(Resultado,2), i));
%         media_i(i) = mean(dados_i);
%     end
% 
%     % Estimacao da media do JK
%     media_p = sum(media_i)/size(media_i,2);
% 
%     bias_jk = (n-1)*(media_p-media);
% 
%     % Variancia
    
    Esperado = Results(idt+1).legenda * ones(1,n);
    
    mi = jackknife(@rmse, Resultado, 1);
    mp = mean(mi);
    
    jbias(idt+1) = (n-1)*(rmse(mi)-mhat);
    Var_m(idt+1) = ((n-1)/n) * (sum((mi - mp).^2));
    
    
end



