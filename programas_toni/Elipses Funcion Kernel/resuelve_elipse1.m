%Ejercicio 4
function [exitflag,w,b1,b2] = resuelve_elipse1( nombre,h)
fichero=fopen(nombre,'r');
n=fscanf(fichero,'%d')

[xpos,ypos,xneg,yneg]=leer(nombre,n,h);

[V1,V2,Y]=textread(nombre,'%f %f %f',n,'headerlines',h)

%Hacer optimtool con elipse_trans_dual para obtener las alfas

%Obtenemos los resultados
alfa=0.1*ones(1,n);

[alfa,fval,exitflag]=fmincon(@(alfa)(elipse_trans_dual(nombre,alfa,n,h)),alfa',[],[],Y',0,zeros(1,n),[])

if(exitflag~=1)
    w=0;b1=0;b2=0;
    return;
end

z=trans(nombre,n,h);

%Calculo de w (generalizar)
w=(Y.*alfa)'*z;

%Caso con indices cualesquiera, que cumplan la condición siguiente (no
%funciona)

% while(ind1==ind2 || Y(ind1)==Y(ind2) || abs(alfa(ind1))<0.0001 || abs(alfa(ind2))<0.0001)
%       if(ind1==n)
%           ind1=1;
%           ind2=ind2+1;
%       end
%       ind1=ind1+1;
% end
% ind1
% ind2

% b1=w*z(ind1,:)';
% b2=w*z(ind2,:)';


%Caso cogiendo máximo y mínimo correspondiente según categoria
ind1=0;
mmin=Inf;
mmax=-Inf;
ind2=0;

%Tomamos el indice que tiene alfa máximo, de los de categoria -1
%Tomamos el indice que tiene alfa mínimo, de los de categoria +1

for i=1:n
    if abs(alfa(i)) > 0.001
        if Y(i)==1 && alfa(i) < mmin
            mmin=alfa(i);
            ind1=i;
        end
        if Y(i)==-1 && alfa(i) > mmax
            mmax=alfa(i);
            ind2=i;
        end        
    end
end

b1=w*z(ind1,:)';
b2=w*z(ind2,:)';

b=(b1+b2)/2;

%Dibujar
%axis([-1 4 -1 4]);
hold on;
plot(xpos,ypos,'+r',xneg,yneg,'go');
ezplot(@(x1,x2)elipse(x1,x2,w,b));
setcurve('color','red','linestyle','-','linewidth',2);
ezplot(@(x1,x2)elipse(x1,x2,w,b1));
setcurve('color','blue','linestyle','-','linewidth',1);
ezplot(@(x1,x2)elipse(x1,x2,w,b2));
setcurve('color','blue','linestyle','-','linewidth',1);

title('Separación Elipse Datos d');
legend('positivos','negativos','Separador', 'Franjas');

