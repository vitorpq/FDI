function dispresults(results)
%% DISPRESULTS Summary of this function goes here
%   Detailed explanation goes here
    disp(' Padrão |    LOO   |   RMSE ');
    disp('-----------------------------');
    for i = 1:length(results)
        if ~isempty(results(i).padrao)
            Str = sprintf('   %2d   | %1.6f | %1.5f ', (i-1), results(i).LOO, results(i).RMSE);
            %Str = ['Padrão ', num2str(i), '  LOO: ', num2str(results(i).LOO), '  RMSE: ', num2str(results(i).RMSE)];
            disp(Str);
        end
end

