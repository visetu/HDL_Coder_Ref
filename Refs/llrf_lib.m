%%--------- llrf_lib.m ---------
% 
% LIBRARY OF TRANSFER FUNCTION MODELS AND MISC
%
%
% Before use the functions from this library (package) make a call from command line:
%  > lib = llrf_lib;
% and then, call any function:
%  > lib.cavity_LPF(tau);
%  > lib.ferCoilDriver_LPF();
%  >   ETC ...

function lib = llrf_lib

lib.cav_TF            = @cav_TF;
lib.cavity_LPF        = @cavity_LPF;
lib.ferCoil_LPF       = @ferCoil_LPF;
lib.ferCoilDriver_LPF = @ferCoilDriver_LPF;
lib.Tuning_Coil       = @Tuning_Coil;
lib.Diagnostic_Plot   = @Diagnostic_Plot;



%%
%========================================================================
%  RF-CAVITY Model based on 1st order LPF Transfer Function 
%------------------------------------------------------------------------
%      F_rf      = 325e6;              % Hz
%      Q_load    = 6000;               %
%      F_half_bw = F_rf/Q_load/2;      % Hz
%      tau       = 1/(2*pi*F_half_bw); % sec
%      R  = 1;                         % Resistance in Ohms
%      C  = tau/R;                     % Capacitance in Farads
%
%     u  ----\/\/\---|--------  y = TF(s) * u
%              R     |
%                   --- C
%                   ---   Zc = 1/s*C;
%                    |          
%                    |    TF(s) = Zc/(Zc+R) = 1/(s*R*C + 1) = 1/(tau*s+1)
%                   ===
% Eiler Formula: exp(jwTau) = cos(w*Tau) + jsin(w*Tau)
%                Tau = dT ==> Phi_det = dT/T ==> dT = Phi_det * T;
%========================================================================      
%function y = cav_TF(f0,QL)
function y = cav_TF(f0,QL,N)

      F_half_bw = f0/QL/2;             % Hz
      tau       = 1/(2*pi*F_half_bw);  % sec
      %R  = 1;                         % Resistance in Ohms
      %C  = tau/R;                     % Capacitance in Farads

