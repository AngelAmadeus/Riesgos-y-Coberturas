%% Caps & Floors
clear all;
clc;
format bank %da los resultados en formato de dinero
%% Notas
%ir a: http://www.mexder.com.mx/wb3/wb/MEX/boletin_diario
%dar click en:  Boletín Diario de Transacciones del Mercado de Futuros
%Descargar el PDF
%ir a https://www.ilovepdf.com/es 
%transfomar e PDF a Excel
%En el Excel, buscar los datos que corresponden a:
%"FUTUROS SOBRE TIIE 28 DIAS / 28 DAY INTERBANK EQUILIBRIUM INTEREST RATE FUTURES"
%importar esos datos a MATLAB, utilizar plantilla boletina.
%El formato de las fechas en boletina es de numero incluso para las fechas
%% Curva de Tasas
FuturosTiie = xlsread('/Users/pablomendoza/Documents/ITESO/PAP_Riesgos_y_Coberturas/MATLAB/Exceles para Matlab/Boletina.xlsx','Hoja1','C3:C122')/100;
Fechas = xlsread('/Users/pablomendoza/Documents/ITESO/PAP_Riesgos_y_Coberturas/MATLAB/Exceles para Matlab/Boletina.xlsx','Hoja1','A3:A122'); %Fechas de Vencimiento
Dates = x2mdate(Fechas,0);    
FechaInicio = '23-may-2018'; %Fecha inicio del año
Reset = 12; %Numero de pagos al año
Basis = 2; %Convención de días (2 = 360) si es ISDA utilizar 12(365 días)
[cupocero, fechascurva] = fwd2zero(FuturosTiie,Dates,FechaInicio,Reset,Basis);
CurvaTasas = intenvset('Rates',cupocero,'EndDates',fechascurva,'StartDates',FechaInicio);
%% Caps
FechaFin = '23-may-2023'; %Fecha inicio del año
Reset = 4; %Periodicidad, en este caso son 4 caplets por año
Tiie = 0.08;
Vol = 0.21;
Nocional = 50000000;
Prima_Porcent = capbyblk(CurvaTasas,Tiie,FechaInicio,FechaFin,Vol); %Esto indica el porcentaje del nocional que se paga de prima
Prima_val = capbyblk(CurvaTasas,Tiie,FechaInicio,FechaFin,Vol,'principal',Nocional); %Esto indica el valor de la prima
Prima_fin = capbyblk(CurvaTasas,Tiie,FechaInicio,FechaFin,Vol,'principal',Nocional,'Reset',Reset); %Esto indica los pagos
[Prima, x] = capbyblk(CurvaTasas,Tiie,FechaInicio,FechaFin,Vol,'principal',Nocional,'Reset',Reset); %Esto indica el valor de cada caplet
disp(['CAPS'])
disp(['Porcentaje de la Prima: ',num2str(Prima_Porcent)])
disp(['Precio de la Prima: ',num2str(Prima_val)])
disp(['Valor de los pagos: ',num2str(Prima_fin)])
disp(['Valor de cada Caplet: ',num2str(x)])
disp([' '])
%% Floors
FechaFin = '23-may-2023'; %Fecha inicio del año
Reset = 4; %Periodicidad, en este caso son 4 caplets por año, y son 5 años
Tiie = 0.08;
Vol = 0.21;
Nocional = 50000000;
Prima_Porcent = floorbyblk(CurvaTasas,Tiie,FechaInicio,FechaFin,Vol); %Esto indica el porcentaje del nocional que se paga de prima
Prima_val = floorbyblk(CurvaTasas,Tiie,FechaInicio,FechaFin,Vol,'principal',Nocional); %Esto indica el valor de la prima
Prima_fin = floorbyblk(CurvaTasas,Tiie,FechaInicio,FechaFin,Vol,'principal',Nocional,'Reset',Reset); %Esto indica los pagos, el reset deterina la cantidad de pagos anuales, si no lo tiene se considera un pago 
[Prima, x] = floorbyblk(CurvaTasas,Tiie,FechaInicio,FechaFin,Vol,'principal',Nocional,'Reset',Reset); %x indica el valor de cada caplet
disp(['FLOORS'])
disp(['Porcentaje de la Prima: ',num2str(Prima_Porcent)])
disp(['Precio de la Prima: ',num2str(Prima_val)])
disp(['Valor de los pagos: ',num2str(Prima_fin)])
disp(['Valor de cada Caplet: ',num2str(x)])