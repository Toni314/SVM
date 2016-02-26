function varargout = svm(varargin)
% SVM MATLAB code for svm.fig
%      SVM, by itself, creates a new SVM or raises the existing
%      singleton*.
%
%      H = SVM returns the handle to a new SVM or the handle to
%      the existing singleton*.
%
%      SVM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SVM.M with the given input arguments.
%
%      SVM('Property','Value',...) creates a new SVM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before svm_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to svm_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help svm

% Last Modified by GUIDE v2.5 06-Sep-2015 19:42:41

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @svm_OpeningFcn, ...
                   'gui_OutputFcn',  @svm_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT



% --- Executes just before svm is made visible.
function svm_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to svm (see VARARGIN)

% Choose default command line output for svm
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes svm wait for user response (see UIRESUME)
% uiwait(handles.figure1);

%Sustituir aquí por el nombre del fichero
%Fichero por defecto, modificado luego por el fichero deseado
%file_output=fileread('elipse0.txt');
%set(handles.text4,'String',file_output);

global metodo;
metodo='Lineal Primal Hard';

% --- Outputs from this function are returned to the command line.
function varargout = svm_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%   LECTURA DEL FICHERO DE DATOS
% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global  file_input;
global metodo;
file_input=uigetfile('.txt');

global archivo;
archivo=fileread(file_input);

global Nombre;
Nombre=string(file_input)
fic=fopen(Nombre,'r');

n=fscanf(fic,'%d');
global xpos;
global ypos;
global xneg;
global yneg;
global Y;

[xpos,ypos,xneg,yneg]=leer(Nombre,n,2)


%   EJECUCIÓN
% Ejecutar
function pushbutton2_Callback(hObject, eventdata, handles)
%   Control de los checkbox
global xpos;
global ypos;
global xneg;
global yneg;
global Y;
global archivo;
global Nombre;
%x=(x(1),x(2)) nueva observación a clasificar
global x;
global clase;
global dibujo;
dibujo=handles.grafico;

x=[str2double(get(handles.P1,'String')),str2double(get(handles.P2,'String'))];
%contents = cellstr(get(handles.metodo,'String'));
%metodo=contents{get(handles.metodo,'Value')};
%metodo=get(handles.metodo,'String')
global metodo;

%Limpia grafico
cla(handles.grafico);
axes(handles.grafico);
axis([-10 10 -10 10]);

%Lista de métodos:

% Lineal Primal Hard
% Lineal Primal Soft

% Lineal Dual Hard
% Lineal Dual Soft

% Alternativo Elíptico Hard
% Alternativo Elíptico Soft

% Alternativo Cónico Hard
% Alternativo Cónico Soft

% Kernel Mediante Phi
% Kernel Directo
% 

