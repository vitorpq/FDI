function [out_l, out_u] = OutSet2(antecedentes, MFpar)
    %% OutSet2 function para calculo do conjunto de saida de cada regra
    
    y = 0:0.001:2;
    j = 0:3:57; % determinado por ser 20 antecedentes
    % Para zerar a agregacao dos antecedentes
    A_l = 1;
    A_u = 1;

    for a = 1:20
        %% Entradas para os antecedentes
        input = antecedentes(a);
        % assign the correct parameters for each antecedent
        pars = parfunc2(MFpar, a, j(a));
        mf = gauss4mf(input, pars);
        % aggregate all antecedents
        A_u(a) = mf.u;
        A_l(a) = mf.l;
    end
    
    %% Firing Level
    Fl_u = prod(A_u);
	Fl_l = prod(A_l);
    
    %% Consequents
    dom = MFpar(2);
    G = trimf(y, [dom-0.5 dom dom+0.5]);
            
    %% Implication
    % Rule output set
    out_u = (Fl_u .* G);
    out_l = (Fl_l .* G);
    
 % ----VELHO-----
%             J = 0;
%             % Para zerar a agregacao dos antecedentes
%             A_u = 1;
%             A_l = 1;
%             for a = 1:((size(MFpar,2)-2)/4)
% 
%                 % parametros do antecedente
%                 pars(r,a).m1 = MFpar(r, a+2+J);
%                 pars(r,a).s1 = MFpar(r, a+3+J);
%                 pars(r,a).m2 = MFpar(r, a+4+J);
%                 pars(r,a).s2 = MFpar(r, a+5+J);
%                 J = J + 3;
% 
%                 mf = gauss4mf(entrada(a), pars(r,a));
% 
%                 % agregacao dos antecedentes
%     %             A_u = (A_u * mf.u);
%     %             A_l = (A_l * mf.l);
%                 A_u(r,a) = mf.u;
%                 A_l(r,a) = mf.l;
%             end
%             % Consequents
%             G(r,:) = trimf(y, [MFpar(r, 2)-0.5 MFpar(r, 2) MFpar(r, 2)+0.5]);
%             Firing_u(r) = prod(A_u(r,:));
%             Firing_l(r) = prod(A_l(r,:));
%             % Implication
%             OutSet_u(r,:) = (Firing_u(r) .* G(r,:));
%             OutSet_l(r,:) = (Firing_l(r) .* G(r,:));
end