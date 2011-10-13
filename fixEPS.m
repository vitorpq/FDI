function fixEPS(file)
% SUMMARY Corrigir as linhas dos graficos EPS
    fixedfile = strrep(file, '.eps', '-fixed.eps');
    fixPSlinestyle(file, fixedfile);
end