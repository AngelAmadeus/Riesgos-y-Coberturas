%% SWAP
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
%% SWAP Payer
FechaFin = '24-may-2028';
%Para Calcular Tasa
Tasa_Recibo = 0;
Tasa_Pago = NaN;
[Swap x] = swapbyzero(CurvaTasas,[Tasa_Recibo Tasa_Pago],FechaInicio,FechaFin,'legreset',[12 1],'legtype',[0 1]); %recibir variable y pagar fija
disp(['Tasa SWAP Payer: ',num2str(x)])
%Para Calcular diferencia a pagar o recibir (Off Market)
Tasa_Recibo = 0;
Tasa_Pago = 0.0709;
[Swap x] = swapbyzero(CurvaTasas,[Tasa_Recibo Tasa_Pago],FechaInicio,FechaFin,'legreset',[12 1],'legtype',[0 1],'principal',10000000);
disp(['Precio SWAP Payer: ',num2str(Swap)])
%% SWAP Receiver
FechaFin = '24-may-2028';
%Para Calcular Tasa
Tasa_Recibo = 0;
Tasa_Pago = NaN;
[Swap x] = swapbyzero(CurvaTasas,[Tasa_Pago Tasa_Recibo],FechaInicio,FechaFin,'legreset',[1 12],'legtype',[1 0]);
disp(['Tasa SWAP Receiver: ',num2str(x)])
%Para Calcular diferencia a pagar o recibir (Off Market)
Tasa_Recibo = 0;
Tasa_Pago = 0.0719;
[Swap x] = swapbyzero(CurvaTasas,[Tasa_Pago Tasa_Recibo],FechaInicio,FechaFin,'legreset',[1 12],'legtype',[1 0],'principal',50000000);
disp(['Precio SWAP Receiver: ',num2str(Swap)])