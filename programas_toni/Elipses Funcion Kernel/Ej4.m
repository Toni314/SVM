%Examen Opti
%Ejercicio 4

clear all;
close all;
X1=[0.5 1 2.25 2.95 1 1.5 2 2.75]
X2=[1 2.5 3.5 3 0.25 1.25 1.9 1.8]

Y=[1 1 1 1 -1 -1 -1 -1]
    
X=[X1,X2];

%Restricciones

    for(i=1:8)
        A(i,:)=[-X(i,1)*Y(i), -X(i,2)*Y(i), +1*Y(i)];
    end

b=-ones(8,1);

%Funcion a maximizar
f=@(z)(-1./(z(1)^2 + z(2)^2));

z=fmincon(f,[1,1,0],A,b);

%1º
figure(1);
clf;
%axis([-3 20 -3 20]);
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

title('Separación Primal Datos a');
legend('positivos','negativos','Separador', 'Franjas');
