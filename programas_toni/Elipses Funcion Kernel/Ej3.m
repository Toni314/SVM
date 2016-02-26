%Examen Técnicas Optimización
%Ejercicio 3

%Vector de compatibilidades
%Se entiende como un vector yuxtaponiendo los vectores fila de la matriz
%descrita en el examen
C=[1 0 0 0 0 0 1 0 0 0 0 0 1 1 1 1 0 0 0 1 0 0 0 0 0 0 1 1 1 1];

%Funcion a minimizar (Recordamos que es la suma de todos los componentes de
%nuestra matriz M
f=-ones(30,1);

%Restricciones
A=[
    %Restriccion 1 trabajador , como maximo en un puesto de trabajo
    1 1 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
    0 0 0 0 0 0 1 1 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
    0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0
    0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 0 0 0 0 0 0
    0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 1 1 1 1
    %Restriccion puesto de trabajo, como mucho, para cada trabajador
    1 0 0 0 0 0 1 0 0 0 0 0 1 0 0 0 0 0 1 0 0 0 0 0 1 0 0 0 0 0
    0 1 0 0 0 0 0 1 0 0 0 0 0 1 0 0 0 0 0 1 0 0 0 0 0 1 0 0 0 0
    0 0 1 0 0 0 0 0 1 0 0 0 0 0 1 0 0 0 0 0 1 0 0 0 0 0 1 0 0 0
    0 0 0 1 0 0 0 0 0 1 0 0 0 0 0 1 0 0 0 0 0 1 0 0 0 0 0 1 0 0
    0 0 0 0 1 0 0 0 0 0 1 0 0 0 0 0 1 0 0 0 0 0 1 0 0 0 0 0 1 0
    0 0 0 0 0 1 0 0 0 0 0 1 0 0 0 0 0 1 0 0 0 0 0 1 0 0 0 0 0 1
];
%Restriccion de las compatibilidades

A=[A;eye(30)];

%Restricciones R1 R2
b=ones(1,11);
%Restriccion de compatibilidades
b=[b,C];

[z,zval]=bintprog(f,A,b);
z
zval
