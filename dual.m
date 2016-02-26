function [alfa,fopt,exit] = dual(xpos,xneg)
X=[xpos;xneg];
n=size(X,1)
Y=[ones(size(xpos,1),1);-ones(size(xneg,1),1)]

global clase;
global x;

b=-ones(n,1);

%alfa=ones(8,1);
%0.5*(alfa.*Y)'*X*(X')*(Y.*alfa)-sum(alfa)
%fundual1(ones(8,1))
 

%Calculamos alfa con optimtools y nos da:
x0=0.1*ones(n,1);
lb=zeros(n,1);
[alfa,fval,exit]=fmincon(@(alfa)fdual1( alfa,xpos,xneg,Y),x0,[],[],Y',0,lb,[]);
if(exit~=1)
    alfa=0; fopt=0;
    open('error1.fig');
end
alfa
%Calculamos w con la transformación:
w=X'*(alfa.*Y)
%Y calculamos b promediando entre valores opuestos

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

b1=X(ind1,:)*w;
b2=X(ind2,:)*w;

b=(b1+b2)/2;

cuadra(xpos(:,1),xpos(:,2),xneg(:,1),xneg(:,2));

plot(xpos(:,1),xpos(:,2),'+r',xneg(:,1),xneg(:,2),'bo');
 
x1=0;y1=(b-x1*w(1))./w(2);
x2=10;y2=(b-x2*w(1))./w(2);
plot([x1,x2],[y1,y2],'c--','LineWidth',3);
 
x1=0;y1=(b+1-x1*w(1))./w(2);
x2=10;y2=(b+1-x2*w(1))./w(2);
plot([x1,x2],[y1,y2],'y--','LineWidth',2);
 
x1=0;y1=(b-1-x1*w(1))./w(2);
x2=10;y2=(b-1-x2*w(1))./w(2);
plot([x1,x2],[y1,y2],'y--','LineWidth',2);

legend('Positivos','Negativos');

hold off;
%Clasifica
if(w(1)*x(1)+w(2)*x(2)<b)
    clase=-1;
elseif(w(1)*x(1)+w(2)*x(2)>b)
    clase=+1;
else
    clase=0;
end