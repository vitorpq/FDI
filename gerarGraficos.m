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

% numero de antecedentes: n+1
ant = 20;
% padrao a ser testado
i = 1;
k = 1;
temp2 = temp;
temp2(temp2(:,end-1)==2,end-1) = 1;

for idt=padrao
    data = datapd(temp2, idt, ant);
    dados = data(:,end-2);
    
    prtyplot(dados, idt)
    
%         startDate = datenum('00:00:00');
%         [hora minu secu] = sec2hms(30*(size(dados,1)));
%         endDate = datenum(strcat(int2str(hora),':',int2str(minu),':',int2str(secu)));
%         xData = linspace(startDate, endDate, size(dados,1));
%         plot(xData, dados, 'r');
%         [xInicio xFim xpts] = limtempo(xData);
%         
%         %hTitle  = title ('My Publication-Quality Graphics');
%         hXLabel = xlabel('Time (hours)');
%         hYLabel = ylabel('Temperature (^{\circ}C)');
%         
%         
%         %xlim([xData(1) xData(end)]);
%         set(gcf, 'color', 'white');        
%         
%         
%         set( gca                       , ...
%             'FontName'   , 'Helvetica' );
% %         set([hTitle, hXLabel, hYLabel], ...
% %             'FontName'   , 'AvantGarde');
%         set([hXLabel, hYLabel], ... % Caso sem Título
%             'FontName', 'Helvetica');
%         set([hXLabel, hYLabel]  , ...
%             'FontSize', 12);
% %         set( hTitle                    , ...
% %             'FontSize'   , 12          , ...
% %             'FontWeight' , 'bold'      );
%         
%         [inicio fim ticos] = limites(dados);
%         
%         
%         set(gca, ...
%           'Box'         , 'off'     , ...
%           'TickDir'     , 'out'     , ...
%           'TickLength'  , [.02 .02] , ...
%           'XMinorTick'  , 'on'      , ...
%           'YMinorTick'  , 'on'      , ...
%           'YGrid'       , 'on'      , ...
%           'XColor'      , [.3 .3 .3], ...
%           'YColor'      , [.3 .3 .3], ...
%           'YTick'       , ticos, ...
%           'YTickLabel'  , num2str(transpose(ticos), '%0.1f'), ...
%           'YLim'        , [inicio fim], ...
%           'LineWidth'   , 1, ...
%           'XTick'       , xpts, ...
%           'XTickLabel'  , datestr(xpts, 'HH:MM'),...
%           'XLim'        , [xInicio xFim]);
% 
%         set(gcf, 'PaperPositionMode', 'auto');
%         saveeps = strcat('figs/Padrao_', int2str(idt), '_teste.eps');
%         savetiff = strcat('figs/Padrao_', int2str(idt), '_teste.tiff');
%         savepng1 = strcat('figs/Padrao_', int2str(idt), '_teste1.png');
%         savepng2 = strcat('figs/Padrao_', int2str(idt), '_teste2.png');
%         print('-depsc2', saveeps);
%         print('-dtiff', savetiff);
%         print('-dpng', savepng1);
%         print('-dpng', '-r200', savepng2);
%         close;
end