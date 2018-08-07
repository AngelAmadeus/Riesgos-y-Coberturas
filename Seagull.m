%% Seagull
clear all
clc
%Notas

%% Long Put
precio = 19.88;%precio spot del subyacente
strike = [21];%precio de ejercicio
tasa = 0.0797; %tasa libre de riesgo
tiempo = [120/360]; %tiempo expresado en años
volatilidad = 0.1529; %volatilidad implicita
yield = 0.0213; %tasa de dividendos o en tipo de cambio rf de la otra moneda 
[primacall pput] = blsprice(precio,strike,tasa,tiempo,volatilidad,yield);
disp(['Prima Long Put: ',num2str(pput)])
%% Short Put
precio = 19.88;%precio spot del subyacente
strike = [20.60];%precio de ejercicio
tasa = 0.0797; %tasa libre de riesgo
tiempo = [120/360]; %tiempo expresado en años
volatilidad = 0.1485; %volatilidad implicita
yield = 0.0213; %tasa de dividendos o en tipo de cambio rf de la otra moneda 
[primacall pputshort] = blsprice(precio,strike,tasa,tiempo,volatilidad,yield);
disp(['Prima Short Put: ',num2str(pputshort)])
%% Short Call
precio = 19.88;%precio spot del subyacente
strike = [21.2];%precio de ejercicio
tasa = 0.0797; %tasa libre de riesgo
tiempo = [120/360]; %tiempo expresado en años
volatilidad = 0.1529; %volatilidad implicita
yield = 0.0213; %tasa de dividendos o en tipo de cambio rf de la otra moneda 
[primacalls] = blsprice(precio,strike,tasa,tiempo,volatilidad,yield);
disp(['Prima Short Call: ',num2str(primacalls)])
%% Total
total = pput - pputshort - primacalls;
disp(['El cliente paga: ',num2str(total)])
