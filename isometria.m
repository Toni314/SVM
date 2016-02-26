function Y = isometria( X,lambda1,lambda2,theta )
%X matriz de datos de n filas 2 columnas
%Se devuelve la isometria X de traslación con rotación
n=size(X,1)
Y=X-[lambda1*ones(n,1),lambda2*ones(n,1)];
Y=Y*[cos(theta), -sin(theta);sin(theta),cos(theta)];
end
