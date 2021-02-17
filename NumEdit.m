function varargout = NumEdit(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @NumEdit_OpeningFcn, ...
                   'gui_OutputFcn',  @NumEdit_OutputFcn, ...
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


% --- Executes just before NumEdit is made visible.
function NumEdit_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;
handles.figure1.UserData = varargin{1, 1};
count = 1;
handles.figure1.UserData.count = count;
Maska = handles.figure1.UserData.Maska;
I = handles.figure1.UserData.INorm;
map = handles.figure1.UserData.MapNorm;

axes(handles.axes1)
imshow(I, map)

s = regionprops(Maska,'centroid');
s = cat(1,s.Centroid);
handles.figure1.UserData.s = s;


Maska = bwmorph(Maska, 'remove');
[x, y] = find(Maska);
hold on
gscatter(y,x)
hold off
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes NumEdit wait for user response (see UIRESUME)
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



% --- Outputs from this function are returned to the command line.
function varargout = NumEdit_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
Data = handles.figure1.UserData;
EditPic(Data)
close(handles.figure1)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
Data = handles.figure1.UserData;
MaskaEdit(Data)
close(handles.figure1)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
Value = handles.pushbutton3.Value;
count = handles.figure1.UserData.count;
s = handles.figure1.UserData.s;
while Value == 1
    Maska = handles.figure1.UserData.Maska;    
    I = handles.figure1.UserData.INorm;
    map = handles.figure1.UserData.MapNorm;
    if count == 1
        NumMatrix = [0, 0]
        axes(handles.axes1)
        imshow(I, map)
        M = bwmorph(Maska, 'remove');
        [x, y] = find(M);
        hold on
        gscatter(y,x)
        hold off
    end
    Maska = bwlabel(Maska);
    [x, y] = ginput (1);
    if isempty(x)
        handles.pushbutton3.Value   = 0;
        break
    elseif x < 0
        handles.pushbutton3.Value   = 0;
        break
    elseif y < 0
        handles.pushbutton3.Value   = 0;
        break
    elseif sum(size(Maska) > [x, y]) < 2
        handles.pushbutton3.Value   = 0;
        break
    end
    
    punct = Maska(round(y), round(x));
    if punct ~= 0
        text(s(punct,1), s(punct, 2), num2str(count), 'Color', 'g', 'FontSize', 14)
    end
    now = [ punct, count];
    NumMatrix = cat(1, NumMatrix, now);
    if NumMatrix(1, 2) == 0
        NumMatrix(1,:) = [];
    end
    handles.figure1.UserData.NumMatrix = NumMatrix;
    
    handles.text3.String = strcat('Текущий номер: ', num2str(count));
    
    count = count + 1;
    handles.figure1.UserData.count =  count;
    
end


% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
plotPicture(handles)
handles.figure1.UserData.count = 1;
Maska = handles.figure1.UserData.Maska;
numeric=num(Maska);
n = 1:length(numeric);
NumMatrix = [];
NumMatrix = cat(2, numeric, n' );
count = 1;
handles.figure1.UserData.count = count;
handles.figure1.UserData.NumMatrix = NumMatrix;
handles.text3.String = strcat('Текущий номер: ', num2str(count));


% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
