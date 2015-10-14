function varargout = TUResults(varargin)
% TURESULTS MATLAB code for TUResults.fig
%      TURESULTS, by itself, creates a new TURESULTS or raises the existing
%      singleton*.
%
%      H = TURESULTS returns the handle to a new TURESULTS or the handle to
%      the existing singleton*.
%
%      TURESULTS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TURESULTS.M with the given input arguments.
%
%      TURESULTS('Property','Value',...) creates a new TURESULTS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before TUResults_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to TUResults_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help TUResults

% Last Modified by GUIDE v2.5 14-Oct-2015 13:30:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @TUResults_OpeningFcn, ...
                   'gui_OutputFcn',  @TUResults_OutputFcn, ...
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


% --- Executes just before TUResults is made visible.
function TUResults_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to TUResults (see VARARGIN)

%Inicializacion de variables
if(nargin > 3)
    for index = 1:2:(nargin-3),
        if nargin-3==index, break, end
        switch varargin{index}
         case 'TURes'
             handles.TURes = varargin{index+1};
        end
    end
end

mu = handles.TURes.mu;
sd = handles.TURes.sd;
ix = mu-3*sd:(mu/100):mu+3*sd;
iy = normpdf(ix, mu, sd);
%Areas
x1 = mu-3*sd:(mu/100):mu-2*sd;
x2 = mu-2*sd:(mu/100):mu-sd;
x3 = mu-sd:(mu/100):mu+sd;
x4 = mu+sd:(mu/100):mu+2*sd;
x5 = mu+2*sd:(mu/100):mu+3*sd;
y1 = normpdf(x1, mu, sd);
y2 = normpdf(x2, mu, sd);
y3 = normpdf(x3, mu, sd);
y4 = normpdf(x4, mu, sd);
y5 = normpdf(x5, mu, sd);
%Plot 
Rosado = [0.85 0.6 0.6];
Amarillo = [0.83 0.83 0];
Verde = [0.3 0.8 0.3];
axes(handles.axes1);
h1 = area(x1, y1);
hold on;
h2 = area(x2, y2);
hold on;
h3 = area(x3, y3);
hold on;
h4 = area(x4, y4);
hold on;
h5 = area(x5, y5);
hold on;
h1.FaceColor = Rosado;
h2.FaceColor = Amarillo;
h3.FaceColor = Verde;
h4.FaceColor = Amarillo;
h5.FaceColor = Rosado;
%Linea divisoria del medio
alturaMaxima = [0 max(iy)];
line([mu mu],alturaMaxima,'Color',[0 0 0]); 
%Linea de Caracteristica
AlturaLinea = [0 pdf('Normal',handles.TURes.c,mu,sd)];
lc = line([handles.TURes.c handles.TURes.c],AlturaLinea,'Color',[0 0 1], 'LineWidth', 2); 

%Titulo y leyenda
Linea1 = ['Distribution of',' ', char(handles.TURes.IPM_largo)];
Linea2 = ['(',char(handles.TURes.IPM_corto),') for',' ', int2str(handles.TURes.Ciclos) ,' ', 'chewing strokes'];
TituloGrafico = {Linea1; Linea2};
title(TituloGrafico);
xlabel(char(handles.TURes.IPM_corto)); % x-axis label
textoLeyenda = [char(handles.TURes.IPM_corto), ' ','=', ' ', num2str(handles.TURes.c, 3)];
legend(lc, textoLeyenda, 'Location','northwest') %leyenda
set(gca,'YtickLabel',[]);

%Z Score y Caracteristica medida
set(handles.lbl_z,'String',num2str(handles.TURes.zsc, 3));
set(handles.lbl_c,'String',num2str(handles.TURes.c, 3));
set(handles.lbl_meas,'String',[char(handles.TURes.IPM_corto), ' ','of the specimen:']);

%Imagenes miniatura
axes(handles.axes_A);
imshow(handles.TURes.LA);
axes(handles.axes_B);
imshow(handles.TURes.LB);

% Choose default command line output for TUResults
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes TUResults wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = TUResults_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Panel();
close(TUResults);
