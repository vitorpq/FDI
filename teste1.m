% Sistema 01A v8
% Design:
% Padroes - [0 1 7 8 9 10 11 12 13]
% Com 20 antecedentes
% Usando o "winner takes all"
% Sem otimizacao
% Tipo-1 com somente um m
% m = 2

clear all
close all
load Dados_Sist01v7_2.mat
% Dados utilizados: UsedData
% vide Tratamento de Dados Amostra 1

y = 0:0.001:2;
x = 0:0.001:200;

% padraototal = [0 1 2 3 4 7 8 9 10 11 12 13 14];
% Padroes usados para extrair os parametros dos antecedentes
padrao = [0 1 7 8 9 10 11 12 13];
% Numero de clusters para cada um dos padroes
nclusters = [4 2 2 3 6 6 6 7 3 5 3 2 2 2 3];
% numero de antecedentes: n+1
ant = 20;
% expoente fuzzificacao
m = 2;
if matlabpool('size') < 4
    matlabpool close;
    matlabpool open 4;
end

clc;

for idt=[8 9 11 12 13] %padrao
    disp('-------------------------------------------------------------');
    disp(['Iniciando Padrão - ', num2str(idt)]);
    data = datapd(UsedData, idt, ant);
    
    %Usar somente 1 valor por vez para testar
    tic;
    Range = size(data,1);
    clear state1 estado final1 Erro1
    parfor ii= 1:Range
        entrada = data(ii,1:end-2);
        
        % Parametros
        % Tenho que passar os dados sem o feature de teste
        % Function para Fuzzy Tipo-1, metodo de erro leaving-one-out
        MFpar = mfpars1(UsedData, padrao, m, ant, nclusters, ii, idt);
        rules = size(MFpar,1);
        
        OutSet_1 = zeros(rules,size(y,2));
        for r = 1:size(MFpar,1)
            pars = MFpar(r, :);
            [OutSet_1(r,:)] = FiringLevel1(entrada, pars);
        end
        
        % Rule Aggregation
            % winner takes all
            [value idmax1] = max(max(OutSet_1, [], 2));
            RA_1 = OutSet_1(idmax1, :);

        if max(RA_1) == 0
            state1(ii) = 0;
        else
            state1(ii) = defuzz(y, RA_1, 'centroid');
        end
    end
    toc;
    % AvgTime = EndTime/i;
    % disp(['Total Time: ', num2str(EndTime)]);
    % disp(['Average Time: ', num2str(AvgTime)]);
    estado = data(1:Range,end);
    final1 = round(state1');
    % plot([estado final], 'x');
    % legend('Correct', 'FDD');
    Erro1 = 100*(size(find(final1 ~= estado))/size(final1));
    
    disp(['Error (m=', num2str(m), '): ',num2str(Erro1), '%'])
    
end
