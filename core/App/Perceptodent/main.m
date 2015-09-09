function varargout = main(varargin)
% MAIN MATLAB code for main.fig
%      MAIN, by itself, creates a new MAIN or raises the existing
%      singleton*.
%
%      H = MAIN returns the handle to a new MAIN or the handle to
%      the existing singleton*.
%
%      MAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN.M with the given input arguments.
%
%      MAIN('Property','Value',...) creates a new MAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help main

% Last Modified by GUIDE v2.5 07-Sep-2015 15:39:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_OpeningFcn, ...
                   'gui_OutputFcn',  @main_OutputFcn, ...
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


% --- Executes just before main is made visible.
function main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to main (see VARARGIN)

% Choose default command line output for main
handles.output = hObject;

%inicializacion de variables
handles.designacion = {'MR', 'Mean of the R channel from RGB' ; ...
                        'VR','Variance of the R channel from RGB'; ...
                        'P1R','Position of the highest peak of the histogram of the R channel from RGB'; ...
                        'V1R','Value of the highest peak of the histogram of the R channel from RGB'; ...
                        'P2R','Position of the sendon highest peak of the histogram of the R channel from RGB'; ...
                        'V2R','Value of the second highest peak of the histogram of the R channel from RGB'; ...
                        'VhR','Variance of the histogram of the R channel from RGB'; ...
                        'ShR','Skewness of the histogram of the R channel from RGB'; ...
                        'EhR','Energy of the histogram of the R channel from RGB'; ...
                        'NhR','Entropy of the histogram of the R channel from RGB'; ...
                        'MG', 'Mean of the G channel from RGB' ; ...
                        'VG','Variance of the G channel from RGB'; ...
                        'P1G','Position of the highest peak of the histogram of the G channel from RGB'; ...
                        'V1G','Value of the highest peak of the histogram of the G channel from RGB'; ...
                        'P2G','Position of the sendon highest peak of the histogram of the G channel from RGB'; ...
                        'V2G','Value of the second highest peak of the histogram of the G channel from RGB'; ...
                        'VhG','Variance of the histogram of the G channel from RGB'; ...
                        'ShG','Skewness of the histogram of the G channel from RGB'; ...
                        'EhG','Energy of the histogram of the G channel from RGB'; ...
                        'NhG','Entropy of the histogram of the G channel from RGB'; ...
                        'MB', 'Mean of the B channel from RGB' ; ...
                        'VB','Variance of the B channel from RGB'; ...
                        'P1B','Position of the highest peak of the histogram of the B channel from RGB'; ...
                        'V1B','Value of the highest peak of the histogram of the B channel from RGB'; ...
                        'P2B','Position of the sendon highest peak of the histogram of the B channel from RGB'; ...
                        'V2B','Value of the second highest peak of the histogram of the B channel from RGB'; ...
                        'VhB','Variance of the histogram of the B channel from RGB'; ...
                        'ShB','Skewness of the histogram of the B channel from RGB'; ...
                        'EhB','Energy of the histogram of the B channel from RGB'; ...
                        'NhB','Entropy of the histogram of the B channel from RGB'; ...
                        'ML', 'Mean of the L channel from LUV' ; ...
                        'VL','Variance of the L channel from LUV'; ...
                        'P1L','Position of the highest peak of the histogram of the L channel from LUV'; ...
                        'V1L','Value of the highest peak of the histogram of the L channel from LUV'; ...
                        'P2L','Position of the sendon highest peak of the histogram of the L channel from LUV'; ...
                        'V2L','Value of the second highest peak of the histogram of the L channel from LUV'; ...
                        'VhL','Variance of the histogram of the L channel from LUV'; ...
                        'ShL','Skewness of the histogram of the L channel from LUV'; ...
                        'EhL','Energy of the histogram of the L channel from LUV'; ...
                        'NhL','Entropy of the histogram of the L channel from LUV'; ...
                        'Mu', 'Mean of the u channel from LUV' ; ...
                        'Vu','Variance of the u channel from LUV'; ...
                        'P1u','Position of the highest peak of the histogram of the u channel from LUV'; ...
                        'V1u','Value of the highest peak of the histogram of the u channel from LUV'; ...
                        'P2u','Position of the sendon highest peak of the histogram of the u channel from LUV'; ...
                        'V2u','Value of the second highest peak of the histogram of the u channel from LUV'; ...
                        'Vhu','Variance of the histogram of the u channel from LUV'; ...
                        'Shu','Skewness of the histogram of the u channel from LUV'; ...
                        'Ehu','Energy of the histogram of the u channel from LUV'; ...
                        'Nhu','Entropy of the histogram of the u channel from LUV'; ...
                        'Mv', 'Mean of the v channel from LUV' ; ...
                        'Vv','Variance of the v channel from LUV'; ...
                        'P1v','Position of the highest peak of the histogram of the v channel from LUV'; ...
                        'V1v','Value of the highest peak of the histogram of the v channel from LUV'; ...
                        'P2v','Position of the sendon highest peak of the histogram of the v channel from LUV'; ...
                        'V2v','Value of the second highest peak of the histogram of the v channel from LUV'; ...
                        'Vhv','Variance of the histogram of the v channel from LUV'; ...
                        'Shv','Skewness of the histogram of the v channel from LUV'; ...
                        'Ehv','Energy of the histogram of the v channel from LUV'; ...
                        'Nhv','Entropy of the histogram of the v channel from LUV'; ...
                        'MR', 'Mean of the Rn channel from Normalized RGB' ; ...
                        'VR','Variance of the Rn channel from RGB'; ...
                        'P1Rn','Position of the highest peak of the histogram of the Rn channel from Normalized RGB'; ...
                        'V1Rn','Value of the highest peak of the histogram of the Rn channel from Normalized RGB'; ...
                        'P2Rn','Position of the sendon highest peak of the histogram of the Rn channel from Normalized RGB'; ...
                        'V2Rn','Value of the second highest peak of the histogram of the Rn channel from Normalized RGB'; ...
                        'VhRn','Variance of the histogram of the Rn channel from Normalized RGB'; ...
                        'ShRn','Skewness of the histogram of the Rn channel from Normalized RGB'; ...
                        'EhRn','Energy of the histogram of the Rn channel from Normalized RGB'; ...
                        'NhRn','Entropy of the histogram of the Rn channel from Normalized RGB'; ...
                        'MGn', 'Mean of the Gn channel from Normalized RGB' ; ...
                        'VGn','Variance of the Gn channel from Normalized RGB'; ...
                        'P1Gn','Position of the highest peak of the histogram of the Gn channel from Normalized RGB'; ...
                        'V1Gn','Value of the highest peak of the histogram of the Gn channel from Normalized RGB'; ...
                        'P2Gn','Position of the sendon highest peak of the histogram of the Gn channel from Normalized RGB'; ...
                        'V2Gn','Value of the second highest peak of the histogram of the Gn channel from Normalized RGB'; ...
                        'VhGn','Variance of the histogram of the Gn channel from Normalized RGB'; ...
                        'ShGn','Skewness of the histogram of the Gn channel from Normalized RGB'; ...
                        'EhGn','Energy of the histogram of the Gn channel from Normalized RGB'; ...
                        'NhGn','Entropy of the histogram of the Gn channel from Normalized RGB'; ...
                        'MBn', 'Mean of the Bn channel from Normalized RGB' ; ...
                        'VBn','Variance of the Bn channel from Normalized RGB'; ...
                        'P1Bn','Position of the highest peak of the histogram of the Bn channel from Normalized RGB'; ...
                        'V1Bn','Value of the highest peak of the histogram of the Bn channel from Normalized RGB'; ...
                        'P2Bn','Position of the sendon highest peak of the histogram of the Bn channel from Normalized RGB'; ...
                        'V2Bn','Value of the second highest peak of the histogram of the Bn channel from Normalized RGB'; ...
                        'VhBn','Variance of the histogram of the Bn channel from Normalized RGB'; ...
                        'ShBn','Skewness of the histogram of the Bn channel from Normalized RGB'; ...
                        'EhBn','Energy of the histogram of the Bn channel from Normalized RGB'; ...
                        'NhBn','Entropy of the histogram of the Bn channel from Normalized RGB'; ...
                        'MH', 'Mean of the H channel from HSI' ; ...
                        'VH','Variance of the H channel from HSI'; ...
                        'P1H','Position of the highest peak of the histogram of the H channel from HSI'; ...
                        'V1H','Value of the highest peak of the histogram of the H channel from HSI'; ...
                        'P2H','Position of the sendon highest peak of the histogram of the H channel from HSI'; ...
                        'V2H','Value of the second highest peak of the histogram of the H channel from HSI'; ...
                        'VhH','Variance of the histogram of the H channel from HSI'; ...
                        'ShH','Skewness of the histogram of the H channel from HSI'; ...
                        'EhH','Energy of the histogram of the H channel from HSI'; ...
                        'NhH','Entropy of the histogram of the H channel from HSI'; ...
                        'MS', 'Mean of the S channel from HSI' ; ...
                        'VS','Variance of the S channel from HSI'; ...
                        'P1S','Position of the highest peak of the histogram of the S channel from HSI'; ...
                        'V1S','Value of the highest peak of the histogram of the S channel from HSI'; ...
                        'P2S','Position of the sendon highest peak of the histogram of the S channel from HSI'; ...
                        'V2S','Value of the second highest peak of the histogram of the S channel from HSI'; ...
                        'VhS','Variance of the histogram of the S channel from HSI'; ...
                        'ShS','Skewness of the histogram of the S channel from HSI'; ...
                        'EhS','Energy of the histogram of the S channel from HSI'; ...
                        'NhS','Entropy of the histogram of the S channel from HSI'; ...
                        'MI', 'Mean of the I channel from HSI' ; ...
                        'VI','Variance of the I channel from HSI'; ...
                        'P1I','Position of the highest peak of the histogram of the I channel from HSI'; ...
                        'V1I','Value of the highest peak of the histogram of the I channel from HSI'; ...
                        'P2I','Position of the sendon highest peak of the histogram of the I channel from HSI'; ...
                        'V2I','Value of the second highest peak of the histogram of the I channel from HSI'; ...
                        'VhI','Variance of the histogram of the I channel from HSI'; ...
                        'ShI','Skewness of the histogram of the I channel from HSI'; ...
                        'EhI','Energy of the histogram of the I channel from HSI'; ...
                        'NhI','Entropy of the histogram of the I channel from HSI'; ...
                        'CVOH', 'Circular variance of the Hue'};
                    
