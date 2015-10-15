function varargout = Panel(varargin)
% PANEL MATLAB code for Panel.fig
%      PANEL, by itself, creates a new PANEL or raises the existing
%      singleton*.
%
%      H = PANEL returns the handle to a new PANEL or the handle to
%      the existing singleton*.
%
%      PANEL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PANEL.M with the given input arguments.
%
%      PANEL('Property','Value',...) creates a new PANEL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Panel_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Panel_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Panel

% Last Modified by GUIDE v2.5 07-Oct-2015 18:44:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Panel_OpeningFcn, ...
                   'gui_OutputFcn',  @Panel_OutputFcn, ...
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


% --- Executes just before Panel is made visible.
function Panel_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Panel (see VARARGIN)



%Cargar imagenes
LogoUma = imread('LogoUma.png');
axes(handles.LogoUma);
imshow(LogoUma);
LogoLcc = imread('logo_lcc.png');
axes(handles.LogoLcc);
imshow(LogoLcc);

% Choose default command line output for Panel
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Panel wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Panel_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function figure1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Busca todos los archivos de calibración
CalibrationFiles=dir(fullfile('.','*.cbmat'));
%Genera una lista con los nombres de los archivos de calibacion y su
%descripcion
[sorted_names,sorted_index] = sortrows({CalibrationFiles.name}');
dime = size(CalibrationFiles);
CantidadCalibraciones = dime(1);
handles.ListaCalibraciones = cell(CantidadCalibraciones,5);
if(CantidadCalibraciones<1)
     h = msgbox('There are no calibration files. You must calibrate the application before doing Unitary Tests','Calibration files needed', 'warn');
else
    unitarytest();
end

% --- Executes on button press in btn_calibrate.
function btn_calibrate_Callback(hObject, eventdata, handles)
% hObject    handle to btn_calibrate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
main();

% --------------------------------------------------------------------
function Menu1_Callback(hObject, eventdata, handles)
% hObject    handle to Menu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function About_Callback(hObject, eventdata, handles)
% hObject    handle to About (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
web('http://www.perceptodent.lcc.uma.es');


% --------------------------------------------------------------------
function Documentation_Callback(hObject, eventdata, handles)
% hObject    handle to Documentation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
web('http://www.perceptodent.lcc.uma.es/documentation/index.htm');
