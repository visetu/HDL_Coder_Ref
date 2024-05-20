function varargout = llrf_gui(varargin)
% LLRF_GUI MATLAB code for llrf_gui.fig
%      LLRF_GUI, by itself, creates a new LLRF_GUI or raises the existing
%      singleton*.
%
%      H = LLRF_GUI returns the handle to a new LLRF_GUI or the handle to
%      the existing singleton*.
%
%      LLRF_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LLRF_GUI.M with the given input arguments.
%
%      LLRF_GUI('Property','Value',...) creates a new LLRF_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before llrf_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to llrf_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help llrf_gui

% Last Modified by GUIDE v2.5 02-Jan-2012 09:27:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @llrf_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @llrf_gui_OutputFcn, ...
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


% --- Executes just before llrf_gui is made visible.
%function llrf_gui_OpeningFcn(hObject, eventdata, handles, varargin)
function llrf_gui_OpeningFcn(hObject,   ~,        handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to llrf_gui (see VARARGIN)

% Choose default command line output for llrf_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes llrf_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% PUT HERE THE VARIABLES SHARED ACROSS DIFFERENT CALLBACK FUNCS ***


%**********************************************************************
%*****  S Y N C H  Simulink Components to GUI Controls   **************
%**********************************************************************

    %==== Manual switches =============================================
    %value = get_param([bdroot '/timer/ctl_fb_enb_sw'],'sw');
    %if strcmp(value,'0');   set(handles.checkbox_switch,'Value',0)
    %else                    set(handles.checkbox_switch,'Value',1)
    %end
    
        value = get_param([bdroot '/daq/daq_tp1_enb'],'sw');
        if strcmp(value,'0');   set(handles.checkbox_tp1_sw,'Value',0)
        else                   set(handles.checkbox_tp1_sw,'Value',1)
        end
        
    value = get_param([bdroot '/daq/daq_tp2_enb'],'sw');
    if strcmp(value,'0');   set(handles.checkbox_tp2_sw,'Value',0)
    else                   set(handles.checkbox_tp2_sw,'Value',1)
    end
    
        value = get_param([bdroot '/daq/daq_tp3_enb'],'sw');
        if strcmp(value,'0');   set(handles.checkbox_tp3_sw,'Value',0)
        else                   set(handles.checkbox_tp3_sw,'Value',1)
        end
        
    value = get_param([bdroot '/daq/daq_tp4_enb'],'sw');
    if strcmp(value,'0');   set(handles.checkbox_tp4_sw,'Value',0)
    else                   set(handles.checkbox_tp4_sw,'Value',1)
    end 
    
        value = get_param([bdroot '/daq/daq_tp5_enb'],'sw');
        if strcmp(value,'0');   set(handles.checkbox_tp5_sw,'Value',0)
        else                   set(handles.checkbox_tp5_sw,'Value',1)
        end
        
    value = get_param([bdroot '/daq/daq_tp6_enb'],'sw');
    if strcmp(value,'0');   set(handles.checkbox_tp6_sw,'Value',0)
    else                   set(handles.checkbox_tp6_sw,'Value',1)
    end
    
        value = get_param([bdroot '/daq/daq_tp7_enb'],'sw');
        if strcmp(value,'0');   set(handles.checkbox_tp7_sw,'Value',0)
        else                   set(handles.checkbox_tp7_sw,'Value',1)
        end
        
    value = get_param([bdroot '/daq/daq_tp8_enb'],'sw');
    if strcmp(value,'0');   set(handles.checkbox_tp8_sw,'Value',0)
    else                   set(handles.checkbox_tp8_sw,'Value',1)
    end
    
        value = get_param([bdroot '/daq/daq_Quad_nPolar_sel_sw'],'sw');
        if strcmp(value,'0');   set(handles.popupmenu_plot_mode_sel, 'Value',1)
        else                   set(handles.popupmenu_plot_mode_sel, 'Value',2)
        end
        
    value = get_param([bdroot '/VS SWITCH/ctl_vs_sw0'],'sw');
    if strcmp(value,'0');   set(handles.vsSW1,'Value',0)
    else                    set(handles.vsSW1,'Value',1)
    end
    value = get_param([bdroot '/VS SWITCH/ctl_vs_sw1'],'sw');
    if strcmp(value,'0');   set(handles.vsSW2,'Value',0)
    else                    set(handles.vsSW2,'Value',1)
    end
    value = get_param([bdroot '/VS SWITCH/ctl_vs_sw2'],'sw');
    if strcmp(value,'0');   set(handles.vsSW3,'Value',0)
    else                    set(handles.vsSW3,'Value',1)
    end
    value = get_param([bdroot '/VS SWITCH/ctl_vs_sw3'],'sw');
    if strcmp(value,'0');   set(handles.vsSW4,'Value',0)
    else                    set(handles.vsSW4,'Value',1)
    end
     value = get_param([bdroot '/VS SWITCH/ctl_vs_sw4'],'sw');
    if strcmp(value,'0');   set(handles.vsSW5,'Value',0)
    else                    set(handles.vsSW5,'Value',1)
    end
    value = get_param([bdroot '/VS SWITCH/ctl_vs_sw5'],'sw');
    if strcmp(value,'0');   set(handles.vsSW6,'Value',0)
    else                    set(handles.vsSW6,'Value',1)
    end
    value = get_param([bdroot '/VS SWITCH/ctl_vs_sw6'],'sw');
    if strcmp(value,'0');   set(handles.vsSW7,'Value',0)
    else                    set(handles.vsSW7,'Value',1)
    end
    value = get_param([bdroot '/VS SWITCH/ctl_vs_sw7'],'sw');
    if strcmp(value,'0');   set(handles.vsSW8,'Value',0)
    else                    set(handles.vsSW8,'Value',1)
    end
 
 
   
        
    %==================================================================

    %==== TIMER constants  =====================================
    value = get_param([bdroot '/timer/Igate_delay'], 'Value');
            set(handles.edit_Idelay,    'String',       value); 
    value = get_param([bdroot '/timer/Igate_width'], 'Value');
            set(handles.edit_Iwidth,    'String',       value); 

    value = get_param([bdroot '/timer/Pgate_delay'], 'Value');
            set(handles.edit_Pdelay,    'String',       value); 
    value = get_param([bdroot '/timer/Pgate_width'], 'Value');
            set(handles.edit_Pwidth,    'String',       value);
    
    value = get_param([bdroot '/timer/FVMgate_delay'], 'Value');
            set(handles.edit_FVMdelay,    'String',       value); 
    value = get_param([bdroot '/timer/FVMgate_width'], 'Value');
            set(handles.edit_FVMwidth,    'String',       value);

    value = get_param([bdroot '/timer/RFgate_delay'], 'Value');
            set(handles.edit_RF_delay,    'String',       value); 
    value = get_param([bdroot '/timer/RFgate_width'], 'Value');
            set(handles.edit_RF_width,    'String',       value);
            
            
    %==================================================================
    
    
    %==== FEED-FORWARD constants  =====================================
    value = get_param([bdroot '/ctl_ff_lut/ff_delay'],   'Value');
            set(handles.edit_ff_delay,    'String',       value); 
    value = get_param([bdroot '/ctl_ff_lut/ff_fill'],    'Value');
            set(handles.edit_ff_fill,     'String',       value); 
    value = get_param([bdroot '/ctl_ff_lut/ff_flattop'], 'Value');
            set(handles.edit_ff_flattop,  'String',       value); 
    value = get_param([bdroot '/ctl_ff_lut/ff_ampl'],    'Value');
            set(handles.edit_ff_ampl,     'String',       value); 
    value = get_param([bdroot '/ctl_ff_lut/ff_ratio'],   'Value');
            set(handles.edit_ff_ratio,    'String',       value); 
    value = get_param([bdroot '/ctl_ff_lut/ff_angle'],   'Value');
            set(handles.edit_ff_phase,    'String',       value);
    %==================================================================

    %==== SET-POINT constants =========================================
    value = get_param([bdroot '/ctl_sp_lut/sp_delay'],   'Value');
            set(handles.edit_sp_delay,    'String',       value);
    value = get_param([bdroot '/ctl_sp_lut/sp_stop'],    'Value');
            set(handles.edit_sp_stop,     'String',       value);
    value = get_param([bdroot '/ctl_sp_lut/sp_ampl'],    'Value');
            set(handles.edit_sp_ampl,     'String',       value);
    value = get_param([bdroot '/ctl_sp_lut/sp_phase'],   'Value');
            set(handles.edit_sp_phase,    'String',       value);
    value = get_param([bdroot '/ctl_sp_lut/sp_QL'],      'Value');
            set(handles.edit_sp_QL,       'String',       value);
    value = get_param([bdroot '/ctl_sp_lut/sp_f0'],      'Value');
            set(handles.edit_sp_f0,       'String',       value);
    %==================================================================    

    %====  BEAM constants =============================================
    value = get_param([bdroot '/Hminus/beam_delay'],       'Value');
            set(handles.edit_beam_delay,    'String',     value);
    value = get_param([bdroot '/Hminus/beam_length'],      'Value');
            set(handles.edit_beam_length,    'String',    value);
    value = get_param([bdroot '/Hminus/beam_current'],     'Value');
            set(handles.edit_beam_current,    'String',   value);
    value = get_param([bdroot '/Hminus/beam_phase'],       'Value');
            set(handles.edit_beam_phase,    'String',     value);
    %==================================================================    

    %====  BEAM compensation constants =================================
    value = get_param([bdroot '/ctl_ff_lut/beam_comp_delay'],  'Value');
            set(handles.edit_beam_comp_delay,   'String',       value);
    value = get_param([bdroot '/ctl_ff_lut/beam_comp_length'], 'Value');
            set(handles.edit_beam_comp_length,  'String',       value);
    value = get_param([bdroot '/ctl_ff_lut/beam_comp_current'],'Value');
            set(handles.edit_beam_comp_current, 'String',       value);
    value = get_param([bdroot '/ctl_ff_lut/beam_comp_phase'],  'Value');
            set(handles.edit_beam_comp_phase,   'String',       value);
    %==================================================================      
  
    
    %====  Cycle Counter    constants =================================
    %value = get_param([bdroot '/ctl_ff_lut/beam_comp_delay'],  'Value');
    %        set(handles.edit_beam_comp_delay,   'String',       value);
    %==================================================================  
        
    
    %====  PID Controller P & I Gains =================================
    value = get_param([bdroot '/PI_Controller_MFC/PID_I'],'P');
            set_param([bdroot '/PI_Controller_MFC/PID_Q'],'P',value);
            set(handles.edit_P_Gain,'String',value);   
            %==== Set the slider gain, with max/min of +10000/-10000
            slider_position = max(0,min(1,(str2double(value) + 10000)/20000));
            set(handles.slider_P_Gain,'Value',slider_position);
    value = get_param([bdroot '/PI_Controller_MFC/PID_I'],'I');
            set_param([bdroot '/PI_Controller_MFC/PID_Q'],'I',value);
            set(handles.edit_I_Gain,'String',value);   
            %==== Set the slider gain, with max/min of +10000000/-10000000
            slider_position = max(0,min(1,(str2double(value) + 10000000)/20000000));
            set(handles.slider_I_Gain,'Value',slider_position);            
    %==================================================================

    %==== Electrical Delay ============================================
        value = get_param([bdroot '/Electrical_Delay/Electrical_delay_us'], 'Value');
            set(handles.edit_electrical_delay,  'String',  value);
    %==================================================================

   
    %==== CAVITY constants  =====================================
    value = get_param([bdroot '/ctl_ff_lut/ff_delay'],   'Value');
            set(handles.edit_ff_delay,    'String',       value); 
            
    value = get(handles.edit_cav_f0, 'String'); f0   = str2double(value);
    value = get(handles.edit_cav_QL, 'String'); QL   = str2double(value);
    value = get(handles.edit_cav_num,'String'); cNum = str2double(value);    
    
    lib = llrf_lib; 
    lib.cav_TF(f0,QL,cNum);
    
    halfBW = 0.001*f0/QL/2;  str = num2str(halfBW,'%6.4f');
                             set(handles.text_BW, 'String', str);              
    %==================================================================
   
    %==== Klystron EACC constants  =====================================
    value = get_param([bdroot '/Klystron/EACC'],'Gain');
            set(handles.edit_cav_eacc,    'String',       value); 
    %==================================================================
    
    %==== Axes_plot ===================================================
        handles.xmin = 0.0;   str = num2str(handles.xmin);
                              set(handles.edit_axis_xmin, 'String', str);
        handles.xmax = 0.005; str = num2str(handles.xmax);
                              set(handles.edit_axis_xmax, 'String', str);
        handles.ymin = 0.0;   str = num2str(handles.ymin);
                              set(handles.edit_axis_ymin, 'String', str);        
        handles.ymax = 1.0;   str = num2str(handles.ymax);
                              set(handles.edit_axis_ymax, 'String', str);        
        %axes(handles.axes_plot);
        axis( [handles.xmin handles.xmax handles.ymin handles.ymax] );
        grid on;  set(handles.checkbox_grid,'Value',1)
    %==================================================================
    
    %==== FVM constants  =====================================
    
    value = get_param([bdroot '/FVM_Control/LEARNING_CONTROLLER/DelayB_in_us'],'Value');
            set(handles.edit_TRF_delay,    'String',       value);             
            
    %==================================================================
    
    %====   VS Scalar   ===============================================
          
    value = get_param([bdroot '/VS_Scalar/vsScalar'],'Gain');
            set(handles.vsGain,    'String',       value);             
    %==================================================================
    
    
%**********************************************************************
%*****   S Y N C H    E N D                             ***************
%**********************************************************************

guidata(hObject, handles); %updates the handles


% --- Outputs from this function are returned to the command line.
%function varargout = llrf_gui_OutputFcn(hObject, eventdata, handles)
function varargout = llrf_gui_OutputFcn( ~,       ~,         handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



% --- Executes on button press in pushbutton_startstop.
%function pushbutton_startstop_Callback(hObject, eventdata, handles)
function pushbutton_startstop_Callback(hObject,  ~,         handles)
mystring = get(hObject,'String');
status = get_param(bdroot,'simulationstatus');

if strcmp(mystring,'Start Time-Domain Simulation')
    
    % Check the status of the simulation and start it if it's stopped
    if strcmp(status,'stopped')
        set_param(bdroot,'simulationcommand','start')
    end
    
    % Update the string on the pushbutton
    set(handles.pushbutton_startstop,'String','Stop Simulation')     
    
elseif strcmp(mystring,'Stop Simulation')
    
    % Check the status of the simulation and stop it if it's running
    if strcmp(status,'running')
        set_param(bdroot, 'SimulationCommand', 'Stop')
    end
    
    % Update the string on the pushbutton
    set(handles.pushbutton_startstop,'String','Start Time-Domain Simulation')      
  

else
    warning('Unrecognized string for pushbutton_startstop') %#ok<WNTAG>
end

guidata(hObject, handles); %updates the handles

% Assign handles and the startstop object to the base workspace
assignin('base','llrf_handles',handles)
assignin('base','startstop_hObject',handles.pushbutton_startstop)




% --- Executes on button press in checkbox_switch.
%function checkbox_switch_Callback(hObject, eventdata, handles)
function checkbox_switch_Callback(hObject, eventdata, handles)

value = get(hObject,'Value');

if value == 0
%    set_param([bdroot '/timer/ctl_fb_enb_sw'],'sw','0')
else
%    set_param([bdroot '/timer/ctl_fb_enb_sw'],'sw','1')
    fvm_coil_bode_plot_func(hObject, eventdata, handles);
end

% Assign handles and the switch object to the base workspace
assignin('base','llrf_handles',handles)
assignin('base','switch_hObject',handles.checkbox_switch)




function edit_P_Gain_Callback(hObject, eventdata, handles)

value = get(hObject,'String');

% Update the model's gain value
set_param([bdroot '/PI_Controller_MFC/PID_I'],'P',value);
set_param([bdroot '/PI_Controller_MFC/PID_Q'],'P',value);

% Set the value of the gain slider, with max/min of +10000/-10000
slider_position = max(0,min(1,(str2double(value) + 10000)/20000));
set(handles.slider_P_Gain,'Value',slider_position);

% Update simulation if the model is running
status = get_param(bdroot,'simulationstatus');
if strcmp(status,'running')
    set_param(bdroot, 'SimulationCommand', 'Update');   
end

bode_plot_func(hObject, eventdata, handles);



% --- Executes during object creation, after setting all properties.
%function edit_P_Gain_CreateFcn(hObject, eventdata, handles)
function edit_P_Gain_CreateFcn(hObject, ~,          ~) 

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider_P_Gain_Callback(hObject, eventdata, handles) %#ok<*DEFNU>

% Get the value of the gain slider and determine what the gain value should be
slider_position = get(hObject,'Value');
value = num2str(10000*(slider_position*2 - 1));

% Update the model's gain value
set_param([bdroot '/PI_Controller_MFC/PID_I'],'P',value);
set_param([bdroot '/PI_Controller_MFC/PID_Q'],'P',value);


% Set the value of the gain edit box
set(handles.edit_P_Gain,'String',value);

% Update simulation if the model is running
status = get_param(bdroot,'simulationstatus');
if strcmp(status,'running')
    set_param(bdroot, 'SimulationCommand', 'Update');
end;

bode_plot_func(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
%function slider_P_Gain_CreateFcn(hObject, eventdata, handles)
function slider_P_Gain_CreateFcn(hObject, ~, ~)    

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --------------------------------------------------------------------
%function menu_File_Callback(hObject, eventdata, handles)
function menu_File_Callback(~, ~, ~)


% --------------------------------------------------------------------
%function menu_Tools_Callback(hObject, eventdata, handles)
function menu_Tools_Callback(~, ~, ~)



% --------------------------------------------------------------------
%function menu_File_Save_Config_Callback(hObject, eventdata, handles)
function menu_File_Save_Config_Callback(~, ~, ~)


% --------------------------------------------------------------------
%function menu_File_Restore_Config_Callback(hObject, eventdata, handles)
function menu_File_Restore_Config_Callback(~, ~, ~)  


% --------------------------------------------------------------------
%function menu_File_Save_Data_Callback(hObject, eventdata, handles)
function menu_File_Save_Data_Callback(~, ~, ~)


% --------------------------------------------------------------------
%function menu_File_Restore_Data_Callback(hObject, eventdata, handles)
function menu_File_Restore_Data_Callback(~, ~, ~)


% --------------------------------------------------------------------
%function menu_File_Exit_gui_Callback(hObject, eventdata, handles)
function menu_File_Exit_gui_Callback(~, ~, ~)    
close;                      % exit the application


% --- Executes on button press in checkbox_tp1_sw.
%function checkbox_tp1_sw_Callback(hObject, eventdata, handles)
function checkbox_tp1_sw_Callback(hObject, ~, handles)
value = get(hObject,'Value');
if value == 0;   set_param([bdroot '/daq/daq_tp1_enb'],'sw','0')
else             set_param([bdroot '/daq/daq_tp1_enb'],'sw','1')
end
% Assign handles and the switch object to the base workspace
assignin('base','llrf_handles',handles)
assignin('base','switch_hObject',handles.checkbox_tp1_sw)


    % --- Executes on button press in checkbox_tp2_sw.
    %function checkbox_tp2_sw_Callback(hObject, eventdata, handles)
    function checkbox_tp2_sw_Callback(hObject, ~, handles)
    value = get(hObject,'Value');
    if value == 0;   set_param([bdroot '/daq/daq_tp2_enb'],'sw','0')
    else             set_param([bdroot '/daq/daq_tp2_enb'],'sw','1')
    end
    % Assign handles and the switch object to the base workspace
    assignin('base','llrf_handles',handles)
    assignin('base','switch_hObject',handles.checkbox_tp2_sw)


% --- Executes on button press in checkbox_tp3_sw.
%function checkbox_tp3_sw_Callback(hObject, eventdata, handles)
function checkbox_tp3_sw_Callback(hObject, ~, handles)
value = get(hObject,'Value');
if value == 0;   set_param([bdroot '/daq/daq_tp3_enb'],'sw','0')
else             set_param([bdroot '/daq/daq_tp3_enb'],'sw','1')
end
% Assign handles and the switch object to the base workspace
assignin('base','llrf_handles',handles)
assignin('base','switch_hObject',handles.checkbox_tp3_sw)


    % --- Executes on button press in checkbox_tp4_sw.
    %function checkbox_tp4_sw_Callback(hObject, eventdata, handles)
    function checkbox_tp4_sw_Callback(hObject, ~, handles)    
    value = get(hObject,'Value');
    if value == 0;   set_param([bdroot '/daq/daq_tp4_enb'],'sw','0')
    else             set_param([bdroot '/daq/daq_tp4_enb'],'sw','1')
    end
    % Assign handles and the switch object to the base workspace
    assignin('base','llrf_handles',handles)
    assignin('base','switch_hObject',handles.checkbox_tp4_sw)


% --- Executes on button press in checkbox_tp5_sw.
%function checkbox_tp5_sw_Callback(hObject, eventdata, handles)
function checkbox_tp5_sw_Callback(hObject, ~, handles)
value = get(hObject,'Value');
if value == 0;   set_param([bdroot '/daq/daq_tp5_enb'],'sw','0')
else             set_param([bdroot '/daq/daq_tp5_enb'],'sw','1')
end
% Assign handles and the switch object to the base workspace
assignin('base','llrf_handles',handles)
assignin('base','switch_hObject',handles.checkbox_tp5_sw)


    % --- Executes on button press in checkbox_tp6_sw.
    %function checkbox_tp6_sw_Callback(hObject, eventdata, handles)
    function checkbox_tp6_sw_Callback(hObject, ~, handles)
    value = get(hObject,'Value');
    if value == 0;   set_param([bdroot '/daq/daq_tp6_enb'],'sw','0')
    else             set_param([bdroot '/daq/daq_tp6_enb'],'sw','1')
    end
    % Assign handles and the switch object to the base workspace
    assignin('base','llrf_handles',handles)
    assignin('base','switch_hObject',handles.checkbox_tp6_sw)


% --- Executes on button press in checkbox_tp7_sw.
%function checkbox_tp7_sw_Callback(hObject, eventdata, handles)
function checkbox_tp7_sw_Callback(hObject, ~, handles)    

value = get(hObject,'Value');
if value == 0;   set_param([bdroot '/daq/daq_tp7_enb'],'sw','0')
else             set_param([bdroot '/daq/daq_tp7_enb'],'sw','1')
end
% Assign handles and the switch object to the base workspace
assignin('base','llrf_handles',handles)
assignin('base','switch_hObject',handles.checkbox_tp7_sw)


    % --- Executes on button press in checkbox_tp8_sw.
    %function checkbox_tp8_sw_Callback(hObject, eventdata, handles)
    function checkbox_tp8_sw_Callback(hObject, ~, handles)    
    value = get(hObject,'Value');
    if value == 0;   set_param([bdroot '/daq/daq_tp8_enb'],'sw','0')
    else             set_param([bdroot '/daq/daq_tp8_enb'],'sw','1')
    end
    % Assign handles and the switch object to the base workspace
    assignin('base','llrf_handles',handles)
    assignin('base','switch_hObject',handles.checkbox_tp8_sw)




% --- Executes on selection change in popupmenu_plot_mode_sel.
%function popupmenu_plot_mode_sel_Callback(hObject, eventdata, handles)
function popupmenu_plot_mode_sel_Callback(hObject, ~, ~)
    
%gets the selected option 

value = get(hObject,'Value');

switch value
    case 1
            set_param([bdroot '/daq/daq_Quad_nPolar_sel_sw'],'sw','0')
    case 2
            set_param([bdroot '/daq/daq_Quad_nPolar_sel_sw'],'sw','1')
    otherwise
end


% --- Executes during object creation, after setting all properties.
%function popupmenu_plot_mode_sel_CreateFcn(hObject, eventdata, handles)
function popupmenu_plot_mode_sel_CreateFcn(hObject, ~, ~)    
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_cav_f0_Callback(hObject, eventdata, handles)

value = get(hObject,'String');              f0  = str2double(value);
value = get(handles.edit_cav_QL,'String');  QL  = str2double(value);
value = get(handles.edit_cav_num,'String'); cNum = str2double(value);    
%set(handles.edit_sp_QL,'String',value);
    lib = llrf_lib; 
    lib.cav_TF(f0,QL,cNum);  

% Update simulation if the model is running
status = get_param(bdroot,'simulationstatus');
if strcmp(status,'running')
    set_param(bdroot, 'SimulationCommand', 'Update')
end;

bode_plot_func(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
%function edit_cav_f0_CreateFcn(hObject, eventdata, handles)
function edit_cav_f0_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



%function edit_ff_delay_Callback(hObject, eventdata, handles)
function edit_ff_delay_Callback(hObject, ~, ~)
% Get the value of the ff_delay from the "edit_ff_delay"
ff_delay = get(hObject,'String');
set_param([bdroot '/ctl_ff_lut/ff_delay'],'Value',ff_delay)
        

% --- Executes during object creation, after setting all properties.
%function edit_ff_delay_CreateFcn(hObject, eventdata, handles)
function edit_ff_delay_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



%function edit_ff_fill_Callback(hObject, eventdata, handles)
function edit_ff_fill_Callback(hObject, ~, ~)
% Get the value of the ff_delay from the "edit_ff_fill"
ff_fill = get(hObject,'String');
set_param([bdroot '/ctl_ff_lut/ff_fill'],'Value',ff_fill)

% --- Executes during object creation, after setting all properties.
%function edit_ff_fill_CreateFcn(hObject, eventdata, handles)
function edit_ff_fill_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



%function edit_ff_flattop_Callback(hObject, eventdata, handles)
function edit_ff_flattop_Callback(hObject, ~, ~)
ff_flattop = get(hObject,'String');
set_param([bdroot '/ctl_ff_lut/ff_flattop'],'Value',ff_flattop)

% --- Executes during object creation, after setting all properties.
%function edit_ff_flattop_CreateFcn(hObject, eventdata, handles)
function edit_ff_flattop_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



%function edit_ff_ampl_Callback(hObject, eventdata, handles)
function edit_ff_ampl_Callback(hObject, ~, ~)
ff_ampl = get(hObject,'String');
set_param([bdroot '/ctl_ff_lut/ff_ampl'],'Value',ff_ampl)


% --- Executes during object creation, after setting all properties.
%function edit_ff_ampl_CreateFcn(hObject, eventdata, handles)
function edit_ff_ampl_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



%function edit_ff_ratio_Callback(hObject, eventdata, handles)
function edit_ff_ratio_Callback(hObject, ~, ~)
ff_ratio = get(hObject,'String');
set_param([bdroot '/ctl_ff_lut/ff_ratio'],'Value',ff_ratio)

% --- Executes during object creation, after setting all properties.
%function edit_ff_ratio_CreateFcn(hObject, eventdata, handles)
function edit_ff_ratio_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



%function edit_ff_phase_Callback(hObject, eventdata, handles)
function edit_ff_phase_Callback(hObject, ~, ~)
ff_angle = get(hObject,'String');
set_param([bdroot '/ctl_ff_lut/ff_angle'],'Value',ff_angle)

% --- Executes during object creation, after setting all properties.
%function edit_ff_phase_CreateFcn(hObject, eventdata, handles)
function edit_ff_phase_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



%function edit_sp_delay_Callback(hObject, eventdata, handles)
function edit_sp_delay_Callback(hObject, ~, ~)
% Get the value of the sp_delay from the "edit_sp_delay"
sp_delay = get(hObject,'String');
set_param([bdroot '/ctl_sp_lut/sp_delay'],'Value',sp_delay)

% --- Executes during object creation, after setting all properties.
%function edit_sp_delay_CreateFcn(hObject, eventdata, handles)
function edit_sp_delay_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



%function edit_sp_stop_Callback(hObject, eventdata, handles)
function edit_sp_stop_Callback(hObject, ~, ~)
% Get the value of the sp_stop from the "edit_sp_stop"
sp_stop = get(hObject,'String');
set_param([bdroot '/ctl_sp_lut/sp_stop'],'Value',sp_stop)

% --- Executes during object creation, after setting all properties.
%function edit_sp_stop_CreateFcn(hObject, eventdata, handles)
function edit_sp_stop_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



%function edit_sp_ampl_Callback(hObject, eventdata, handles)
function edit_sp_ampl_Callback(hObject, ~, ~)
% Get the value of the sp_ampl from the "edit_sp_ampl"
sp_ampl = get(hObject,'String');
set_param([bdroot '/ctl_sp_lut/sp_ampl'],'Value',sp_ampl)


% --- Executes during object creation, after setting all properties.
%function edit_sp_ampl_CreateFcn(hObject, eventdata, handles)
function edit_sp_ampl_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



%function edit_sp_phase_Callback(hObject, eventdata, handles)
function edit_sp_phase_Callback(hObject, ~, ~)
% Get the value of the sp_phase from the "edit_sp_phase"
sp_phase = get(hObject,'String');
set_param([bdroot '/ctl_sp_lut/sp_phase'],'Value',sp_phase)

% --- Executes during object creation, after setting all properties.
%function edit_sp_phase_CreateFcn(hObject, eventdata, handles)
function edit_sp_phase_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



%function edit_sp_QL_Callback(hObject, eventdata, handles)
function edit_sp_QL_Callback(hObject, ~, ~)
% Get the value of the sp_sp_QL from the "edit_sp_QL"
sp_QL = get(hObject,'String');
set_param([bdroot '/ctl_sp_lut/sp_QL'],'Value',sp_QL)

% --- Executes during object creation, after setting all properties.
%function edit_sp_QL_CreateFcn(hObject, eventdata, handles)
function edit_sp_QL_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



%function edit_sp_f0_Callback(hObject, eventdata, handles)
function edit_sp_f0_Callback(hObject, ~, ~)
% Get the value of the sp_sp_f0 from the "edit_sp_f0"
sp_f0 = get(hObject,'String');
set_param([bdroot '/ctl_sp_lut/sp_f0'],'Value',sp_f0)

% --- Executes during object creation, after setting all properties.
%function edit_sp_f0_CreateFcn(hObject, eventdata, handles)
function edit_sp_f0_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_cav_QL_Callback(hObject, eventdata, handles)

  value = get(handles.edit_cav_f0,'String');  f0  = str2double(value);
  value = get(handles.edit_cav_QL,'String');  QL  = str2double(value);
  value = get(handles.edit_cav_num,'String'); cNum = str2double(value); 
  
    lib = llrf_lib; 
    lib.cav_TF(f0,QL,cNum);  
    
    halfBW = 0.001*f0/QL/2;  str = num2str(halfBW,'%6.4f');
                             set(handles.text_BW, 'String', str);  
    
% Update simulation if the model is running
status = get_param(bdroot,'simulationstatus');
if strcmp(status,'running')
    set_param(bdroot, 'SimulationCommand', 'Update')
end;

bode_plot_func(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
%function edit_cav_QL_CreateFcn(hObject, eventdata, handles)
function edit_cav_QL_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_electrical_delay_Callback(hObject, eventdata, handles)

value = get(handles.edit_electrical_delay,'String'); 
set_param([bdroot '/Electrical_Delay/Electrical_delay_us'],'Value',value)

bode_plot_func(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
%function edit_electrical_delay_CreateFcn(hObject, eventdata, handles)
function edit_electrical_delay_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



%function edit_beam_delay_Callback(hObject, eventdata, handles)
function edit_beam_delay_Callback(hObject, ~, ~)
beam_delay = get(hObject,'String');
set_param([bdroot '/Hminus/beam_delay'],'Value',beam_delay)

% --- Executes during object creation, after setting all properties.
%function edit_beam_delay_CreateFcn(hObject, eventdata, handles)
function edit_beam_delay_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



%function edit_beam_length_Callback(hObject, eventdata, handles)
function edit_beam_length_Callback(hObject, ~, ~)
beam_length = get(hObject,'String');
set_param([bdroot '/Hminus/beam_length'],'Value',beam_length)

% --- Executes during object creation, after setting all properties.
%function edit_beam_length_CreateFcn(hObject, eventdata, handles)
function edit_beam_length_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%function edit_beam_current_Callback(hObject, eventdata, handles)
function edit_beam_current_Callback(hObject, ~, ~)
beam_current = get(hObject,'String');
set_param([bdroot '/Hminus/beam_current'],'Value',beam_current)


% --- Executes during object creation, after setting all properties.
%function edit_beam_current_CreateFcn(hObject, eventdata, handles)
function edit_beam_current_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



%function edit_beam_phase_Callback(hObject, eventdata, handles)
function edit_beam_phase_Callback(hObject, ~, ~)
beam_phase = get(hObject,'String');
set_param([bdroot '/Hminus/beam_phase'],'Value',beam_phase)

% --- Executes during object creation, after setting all properties.
%function edit_beam_phase_CreateFcn(hObject, eventdata, handles)
function edit_beam_phase_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%function edit_beam_comp_delay_Callback(hObject, eventdata, handles)
function edit_beam_comp_delay_Callback(hObject, ~, ~)
    beam_comp_delay = get(hObject,'String');
    set_param([bdroot '/ctl_ff_lut/beam_comp_delay'],'Value',beam_comp_delay)


% --- Executes during object creation, after setting all properties.
%function edit_beam_comp_delay_CreateFcn(hObject, eventdata, handles)
function edit_beam_comp_delay_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%function edit_beam_comp_length_Callback(hObject, eventdata, handles)
function edit_beam_comp_length_Callback(hObject, ~, ~)
    beam_comp_length = get(hObject,'String');
    set_param([bdroot '/ctl_ff_lut/beam_comp_length'],'Value',beam_comp_length)

% --- Executes during object creation, after setting all properties.
%function edit_beam_comp_length_CreateFcn(hObject, eventdata, handles)
function edit_beam_comp_length_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%function edit_beam_comp_current_Callback(hObject, eventdata, handles)
function edit_beam_comp_current_Callback(hObject, ~, ~)
    beam_comp_current = get(hObject,'String');
    set_param([bdroot '/ctl_ff_lut/beam_comp_current'],'Value',beam_comp_current)

    
% --- Executes during object creation, after setting all properties.
%function edit_beam_comp_current_CreateFcn(hObject, eventdata, handles)
function edit_beam_comp_current_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%function edit_beam_comp_phase_Callback(hObject, eventdata, handles)
function edit_beam_comp_phase_Callback(hObject, ~, ~)
    beam_comp_phase = get(hObject,'String');
    set_param([bdroot '/ctl_ff_lut/beam_comp_phase'],'Value',beam_comp_phase)

% --- Executes during object creation, after setting all properties.
%function edit_beam_comp_phase_CreateFcn(hObject, eventdata, handles)
function edit_beam_comp_phase_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider_I_Gain_Callback(hObject, eventdata, handles)
% Get the value of the gain slider and determine what the gain value should be
slider_position = get(hObject,'Value');
value = num2str(10000000*(slider_position*2 - 1));

% Update the model's gain value
set_param([bdroot '/PI_Controller_MFC/PID_I'],'I',value);
set_param([bdroot '/PI_Controller_MFC/PID_Q'],'I',value);

% Set the value of the gain edit box
set(handles.edit_I_Gain,'String',value);

% Update simulation if the model is running
status = get_param(bdroot,'simulationstatus');
if strcmp(status,'running')
    set_param(bdroot, 'SimulationCommand', 'Update');
end;

bode_plot_func(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
%function slider_I_Gain_CreateFcn(hObject, eventdata, handles)
function slider_I_Gain_CreateFcn(hObject, ~, ~)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit_I_Gain_Callback(hObject, eventdata, handles)

value = get(hObject,'String');

% Update the model's gain value
set_param([bdroot '/PI_Controller_MFC/PID_I'],'I',value);
set_param([bdroot '/PI_Controller_MFC/PID_Q'],'I',value);

% Set the value of the gain slider, with max/min of +10000000/-10000000
slider_position = max(0,min(1,(str2double(value) + 10000000)/20000000));
set(handles.slider_I_Gain,'Value',slider_position);

% Update simulation if the model is running
status = get_param(bdroot,'simulationstatus');
if strcmp(status,'running')
    set_param(bdroot, 'SimulationCommand', 'Update');   
end

bode_plot_func(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
%function edit_I_Gain_CreateFcn(hObject, eventdata, handles)
function edit_I_Gain_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



%function edit_tittle_Callback(hObject, eventdata, handles)
function edit_tittle_Callback(~, ~, ~)
    
% --- Executes during object creation, after setting all properties.
%function edit_tittle_CreateFcn(hObject, eventdata, handles)
function edit_tittle_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



%function edit_axis_xmin_Callback(hObject, eventdata, handles)
function edit_axis_xmin_Callback(~, ~, handles)
        str  = get(handles.edit_axis_xmin,'String'); xmin = str2double(str);
        str  = get(handles.edit_axis_xmax,'String'); xmax = str2double(str);
        str  = get(handles.edit_axis_ymin,'String'); ymin = str2double(str);
        str  = get(handles.edit_axis_ymax,'String'); ymax = str2double(str);
%        axes(handles.axes_plot);  
        if (xmin > xmax); xmin = xmax-0.0000001; end;  
        if (ymin > ymax); ymin = ymax-0.0000001; end;
        axis( [xmin xmax ymin ymax] );

% --- Executes during object creation, after setting all properties.
%function edit_axis_xmin_CreateFcn(hObject, eventdata, handles)
function edit_axis_xmin_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%function edit_axis_ymin_Callback(hObject, eventdata, handles)
function edit_axis_ymin_Callback(~, ~, handles)
    
        str  = get(handles.edit_axis_xmin,'String'); xmin = str2double(str);
        str  = get(handles.edit_axis_xmax,'String'); xmax = str2double(str);
        str  = get(handles.edit_axis_ymin,'String'); ymin = str2double(str);
        str  = get(handles.edit_axis_ymax,'String'); ymax = str2double(str);
%        axes(handles.axes_plot);  
        if (xmin > xmax); xmin = xmax-0.0000001; end;
        if (ymin > ymax); ymin = ymax-0.0000001; end;
        axis( [xmin xmax ymin ymax] );

% --- Executes during object creation, after setting all properties.
%function edit_axis_ymin_CreateFcn(hObject, eventdata, handles)
function edit_axis_ymin_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



%function edit_axis_xmax_Callback(hObject, eventdata, handles)
function edit_axis_xmax_Callback(~, ~, handles)    

        str  = get(handles.edit_axis_xmin,'String'); xmin = str2double(str);
        str  = get(handles.edit_axis_xmax,'String'); xmax = str2double(str);
        str  = get(handles.edit_axis_ymin,'String'); ymin = str2double(str);
        str  = get(handles.edit_axis_ymax,'String'); ymax = str2double(str);
%        axes(handles.axes_plot);  
        if (xmin > xmax); xmin = xmax-0.0000001; end;  
        if (ymin > ymax); ymin = ymax-0.0000001; end;
        axis( [xmin xmax ymin ymax] );
        
% --- Executes during object creation, after setting all properties.
%function edit_axis_xmax_CreateFcn(hObject, eventdata, handles)
function edit_axis_xmax_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



%function edit_axis_ymax_Callback(hObject, eventdata, handles)
function edit_axis_ymax_Callback(~, ~, handles)
        str  = get(handles.edit_axis_xmin,'String'); xmin = str2double(str);
        str  = get(handles.edit_axis_xmax,'String'); xmax = str2double(str);
        str  = get(handles.edit_axis_ymin,'String'); ymin = str2double(str);
        str  = get(handles.edit_axis_ymax,'String'); ymax = str2double(str);
%        axes(handles.axes_plot);  
        if (xmin > xmax); xmin = xmax-0.0000001; end;  
        if (ymin > ymax); ymin = ymax-0.0000001; end;
        axis( [xmin xmax ymin ymax] );
        
        
% --- Executes during object creation, after setting all properties.
%function edit_axis_ymax_CreateFcn(hObject, eventdata, handles)
function edit_axis_ymax_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox_grid.
%function checkbox_grid_Callback(hObject, eventdata, handles)
function checkbox_grid_Callback(hObject, ~, handles)    
    value = get(hObject,'Value');
    if value == 0;   grid off;
    else             grid on;
    end
    
% Assign handles and the switch object to the base workspace
assignin('base','llrf_handles',handles)
assignin('base','switch_hObject',handles.checkbox_grid)


% --- Executes during object creation, after setting all properties.
%function axes_plot_CreateFcn(hObject, eventdata, handles)
function axes_plot_CreateFcn(~, ~, ~)    
% hObject    handle to axes_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes_plot



%function edit_cav_num_Callback(hObject, eventdata, handles)
function edit_cav_num_Callback(~, ~, ~)    
% hObject    handle to edit_cav_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_cav_num as text
%        str2double(get(hObject,'String')) returns contents of edit_cav_num as a double


% --- Executes during object creation, after setting all properties.
%function edit_cav_num_CreateFcn(hObject, eventdata, handles)
function edit_cav_num_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on selection change in popupmenu_bode_sel.
function popupmenu_bode_sel_Callback(hObject, eventdata, handles)

    bode_plot_func(hObject, eventdata, handles)    



% --- Executes during object creation, after setting all properties.
%function popupmenu_bode_sel_CreateFcn(hObject, eventdata, handles)
function popupmenu_bode_sel_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on multiple events.
%function bode_plot_func(hObject, eventdata, handles)
function bode_plot_func(~, ~, handles)
    
    Kp     = str2double( get_param([bdroot '/PI_Controller_MFC/PID_I'],'P') );
    Ki     = str2double( get_param([bdroot '/PI_Controller_MFC/PID_I'],'I') );
    sys_PI = tf([Kp Ki],[1 0]);  % PI-controller TF
    
    CavNum = get_param([bdroot '/cav1/TFi'],'Numerator');
    CavDen = get_param([bdroot '/cav1/TFi'],'Denominator');
    Num = eval(CavNum);  % Transforms string of '[1 1 0]'   into vector [1 1 0]
    Den = eval(CavDen);  % Transforms string of '[1 0 1 0]' into vector [1 0 1 0]
    sys_CAV = tf(Num,Den);  % CAVITY TF
    
    delay_s = str2double( get_param([bdroot '/Electrical_Delay/Electrical_delay_us'],'Value'))*0.000001;    
    s = zpk('s');    
    sys_DELAY = exp(-delay_s*s);
    
    sys_GAIN = 1;
    

%    value = get(hObject,'Value');
    plot_mode = get(handles.popupmenu_bode_sel,'Value');
    switch plot_mode  
        case 1                                          % Loop Gain
            sys_TF = sys_PI*sys_CAV*sys_DELAY*sys_GAIN; 
        case 2                                          % Closed Loop Gain
            G = ss(sys_PI*sys_CAV*sys_DELAY*sys_GAIN);
            sys_TF = feedback(G,1);                     
        case 3                                          % Step Responce
            G = ss(sys_PI*sys_CAV*sys_DELAY*sys_GAIN);
            sys_TF = feedback(G,1);     
        case 4                                          % Impulse Responce
            G = ss(sys_PI*sys_CAV*sys_DELAY*sys_GAIN);
            sys_TF = feedback(G,1);     
        otherwise            
    end    

    opt = bodeoptions;  opt.FreqUnits = 'Hz';      

    if (plot_mode == 1 )||(plot_mode == 2 )
        w_min = 1;  % keeping it =1rad/s helps identifying Integral Gain
        w_max = 2*pi*1000000;  % rad/sec ( corrsponds to 1000kHz ) 
        if (get(handles.checkbox_grid,'Value') == 0);   opt.Grid = 'Off';
        else                                            opt.Grid = 'On';
        end;
       bode(sys_TF,opt,{w_min,w_max});          
    end;
    
    if (plot_mode == 3 )
%       step(sys_TF);
       impulseplot(sys_TF,0.0001);
        if (get(handles.checkbox_grid,'Value') == 0);   grid off;
        else                                            grid on;
        end;       
    end;
   
    if (plot_mode == 4 )
       impulseplot(sys_TF,0.0001);
        if (get(handles.checkbox_grid,'Value') == 0);   grid off;
        else                                            grid on;
        end;       
    end;
   
        
%function fvm_coil_bode_plot_func(hObject, eventdata, handles)
function fvm_coil_bode_plot_func(~, ~, handles)
    
    
    Ps125NumChar = get_param([bdroot '/FVM_Control/fvm/PS_TF1/PS_125kHz_LPF1/TF_fnc'],'Numerator');
    Ps125DenChar = get_param([bdroot '/FVM_Control/fvm/PS_TF1/PS_125kHz_LPF1/TF_fnc'],'Denominator');    
    Ps125Num = eval(Ps125NumChar);  % Transforms string of '[1 1 0]'   into vector [1 1 0]
    Ps125Den = eval(Ps125DenChar);  % Transforms string of '[1 0 1 0]' into vector [1 0 1 0]

    Ps40NumChar = get_param([bdroot '/FVM_Control/fvm/PS_TF1/40KHz Filter1/TF_fnc'],'Numerator');
    Ps40DenChar = get_param([bdroot '/FVM_Control/fvm/PS_TF1/40KHz Filter1/TF_fnc'],'Denominator');    
    Ps40Num = eval(Ps40NumChar);  % Transforms string of '[1 1 0]'   into vector [1 1 0]
    Ps40Den = eval(Ps40DenChar);  % Transforms string of '[1 0 1 0]' into vector [1 0 1 0]    
    
    PsCoilNumChar = get_param([bdroot '/FVM_Control/fvm/PS_TF1/Tuning Coil/TF_fnc'],'Numerator');
    PsCoilDenChar = get_param([bdroot '/FVM_Control/fvm/PS_TF1/Tuning Coil/TF_fnc'],'Denominator');    
    PsCoilNum = eval(PsCoilNumChar);  % Transforms string of '[1 1 0]'   into vector [1 1 0]
    PsCoilDen = eval(PsCoilDenChar);  % Transforms string of '[1 0 1 0]' into vector [1 0 1 0]    
    
    Num = conv(Ps125Num,Ps40Num); Num = conv(Num,PsCoilNum);
    Den = conv(Ps125Den,Ps40Den); Den = conv(Den,PsCoilDen);
    
    sys_PS = tf(Num,Den);  % PS TF
     
    %delay_s = str2double( get_param([bdroot '/Electrical_Delay/Electrical_delay_us'],'Value'))*0.000001;    
    %s = zpk('s');    
    %sys_DELAY = exp(-delay_s*s);
    
    sys_FBGAIN = 150.0;
    sys_GAIN = 1.0/48.387;   

%    value = get(hObject,'Value');
        % Loop Gain
            %sys_TF = sys_PS*sys_GAIN;
        % Closed Loop Gain
            G = ss(sys_PS*sys_FBGAIN);
            sys_TF = feedback(G,0.02)*sys_GAIN; 

    opt = bodeoptions;  opt.FreqUnits = 'Hz';      

        w_min = 1;  % keeping it =1rad/s helps identifying Integral Gain
        w_max = 2*pi*1000000;  % rad/sec ( corrsponds to 1000kHz ) 
        if (get(handles.checkbox_grid,'Value') == 0);   opt.Grid = 'Off';
        else                                            opt.Grid = 'On';
        end;
       bode(sys_TF,opt,{w_min,w_max});          
    
   
        



function edit_cav_phideg_Callback(hObject, eventdata, handles)

sp_phase = get(hObject,'String');
set_param([bdroot '/cav/Cav_Phi_deg'],'Value',sp_phase)

bode_plot_func(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
%function edit_cav_phideg_CreateFcn(hObject, eventdata, handles)
function edit_cav_phideg_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



%function edit_detune_Callback(hObject, eventdata, handles)
function edit_detune_Callback(hObject, ~, ~)
value = get(hObject,'String');

% Update the model's gain value
set_param([bdroot '/cav/A2Hz'],'Gain',value);


% --- Executes during object creation, after setting all properties.
%function edit_detune_CreateFcn(hObject, eventdata, handles)
function edit_detune_CreateFcn(hObject, ~, ~)    
% hObject    handle to edit_detune (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



%function edit_cav_eacc_Callback(hObject, eventdata, handles)
function edit_cav_eacc_Callback(hObject, ~, ~)    
value = get(hObject,'String');

% Update the model's gain value
set_param([bdroot '/Klystron/EACC'] ,'Gain',value);  % I term
set_param([bdroot '/Klystron/EACC1'],'Gain',value);  % Q term


% --- Executes during object creation, after setting all properties.
%function edit_cav_eacc_CreateFcn(hObject, eventdata, handles)
function edit_cav_eacc_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%function edit_Idelay_Callback(hObject, eventdata, handles)
function edit_Idelay_Callback(hObject, ~, ~)
% Hints: get(hObject,'String') returns contents of edit_Idelay as text
%        str2double(get(hObject,'String')) returns contents of edit_Idelay as a double
I_delay = get(hObject,'String');
set_param([bdroot '/timer/Igate_delay'],'Value',I_delay)

% --- Executes during object creation, after setting all properties.
%function edit_Idelay_CreateFcn(hObject, eventdata, handles)
function edit_Idelay_CreateFcn(hObject, ~, ~)    
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%function edit_Iwidth_Callback(hObject, eventdata, handles)
function edit_Iwidth_Callback(hObject, ~, ~)
% Hints: get(hObject,'String') returns contents of edit_Iwidth as text
%        str2double(get(hObject,'String')) returns contents of edit_Iwidth as a double
I_width = get(hObject,'String');
set_param([bdroot '/timer/Igate_width'],'Value',I_width)

% --- Executes during object creation, after setting all properties.
%function edit_Iwidth_CreateFcn(hObject, eventdata, handles)
function edit_Iwidth_CreateFcn(hObject, ~, ~)    
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



%function edit_Pdelay_Callback(hObject, eventdata, handles)
function edit_Pdelay_Callback(hObject, ~, ~)    
% Hints: get(hObject,'String') returns contents of edit_Pdelay as text
%        str2double(get(hObject,'String')) returns contents of edit_Pdelay as a double
P_delay = get(hObject,'String');
set_param([bdroot '/timer/Pgate_delay'],'Value',P_delay)

% --- Executes during object creation, after setting all properties.
%function edit_Pdelay_CreateFcn(hObject, eventdata, handles)
function edit_Pdelay_CreateFcn(hObject, ~, ~)    
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%function edit_Pwidth_Callback(hObject, eventdata, handles)
function edit_Pwidth_Callback(hObject, ~, ~)    
% Hints: get(hObject,'String') returns contents of edit_Pwidth as text
%        str2double(get(hObject,'String')) returns contents of edit_Pwidth as a double
P_width = get(hObject,'String');
set_param([bdroot '/timer/Pgate_width'],'Value',P_width)

% --- Executes during object creation, after setting all properties.
%function edit_Pwidth_CreateFcn(hObject, eventdata, handles)
function edit_Pwidth_CreateFcn(hObject, ~, ~)    
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_FVMdelay_Callback(hObject, ~, ~)
% Hints: get(hObject,'String') returns contents of edit_FVMwidth as text
%        str2double(get(hObject,'String')) returns contents of edit_FVMwidth as a double
FVM_delay = get(hObject,'String');
set_param([bdroot '/timer/FVMgate_delay'],'Value',FVM_delay)

% --- Executes during object creation, after setting all properties.
function edit_FVMdelay_CreateFcn(hObject, ~, ~)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit_FVMwidth_Callback(hObject, ~, ~)
% Hints: get(hObject,'String') returns contents of edit_FVMwidth as text
%        str2double(get(hObject,'String')) returns contents of edit_FVMwidth as a double
FVM_width = get(hObject,'String');
set_param([bdroot '/timer/FVMgate_width'],'Value',FVM_width)

% --- Executes during object creation, after setting all properties.
function edit_FVMwidth_CreateFcn(hObject, ~, ~)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in vsSW1.
%function vsSW1_Callback(hObject, eventdata, handles)
function vsSW1_Callback(hObject, ~, handles)    
% Hint: get(hObject,'Value') returns toggle state of vsSW1
value = get(hObject,'Value');
if value == 0;   set_param([bdroot '/VS SWITCH/ctl_vs_sw0'],'sw','0')
else             set_param([bdroot '/VS SWITCH/ctl_vs_sw0'],'sw','1')
end
% Assign handles and the switch object to the base workspace
assignin('base','llrf_handles',handles)
assignin('base','switch_hObject',handles.vsSW1)

% --- Executes on button press in vsSW2.
%function vsSW2_Callback(hObject, eventdata, handles)
function vsSW2_Callback(hObject, ~, handles)
% Hint: get(hObject,'Value') returns toggle state of vsSW2
value = get(hObject,'Value');
if value == 0;   set_param([bdroot '/VS SWITCH/ctl_vs_sw1'],'sw','0')
else             set_param([bdroot '/VS SWITCH/ctl_vs_sw1'],'sw','1')
end
% Assign handles and the switch object to the base workspace
assignin('base','llrf_handles',handles)
assignin('base','switch_hObject',handles.vsSW2)

% --- Executes on button press in vsSW3.
%function vsSW3_Callback(hObject, eventdata, handles)
function vsSW3_Callback(hObject, ~, handles)
% Hint: get(hObject,'Value') returns toggle state of vsSW3
value = get(hObject,'Value');
if value == 0;   set_param([bdroot '/VS SWITCH/ctl_vs_sw2'],'sw','0')
else             set_param([bdroot '/VS SWITCH/ctl_vs_sw2'],'sw','1')
end
% Assign handles and the switch object to the base workspace
assignin('base','llrf_handles',handles)
assignin('base','switch_hObject',handles.vsSW3)

% --- Executes on button press in vsSW4.
%function vsSW4_Callback(hObject, eventdata, handles)
function vsSW4_Callback(hObject, ~, handles)
% Hint: get(hObject,'Value') returns toggle state of vsSW4
value = get(hObject,'Value');
if value == 0;   set_param([bdroot '/VS SWITCH/ctl_vs_sw3'],'sw','0')
else             set_param([bdroot '/VS SWITCH/ctl_vs_sw3'],'sw','1')
end
% Assign handles and the switch object to the base workspace
assignin('base','llrf_handles',handles)
assignin('base','switch_hObject',handles.vsSW4)

% --- Executes on button press in vsSW5.
%function vsSW5_Callback(hObject, eventdata, handles)
function vsSW5_Callback(hObject, ~, handles)
% Hint: get(hObject,'Value') returns toggle state of vsSW5
value = get(hObject,'Value');
if value == 0;   set_param([bdroot '/VS SWITCH/ctl_vs_sw4'],'sw','0')
else             set_param([bdroot '/VS SWITCH/ctl_vs_sw4'],'sw','1')
end
% Assign handles and the switch object to the base workspace
assignin('base','llrf_handles',handles)
assignin('base','switch_hObject',handles.vsSW5)

% --- Executes on button press in vsSW6.
%function vsSW6_Callback(hObject, eventdata, handles)
function vsSW6_Callback(hObject, ~, handles)
% Hint: get(hObject,'Value') returns toggle state of vsSW6
value = get(hObject,'Value');
if value == 0;   set_param([bdroot '/VS SWITCH/ctl_vs_sw5'],'sw','0')
else             set_param([bdroot '/VS SWITCH/ctl_vs_sw5'],'sw','1')
end
% Assign handles and the switch object to the base workspace
assignin('base','llrf_handles',handles)
assignin('base','switch_hObject',handles.vsSW6)

% --- Executes on button press in vsSW7.
%function vsSW7_Callback(hObject, eventdata, handles)
function vsSW7_Callback(hObject, ~, handles)
% Hint: get(hObject,'Value') returns toggle state of vsSW7
value = get(hObject,'Value');
if value == 0;   set_param([bdroot '/VS SWITCH/ctl_vs_sw6'],'sw','0')
else             set_param([bdroot '/VS SWITCH/ctl_vs_sw6'],'sw','1')
end
% Assign handles and the switch object to the base workspace
assignin('base','llrf_handles',handles)
assignin('base','switch_hObject',handles.vsSW7)

% --- Executes on button press in vsSW8.
%function vsSW8_Callback(hObject, eventdata, handles)
function vsSW8_Callback(hObject, ~, handles)
% Hint: get(hObject,'Value') returns toggle state of vsSW8
value = get(hObject,'Value');
if value == 0;   set_param([bdroot '/VS SWITCH/ctl_vs_sw7'],'sw','0')
else             set_param([bdroot '/VS SWITCH/ctl_vs_sw7'],'sw','1')
end
% Assign handles and the switch object to the base workspace
assignin('base','llrf_handles',handles)
assignin('base','switch_hObject',handles.vsSW8)


%function vsGain_Callback(hObject, eventdata, handles)
function vsGain_Callback(hObject, ~, ~)
% Hints: get(hObject,'String') returns contents of vsGain as text
%        str2double(get(hObject,'String')) returns contents of vsGain as a double
value = get(hObject,'String');

% Update the model's gain value
set_param([bdroot '/VS_Scalar/vsScalar'],'Gain',value);


% --- Executes during object creation, after setting all properties.
function vsGain_CreateFcn(hObject, ~, ~)
% hObject    handle to vsGain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_RF_delay_Callback(hObject, ~, ~)

RF_delay = get(hObject,'String');
set_param([bdroot '/timer/RFgate_delay'],'Value',RF_delay);


% --- Executes during object creation, after setting all properties.
function edit_RF_delay_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_RF_width_Callback(hObject, ~, ~)

RF_width = get(hObject,'String');
set_param([bdroot '/timer/RFgate_width'],'Value',RF_width);


% --- Executes during object creation, after setting all properties.
function edit_RF_width_CreateFcn(hObject, ~, ~)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_fvm_num_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fvm_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fvm_num as text
%        str2double(get(hObject,'String')) returns contents of edit_fvm_num as a double


% --- Executes during object creation, after setting all properties.
function edit_fvm_num_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fvm_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_TRF_delay_Callback(hObject, eventdata, handles)

    value = get(handles.edit_fvm_num,'String'); cNum = str2double(value);      
    value = get(hObject,'String');
    
    switch cNum
      case 1 
          set_param([bdroot '/FVM_Control/LEARNING_CONTROLLER/DelayB_in_us'],'Value',value);
      %case 2 set_param([bdroot '/fvm/LFF1/DelayB_in_us'],'Value',value);
        otherwise
            ;
    end;
            

% Hints: get(hObject,'String') returns contents of edit_TRF_delay as text
%        str2double(get(hObject,'String')) returns contents of edit_TRF_delay as a double


% --- Executes during object creation, after setting all properties.
function edit_TRF_delay_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_TRF_delay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox_LFF_Enb.
function checkbox_LFF_Enb_Callback(hObject, eventdata, handles)
value = get(hObject,'Value');
if value == 0;   set_param([bdroot '/timer/LFF_Enb'],'Value','0')
else             set_param([bdroot '/timer/LFF_Enb'],'Value','1')
end
% Assign handles and the switch object to the base workspace
%assignin('base','llrf_handles',handles)
%assignin('base','switch_hObject',handles.checkbox_tp1_sw)
