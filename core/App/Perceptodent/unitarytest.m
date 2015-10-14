function varargout = unitarytest(varargin)
% UNITARYTEST MATLAB code for unitarytest.fig
%      UNITARYTEST, by itself, creates a new UNITARYTEST or raises the existing
%      singleton*.
%
%      H = UNITARYTEST returns the handle to a new UNITARYTEST or the handle to
%      the existing singleton*.
%
%      UNITARYTEST('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UNITARYTEST.M with the given input arguments.
%
%      UNITARYTEST('Property','Value',...) creates a new UNITARYTEST or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before unitarytest_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to unitarytest_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help unitarytest

% Last Modified by GUIDE v2.5 13-Oct-2015 18:17:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @unitarytest_OpeningFcn, ...
                   'gui_OutputFcn',  @unitarytest_OutputFcn, ...
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


% --- Executes just before unitarytest is made visible.
function unitarytest_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to unitarytest (see VARARGIN)

%Inicializacion de variables
handles.setA = false;
handles.setB = false;
handles.setCiclos = false;
handles.setMPAT = false;
handles.PathNameLast = './';
%Busca todos los archivos de calibración
CalibrationFiles=dir(fullfile('./','*.cbmat'));
%Genera una lista con los nombres de los archivos de calibacion y su
%descripcion
[sorted_names,sorted_index] = sortrows({CalibrationFiles.name}');
dime = size(CalibrationFiles);
CantidadCalibraciones = dime(1);
handles.ListaCalibraciones = cell(CantidadCalibraciones,5);
for j = 1:CantidadCalibraciones
    %carga archivo
    load(char(sorted_names(j)),'-mat');
    handles.ListaCalibraciones(j,1) = {sorted_names(j)};
    handles.ListaCalibraciones(j,2) = {StRes.NombreDescriptivo};
    handles.ListaCalibraciones(j,3) = {StRes.DetallesAlimento};
    handles.ListaCalibraciones(j,4) = {StRes.PaisOrigen};
    handles.ListaCalibraciones(j,5) = {j};
    
end
ListaIndex = 1:CantidadCalibraciones;

%Carga la primera MPAT si estád disponible
set(handles.listbox1,'String',handles.ListaCalibraciones(:,2),'Value',1)
handles = cargarMPAT(hObject, handles);

%Muestra las imágenes de prueba iniciales
imsidea= imread('./sidea.png');
axes(handles.AxesA);
imshow(imsidea);
imsideb= imread('./sideb.png');
axes(handles.AxesB);
imshow(imsideb);

% Choose default command line output for unitarytest
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes unitarytest wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = unitarytest_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1
handles = cargarMPAT(hObject, handles);

handles.setMPAT = true;
% Update handles structure
guidata(hObject, handles);

function handles = cargarMPAT(hObject,handles)
index_selected = get(handles.listbox1,'Value');
%disp(index_selected);
Calib = handles.ListaCalibraciones(index_selected);
try
    ruta_calibracion = char(Calib{1,1}{1,1});
    load(ruta_calibracion, '-mat');
    handles.StRes = StRes;
    set(handles.listbox2,'Enable','on');
    set(handles.listbox2,'String',handles.StRes.Clases,'Value',1)
    %coloca el indice en el final del listbox2
    LastIndex = size(StRes.Clases);
    LastIndex = LastIndex(1);
    set(handles.listbox2, 'Value', LastIndex);
    handles.IndexCiclos = get(handles.listbox2,'Value');
    %Muestra los detalles de la MPAT
    set(handles.lbl_tfdesc,'String',handles.StRes.DetallesAlimento);
    set(handles.lbl_origen,'String',handles.StRes.PaisOrigen);
    set(handles.lbl_OIPM,'String',char(handles.StRes.designacion(handles.StRes.Optimal,2)));
    %Establece que ya se ha seleccionado una MPAT y un numero de ciclos
    handles.setMPAT = true;
    handles.setCiclos = true;
catch
    disp('ERROR');
    
end


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.AxesB);
[FileName,PathName,FilterIndex] = uigetfile(...
    {'*.jpg;*.tif;*.tiff;*.bmp',...
    'Image Files (*.jpg, *.tif, *.tiff, *.bmp)'},...
    'Select Image of side B', handles.PathNameLast);
if(FileName ~= 0)
    handles.ladoB = imread([PathName,FileName]);
    imshow(handles.ladoB);
    handles.setB = true;
    
    %actualiza el PathName
    handles.PathNameLast = PathName;
end
% Update handles structure
guidata(hObject, handles);



% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.AxesA);
[FileName,PathName,FilterIndex] = uigetfile(...
    {'*.jpg;*.tif;*.tiff;*.bmp',...
    'Image Files (*.jpg, *.tif, *.tiff, *.bmp)'},...
    'Select Image of side A',handles.PathNameLast);
if(FileName ~= 0)
    try
    handles.ladoA = imread([PathName,FileName]);
    imshow(handles.ladoA);
    handles.setA = true;
    catch
       h = msgbox('This image is invalid.  The current image includes a TRANSPARENCY layer that is incompatible with the analysis. For further informantion please read the Documentation.','Invalid image', 'warn'); 
    end
    
    %actualiza el PathName
    handles.PathNameLast = PathName;
end
% Update handles structure
guidata(hObject, handles);


