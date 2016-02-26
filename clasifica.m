function [ J,clase ] = clasifica( w,x,b )
J=w*x'+b;
if(J>=0)
    clase=1;
else
    clase=-1;
end
end