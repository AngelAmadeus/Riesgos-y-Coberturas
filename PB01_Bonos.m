%% PB01
clc;
clear all;
%Cambio en el valor de un portafolio o instrumento por el cambio de un punto base
%% Usos
%Portaflio de Inversion 
%Cobertura de Bonos M y un swap
%% Datos
Cant_Bonos = 134567;
Rend_Bono = 0.0780;
Rend_Bono_2 = 0.0781;
Cupon = 0.085;
Today = '28-may-2018';
Vencimiento = '05-jun-2027';
A = bndprice(Rend_Bono, Cupon, Today, Vencimiento);
B = bndprice(Rend_Bono_2, Cupon, Today, Vencimiento);
PB_01 = A-B;
Precio = PB_01 * Cant_Bonos;
disp(['PB01: ',num2str(PB_01)])
disp(['Valor del PB01: ',num2str(Precio)])