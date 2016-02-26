function Y = traslacion( X,lambda1,lambda2 )
%X matriz de datos de n filas 2 columnas
%Se devuelve la isometria X de traslación
n=size(X,1)
Y=X-[lambda1*ones(n,1),lambda2*ones(n,1)];
end
