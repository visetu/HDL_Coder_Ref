
function foc = foc_lib


foc.pmsm_pars         = @pmsm_pars;
foc.createPMSMModel   = @createPMSMModel;
foc.main              = @main;


%%  1. Define Motor Parameters
%=========================================================================
% 
  function out = pmsm_pars(xel)
%   foc = foc_lib;  out = foc.pmsm_pars(2)
%=========================================================================
    out.Rs =  0.435;  % Stator resistance    (ohms)
    out.Ld = 0.0012;  % D-axis inductance    (H)
    out.Lq = 0.0012;  % Q-axis inductance    (H)
    out.J  = 0.0001;  % Inertia              (kg.m^2)
    out.B  = 0.0001;  % Friction coefficient (N.m.s)
    out.Ke =    0.1;  % Back EMF constant    (V.s/rad)
    out.Kt =    0.1;  % Torque constant      (N.m/A)
    out.P  =      4;  % Number of poles      (# pole pairs)


%% 2. Create the PMSM Model
%=========================================================================
%
  function pmsm_model = createPMSMModel(Rs, Ld, Lq, J, B, Ke, Kt, P)
%   foc = foc_lib;  out = foc.createPMSMModel()
%=========================================================================
     
     pmsm_model = 'PMSM_Model'; % Create a Simulink model
     new_system (pmsm_model)  ;
     open_system(pmsm_model)  ;
 
     % Add blocks and set parameters
     add_block('simulink/Commonly Used Blocks/Constant', [pmsm_model, '/Constant']);
     add_block('simulink/Commonly Used Blocks/Scope'   , [pmsm_model, '/Scope']);
     % Add more blocks and set parameters as needed
 
     % Set motor parameters in the workspace
     assignin('base', 'Rs', Rs);
     assignin('base', 'Ld', Ld);
     assignin('base', 'Lq', Lq);
     assignin('base', 'J',  J);
     assignin('base', 'B',  B);
     assignin('base', 'Ke', Ke);
     assignin('base', 'Kt', Kt);
     assignin('base', 'P',  P);
 

%% 
%% %% 3. Initialize the Model
%% 
%% % Initialize the model
%% createPMSMModel(Rs, Ld, Lq, J, B, Ke, Kt, P);
%% 
%% % Set simulation parameters
%% set_param('PMSM_Model', 'Solver', 'ode45', 'StopTime', '10');
%% 
%% % Run the simulation
%% sim('PMSM_Model');
%% 
%% %% 4. Analyze the Results
%% 
%% % Load simulation results
%% load('PMSM_Model');
%% 
%% % Plot results
%% figure;
%% plot(simout.time, simout.signals.values);
%% xlabel('Time (s)');
%% ylabel('Motor Response');
%% title('PMSM Simulation Results');
%% 

%%
%========================================================
% 
  function main( )
%   foc = foc_lib; foc.main()
%========================================================
    %% 1. Initialize PMSM Motor Parameters
    xel        = pmsm_pars(2);    % init pmsm motor pars            (obj)
    %% 2. Initialize PMSM Motor Model 
    pmsm_model = createPMSMModel(xel.Rs, xel.Ld, xel.Lq, xel.J, ... (mod)
                                 xel.B , xel.Ke, xel.Kt, xel.P);
    %% 3. Set simulation parameters
    set_param('PMSM_Model', 'Solver', 'ode45', 'StopTime', '10');
    %% 4. Run the simulation
    sim('PMSM_Model');
    %% 5. Analyze the Results
    %%   5.1 Load simulation results
    load('PMSM_Model');
    %%   5.2 Plot results
    figure;
    plot(simout.time, simout.signals.values);
    xlabel('Time (s)');
    ylabel('Motor Response');
    title('PMSM Simulation Results');