switch metodo
    %Directo
    case 'Lineal Primal Hard'
        yopt=primal([xpos;ypos]',[xneg;yneg]')
    case 'Lineal Primal Soft'
        C=str2double(get(handles.cteC,'String'));
        yopt=primal_soft([xpos;ypos]',[xneg;yneg]',C)

    case 'Lineal Dual Hard'
        yopt=dual([xpos;ypos]',[xneg;yneg]')
        
    case 'Lineal Dual Soft'
        C=str2double(get(handles.cteC,'String'));
        yopt=dual_soft([xpos;ypos]',[xneg;yneg]',C)
        
    case 'Alternativo Elíptico Hard'
        A(1)=str2double(get(handles.cte1,'String'))
        C=str2double(get(handles.cteC,'String'));
        flag(1)=get(handles.rotac,'Value');
        flag(2)=get(handles.traslac,'Value');

        yopt=optim_5(A, flag, [xpos;ypos]',[xneg;yneg]')
        
        %yopt=optim_5(A,flag,Nombre)
        x(1)=x(1)-yopt(5);
        x(2)=x(2)-yopt(6);
        aux=x(1)*cos(yopt(4))+x(2)*sin(yopt(4));
        x(2)=-x(1)*sin(yopt(4))+x(2)*cos(yopt(4));
        x(1)=aux;
        
        clase=0;
        %Elipse intermedia con semieje a((1+lambda)/2)
        J=elipse(x(1),x(2),[1/(((1+yopt(3))/2)*(yopt(1)*yopt(1))),...
            0,1/(((1+yopt(3))/2)*(yopt(2)*yopt(2)))],1);
        if(J>0)
            clase=+1;
        elseif(J<0)
            clase=-1;
        else
            clase=0;
        end
    case 'Alternativo Elíptico Soft'
        A(1)=str2double(get(handles.cte1,'String'))
        C=str2double(get(handles.cteC,'String'));
        flag(1)=get(handles.rotac,'Value');
        flag(2)=get(handles.traslac,'Value');

        yopt=optim_5soft(A,C, flag,[xpos;ypos]',[xneg;yneg]')
        
        %yopt=optim_5(A,flag,Nombre)
        x(1)=x(1)-yopt(5);
        x(2)=x(2)-yopt(6);
        aux=x(1)*cos(yopt(4))+x(2)*sin(yopt(4));
        x(2)=-x(1)*sin(yopt(4))+x(2)*cos(yopt(4));
        x(1)=aux;
        
        clase=0;
        %Elipse intermedia con semieje a((1+lambda)/2)
        J=elipse(x(1),x(2),[1/(((1+yopt(3))/2)*(yopt(1)*yopt(1))),...
            0,1/(((1+yopt(3))/2)*(yopt(2)*yopt(2)))],1);
        if(J>0)
            clase=+1;
        elseif(J<0)
            clase=-1;
        else
            clase=0;
        end
        
        
    case 'Kernel Mediante Phi'
        [exitflag,w,b1,b2]=resuelve_elipse2( xpos,ypos,xneg,yneg);
        if(exitflag~=1)
            open('error1.fig');
        end

        
        %Clasificacion
%         J=elipse(x1,x2,w,b2);
%         clase=0;
%         if(J<=0)
%             clase=-1;
%         end
%         J=elipse(x1,x2,w,b1);
%         if(J>=0)
%             clase=+1;
%         end
%         set(handles.clase,'String',num2str(clase));
        
        case 'Polinomial Hard'
       
        C=str2double(get(handles.cteC,'String'))
        global delta;
        global g;
        delta=str2double(get(handles.cDelta,'String'));
        g=str2double(get(handles.cg,'String'));
        alfa=dual_pol(C)
end
set(handles.text4, 'String', archivo);
set(handles.clase,'String',int2str(clase));


function cte2_Callback(hObject, eventdata, handles)

% Hints: get(hObject,'String') returns contents of cte2 as text
%        str2double(get(hObject,'String')) returns contents of cte2 as a double


function cte3_Callback(hObject, eventdata, handles)

% Hints: get(hObject,'String') returns contents of cte3 as text
%        str2double(get(hObject,'String')) returns contents of cte3 as a double


function cte4_Callback(hObject, eventdata, handles)

% Hints: get(hObject,'String') returns contents of cte4 as text
%        str2double(get(hObject,'String')) returns contents of cte4 as a double



function cte5_Callback(hObject, eventdata, handles)

% Hints: get(hObject,'String') returns contents of cte5 as text
%        str2double(get(hObject,'String')) returns contents of cte5 as a double



%Objetos menu