handles.columnas = {'Description', 'Kol-Sm p-val', 'ANOVA p-val', 'Sp. Rho', 'Sp. p-val' };
handles.outputfile = 'Results.xlsx';
handles.sigue = true;

%Inicializa columnas en la tabla

%Inicializa el archivo de salida
set(handles.text5, 'String', handles.outputfile);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes main wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = main_OutputFcn(hObject, eventdata, handles) 
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


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%deshabilita el botón
set(handles.pushbutton2, 'Enable', 'off');

addpath('../../entrenamiento/');
[ matriz_entrenamiento, salidas_esperadas, nombresArchivos ] = procesarDirectorio(handles.directorio, handles);

[ StRes ] = BernchmarkEVFs( matriz_entrenamiento, salidas_esperadas ); 
[handles.VALIDATED_Indexes, handles.OMPI_Index] = GetVALIDATED(StRes);
handles.clases = unique(salidas_esperadas);
handles.StRes = StRes;
%actualiza las columnas
handles = DefinirColumnas(StRes, handles.clases, handles);

%inicializa la tabla con todos los EVF
todoslosindices = 1:121;
handles = pupularTabla(StRes, handles.clases, todoslosindices, handles);

%guarda los resultados en una tabla
writetable(handles.TablaFinal,handles.outputfile, 'WriteVariableNames', false);

