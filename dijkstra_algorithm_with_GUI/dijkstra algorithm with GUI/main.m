function varargout = main(varargin)

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

handles.output = hObject;

%initial values
load('graph.mat');
load('position.mat');
load('labelnodeposition.mat');
load('labeledge.mat');

handles.graph = graph;
handles.graph_backup = graph;
handles.position = position;
handles.labelnodeposition = labelnodeposition;
handles.labeledgeposition = getlabeledgeposition;
handles.labeledge = labeledge;
handles.source = 1;
handles.destination = 1;
handles.street = 'J1 ';
guidata(hObject, handles);

axes(handles.axes1);
hold on;
gplot(handles.graph, handles.position,'-ok');
for i = 1:27
    text(handles.labelnodeposition(i,1),handles.labelnodeposition(i,2),int2str(i),'FontSize',7,'Color','k');  
end

for i= 1:36
    text(handles.labeledgeposition(i,1),handles.labeledgeposition(i,2),handles.labeledge(i,1:3),'FontSize',7,'Color','b');
end
axis off;


% --- Outputs from this function are returned to the command line.
function varargout = main_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;


% --- Executes when figure1 is resized.
function figure1_ResizeFcn(hObject, eventdata, handles)


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
val = get(hObject,'Value');
string_list = get(hObject,'String');
source =char(string_list(val));
handles.source = str2num(source);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
val = get(hObject,'Value');
string_list = get(hObject,'String');
source = char(string_list(val));
handles.source = str2num(source);
guidata(hObject, handles);

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
val = get(hObject,'Value');
string_list = get(hObject,'String');
destination = char(string_list(val));
handles.destination = str2num(destination);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
val = get(hObject,'Value');
string_list = get(hObject,'String');
destination = char(string_list(val));
handles.destination = str2num(destination);
guidata(hObject, handles);

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
axes(handles.axes1);
[cost rute] = showShortestPath(handles.graph,handles.position,handles.source,handles.destination);


% --- Executes on selection change in popupmenu4.
function popupmenu4_Callback(hObject, eventdata, handles)
val = get(hObject,'Value');
string_list = get(hObject,'String');
handles.street = char(string_list(val));
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function popupmenu4_CreateFcn(hObject, eventdata, handles)
val = get(hObject,'Value');
string_list = get(hObject,'String');
handles.street = char(string_list(val));
guidata(hObject, handles);

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
[node1 node2] = street2node(handles.street);
handles.graph(node1,node2) = 0;
handles.graph(node2,node1) = 0;
handles.graph(node1,node1) = 1;
handles.graph(node2,node2) = 1;
guidata(hObject, handles);
graph = [0 1; 1 0];
position = [handles.position(node1,1) handles.position(node1,2); handles.position(node2,1) handles.position(node2,2) ];
gplot(graph,position,'-or');


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
[node1 node2] = street2node(handles.street);
handles.graph(node1,node2) = handles.graph_backup(node1,node2);
handles.graph(node2,node1) = handles.graph_backup(node2,node1);
handles.graph(node1,node1) = 0;
handles.graph(node2,node2) = 0;
guidata(hObject, handles);
graph = [0 1; 1 0];
position = [handles.position(node1,1) handles.position(node1,2); handles.position(node2,1) handles.position(node2,2) ];
gplot(graph,position,'-ob');


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
handles.graph = handles.graph_backup;
guidata(hObject, handles);
hold off;
axes(handles.axes1);
gplot(handles.graph, handles.position,'-o');
hold on;
for i = 1:27
    text(handles.labelnodeposition(i,1),handles.labelnodeposition(i,2),int2str(i));  
end

for i= 1:36
    %text(handles.labeledgeposition(i,1),handles.labeledgeposition(i,2),handles.labeledge(i,1:3));
    %handles.labeledgeposition(i,1)
end
axis off;