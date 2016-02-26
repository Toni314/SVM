function [ y ] = kernel_pol(x,n,X,Y,alfa,delta,g,cte)
%Funci�n de clasificaci�n del kernel polin�mico de par�metros (delta,g)
 y=-cte;
 
 for i=1:n
     y=y+alfa(i)*Y(i)*(delta+X(i,:)*x')^g;
 end
end
