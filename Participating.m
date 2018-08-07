%% Participating
clear all;
clc;
format bank
%% Notas
%ir a: http://www.mexder.com.mx/wb3/wb/MEX/boletin_diario
%dar click en:  Boletín Diario de Transacciones del Mercado de Futuros
%Descargar el PDF
%ir a https://www.ilovepdf.com/es 
%transfomar e PDF a Excel
%En el Excel, buscar los datos que corresponden a:
%"FUTUROS SOBRE TIIE 28 DIAS / 28 DAY INTERBANK EQUILIBRIUM INTEREST RATE FUTURES"
%importar esos datos a MATLAB, utilizar plantilla boletina.
%% Curva de Tasas
FuturosTiie = xlsread('/Users/pablomendoza/Documents/ITESO/PAP_Riesgos_y_Coberturas/MATLAB/Exceles para Matlab/Boletina.xlsx','Hoja1','C3:C122')/100;
Fechas = xlsread('/Users/pablomendoza/Documents/ITESO/PAP_Riesgos_y_Coberturas/MATLAB/Exceles para Matlab/Boletina.xlsx','Hoja1','A3:A122'); %Fechas de Vencimiento
Dates = x2mdate(Fechas,0);    
FechaInicio = '23-may-2018'; %Fecha inicio del año
Reset = 12; %Numero de pagos al año
Basis = 2; %Convención de días (2 = 360) si es ISDA utilizar 12(365 días)
[cupocero, fechascurva] = fwd2zero(FuturosTiie,Dates,FechaInicio,Reset,Basis);
CurvaTasas = intenvset('Rates',cupocero,'EndDates',fechascurva,'StartDates',FechaInicio);
%% Call Vanilla
precio = 20.65;%precio spot del subyacente
strike = [20.76];%precio de ejercicio
tasa = 0.0763; %tasa libre de riesgo
tiempo = [30/360]; %tiempo expresado en años
volatilidad = 0.1770; %volatilidad implicita
yield = 0.0182; %tasa de dividendos o en tipo de cambio rf de la otra moneda 
[primacall primaput] = blsprice(precio,strike,tasa,tiempo,volatilidad,yield);
%% Total
Total1 = primacall*1000000;
Total2 = primaput*500000;
disp(['Precio nocional de 1 millon: ',num2str(Total1)])
disp(['Precio nocional de medio millon: ',num2str(Total2)])
