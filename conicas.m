function [ output_args ] = conicas( xpos,xneg,ypos,yneg,Y )
%conicas (d=2)
%u11,u12,u21,u22 <-> zopt(1:4)
%lambda1,lambda2 <-> zopt(5:6)
%lambda, R       <-> zopt(7:8)
%
n=length(Y);
[yopt,fopt,exit]=fmincon(@fobj,y0,[],[],[],[],lb,ub,@(z)nonlincon(z,xneg,xpos));

function [c,ceq] = nonlincon(y,xneg,xpos)
%     xneg son los datos interiores de la elipse menor (y=-1)
%     xpos son los datos exteriores de la elipse mayor (y=+1)
 hold on;
%     plot(xneg,'ro');
%     plot(xpos,'go');

xneg(:,1)=xneg(:,1)-y(5);
xneg(:,2)=xneg(:,2)-y(6);
xpos(:,1)=xpos(:,1)-y(5);
xpos(:,2)=xpos(:,2)-y(6);

xnegaux(:,1)=xneg(:,1)*cos(y(4))+xneg(:,2)*sin(y(4));
xnegaux(:,2)=-xneg(:,1)*sin(y(4))+xneg(:,2)*cos(y(4));

xposaux(:,1)=xpos(:,1)*cos(y(4))+xpos(:,2)*sin(y(4));
xposaux(:,2)=-xpos(:,1)*sin(y(4))+xpos(:,2)*cos(y(4));


    c = [xnegaux(:,1).^2 / y(1)^2 + xnegaux(:,2).^2 /y(2)^2 - y(3)^2; ...
        1- xposaux(:,1).^2 / y(1)^2 - xposaux(:,2).^2 /y(2)^2 ];
    ceq = [ ];
 end
hold off;
end



end