% --------------------------------------------------------------------
function archivo_Callback(hObject, eventdata, handles)
% hObject    handle to archivo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --------------------------------------------------------------------
function ayuda_Callback(hObject, eventdata, handles)
% hObject    handle to ayuda (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function abrir_Callback(hObject, eventdata, handles)
% hObject    handle to abrir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function guardar_Callback(hObject, eventdata, handles)
% hObject    handle to guardar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function importar_Callback(~, eventdata, handles)
% hObject    handle to importar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function exportar_Callback(hObject, eventdata, handles)
% hObject    handle to exportar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% dibujo=get(handles.grafico,'UserData');
% clipboard('copy', dibujo);


% --------------------------------------------------------------------
function salir_Callback(hObject, eventdata, handles)
clear all; close all;


% --------------------------------------------------------------------
function editar_Callback(hObject, eventdata, handles)
% hObject    handle to editar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function acerca_Callback(hObject, eventdata, handles)
open('acerca.fig');


% --- Executes on selection change in metodos.
function metodos_Callback(hObject, eventdata, handles)
% hObject    handle to metodos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns metodos contents as cell array
%        contents{get(hObject,'Value')} returns selected item from metodos


% --- Executes during object creation, after setting all properties.
function metodos_CreateFcn(hObject, eventdata, handles)
% hObject    handle to metodos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
global archivo;
global xpos;
global ypos;
global xneg;
global yneg;
%A es el valor del slider
A(1)=get(hObject,'Value')
set(handles.cte1,'Value',A(1))
%C es la constante de penalización de epsilons
C=str2double(get(handles.cteC,'String'))

flag(1)=get(handles.rotac,'Value');
flag(2)=get(handles.traslac,'Value');
set(handles.cte1,'String',num2str(A(1)));
%axes(handles.grafico);
cla(handles.grafico);

optim_5soft(A,C,flag,[xpos;ypos]',[xneg;yneg]');
set(handles.text4, 'String', archivo);

% --- Executes on button press in traslac.
function traslac_Callback(hObject, eventdata, handles)
% hObject    handle to traslac (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of traslac


% --------------------------------------------------------------------
function info_Callback(hObject, eventdata, handles)
open('info.fig');



% --- Executes on selection change in metodo.
function metodo_Callback(hObject, eventdata, handles)
% hObject    handle to metodo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns metodo contents as cell array
%        contents{get(hObject,'Value')} returns selected item from metodo
global metodo;

%   todos los valores posibles del menú:
 contents = get(handles.metodo,'String');

 %   valor elegido
 valor = contents{get(handles.metodo,'Value')};

 metodo=valor;

% --- Executes during object creation, after setting all properties.
function metodo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to metodo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function P1_Callback(hObject, eventdata, handles)
% hObject    handle to P1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of P1 as text
%        str2double(get(hObject,'String')) returns contents of P1 as a double


% --- Executes during object creation, after setting all properties.
function P1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to P1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function P2_Callback(hObject, eventdata, handles)
% hObject    handle to P2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of P2 as text
%        str2double(get(hObject,'String')) returns contents of P2 as a double


% --- Executes during object creation, after setting all properties.
function P2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to P2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function cteC_Callback(hObject, eventdata, handles)
% hObject    handle to cteC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cteC as text
%        str2double(get(hObject,'String')) returns contents of cteC as a double


% --- Executes during object creation, after setting all properties.
function cteC_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cteC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in limpiar.
function limpiar_Callback(hObject, eventdata, handles)
% hObject    handle to limpiar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla;
set(handles.text4,'String','Salida de texto');


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla;
global xpos; global ypos; global xneg; global yneg;
cuadra(xpos,ypos,xneg,yneg);
plot(xpos,ypos,'+r',xneg,yneg,'bo');
global archivo;
set(handles.text4,'String',archivo);

% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

hgexport(gcf,'-clipboard');

% --- Executes on button press in cDelta.
function cDelta_Callback(hObject, eventdata, handles)
% hObject    handle to cDelta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cDelta


% --- Executes during object creation, after setting all properties.
function cDelta_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cDelta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function cg_Callback(hObject, eventdata, handles)
% hObject    handle to cg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of cg as text
%        str2double(get(hObject,'String')) returns contents of cg as a double


% --- Executes during object creation, after setting all properties.
function cg_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
