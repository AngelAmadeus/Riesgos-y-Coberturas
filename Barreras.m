%% Barreras
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
%% Barreras
vol=0.1391;
precioactivo = 19.1;
montodividendo = 0.0197;%tasa moneda extranjera
detallesuby = stockspec(vol,precioactivo,('continuous'),montodividendo); %detalles del subyacente stockspec
opttipo = 'put';
strike =19.3;
settle = '11-jul-2018'; %fecha en que se valuo
fechaejercicio = '11-oct-2018';
barreratipo1 = 'DI'; %TIPO DE barrera que es DO=DOWN&OUT,UO=UP&OUT,DI=DOWN&IN,UI=UP&IN
barreratipo2 = 'DO'; %TIPO DE barrera que es DO=DOWN&OUT,UO=UP&OUT,DI=DOWN&IN,UI=UP&IN
barreratipo3 = 'UI'; %TIPO DE barrera que es DO=DOWN&OUT,UO=UP&OUT,DI=DOWN&IN,UI=UP&IN
barreratipo4 = 'UO'; %TIPO DE barrera que es DO=DOWN&OUT,UO=UP&OUT,DI=DOWN&IN,UI=UP&IN
barrera = 18.70;
primaKOCall= barrierbybls(CurvaTasas,detallesuby,opttipo,strike,settle,fechaejercicio,barreratipo1,barrera);
disp(['Prima de la Barrera: ',num2str(primaKOCall)])