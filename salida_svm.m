function salida_svm(file_input,kernel)
%%  salida_svm (gr�fica y de texto)

%   Se lee la primera l�nea del fichero de datos, que lo identifica
fin=fopen(file_input);
tline = fgetl(fin);

%   Se abre el fichero de salida, que se mostrar� en la pantalla
fout=fopen('fsalida','w');
fprintf(fout,'SVM, Support Vector Machine \n');
fprintf(fout,'Fichero de entrada: '); 
fprintf(fout,' %s ',file_input);
fprintf(fout,' (%s) \n',tline);
if kernel(1)==1
    fprintf(fout,'Funci�n de kernel lineal \n');
end
if kernel(2)==1
    fprintf(fout,'Funci�n de kernel polin�mica \n');
end
if kernel(3)==1
    fprintf(fout,'Funci�n de kernel de base radial \n');
end
if kernel(4)==1
    fprintf(fout,'Funci�n de kernel sigmoid \n');
end
if kernel(5)==1
    fprintf(fout,'Funci�n de kernel polin�mica directa \n');
end



end

