function [ ] = rot_tras( file_in,trasx,trasy,rot )
%% coge los datos del fichero file_in y los traslada y rota en las magnitudes:
%   trasx,trasy,rot
%  los datos los graba con el mismo formato en el fichero file_out


[x1,x2,y] =textread(file_in,'%f%f%f','headerlines',1);
n=size(x1,1);

file_out='trans.txt';
fout=fopen('trans.txt','w');
fprintf(fout,'Fichero transformado: %s, %f %f %f \n',file_in,trasx,trasy,rot);

xx=zeros(2,1);
xxx=zeros(2,1);
ROT = [cos(rot) sin(rot) ; -sin(rot) cos(rot)];
for i=1:n
    % primero se traslada
    xx(1)=x1(i)+trasx;
    xx(2)=x2(i)+trasy;
    
    % luego se rota
    xxx=ROT*[xx(1);xx(2)];
    
    fprintf(fout,'%f %f %f \n',xxx(1),xxx(2),y(i));

end


fclose(fout);

end

