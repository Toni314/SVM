%Ejercicio 4
%Funcion que separa los datos clasificados M según la clasificación V, y
%los guarda en xpos, xneg
function [ xpos,xneg,pos,neg] = separa( M,V)
    n=size(M,1);
    d=size(M,2);
    pos=0;neg=0;
    for i=1:n
        if(V(i)==1)
            pos=pos+1;
            xpos(pos,:)=M(i,:);  
        end
        if(V(i)==-1)
            neg=neg+1;
            xneg(neg,:)=M(i,:);
        end
    end
end