hold on;
guidata(hObject, handles);

function [ matriz_entrenamiento, salidas_esperadas, nombresArchivos ] = procesarDirectorio(dataPath, handles)
%limpia pantalla
clc
% %Matlab Pool
% if isempty(gcp('nocreate'))
%     parpool(2);
% end
%Toma en cuenta ambos lados de la muestra
hs = 20;
hr = 10;
minreg = 4;
signo = 'mayor';
formato = 'tif';

%Añade al path
dataPath = strcat(dataPath, '\');
addpath(dataPath, '../../captura/','../../estadistica/','../../extraccion/','../../interfaz/','../../representacion/','../../scripts/','../../segmentacion/','../../extraccion/circular/');
%Obtiene la lista de imagenes en el directorio
rutaGenerica = strcat(dataPath,'*.',formato);
ImageList = getAllImages(rutaGenerica);
MuestrasPares = [];
dime = size(ImageList);

%Verificar que las muestras sean pares
for j =1:dime(2)
    temporal = ImageList(j);
    %transforma cell array  -> char
    nombreImagen = char(temporal);
    %separa el número de muestra
    temporal = strsplit(nombreImagen,'-');
    Muestra = str2num(char(temporal(1)));
    %separa el numero de ciclos
    Ciclos = str2num(char(temporal(2)));
    %separa el lado
    temporal = temporal(3);
    temporal = strsplit(char(temporal),'.');
    Lado = char(temporal(1));
    %verifica si existe la pareja
    if(Lado=='A')
        pareja_N = strcat(int2str(Muestra),'-',int2str(Ciclos),'-B.tif');
        pareja_H = strcat(sprintf('%03d',Muestra),'-',int2str(Ciclos),'-B.tif');
        if exist(pareja_N, 'file') == 2 || exist(pareja_H, 'file') == 2
            %añade la muestra a la lista para su analisis
            MuestrasPares = [MuestrasPares ; Muestra, Ciclos];
        end
    end
end
%el total de muestras es la cantidad de parejas existentes
total_muestras = size(MuestrasPares);
total_muestras = total_muestras(1);
%Declaración de variables
matriz_entrenamiento = zeros(total_muestras, 121);
salidas_esperadas = zeros(total_muestras,1);
nombresArchivos = cell(total_muestras,1);
%Muestra la barra de espera
h = waitbar(0,'Please wait...','CreateCancelBtn','setappdata(gcbf,''canceling'',1)');
setappdata(h,'canceling',0);
%Itera entre las muestras de la base de datos
for i = 1:total_muestras
    %Verifica si la bandera de terminar está activada
    if get(handles.btn_cancelarSalir,'UserData')
        delete(h);
        break
    end
    if getappdata(h,'canceling')
        delete(h);
        break
    end
    %actualiza la barra de espera
    lnd = ['Sample ' int2str(i) ' of ' int2str(total_muestras)];
    waitbar(i / total_muestras, h, lnd);
    estructura_imagen_A=struct('imagen',0,'suave',0, 'regiones',0,'features',0,'etiquetas', 0, 'marcas', 0);
    estructura_imagen_B=struct('imagen',0,'suave',0, 'regiones',0,'features',0,'etiquetas', 0, 'marcas', 0);
    S = MuestrasPares(i,:);
    N= S(1);
    C = S(2);
    %muestra el número de la muestra siendo procesada
    disp(N);
    %Cargar las imagenes
    nombreImagenA = strcat(int2str(N),'-',int2str(C),'-A.tif');
    nombreImagenB = strcat(int2str(N),'-',int2str(C),'-B.tif');
    nombreImagenA_H = strcat(sprintf('%03d',N),'-',int2str(C),'-A.tif');
    nombreImagenB_H = strcat(sprintf('%03d',N),'-',int2str(C),'-B.tif');
    try
        ruta_imagenA = strcat(dataPath, nombreImagenA);
        ruta_imagenB = strcat(dataPath, nombreImagenB);
        ImgInicial_A = imread(ruta_imagenA);
        ImgInicial_B = imread(ruta_imagenB);
    catch
        ruta_imagenA = strcat(dataPath, nombreImagenA_H);
        ruta_imagenB = strcat(dataPath, nombreImagenB_H);
        ImgInicial_A = imread(ruta_imagenA);
        ImgInicial_B = imread(ruta_imagenB);
    end
    ComponenteR = ImgInicial_A(:,:,1);
    ComponenteG = ImgInicial_A(:,:,2);
    ComponenteB = ImgInicial_A(:,:,3);
    estructura_imagen_A.imagen = cat(3, ComponenteR, ComponenteG, ComponenteB);
    ComponenteR = ImgInicial_B(:,:,1);
    ComponenteG = ImgInicial_B(:,:,2);
    ComponenteB = ImgInicial_B(:,:,3);
    estructura_imagen_B.imagen = cat(3, ComponenteR, ComponenteG, ComponenteB);
    %redimensiona las imagenes
    estructura_imagen_A.imagen = imresize(estructura_imagen_A.imagen, [300 NaN]);
    estructura_imagen_B.imagen = imresize(estructura_imagen_B.imagen, [300 NaN]);
    %Segmenta las imagenes
    [estructura_imagen_A.suave, estructura_imagen_A.regiones, modes, regsize, grad, conf]= segmentar(estructura_imagen_A.imagen,hs,hr,minreg);
    [estructura_imagen_B.suave, estructura_imagen_B.regiones, modes, regsize, grad, conf]= segmentar(estructura_imagen_B.imagen,hs,hr,minreg);
    %Extrae características
    umbral_A = calcularUmbral( estructura_imagen_A.suave(:,:,2) );
    umbral_B = calcularUmbral( estructura_imagen_B.suave(:,:,2) );
    linea_caracteristicas  = MPAT_DUAL( estructura_imagen_A, umbral_A,estructura_imagen_B, umbral_B, signo );
    tama = size(linea_caracteristicas);
    %registra la linea en la matriz de entrenamiento
    matriz_entrenamiento(i,:) = linea_caracteristicas(1,1:tama(2));
    salidas_esperadas(i) = C;
    
end



function handles = DefinirColumnas(StRes, clases, handles)
tm = size(StRes.BONFF);
tm = tm(1);
sam = StRes.BONFF(:,:,1);
posicion = length(handles.columnas);
CantidadDeClases = length(clases);
%Descriptivos - Medias
for i=1:CantidadDeClases
    posicion = posicion +1;
    handles.columnas(posicion) = {['Mean',' ', int2str(clases(i)), ' cycles']};
end
%Descriptivos - Mediana
for i=1:CantidadDeClases
    posicion = posicion +1;
    handles.columnas(posicion) = {['Median',' ', int2str(clases(i)), ' cycles']};
end
%Descriptivos - Varianza
for i=1:CantidadDeClases
    posicion = posicion +1;
    handles.columnas(posicion) = {['Var',' ', int2str(clases(i)), ' cycles']};
end
%Intervalos de confianza
for i=1:CantidadDeClases
    posicion = posicion +1;
    handles.columnas(posicion) = {['Lower CI for',' ', int2str(clases(i)), ' cycles']};
    posicion = posicion +1;
    handles.columnas(posicion) = {['Upper CI for',' ', int2str(clases(i)), ' cycles']};
end
%Bonferronni
clasesT = clases';
for i = 1:tm
    posicion = posicion +1;
    tA = sam(i,1);
    tB = sam(i,2);
    handles.columnas(posicion) = {[int2str(clasesT(tA)),' vs', ' ', int2str(clasesT(tB)), ' p-val']};
end


function handles = pupularTabla(StRes,clases, Indices, handles)
%Indices debe tener la forma [ a b c ... z]
%Definir filas
filas = handles.designacion(Indices);
CantidadColumnas = length(handles.columnas);
Datos = cell(length(Indices),CantidadColumnas);
CantidadDeClases = length(clases);
cont = 1;
%itera entre los EVFs
for i = Indices
    Datos(cont,1) = {char(handles.designacion(i,2))};
    Datos(cont,2) ={StRes.KolmogorovSmirnov(i)};
    Datos(cont,3) ={StRes.ANOVA_P(i)};
    Datos(cont,4) ={StRes.SP_RHO(i)};
    Datos(cont,5) ={StRes.SP_P(i)};
    
    %Conlumnas adicionales
    posicion = 5;
    for j=1:CantidadDeClases
        posicion = posicion +1;
        Datos(cont,posicion) = {StRes.descriptivos(j,1,i)};
    end
    for j=1:CantidadDeClases
        posicion = posicion +1;
        Datos(cont,posicion) = {StRes.descriptivos(j,2,i)};
    end
    for j=1:CantidadDeClases
        posicion = posicion +1;
        Datos(cont,posicion) = {StRes.descriptivos(j,3,i)};
    end
    for j=1:CantidadDeClases
        posicion = posicion +1;
        Datos(cont,posicion) = {StRes.CI(j,1,i)};
        posicion = posicion +1;
        Datos(cont,posicion) = {StRes.CI(j,2,i)};
    end
    tm = size(StRes.BONFF);
    tm = tm(1);
    for j = 1:tm
        posicion = posicion +1;
        Datos(cont,posicion) = {StRes.BONFF(j,6,i)};
    end

    cont = cont+1;
end

%guardar en tabla ESTO ESTA MAL, CAMBIAR
DatosEscritura = handles.columnas;
DatosEscritura = [DatosEscritura ; Datos];
handles.TablaFinal = cell2table(DatosEscritura);

function [VALIDATED_Indexes, OMPI_Index] = GetVALIDATED(StRes)
indices = [];
cont = 1;
OMPI_Index = -1;
OmpiVal = 0;
for i=1:length(StRes.KolmogorovSmirnov)
   if(StRes.KolmogorovSmirnov(i)== 0 && StRes.ANOVA_P(i) < 0.05 && abs(StRes.SP_RHO(i)) >=0.6 && StRes.SP_P(i) <0.05)
       indices = [indices; cont];
       if(StRes.SP_RHO(i) > OmpiVal)
           OMPI_Index = i;
       end
   end
   cont = cont+1;
end
VALIDATED_Indexes = indices;


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName]=uigetdir();
handles.directorio = FileName;
set(handles.text2, 'String', handles.directorio);

