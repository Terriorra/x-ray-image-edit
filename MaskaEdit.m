function varargout = MaskaEdit(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MaskaEdit_OpeningFcn, ...
                   'gui_OutputFcn',  @MaskaEdit_OutputFcn, ...
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


% --- Executes just before MaskaEdit is made visible.
function MaskaEdit_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
handles.figure1.UserData = varargin{1, 1};

plotPicture(handles)


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MaskaEdit wait for user response (see UIRESUME)
% uiwait(handles.figure1);

function plotPicture(handles)
Maska = handles.figure1.UserData.Maska;
I = handles.figure1.UserData.INorm;
map = handles.figure1.UserData.MapNorm;

axes(handles.axes1)
imshow(I, map)

Maska = bwmorph(Maska, 'remove');
[x, y] = find(Maska);
hold on
gscatter(y,x)

%Пронумеруем объекты
numeric=num(Maska);
s = regionprops(Maska,'centroid');
s = cat(1,s.Centroid);
%вывести подписанные
for j=1:length(numeric)
    text(s(numeric(j),1), s(numeric(j),2), num2str(j), 'Color', 'g', 'FontSize', 14 )
end
hold off

handles.text3.String = strcat('Найдено объектов:_', num2str(max(numeric)));


% --- Outputs from this function are returned to the command line.
function varargout = MaskaEdit_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
Data = handles.figure1.UserData;
NumEdit(Data)
close(handles.figure1)

% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
Data = handles.figure1.UserData;
MaskaCreate(Data)
close(handles.figure1)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
Maska = handles.figure1.UserData.Maska;
Maska = bwlabel(Maska);

a =unique( Maska(1:10,:));
b = unique(Maska(end-10:end, :));
c = unique(Maska(:, 1:10));
d = unique(Maska(:, end-10:end));

s = unique([a; b; c; d]);
M = ~ismember(Maska, s);
Maska = M & Maska;
handles.figure1.UserData.Maska = Maska;

plotPicture(handles)

% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
Maska = handles.figure1.UserData.Maska;
Maska = imfill(Maska, 'holes');
handles.figure1.UserData.Maska = Maska;
plotPicture(handles)

% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
Maska = handles.figure1.UserData.Maska;
L = zeros(size(Maska));
[x, y] = myginput(2,'crosshair');
L = PlotLine(L, x, y);
Maska = ~L & Maska;
handles.figure1.UserData.Maska = Maska;
plotPicture(handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
Maska = handles.figure1.UserData.Maska;


[a, b] = myginput(1,'crosshair');
x = [];
y = [];
axes(handles.axes1)
hold on
while ~isempty(a)
    x = cat(1, x, a);
    y = cat(1, y, b);
    gscatter(x, y)
    [a, b] = myginput(1,'crosshair');
end
x(end+1)=x(1);
y(end+1)=y(1);

spcv = cscvn( [x, y].' );

%создать пиксельный контур
z = fnplt( spcv);
%z = round(z);
z(:, end+1)=z(:, 1);

R = AddPunct(Maska, z(1,:), z(2,:));

Maska = R | Maska;
handles.figure1.UserData.Maska = Maska;
plotPicture(handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
Maska = handles.figure1.UserData.Maska;
numeric=num(Maska);
e = str2double(handles.edit1.String);
T = ~ ismember(bwlabel(Maska), numeric(e));
Maska  = Maska&T;
handles.figure1.UserData.Maska = Maska;
plotPicture(handles)


% hObject    handle to pushbutton7 (see GCBO)
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
