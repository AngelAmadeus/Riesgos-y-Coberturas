%% Notas
%% Opciones
clear all
clc
Opciones = {'Long(comprador/tiene el derecho)';'Short(vendedor/tiene la obligacion)'};
Call = {'de comprar';'de vender'};
Put = {'de vender';'de comprar'};
T = table(Opciones,Call,Put)
%% Griegas
clear all
clc
Griegas = {'Delta';'DeltaHedge';'Gamma';'GammaInd';'Vega';'Theta';'ThetaInd'};
Call_Corto = {'Negativo';'ComprarSubyacente';'Negativo';'ComproCaro/VendoBarato';'1';'Positivo';'TiempoAFavor/GanasDinero'};
Call_Largo = {'Positivo';'VenderSubyacente';'Positivo';'ComproBarato/VendoCaro';'6';'Negativo';'TiempoEnContra/PierdesDinero'};
Put_Corto = {'Positivo';'VenderSubyacente';'Negativo';'ComproCaro/VendoBarato';'6';'Positivo';'TiempoAFavor/GanasDinero'};
Put_Largo = {'Negativo';'ComprarSubyacente';'Positivo';'ComproBarato/VendoCaro';'6';'Negativo';'TiempoEnContra/PierdesDinero'};
T = table(Griegas,Call_Corto,Call_Largo,Put_Corto,Put_Largo)