%esto es una prueba

set(handles.btn_cancelarSalir,'UserData',0)

guidata(hObject, handles);


% --- Executes on button press in mostrarOmpi.
function mostrarOmpi_Callback(hObject, eventdata, handles)
% hObject    handle to mostrarOmpi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = pupularTabla(handles.StRes, handles.clases, handles.OMPI_Index, handles);
guidata(hObject, handles);

% --- Executes on button press in mostrarValidados.
function mostrarValidados_Callback(hObject, eventdata, handles)
% hObject    handle to mostrarValidados (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = pupularTabla(handles.StRes, handles.clases, handles.VALIDATED_Indexes, handles);
guidata(hObject, handles);

% --- Executes on button press in mostrarTodos.
function mostrarTodos_Callback(hObject, eventdata, handles)
% hObject    handle to mostrarTodos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = pupularTabla(handles.StRes, handles.clases, 1:121, handles);
guidata(hObject, handles);


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName] = uiputfile('Results.xlsx','Save results');
handles.outputfile = [PathName FileName];
set(handles.text5, 'String', handles.outputfile);
guidata(hObject, handles);


% --- Executes on button press in btn_cancelarSalir.
function btn_cancelarSalir_Callback(hObject, eventdata, handles)
% hObject    handle to btn_cancelarSalir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = cancelarEjecucion(handles);
close all;
guidata(hObject, handles);

function handles = cancelarEjecucion(handles)
set(handles.btn_cancelarSalir,'UserData',1)