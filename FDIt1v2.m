% Sistema 01A v8
% Design:
% Tipo-1 com somente um m
% m = 2
% Padroes - [0 1 7 8 9 10 11 12 13]
% Com 20 antecedentes
% Usando o "winner takes all"
% Sem otimizacao
% Version: 29/09/2011 14:40 -%- Vítor Emmanuel Andrade -%-

clear all
close all

Versao = {'FDI Tipo-1';...
    '20 antecedentes';...
    'somente m=2';...
    'Aggregation Max';...
    'padroes = [0 1 7 8 9 10 11 12 13]';...
    'nclusters = [5 2 2 3 6 6 6 7 3 5 3 2 2 2 3]';...
    'sem otimizacao';...
    'paralelizado';...
    'Dados: UsedData';...
    'Arquivo: Dados_Sist01v7_2.mat'};
%% Dados e ctes
% Dados utilizados: UsedData
% vide Tratamento de Dados Amostra 1
load Dados_Sist01v7_2.mat
y = 0:0.001:2;
%x = 0:0.001:200;

% padraototal = [0 1 2 3 4 7 8 9 10 11 12 13 14];
% Padroes usados para extrair os parametros dos antecedentes
padrao = [0 1 7 8 9 10 11 12 13];
% Numero de clusters para cada um dos padroes
% nclusters = [4 2 2 3 6 6 6 7 3 5 3 2 2 2 3]; original
nclusters = [5 2 2 3 6 6 6 7 3 5 3 2 2 2 3]; % teste
% numero de antecedentes: n+1
ant = 20;
% expoente fuzzificacao
m = 2;

%% Parallel Workers
if matlabpool('size') < 2
    if matlabpool('size') > 0
        matlabpool close force;
    end
    matlabpool open 4;
end

% Clean screen
clc;

for idt=padrao
    %% Identificação do padrão
    disp('-------------------------------------------------------------');
    disp(['Iniciando Padrão - ', num2str(idt)]);
    
    %% Padrão a ser testado
    % Extrai o padrão dos dados todos e concatena os antecedentes
    data = datapd(UsedData, idt, ant);
    Range = size(data,1);
    
    tic;
        
    clear state1 estado final1 Erro1
    parfor ii= 1:Range
        % Feature de teste - Entrada do FIS
        entrada = data(ii,1:end-2);
        
        % Parametros dos antecedentes
        % Function para Fuzzy Tipo-1, metodo de erro leaving-one-out
        MFpar = mfpars1(UsedData, padrao, m, ant, nclusters, ii, idt);
        
        % Numero de regras total
        rules = size(MFpar,1);
        
        % pre-alocação
        OutSet_1 = zeros(rules,size(y,2));
        
        for r = 1:size(MFpar,1)
            % Parametros da regra r
            pars = MFpar(r, :);
            % Retorna os consequentes já implicados
            [OutSet_1(r,:)] = FiringLevel1(entrada, pars);
        end

        % Determina a regra com maior Firing Level
        [value idmax1] = max(max(OutSet_1, [], 2));
        % Usa somente a regra com maior Firing Level
        % winner takes all
        % RA_1 = OutSet_1(idmax1, :);
        
        % Regular Rule Aggregation    
        RA_1 = max(OutSet_1, [], 1);

        % Testa se a saída da regra é zero
        % para evitar erro na defuzzificação
        if max(RA_1) == 0
            state1(ii) = 0;
        else
            state1(ii) = defuzz(y, RA_1, 'centroid');
        end
    end
    
    %% Error Rate
    RealState = data(1:Range,end);
    final1 = round(state1');
    Erro1 = 100*(size(find(final1 ~= RealState))/size(final1));
    RMSE = sqrt(sum((state1'-RealState).^2)/Range);
    disp(['Error (m=', num2str(m), '): ',num2str(Erro1), '%']);
    
    %% Results struct
    Results(idt+1).padrao = idt;
    Results(idt+1).estado = state1;
    Results(idt+1).legenda = unique(RealState);
    Results(idt+1).tamanho = size(RealState);
    Results(idt+1).tempo = toc;
    Results(idt+1).LOO = Erro1;
    Results(idt+1).RMSE = RMSE;
end

%% Save Results
% save Results_T1a20m2AgM.mat Results Versao
