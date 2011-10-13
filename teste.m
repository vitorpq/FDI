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

for idt=8%padrao
    data = datapd(temp2, idt, ant);
    dados = data(:,end-2);
    
    if idt == 0
        figure(1);
%         h = figure('visible', 'off');
%         startDate = 0;
%         endDate = 30*size(dados,1);
%         xData = linspace(startDate, endDate, size(dados,1));
        plot(dados, 'r');
        %set(gcf, 'color', 'white');
%         ylabel('temp.', 'FontSize', 14);
%         ylim([(min(dados)-0.1) (max(dados)+0.1)]);
%        xlim([xData(1) xData(end)]);
        
%         savefile1 = strcat('Padrao_', int2str(idt), '.eps');
%         savefile2 = strcat('Padrao_', int2str(idt), '.tiff');
%         print(h, '-deps', '-r100', savefile1);
%         print(h, '-dtiff', '-r100', savefile2);

    elseif (idt == 1 || idt == 7)
        figure(2)
        subplot(2,1,i);
        %h = figure('visible', 'off');
        startDate = 0;%datenum('00:00:00');
        %[hora minu secu] = sec2hms(30*(size(dados,1)));
        endDate = 30*(size(dados,1));%datenum(strcat(int2str(hora),':',int2str(minu),':',int2str(secu)));
        xData = linspace(startDate, endDate, size(dados,1));
        plot(xData, dados, 'r');
        xlabel(['(' grafico(i) ')'], 'fontweight', 'bold', 'FontSize', 14);
        ylabel('temp.', 'FontSize', 14);
        ylim([(min(dados)-0.1) (max(dados)+0.1)]);
        set(gcf, 'color', 'white');        
        xlim([xData(1) xData(end)]);

%         savefile1 = strcat('Padrao_', int2str(idt), '.eps');
%         savefile2 = strcat('Padrao_', int2str(idt), '.tiff');
%         print(h, '-deps', '-r100', savefile1);
%         print(h, '-dtiff', '-r100', savefile2);
        i = i+1;
    else
        figure(3)
        subplot(3,2, k)
%         h = figure('visible', 'off');
        
        startDate = 0;%datenum('00:00:00');
        %[hora minu secu] = sec2hms(30*(size(dados,1)));
        endDate = 30*(size(dados,1));%datenum(strcat(int2str(hora),':',int2str(minu),':',int2str(secu)));
        xData = linspace(startDate, endDate, size(dados,1));
        plot(xData, dados, 'r');
        xlabel(['(' grafico(k) ')'], 'fontweight', 'bold', 'FontSize', 14);
        ylabel('temp.', 'FontSize', 14);
        ylim([(min(dados)-0.1) (max(dados)+0.1)]);
        set(gcf, 'color', 'white');        
        xlim([xData(1) xData(end)]);
%         savefile1 = strcat('Padrao_', int2str(idt), '.eps');
%         savefile2 = strcat('Padrao_', int2str(idt), '.tiff');
%         print(h, '-deps', '-r100', savefile1);
%         print(h, '-dtiff', '-r100', savefile2);
        k = k+1;
    end
    
   
end

% print -depsc2 -r300 padroes.eps;
% print -dpdf -r300 padroes.pdf;
% print -dpng -r300 padroes.png;
% print -dtiff -r300 padroes.tiff;
% print -djpeg100 -r300 padroes.jpg; % unica forma de salvar o jpeg em resolução maior