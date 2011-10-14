# FDI - Fault Detection and Isolation


## Overview

MATLAB scripts for FDI. The study case is based in temperature sensors
failures.


## Requirements

* [Gnuplot-py] [2] for fuzzy number visualization.
* [PyDot] [4] for graph and fuzzy graph visualizations.

[Epydoc] [3] is required for generating API documentation (optional).


## Documentation and Examples


## Core Functionality


[1]: http://www.python.org
[2]: http://gnuplot-py.sourceforge.net
[3]: http://epydoc.sourceforge.net
[4]: http://code.google.com/p/pydot/

## Notations

Dados:
 - Foram usados os padrões: 0, 1, 2, 7, 8, 9, 10, 11, 12, 13, 14
 - Os padrões 1 e 2 foram unificados, o padrão 2 passou a ser chamado de 1 (coluna 2 (padrão))
 - O padrão 14 não foi usado por ser muito pequeno (183 ptos)
Legenda: 0 - Normal; 1 - Bias; 2 - Rompido
 Padrão     Legenda
    0           0
    1           1
    7           1
    8           2
    9           2
    10          2
    11          2
    12          2
    13          2
    14          0



Nesta versão:
 - Usar os 14 padrões - OK
 - 20 antecedentes - OK
 - Testar o "WINNER TAKES ALL"
 - Fazer o leaving-one-out para validar
 - Verificar as porcentagens
 - Talvez: retirar as regras conflitantes
 - Otimizar com OLS
