function [inicio fim ticos] = limites(dados)
    % para plotar um grafico com limites bons e divisoes coerentes
    
    passo = ceil(max(dados)-floor(min(dados)))/10;
    if round(passo) ~= 0
            passo = round(passo);
    end
    
    inicio = round(min(dados))-passo;
    if inicio < 0
        inicio = 0;
    end
    
    
    fim = ceil(max(dados));
    
    ticos = linspace(inicio, fim, round((fim-inicio)/passo));
end