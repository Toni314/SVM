%Funciona!

%phi y k actuarian Como globales

%r indica en que indice o posición nos encontramos (de 1 a d)
%resto indica el nº máximo de iteraciones para el siguiente indice
%x es el vector d-dimensional (x1,...,xd)
%aux variable auxiliar para calcular el producto que será una phi(k)

%inicializacion
%r=0
%resto=g
%aux=1
%global k=0
%global phi (vacía)

function [ phi, k] = nfors( r,d,resto,x,aux,phi,k )
    r=r+1;
    if(r==d)
        k=k+1;
        aux=aux*(x(d)^resto);
        phi(k)=aux;
    else
        %no deja hacerlo de 0 a resto, hacemos correr los indices
        for(i=1:resto+1)
            naux=aux*sqrt(nchoosek(resto,(i-1)))*(x(r)^(i-1));
            [phi,k]=nfors(r,d,resto-i+1,x,naux,phi,k);
        end
    end

end
%Con esto se consigue generalizar svm con kernel polinómico en dimensiones
%superiores
