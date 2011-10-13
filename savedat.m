clear all
close all
load Dados_Sist01v7_1.mat
load Results.mat

% padraototal = [0 1 2 3 4 7 8 9 10 11 12 13 14];
% Padroes usados para extrair os parametros dos antecedentes
padrao = [0 1 7 8 9 10 11 12 13];
% Numero de clusters para cada um dos padroes
% nclusters = [5 8 2 6 3 3 3 5 10 5 12 2 2 5 4];
nclusters = [4 2 2 3 6 6 6 7 3 5 3 2 2 2 3];

grafico = ['a' 'b' 'c' 'd' 'e' 'f' 'g' 'h' 'i' 'j' 'k'];
% numero de antecedentes: n+1
ant = 20;
% padrao a ser testado
i = 1;
k = 1;
temp2 = temp;
temp2(temp2(:,end-1)==2,end-1) = 1;

data = datapd(temp2, 0, ant);
dados = data(:,end-2);

startDate = datenum('00:00:00');
[hora minu secu] = sec2hms(30*(size(dados,1)));
endDate = datenum(strcat(int2str(hora),':',int2str(minu),':',int2str(secu)));
xData = linspace(startDate, endDate, size(dados,1));

xTime = datestr(xData, 'HH:MM:SS');


vetor = [xTime dados];

dlmwrite('teste.dat', xTime, dados, 'precision', '%s %0.4f');

