%% Swaption
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
%% Swaption
Fecha_entro_o_no = '24-sep-2018';
FechaFin_Swaption = '24-sep-2023';
Vol_Implicita = 0.24;
Nocional = 50000000;
Prima_Swaption_percent = swaptionbyblk(CurvaTasas,'call',0.085,FechaInicio,Fecha_entro_o_no,FechaFin_Swaption,Vol_Implicita);
Prima_Swaption = swaptionbyblk(CurvaTasas,'call',0.085,FechaInicio,Fecha_entro_o_no,FechaFin_Swaption,Vol_Implicita,'principal',Nocional);
%Si el strike es mas bajo que la tasa, ya gané
%El que compra el swaption payer o receiver es el que paga la prima
disp(['Porcentaje de Prima del Swaption: ',num2str(Prima_Swaption_percent)])
disp(['Prima del Swaption: ',num2str(Prima_Swaption)])
