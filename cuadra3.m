function [ xinf,xsup,yinf,ysup ] = cuadra3( z1,z2,z3 )
z1min=min(min(z1));
z2min=min(min(z2));
z3min=min(min(z3));
z1max=max(min(z1));
z2max=max(min(z2));
z3max=max(min(z3));

%   Límites del gráfico
z1inf=z1min-0.3*(z1max-z1min);
z1sup=z1max+0.3*(z1max-z1min);
z2inf=z1min-0.3*(z1max-z1min);
z2sup=z1max+0.3*(z1max-z1min);
z1inf=z1min-0.3*(z1max-z1min);
z1sup=z1max+0.3*(z1max-z1min);

axis([xinf xsup yinf ysup]);
hold on;
end

