function Y = traslacion3( Z,lambda1,lambda2,lambda3 )
%X matriz de datos de n filas 2 columnas
%Se devuelve la isometria X de traslación
n=size(Z,1)
Z=Z-[lambda1*ones(n,1),lambda2*ones(n,1),lambda3*ones(n,1)];
end
