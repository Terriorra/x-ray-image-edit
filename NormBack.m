function varargout = NormBack(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @NormBack_OpeningFcn, ...
                   'gui_OutputFcn',  @NormBack_OutputFcn, ...
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


% --- Executes just before NormBack is made visible.
function NormBack_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
handles.figure1.UserData = varargin{1, 1};


I = handles.figure1.UserData.IEdit;
map = handles.figure1.UserData.MapBase;
Size = handles.figure1.UserData.Size;
brash = round(Size / 2);
%фон
Background = imopen(I, strel('disk', brash));
handles.figure1.UserData.Background = Background;
axes(handles.axes1)
imshow(Background, map)
%без искажений
I = imsubtract(I, Background);
%без отклонения
[~, error] = max(imhist(I));
I = imsubtract(I, error);
handles.figure1.UserData.INorm = I;
map = NewMap(I,  0.5);
handles.figure1.UserData.MapNorm = map;
axes(handles.axes2)
imshow(I, map)

%Определим размер кисти
handles.edit2.String = num2str(brash);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes NormBack wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = NormBack_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
Data = handles.figure1.UserData;
MaskaCreate(Data)
close(handles.figure1)

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
Data = handles.figure1.UserData;
ScaleObject(Data)
close(handles.figure1)



% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
Value = get(hObject,'Value');
I = handles.figure1.UserData.Background;
map = handles.figure1.UserData.MapBase;

if Value > 0
    axes(handles.axes1)
    imshow(immultiply(I, Value), map)
else
    axes(handles.axes1)
    imshow(imsubtract(I, abs(Value*10)), map)
end

% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
Value = get(hObject,'Value');
I = handles.figure1.UserData.INorm;
map = handles.figure1.UserData.MapNorm;

if Value > 0
    axes(handles.axes2)
    imshow(immultiply(I, Value), map)
else
    axes(handles.axes2)
    imshow(imsubtract(I, abs(Value*10)), map)
end


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)

brash = str2double(handles.edit2.String);
I = handles.figure1.UserData.IEdit;

Background = imopen(I, strel('disk', brash));
handles.figure1.UserData.Background = Background;

Value = handles.slider1.Value;
map = handles.figure1.UserData.MapBase;
if Value > 0
    axes(handles.axes1)
    imshow(immultiply(Background, Value), map)
else
    axes(handles.axes1)
    imshow(imsubtract(Background, abs(Value*10)), map)
end


I = imsubtract(I, Background);
[~, error] = max(imhist(I));
I = imsubtract(I, error);
map = NewMap(I,  0.5);

Value = handles.slider2.Value;
if Value > 0
    axes(handles.axes2)
    imshow(immultiply(I, Value), map)
else
    axes(handles.axes2)
    imshow(imsubtract(I, abs(Value*10)), map)
end

handles.figure1.UserData.INorm = I;
handles.figure1.UserData.MapNorm = map;

a=1;

% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
