function [ xinf,xsup,yinf,ysup ] = cuadra( xpos,ypos,xneg,yneg )
xmin=min(min(xpos),min(xneg));
ymin=min(min(ypos),min(yneg));
xmax=max(max(xpos),max(xneg));
ymax=max(max(ypos),max(yneg));

%   Límites del gráfico
xinf=xmin-0.3*(xmax-xmin)
xsup=xmax+0.3*(xmax-xmin)
yinf=ymin-0.3*(ymax-ymin)
ysup=ymax+0.3*(ymax-ymin)

axis([xinf xsup yinf ysup]);
hold on;
end

