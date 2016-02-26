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

% Last Modified by GUIDE v2.5 24-Apr-2015 10:40:46

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
global  file_input
file_input=uigetfile('.txt');
archivo=fileread(file_input);
set(handles.edit3, 'String', archivo);

%   EJECUCIÓN
% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%   Fichero de datos y lectura
global  file_input

[x1,x2,y] =textread(file_input,'%f%f%f','headerlines',1);
x1
x2
y
