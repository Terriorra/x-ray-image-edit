function varargout = ScaleObject(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ScaleObject_OpeningFcn, ...
                   'gui_OutputFcn',  @ScaleObject_OutputFcn, ...
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


% --- Executes just before ScaleObject is made visible.
function ScaleObject_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;
handles.figure1.UserData = varargin{1, 1};
I = handles.figure1.UserData.IEdit;
map = handles.figure1.UserData.MapBase;
axes(handles.axes1)
imshow(I, map)
guidata(hObject, handles);

% UIWAIT makes ScaleObject wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ScaleObject_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
[x, y] = ginput (2);
% количество пикселей межу ними
c = round((abs(x(1)-x(2))^2 + abs(y(1)-y(2))^2)^0.5);
handles.figure1.UserData.Size = c;
Scale = handles.figure1.UserData.Scale;
handles.text4.String = strcat('Максимальная длина семени _', num2str(round(c/Scale)) ,' мм');

axes(handles.axes1)
hold on
plot(x, y)
hold off

% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
Value = get(hObject,'Value');
I = handles.figure1.UserData.IEdit;
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


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
Data = handles.figure1.UserData;
NormBack(Data)
close(handles.figure1)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
MainFile()
close(handles.figure1)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
