function varargout = EditPic(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @EditPic_OpeningFcn, ...
                   'gui_OutputFcn',  @EditPic_OutputFcn, ...
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


% --- Executes just before EditPic is made visible.
function EditPic_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
handles.figure1.UserData = varargin{1, 1};

I = handles.figure1.UserData.IBase;
map = handles.figure1.UserData.MapBase;
axes(handles.axes2)
imshow(I, map)


I = handles.figure1.UserData.INorm ;
Maska = handles.figure1.UserData.Maska;
I = uint8(double(I).*Maska);
map = MapFinal(I);
I = handles.figure1.UserData.IFinal;
map = handles.figure1.UserData.MapFinal;

NumMatrix = handles.figure1.UserData.NumMatrix;
Pic = EditObjectMatrix(NumMatrix(:,1), Maska, I, map);
handles.figure1.UserData.Pic = Pic;

a.empty = 1;
a.numeric = NumMatrix;


Picture = EditObjectPicture(Pic, a);
handles.figure1.UserData.Picture = Picture;
map = MapFinal(Picture);
handles.figure1.UserData.MapFinal = map;

axes(handles.axes1)
imshow(Picture, map)

guidata(hObject, handles);

% UIWAIT makes EditPic wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = EditPic_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
Data = handles.figure1.UserData;
SaveFile(Data)
close(handles.figure1)

% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
Data = handles.figure1.UserData;
NumEdit(Data)
close(handles.figure1)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
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



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
a.empty = handles.radiobutton1.Value;
x = handles.edit1.String;
x = str2num(x); %даёт пустой массив, если не цыфра
% проверим, что кол-во столбцов цыфра и не ноль
if ~isempty(x)
    if x ~= 0
        a.line = x;
    end
end

space1 = handles.edit2.String;
space1 = str2num(space1); %даёт пустой массив, если не цыфра
%проверим не ноль

if ~isempty(space1)
    space(1) = space1;
end

space2 = handles.edit3.String;
space2 = str2num(space2); %даёт пустой массив, если не цыфра
%проверим не ноль

if ~isempty(space2)
    space(2) = space2;
end

a.space = space;
Pic = handles.figure1.UserData.Pic;

Picture = EditObjectPicture(Pic, a);
handles.figure1.UserData.Picture = Picture;
handles.figure1.UserData.a = a;

map = handles.figure1.UserData.MapFinal;

axes(handles.axes1)
imshow(Picture, map)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
