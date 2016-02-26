function [z,fopt,exit] = primal(xpos,xneg)
%X matriz de datos
global clase;
global x;
X=[xpos;xneg]
n=size(X,1)
Y=[ones(size(xpos,1),1);-ones(size(xneg,1),1)]
%Restricciones
    for(i=1:n)
        A(i,:)=[-X(i,1)*Y(i), -X(i,2)*Y(i), +1*Y(i)];
    end

b=-ones(n,1);

%Funcion a maximizar
f=@(z)(-1./(z(1)^2 + z(2)^2));
%z(3)=b

[z,fopt,exit]=fmincon(f,[1,1,0],A,b);
if(exit~=1)
    z=0; fopt=0;
    open('error1.fig');
end

%1º
cuadra(xpos(:,1),xpos(:,2),xneg(:,1),xneg(:,2));
plot(xpos(:,1),xpos(:,2),'+r',xneg(:,1),xneg(:,2),'bo');
 
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

legend('Positivos','Negativos');

hold off;
%Clasifica
if(z(1)*x(1)+z(2)*x(2)<z(3))
    clase=-1;
elseif(z(1)*x(1)+z(2)*x(2)>z(3))
    clase=+1;
else
    clase=0;
end
end