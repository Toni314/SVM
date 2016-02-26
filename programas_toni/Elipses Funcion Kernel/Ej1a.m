%Práctica 4
%Ejercicio 1
%Apartado a)

clear all;
close all;
%Restricciones
A=[1 2];
b=4;
lb=[0,0];
x0=[-5,0];

options=optimset('Algorithm','sqp');
[z,val,flag]=fmincon(@fun_a,x0,A,b,[],[],lb,[],@restr_a),options;
