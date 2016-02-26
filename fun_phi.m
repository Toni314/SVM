
%Funcion phi sacada de kernel polinómico (caso más general)
%x vector d-dimensional
%d=size(x)
%g parámetro
%a>=0

function [ phi ] = fun_phi( x,g,a )
%para que funcione tanto en vectores horizontales como verticales
d=size(x,2)*size(x,1);
phi=[];

%a distinto de 0
if(a>0.0001)
    %se considera que tenemos una dimensión más
    %x vector horizontal
    
    x=[x,sqrt(a)];
    d=d+1;
end
[phi,k]=nfors(0,d,g,x,1,phi,0);
end

