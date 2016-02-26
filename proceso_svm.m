function [ ] = proceso_svm(file_input,kernel,C_constante)
%%  proceso_svm: calcula el svm de los kernel elegidos y valores C seleccionados
  %   Captura de los datos

  [x1,x2,y] =textread(file_input,'%f%f%f','headerlines',1);

  %   escalando el gr�fico de salida
  x1min=min(x1);
  x2min=min(x2);
  x1max=max(x1);
  x2max=max(x2);
  g1min=x1min-0.30*(x1max-x1min);
  g1max=x1max+0.30*(x1max-x1min);
  g2min=x2min-0.30*(x2max-x2min);
  g2max=x2max+0.30*(x2max-x2min);

  n=size(x1,1);
  for i=1:n   
    if y(i)==1  %   +1 color verde y s�mbolo "+"
        plot(x1(i),x2(i),'+b');  
    else   %    -1 color rojo y s�mbolo "o"
        plot(x1(i),x2(i),'or');  
    end
    hold on;
  end
  axis([g1min g1max g2min g2max]);
  hold off;


    %   Representaci�n de los hiperplanos o funciones separadores
    %   Kernel lineal
    if kernel(1) == 1  
        
    end
    %   Kernel polin�mico
    if kernel(2) == 1  

    end
    %   Kernel de base radial
    if kernel(3) == 1
        
    end
    %   Kernel sigmoide
    if kernel(4) == 1  

    end
    %   Kernel polin�mico directo
    if kernel(5) == 1  

    end
    %   Kernel lineal
    if kernel(1) == 1  % Caso lineal

    end

end

