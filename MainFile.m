function varargout = MainFile(varargin)
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MainFile_OpeningFcn, ...
                   'gui_OutputFcn',  @MainFile_OutputFcn, ...
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


% --- Executes just before MainFile is made visible.
function MainFile_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MainFile wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MainFile_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
Data = handles.figure1.UserData;
if isfield(Data, 'Scale')
    ScaleObject(Data)
    close(handles.figure1)
end
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function uipushtool3_ClickedCallback(hObject, eventdata, handles)

[FileName Path Call] = uigetfile({'*.bmp; *.png; *.tiff; *.jpg'}, 'Выбор изображения');
if Call == 1
    
    handles.figure1.UserData.FileName = FileName;
    handles.figure1.UserData.Path = Path;
    [I, map] = imread(strcat(Path, FileName));
    %работаю только с полутоновой 8ми биткой
    I = I(:,:,1);
    if ~strcmp('uint8', class(I))
        %определим глубину
        cl = class(I);
        if strcmp('uint16', class(I))
            t = 2^16;
        elseif strcmp('uint32', class(I))
            t = 2^32;
        elseif strcmp('uint64', class(I))
            t = 2^64;
        else
            t = max(max(I));
        end
        I = double(I)./t;
        I = uint8(I.*255);
    end
    
    
    handles.figure1.UserData.IBase = I;
    handles.figure1.UserData.MapBase = map;
    handles.figure1.UserData.MapFinal = map;
    %нужен ещё промежуточный и конечный
    handles.figure1.UserData.IEdit = I;
    handles.figure1.UserData.IFinal = I;
    axes(handles.axes1);
    imshow(I, map)
end

% hObject    handle to uipushtool3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbuttonLine.
function pushbuttonLine_Callback(hObject, eventdata, handles)
Data = handles.figure1.UserData;
if ~isempty(Data)
    lengthScale = str2double( handles.editScale.String);
    if ~isempty(lengthScale)
        if lengthScale ~=0
            %������� ������� ��������
            %������� 2 �����
            [x, y] = ginput (2);
            axes(handles.axes1)
            hold on
            plot(x, y)
            hold off
            % ���������� �������� ���� ����
            c = round((abs(x(1)-x(2))^2 + abs(y(1)-y(2))^2)^0.5);
            
            Scale = round(c/lengthScale);
            
            handles.figure1.UserData.Scale = Scale;
            handles.textScale.String = strcat('� 1 ��_', num2str(Scale) ,' ����');
        end
    end
end

function editScale_Callback(hObject, eventdata, handles)
% hObject    handle to editScale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editScale as text
%        str2double(get(hObject,'String')) returns contents of editScale as a double


% --- Executes during object creation, after setting all properties.
function editScale_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editScale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
Data = handles.figure1.UserData;
if ~isempty(Data)
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


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
Data = handles.figure1.UserData;
if ~isempty(Data)
    ScaleHand(Data)
    close(handles.figure1)
end