% --- Executes on button press in Execute.
function Execute_Callback(hObject, eventdata, handles)
% hObject    handle to Execute (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
addpath('../../captura/','../../estadistica/','../../extraccion/','../../interfaz/','../../representacion/','../../scripts/','../../segmentacion/','../../extraccion/circular/');
if(handles.setA && handles.setB && handles.setCiclos && handles.setMPAT)
    %abre la waitbar
    hw = waitbar(0,'Please wait...');
    %Bloquea botones
    waitbar(1 / 5, hw, 'Loading calibration');
    set(handles.Execute, 'Enable', 'off');
    set(handles.pushbutton1, 'Enable', 'off');
    set(handles.pushbutton2, 'Enable', 'off');
    set(handles.listbox1, 'Enable', 'off');
    set(handles.listbox2, 'Enable', 'off');
    %inicia el procesamiento
    hs = 20;
    hr = 10;
    minreg = 4;
    signo = 'mayor';
    estructura_imagen_A=struct('imagen',0,'suave',0, 'regiones',0,'features',0,'etiquetas', 0, 'marcas', 0);
    estructura_imagen_B=struct('imagen',0,'suave',0, 'regiones',0,'features',0,'etiquetas', 0, 'marcas', 0);
    ComponenteR = handles.ladoA(:,:,1);
    ComponenteG = handles.ladoA(:,:,2);
    ComponenteB = handles.ladoA(:,:,3);
    estructura_imagen_A.imagen = cat(3, ComponenteR, ComponenteG, ComponenteB);
    ComponenteR = handles.ladoB(:,:,1);
    ComponenteG = handles.ladoB(:,:,2);
    ComponenteB = handles.ladoB(:,:,3);
    estructura_imagen_B.imagen = cat(3, ComponenteR, ComponenteG, ComponenteB);
    %Redimensiona imagenes
    estructura_imagen_A.imagen = imresize(estructura_imagen_A.imagen, [300 NaN]);
    estructura_imagen_B.imagen = imresize(estructura_imagen_B.imagen, [300 NaN]);
    %Segmenta las imagenes
    waitbar(2 / 5, hw, 'Segmenting image from side A');
    [estructura_imagen_A.suave, estructura_imagen_A.regiones, modes, regsize, grad, conf]= segmentar(estructura_imagen_A.imagen,hs,hr,minreg);
    waitbar(3 / 5, hw, 'Segmenting image from side B');
    [estructura_imagen_B.suave, estructura_imagen_B.regiones, modes, regsize, grad, conf]= segmentar(estructura_imagen_B.imagen,hs,hr,minreg);
    waitbar(4 / 5, hw, 'Analyzing mixture');
    %Extrae características
    umbral_A = calcularUmbral( estructura_imagen_A.suave(:,:,2) );
    umbral_B = calcularUmbral( estructura_imagen_B.suave(:,:,2) );
    linea_caracteristicas  = MPAT_DUAL( estructura_imagen_A, umbral_A,estructura_imagen_B, umbral_B, signo );
    tama = size(linea_caracteristicas);
    lineaCorta = linea_caracteristicas(1,1:tama(2));
    caracteristica = lineaCorta(handles.StRes.Optimal);
    mediaPoblacion = handles.StRes.descriptivos(handles.IndexCiclos,1,handles.StRes.Optimal);
    stdPoblacion = handles.StRes.descriptivos(handles.IndexCiclos,2,handles.StRes.Optimal);
    zsc = (caracteristica-mediaPoblacion)/stdPoblacion;
    TURes = struct('mu',0,'sd',0,'c', 0, 'zsc',0);
    TURes.mu = mediaPoblacion;
    TURes.sd = stdPoblacion;
    TURes.c = caracteristica;
    TURes.zsc = zsc;
    TURes.IPM_corto = char(handles.StRes.designacion(handles.StRes.Optimal,1));
    TURes.IPM_largo = char(handles.StRes.designacion(handles.StRes.Optimal,2));
    TURes.Ciclos = handles.StRes.Clases(handles.IndexCiclos);
    
    %Imagenes segmentadas para presentar
    LA = estructura_imagen_A.imagen;
    LB = estructura_imagen_B.imagen;
    LA1 = LA(:,:,1);
    LA2 = LA(:,:,2);
    LA3 = LA(:,:,3);
    LB1 = LB(:,:,1);
    LB2 = LB(:,:,2);
    LB3 = LB(:,:,3);
    AlternoA = estructura_imagen_A.suave(:,:,2);
    ALternoB = estructura_imagen_B.suave(:,:,2);
    LA1(abs(AlternoA)<umbral_A) = 255;
    LA2(abs(AlternoA)<umbral_A) = 255;
    LA3(abs(AlternoA)<umbral_A) = 255;
    LB1(abs(ALternoB)<umbral_B) = 255;
    LB2(abs(ALternoB)<umbral_B) = 255;
    LB3(abs(ALternoB)<umbral_B) = 255;
    TURes.LA = cat(3,LA1, LA2, LA3);
    TURes.LB = cat(3,LB1, LB2, LB3);
    
    TUResults('TURes', TURes);
    delete(hw);
    close(unitarytest);
else
    if(handles.setMPAT == false)
        h = msgbox('You need to select a calibration file first','Calibration needed', 'warn');
    elseif (handles.setCiclos == false)
        h = msgbox('You need to select the number of chewing cycles','Chewing cycles not selected', 'warn');
    elseif (handles.setA == false || handles.setB == false)
        h = msgbox('You need to select images from both sides of the specimen','Chewing cycles not selected', 'warn');
    end
end


% --- Executes on selection change in listbox2.
function listbox2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox2
handles.IndexCiclos = get(handles.listbox2,'Value');
handles.setCiclos = true;

disp(handles.IndexCiclos);

% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function listbox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