% Define FVM Simulator file name (Simulink's mdl file):
MdlFileNmae = sprintf('llrf');

% Cast the parameters
Cavity_numerator_val   = sprintf('1');
%Cavity_numerator_val   = sprintf('[(cos(pi/3) + 1i*sin(pi/3))]');
Cavity_denominator_val = sprintf('[%0.5g 1]', tau);

% Write into 1st Target (Cavity Simulator block name + TF function)

        switch (N)
          case 1 
              
            Target  = sprintf('%s/cav1/TFi', MdlFileNmae);
            set_param(Target, 'Numerator',   Cavity_numerator_val);
            set_param(Target, 'Denominator', Cavity_denominator_val);

            Target  = sprintf('%s/cav1/TFq', MdlFileNmae);
            set_param(Target, 'Numerator',   Cavity_numerator_val); 
            set_param(Target, 'Denominator', Cavity_denominator_val); 
                
          case 2,              
              
            Target  = sprintf('%s/cav2/TFi', MdlFileNmae);
            set_param(Target, 'Numerator',   Cavity_numerator_val);
            set_param(Target, 'Denominator', Cavity_denominator_val);

            Target  = sprintf('%s/cav2/TFq', MdlFileNmae);
            set_param(Target, 'Numerator',   Cavity_numerator_val); 
            set_param(Target, 'Denominator', Cavity_denominator_val); 
 
          case 3,              
              
            Target  = sprintf('%s/cav3/TFi', MdlFileNmae);
            set_param(Target, 'Numerator',   Cavity_numerator_val);
            set_param(Target, 'Denominator', Cavity_denominator_val);

            Target  = sprintf('%s/cav3/TFq', MdlFileNmae);
            set_param(Target, 'Numerator',   Cavity_numerator_val); 
            set_param(Target, 'Denominator', Cavity_denominator_val); 
            
          case 4,
                            
            Target  = sprintf('%s/cav4/TFi', MdlFileNmae);
            set_param(Target, 'Numerator',   Cavity_numerator_val);
            set_param(Target, 'Denominator', Cavity_denominator_val);

            Target  = sprintf('%s/cav4/TFq', MdlFileNmae);
            set_param(Target, 'Numerator',   Cavity_numerator_val); 
            set_param(Target, 'Denominator', Cavity_denominator_val); 
 
          case 5,
                            
            Target  = sprintf('%s/cav5/TFi', MdlFileNmae);
            set_param(Target, 'Numerator',   Cavity_numerator_val);
            set_param(Target, 'Denominator', Cavity_denominator_val);

            Target  = sprintf('%s/cav5/TFq', MdlFileNmae);
            set_param(Target, 'Numerator',   Cavity_numerator_val); 
            set_param(Target, 'Denominator', Cavity_denominator_val); 

          case 6,
                            
            Target  = sprintf('%s/cav6/TFi', MdlFileNmae);
            set_param(Target, 'Numerator',   Cavity_numerator_val);
            set_param(Target, 'Denominator', Cavity_denominator_val);

            Target  = sprintf('%s/cav6/TFq', MdlFileNmae);
            set_param(Target, 'Numerator',   Cavity_numerator_val); 
            set_param(Target, 'Denominator', Cavity_denominator_val); 

          case 7,
                            
            Target  = sprintf('%s/cav7/TFi', MdlFileNmae);
            set_param(Target, 'Numerator',   Cavity_numerator_val);
            set_param(Target, 'Denominator', Cavity_denominator_val);

            Target  = sprintf('%s/cav7/TFq', MdlFileNmae);
            set_param(Target, 'Numerator',   Cavity_numerator_val); 
            set_param(Target, 'Denominator', Cavity_denominator_val); 
            
            
          otherwise 
            
        end;

y = 0; % void
                                       




%%
%========================================================================
%  FERRITE COIL DRIVER-AMPLIFIER LPF Model based on on 1st order TF 
%========================================================================
%
%  u  ----\/\/\---|--------  y = TF(s) * u
%           R     |
%                ---
%                --- C
%                 |
%                 |
%                ===
%  Zc = 1/s*C;
%  TF(s) = Zc/(Zc+R) = 1/(s*C)/( 1/(s*C)+ R ) = 1/(s*R*C + 1) 
%                                                 
function y = ferCoil_LPF()

% Define FVM Simulator file name (Simulink's mdl file):
MdlFileNmae = sprintf('llrf');

% Define circuit constants

F_cut = 125000;             % Hz
tau   = 1/(2*pi*F_cut);     % sec

%R  = 1;                     % Resistance in Ohms
%C  = tau/R;                 % Capacitance in Farads

% Cast the parameters
numer_val = sprintf('[1]');
denom_val = sprintf('[%0.5g 1]', tau);

% Update 1st Target 
Target  = sprintf('%s/Ferrite Phase Shifter 1/PS_125kHz_LPF1/TF_fnc', MdlFileNmae);
set_param(Target, 'Numerator',   numer_val); 
set_param(Target, 'Denominator', denom_val); 
% Update 2nd Target 
Target  = sprintf('%s/Ferrite Phase Shifter 2/PS_125kHz_LPF1/TF_fnc', MdlFileNmae);
set_param(Target, 'Numerator',   numer_val); 
set_param(Target, 'Denominator', denom_val); 

y = 0; % void

%%
%========================================================================
%  FERRITE COIL DRIVER LOOP-FILTER, LPF Model based on LC series circuit 
%========================================================================
%          _  _  _
%  u  ----/ \/ \/ \---|--------|--------  y = TF(s) * u
%             L       |        |
%                    ---      ---
%                    --- C1   --- C2
%                     |        |
%                     |        |
%                     |        \
%                     |        /  R
%                     |        \
%                     |        | 
%                    ===      ===
%
%  Zl = s*L;  Zc1 = 1/s*C1;   Zc2 = 1/s*C2;
%  Zpar = ( 1/Zc1 + 1/(Zc2+R) ) ^-1 = (Zc1*Zc2 + Zc1*R) / (Zc1+Zc2+R)
%  Zpar = ( 1/sC1*1/sC2 + R/sC1 ) / ( 1/sC1 + 1/sC2 + R)
%  Zpar = ( 1 + s*C2*R )/(s^2*C1*C2) / (s(C1+C2) + R)/(s^2*C1*C2)
%  Zpar = (1+s*C2*R )/(s(C1+C2)+R)
%
%  TF(s) = Zpar/(Zpar + Zl)
%  
%                          s  +  a
%  TF(s) = K * ---------------------------------
%               s^3 + alfa*s^2 + beta*s + gamma
%
%  where: K=1/(LC1); a = 1/(RC2); alfa=(C1+C2)/(RC1C2); beta=K;
%  gamma=1/(RLC1C2);
%
function y = ferCoilDriver_LPF()

% Define FVM Simulator file name (Simulink's mdl file):
MdlFileNmae = sprintf('llrf');

% Define circuit constants

R  = 2.25;      % Resistance in Ohms
C1 = 1e-6;      % Capacitance in Farads
C2 = 3.5e-6;    % Capacitance in Farads
L  = 4.5e-6;    % inductance in Henry

K = 1/(L*C1);
a = 1/(R*C2);
alfa = (C1+C2)/(R*C1*C2);
beta = K;
gamma = 1/(R*L*C1*C2);

% Cast the parameters
denom_val = sprintf('[1 %0.5g %0.5g %0.5g]', alfa, beta, gamma);
numer_val = sprintf('[%0.5g %0.5g]',K,(K*a));

% Update 1st Target 
Target  = sprintf('%s/Ferrite Phase Shifter 1/40KHz Filter1/TF_fnc', MdlFileNmae);
set_param(Target, 'Numerator',   numer_val); 
set_param(Target, 'Denominator', denom_val); 
% Update 2nd Target 
Target  = sprintf('%s/Ferrite Phase Shifter 2/40KHz Filter1/TF_fnc', MdlFileNmae);
set_param(Target, 'Numerator',   numer_val); 
set_param(Target, 'Denominator', denom_val); 

y = 0; % void


%%
%========================================================================
%  TUNING COIL Model based on LR series circuit 
%========================================================================
%                                    __
%          _  _  _                  /  \
%  u  ----/ \/ \/ \-----/\/\/------|  A |-------o GND
%             L           R         \__/    K_a2v
%                                     |___|\_____ y=TF(s)*u 
%                                         |/
%  
%          K_a2v      1           
%  TF(s) = ---- * ----------- 
%           L      s + R/L
%
%  where: K_a2v = 0.02 V/A; R = 0.1 Ohm; L = 45 uH;
%%
function y = Tuning_Coil()

% Define FVM Simulator file name (Simulink's mdl file):
MdlFileNmae = sprintf('llrf');
% Define circuit constants
%

R      = 0.1;       % Resistance in Ohms
L     = 45e-6;      % inductance in Henry
%K_a2v = 0.02;       % V/A;
K_a2v = 1.0;       % V/A;


% Cast the parameters
numer_val = sprintf('[%0.5g]',(K_a2v/L));
denom_val = sprintf('[1 %0.5g]', (R/L));

% ANALITICAL MODEL
% Update 1st Target 
Target  = sprintf('%s/FVM/Ferrite Phase Shifter 1/Tuning Coil/TF_fnc', MdlFileNmae);
set_param(Target, 'Numerator',   numer_val); 
set_param(Target, 'Denominator', denom_val); 
% Update 2nd Target 
Target  = sprintf('%s/FVM/Ferrite Phase Shifter 2/Tuning Coil/TF_fnc', MdlFileNmae);
set_param(Target, 'Numerator',   numer_val); 
set_param(Target, 'Denominator', denom_val); 

% LUT-Based MODEL
% Update 1st Target 
Target  = sprintf('%s/fvm/PS_TF1/Tuning Coil/TF_fnc', MdlFileNmae);
set_param(Target, 'Numerator',   numer_val); 
set_param(Target, 'Denominator', denom_val); 
% Update 2nd Target 
Target  = sprintf('%s/fvm/PS_TF2/Tuning Coil/TF_fnc', MdlFileNmae);
set_param(Target, 'Numerator',   numer_val); 
set_param(Target, 'Denominator', denom_val); 

y = 0; % void


%%
%========================================================================
%  DIAGNOSTIC OUTPUT 
%========================================================================
function y = Diagnostic_Plot()

num = [ 1, 2 ];
den = [1, 2, 3, 4];

%bode(num,den);
[H1,W]=freqs(num,den); P1=angle(H1); H1=abs(H1); dB1=20*log10(H1);
F=W/(2*pi);
plot(F, dB1, 'r-', F, P1, '-b');

y = 0; % void

