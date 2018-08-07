%% Opciones Vanilla
clear all
clc
%notas

%% Vanillas
precio = 18.88;%precio spot del subyacente
strike = [19.05 18.85];%precio de ejercicio
tasa = [0.0772]; %tasa libre de riesgo
tiempo = 7/360; %tiempo expresado en años
volatilidad = [.135 .137] ; %volatilidad implicita
yield = [0.0192]; %tasa de dividendos o en tipo de cambio rf de la otra moneda 
[primacall primaput] = blsprice(precio,strike,tasa,tiempo,volatilidad,yield);
total = primacall(1)+ primaput(2);
disp(['Precio Total: ',num2str(total)])