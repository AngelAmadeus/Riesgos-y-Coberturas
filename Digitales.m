%% Digitales
clear all
clc
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
%% Digitales
precio = 19.88;
vol=0.17;
montodividendo = 0.0114;%tasa moneda extranjera
detallesuby = stockspec(vol,precio,('continuous'),montodividendo); %detalles del subyacente stockspec
strike = 21;
settle = '14-jun-2018'; %fecha en que se valuo
fechaejercicio = '14-sep-2018';
opttipo = 'put';
opttipo2 = 'call';
payoff= 1;
primacalldigital = num2str(cashbybls(CurvaTasas,detallesuby,settle,fechaejercicio,opttipo,strike,payoff));
disp(['Prima Call Digital: ',num2str(primacalldigital)])
primaputdigital = num2str(cashbybls(CurvaTasas,detallesuby,settle,fechaejercicio,opttipo2,strike,payoff));
disp(['Prima Put Digital: ',num2str(primaputdigital)])