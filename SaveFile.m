function varargout = SaveFile(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SaveFile_OpeningFcn, ...
                   'gui_OutputFcn',  @SaveFile_OutputFcn, ...
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


% --- Executes just before SaveFile is made visible.
function SaveFile_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;
handles.figure1.UserData = varargin{1, 1};
I = handles.figure1.UserData.Picture;
map = handles.figure1.UserData.MapFinal;
axes(handles.axes1)
imshow(I, map)

name = handles.figure1.UserData.FileName;
e = strfind(name, '.');
NewName = strcat(name(1:e-1),'_new', name(e:end));
handles.edit1.String = NewName;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SaveFile wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SaveFile_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
I = handles.figure1.UserData.Picture;
map = handles.figure1.UserData.MapFinal;
s = handles.figure1.UserData.Scale;

Z = zeros(size(I, 1), 10);
Z(1:s:end, :)=255;
Z1 = zeros(size(I, 1), 10);
Z1(1:s*5:end, :)=255;
Z2 = zeros(size(I, 1), 10);
Z2(1:s*10:end, :)=255;
I = uint8(cat(2, I, Z2, Z1, Z));
handles.figure1.UserData.Picture = I;

axes(handles.axes1)
imshow(I, map)
 


% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
map = handles.figure1.UserData.MapFinal;
Pic = handles.figure1.UserData.Pic;
name = handles.edit1.String;
path = handles.figure1.UserData.Path;

e = strfind(name, '.');
for i = 1 : length(Pic)
    I = Pic(i).pic;
    if i < 10
        b = '00';
    elseif i < 100
        b = '0';
    else
        b = '';
    end
    n = strcat(path, name(1:e-1), '_', b, num2str(i), name(e:end));
    imwrite(I, map, n)
end

% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
name = handles.edit1.String;
name = strcat(handles.figure1.UserData.Path, name);
I = handles.figure1.UserData.Picture;
map = handles.figure1.UserData.MapFinal;
imwrite(I, map, name)


% hObject    handle to pushbutton3 (see GCBO)
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


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
Data = handles.figure1.UserData;
EditPic(Data)
close(handles.figure1)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
