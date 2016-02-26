%Ejercicio 4
%Funcion que lee los datos para distinguirlos y representarlos
function [ xpos,ypos,xneg,yneg ] = leer( nombre,n,h)
    [V1,V2,C]=textread(nombre,'%f %f %f',n,'headerlines',h);
    pos=1;neg=1;
    for i=1:n
        if(int8(C(i))==1)
            xpos(pos)=V1(i);
            ypos(pos)=V2(i);
            pos=pos+1;
        end
        if(int8(C(i))==-1)
            xneg(neg)=V1(i);
            yneg(neg)=V2(i);
            neg=neg+1;
        end
    end
end
