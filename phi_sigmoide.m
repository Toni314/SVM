function [ phi ] = phi_sigmoide( delta,delta0,x )
%Recordemos que k(x,z)=tanh(delta x^t z + delta0)
%Hay que encontrar phi: R^d --> R^q tal que k(x,z)=phi(x)^t * phi(z)

%Como en la base radial, es posible que q=Inf, pues

%tanh(  (e^x - e^(-x)) / ( e^x + e^(-x) )

%Que es funci�n de exponenciales, y muy probablemente tenga una expresi�n
%en serie de Taylor de infinitos t�rminos.

%No es un problema trivial, y habr�a que pensarlo con detenimiento para
%encontrar una buena soluci�n.

end

