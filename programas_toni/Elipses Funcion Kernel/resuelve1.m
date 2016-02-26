%Ejercicio 4

clear all;
[xpos,ypos,xneg,yneg]=leer('ej4.txt',8,2);

[V1,V2,Y]=textread('ej4.txt','%f %f %d',8,'headerlines',2);
X=[V1,V2];

%Restricciones
    for(i=1:8)
        A(i,:)=[-X(i,1)*Y(i), -X(i,2)*Y(i), +1*Y(i)];
    end
b=-ones(8,1);

%Funcion a maximizar (la opuesta de la funcion a minimizar
f=@(z)(-1./(z(1)^2 + z(2)^2));

[z,zval]=fmincon(f,[1,1,0],A,b)

%1º
figure(1);
clf;
%axis([-1 7 -1 7]);
hold on;
plot(xpos,ypos,'+r',xneg,yneg,'bo');

x1=0;y1=(z(3)-x1*z(1))./z(2);
x2=10;y2=(z(3)-x2*z(1))./z(2);
plot([x1,x2],[y1,y2],'c--','LineWidth',3);

x1=0;
y1=(z(3)-1-x1*z(1))./z(2);
x2=10;
y2=(z(3)-1-x2*z(1))./z(2);
plot([x1,x2],[y1,y2],'m--','LineWidth',2);

x1=0;
y1=(z(3)+1-x1*z(1))./z(2);
x2=10;
y2=(z(3)+1-x2*z(1))./z(2);
plot([x1,x2],[y1,y2],'m--','LineWidth',2);

title('Separación Primal Ejercicio 4');
legend('positivos','negativos','Separador', 'Franjas');
