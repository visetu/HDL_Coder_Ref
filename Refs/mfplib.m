%%
%  Flat Panel Library
%    contains a collection of test functions.
%
%
%
%%
function fplib = mfplib
%%
%-------------------------------
% CONSTANTS
%-------------------------------
global GHz;      GHz=1e9;
global MHz;      MHz=1e6;
global usec;     usec=1e-6;
global nsec;     nsec=1e-9;
global ON;       ON=1;
global OFF;      OFF=0;
global YES;      YES=1;
global NO;       NO=0;
global OK;       OK=1;
global ERR;      ERR=0;

% UTILITY-FUNCTIONS
fplib.open_sport            = @open_sport;         % open serial port
fplib.cfg_gen               = @cfg_gen;            % executes cfg_gen
fplib.cfg_conv              = @cfg_conv;           % executes cfg_conv
fplib.xls2plot              = @xls2plot;           %

function ser = open_sport(PortName)  %PortName = 'COM13'; 
%% 
%#########################################################################
%
% OPEN_SPORT
%     >>fplib = mfplib; ser = fplib.open_sport('COM6')
%
%##########################################################################
  delete(instrfindall);  % remove if few ports are going to be used
  ser = serial(PortName,'BaudRate',921600, 'InputBufferSize',65536, 'OutputBufferSize',65536);
  fopen(ser);
  if strcmp(ser.Status, 'open')            
      str = sprintf('<MSG> %s port is open',ser.Port);   
  else                                     
      str = sprintf('<ERR> Failed open the %s port',ser.Port);   
  end;                                     
  disp(str);                                 

   
%#########################################################################
%
% CFG_GEN
%     >>fplib = mfplib; ser = fplib.cfg_conv()
%
%##########################################################################
function cout = cfg_gen(fn)
 %% Configuration File Generator
 %  Command call format:   >>fplib=mfplib; cout=fplib.cfg_gen('mcfg.txt')
   path='.\'; fname=fn; fname_with_path=[path fname];         
   fid = fopen(fname_with_path, 'w');
    
   ns  = 1e-9;
   Ts  = 25*ns;
   Inf = 1638375*ns

   idx = 1;  % used for 1-based index adjustment in array, i.e. reg(0+idx)
             % corresponds to ink_reg0 register in Flat Panel Design
   %\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
   % Analog DACs 
   %\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
   adac( 0+idx,:) = 2048;                % GOFFSET
   adac( 1+idx,:) = 3000;                % ABIAS_D
   adac( 2+idx,:) =  125;                % PREINB_D
   adac( 3+idx,:) = 2000;                % G_CHCOMP_LVL
   adac( 4+idx,:) = 1977;                % IBPRE
   adac( 5+idx,:) = 2000;                % AVGL
   adac( 6+idx,:) = 2000;                % AVGH
   adac( 7+idx,:) = 1972;                % COMP_LEVEL
   adac( 8+idx,:) = 2000;                % IBCLAMP
   adac( 9+idx,:) = 4095;                % DM_REF_P
   adac(10+idx,:) = 3500;                % IBMUX
   adac(11+idx,:) =  250;                % ???? 

   %\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
   % REGISTERS
   %\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
   Rst0=1;Clmp0=0;Smpl0=0;GlOffs0=0;DrOE0=1;DyGnBypass0=0;ChComp0=0;InvDat0=0;TstMod0=0;
      reg( 0+idx,:)=Rst0*2^15+Clmp0*2^14+Smpl0*2^13+GlOffs0*2^12+DrOE0*2^11 ...
                  +DyGnBypass0*2^10+ChComp0*2^9+InvDat0*2^8+TstMod0*2^7;
   Trst0 = 3500*ns;  
   Trst1 = Inf;
      reg( 1+idx,:) = round(Trst0/Ts);       % ASIC Reset 1st Edge Timing
      reg( 2+idx,:) = round(Trst1/Ts);       % ASIC Reset 2nd Edge Timing
   Tclmp0 =     0*ns;    
   Tclmp1 = 17000*ns;
      reg( 3+idx,:) = round(Tclmp0/Ts);      % ASIC Clamp 1st Edge Timing
      reg( 4+idx,:) = round(Tclmp1/Ts);      % ASIC Clamp 2nd Edge Timing   
   Tsmpl0 =     0*ns;  % 
   Tsmpl1 = 17000*ns;  % |------|__|------|
   Tsmpl2 =  3000*ns;  % 0      1  2      3
   Tsmpl3 = 17000*ns;  %
      reg( 5+idx,:) = round(Tsmpl0/Ts);      % ASIC Sample 1st Edge Timing
      reg( 6+idx,:) = round(Tsmpl1/Ts);      % ASIC Sample 2nd Edge Timing   
      reg( 7+idx,:) = round(Tsmpl2/Ts);      % ASIC Sample 3d  Edge Timing   
      reg( 8+idx,:) = round(Tsmpl3/Ts);      % ASIC Sample 4th Edge Timing   
   Tshiftin0 =  5025*ns;    
   Tshiftin1 = 10250*ns;
      reg( 9+idx,:) = round(Tshiftin0/Ts);   % ASIC Shiftin 1st Edge Timing
      reg(10+idx,:) = round(Tshiftin1/Ts);   % ASIC Shiftin 2nd Edge Timing 
   Tgoffs0   =  Inf;    
   Tgoffs1   =  Inf;
      reg(11+idx,:) = round(Tgoffs0/Ts);     % ASIC Gl.Offset 1st Edge Timing
      reg(12+idx,:) = round(Tgoffs1/Ts);     % ASIC Gl.Offset 2nd Edge Timing 
   Tdroe0   =  Inf;    
   Tdroe1   =  Inf;
      reg(13+idx,:) = round(Tdroe0/Ts);      % ASIC Dr.OE 1st Edge Timing
      reg(14+idx,:) = round(Tdroe1/Ts);      % ASIC Dr.OE 2nd Edge Timing 
   Tchcmp0   =  Inf;    
   Tchcmp1   =  Inf;
      reg(15+idx,:) = round(Tchcmp0/Ts);     % ASIC Ch.Cmp. 1st Edge Timing
      reg(16+idx,:) = round(Tchcmp1/Ts);     % ASIC Ch.Cmp. 2nd Edge Timing 
   Tv55gn0   =  Inf;    
   Tv55gn1   =  Inf;
      reg(17+idx,:) = round(Tv55gn0/Ts);     % ASIC V55 Gn0 bit 1st Edge Timing
      reg(18+idx,:) = round(Tv55gn1/Ts);     % ASIC V55 Gn0 bit 2nd Edge Timing 
   Tdrshin    =  22000*ns;    
      reg(19+idx,:) = round(Tdrshin/Ts);     % ASIC Dr.shiftin Timing   
   Tst_row    =  0*ns;
      reg(20+idx,:) = round(Tst_row/Ts);     % ASIC Start Scanning Row [0:x77e]
   Tcap_sw0   =  0;    
   Tcap_sw1   =  0;
      reg(21+idx,:) = round(Tcap_sw0/Ts);    % ASIC Cap Switching 1st Edge Timing
      reg(22+idx,:) = round(Tcap_sw1/Ts);    % ASIC Cap Switching 2nd Edge Timing 
   Tln_time   =  41975*ns;
      reg(23+idx,:) = round(Tln_time/Ts);    % ASIC Line Time       
   Tfr_time   =  1638400*ns;                 % ASIC Frame Timing
      t_fr = sprintf('%08x',round(Tfr_time/Ts)); t_frMSB=t_fr(1:4); t_frLSB=t_fr(5:8);
      reg(24+idx,:) = hex2dec(t_frLSB);
      reg(25+idx,:) = hex2dec(t_frMSB);
   Ilim       = 0*2^15 + 0*2^14 + 0*2^13;    % Asic Shift R-R Signals
   ImgL2Rflip = 1*2^12;                      %   Flip Image Left to Right
   B42        = 0*2^11 + 0*2^10;             %   For Future Use
   Dr_pol     = 1*2^9;                       %   Driver Polarity
   Sh_dir     = 1*2^8;                       %   Shift Direction 
   Dr_hz      = 1*2^7;                       %   Driver hz
   Spare      = 0*2^6;                       % 
   Bin10      = 1*2^5  + 1*2^4;              %   Column Binning
   Bin3x3     = 0*2^3;                       %   3x3 Mode
   Gain210    = 0*2^2  + 1*2^1 + 1*2^0;      %   ASIC's Gain Select
   reg26      = Ilim+ImgL2Rflip+Dr_pol+Sh_dir+Dr_hz+Spare+Bin10+Bin3x3+Gain210;
      reg(26+idx,:) = round(reg26);         
   RowBin     = 0*2^15+0*2^14+1*2^13+0*2^12+0*2^11; % 0000_1 - 1 row
                                                    % 0001_0 - 2 rows
                                                    % 0010_0 - 4 rows
   Bot2Top    = 0*2^10;        % Outputting Bottom half of the image to the top half
   ShDir_T    = 0*2^9;         % Shift Direction for the Top Gate Driver (0-L2R)
   ShDir_B    = 0*2^8;         % Shift Direction for the Bot Gate Driver (0-L2R)
   
   Reerved    = 0*2^7;         %   
   Cen        = 0*2^6;         % cen, Venus55 operation enable
   Neg_pix    = 0*2^5;         % Negate the Pixel Value (1-off; 0-on)
   Dat_size   = 1*2^4;         % 1==16bit
   
   Vrt_LnCnt  = 0*2^3 + 0*2^2; % number of addition mode used in multi-gain 
                               % mode (virtual line counter to mode memory)
   Msr_mod    = 0*2^1 + 0*2^0; % MSR mode
   reg27 = RowBin+Bot2Top+ShDir_T+ShDir_B+Reerved+Cen+Neg_pix+Dat_size+Vrt_LnCnt+Msr_mod;
      reg(27+idx,:) = round(reg27);
   SatThrshEnb =  1*2^15;                           % Pix Saturation Threshold Enable
   Reserv14_4  =         0*2^14+ 0*2^13+ 1*2^12 ... % ????
                + 1*2^11+ 0*2^10+ 0*2^9 + 0*2^8 ... % ????
                + 0*2^7 + 0*2^6 + 0*2^5 + 0*2^4;    % ????
   N_div       =  0*2^3 + 0*2^2 + 1*2^1 + 1*2^0;    % Fadc_samp = 40MHz/(N_div+1)
   reg28 = SatThrshEnb + Reserv14_4 + N_div;
      reg(28+idx,:) = round(reg28);
   DCDS_ON     = 1*2^15;                            % DCDS Offset
   DCDS_ACTIVE = 1*2^14;
   DCDS_CONST  = 14544;    % must be < 2^14
   reg29 = DCDS_ON + DCDS_ACTIVE + DCDS_CONST;
      reg(29+idx,:) = round(reg29);
   Start_Row   = 0;                                 % Starting Row for data output   
      reg(30+idx,:) = round(Start_Row);
   Num_Row     = 95;                                % Number of Output Rows
      reg(31+idx,:) = round(Num_Row);
   Start_Col   = 0;                                 % Starting Column for data output   
      reg(32+idx,:) = round(Start_Row);
   Num_Row     = 3071;                              % Number of Output Columns
      reg(33+idx,:) = round(Num_Row);
   Asic_CEN0   = Inf;                               % 1st Edge of Readout asic CEN
      reg(34+idx,:) = round(Asic_CEN0/Ts);      
   Asic_CEN1   = Inf;                               % 2nd Edge of Readout asic CEN
      reg(35+idx,:) = round(Asic_CEN1/Ts);      
   Asic_TBD    = 0;                                 % TBD
      reg(36+idx,:) = round(0);      
   Extra_Tim_MSR = 0;                               % 
      reg(37+idx,:) = round(0);      
   %-- V55 [31:16] ------------------------------------------------------
   VidClmp_En    = 0*2^15;                          % Video Clamp Enable
   Gain2         = 0*2^14;                          % 
   ShftDel       = 1*2^13 + 1*2^12;                 % 
   TstMod2_1     = 0*2^11 + 0*2^10;                 %
   ACDS_EnB      = 1*2^9;                           %
   DM_OffEn      = 1*2^8;                           % 
   DM_dac7_0     = 1*2^7+0*2^6+0*2^5+0*2^4+0*2^3+0*2^2+0*2^1+0*2^0;  %      
   reg38  = VidClmp_En+Gain2+ShftDel+TstMod2_1+ACDS_EnB+DM_OffEn+DM_dac7_0;
      reg(38+idx,:) = round(reg38);      
   %-- V55 [15:0] -------------------------------------------------------
   DVCM1_0       = 0*2^15 + 0*2^14;                 % 
   VidGn2_0      = 1*2^13 + 1*2^12 + 0*2^11;        % 
   SHBW2_0       = 0*2^10 + 1*2^9  + 0*2^8;         % 
   GBdel3_0      = 0*2^7  + 0*2^6  + 0*2^5 + 0*2^4; % 
   PrgEnb        = 1*2^3;                           %
   CntrlRegIgnorB= 1*2^2;                           % Control/RegIgnoreB
   SyncReset     = 1*2^1;                           %
   TokenBitt     = 1*2^0;                           %
   reg39 = DVCM1_0+VidGn2_0+SHBW2_0+GBdel3_0+PrgEnb+CntrlRegIgnorB+SyncReset+TokenBitt;
      reg(39+idx,:) = round(reg39);
   Clmp2  =  Inf;  %
   Clmp3  =  Inf;  %
      reg(40+idx,:) = round(Clmp2/Ts);      % ASIC Clamp 3d  Edge Timing   
      reg(41+idx,:) = round(Clmp3/Ts);      % ASIC Clamp 4th Edge Timing   
   AutoSens  =  Inf; %
      reg(42+idx,:) = round(AutoSens/Ts);   % Auto Sense Threshold
      
   for i = 1:12  % Convert 48 Quadrant DAC Settings into String Arrays
     tadac(i,:)  = 16+i;  tad(i,:) = sprintf('%04x',tadac(i,:)); ta_str(i,:) = [tad(i,1:2) '_' tad(i,3:4)];
     tbdac(i,:)  = 80+i;  tbd(i,:) = sprintf('%04x',tbdac(i,:)); tb_str(i,:) = [tbd(i,1:2) '_' tbd(i,3:4)];
     badac(i,:)  = 48+i;  bad(i,:) = sprintf('%04x',badac(i,:)); ba_str(i,:) = [bad(i,1:2) '_' bad(i,3:4)];
     bbdac(i,:)  = 32+i;  bbd(i,:) = sprintf('%04x',bbdac(i,:)); bb_str(i,:) = [bbd(i,1:2) '_' bbd(i,3:4)];     
   end
   for i = 1:12  % Convert 12 Analog DACs Settings into String Arrays
                          dac(i,:) = sprintf('%04x',adac(i,:));  da_str(i,:) = [dac(i,1:2) '_' dac(i,3:4)];        
   end
   for i = 1:43   % Convert 52 Register Settings into String Arrays
                           rg(i,:) = sprintf('%04x',reg(i,:));   rg_str(i,:) = [rg(i,1:2) '_' rg(i,3:4)];       
   end
   
   fprintf(fid,'// packet 0: 6 bytes\n');
   fprintf(fid,'00_2d\n');                                  % SYNCRO WORD
   fprintf(fid,'05_01\n');                                  % STOP FSM COMMAND
   fprintf(fid,'00_00\n');                                  % CHECKSUM
   fprintf(fid,'// packet 1: 188 bytes\n');           
   fprintf(fid,'00_2d\n');                                  % SYNCRO WORD
   fprintf(fid,'02_01\n');                                  % UPLOAD CFG COMMAND
   fprintf(fid,'00_00\n');                                  % CHECKSUM
   fprintf(fid,'00_72\n');                                  %  ????????
   for i = 1 : 12   fprintf(fid,'%s\n',ta_str(i,:));  end   % TA-GDACs
   for i = 1 : 12   fprintf(fid,'%s\n',tb_str(i,:));  end   % TB-GDACs
   for i = 1 : 12   fprintf(fid,'%s\n',ba_str(i,:));  end   % BA-GDACs
   for i = 1 : 12   fprintf(fid,'%s\n',bb_str(i,:));  end   % BB-GDACs
   for i = 1 : 12   fprintf(fid,'%s\n',da_str(i,:));  end   % ANALOG DACs
   fprintf(fid,'00_00\n');                                  % CHECKSUM ????
   for i = 1 : 43   fprintf(fid,'%s\n',rg_str(i,:));  end   % REGISTERS
   fprintf(fid,'ff_ff\n');                                  % reg43
   fprintf(fid,'ff_ff\n');                                  % reg44
   fprintf(fid,'ff_ff\n');                                  % reg45
   fprintf(fid,'ff_ff\n');                                  % reg46
   fprintf(fid,'ff_ff\n');                                  % reg47
   fprintf(fid,'ff_ff\n');                                  % reg48
   fprintf(fid,'ff_ff\n');                                  % reg49
   fprintf(fid,'ff_ff\n');                                  % reg50
   fprintf(fid,'ff_ff\n');                                  % reg51   
   fprintf(fid,'00_00\n');                                  % CHECKSUM ????
   fprintf(fid,'// packet 2: 6 bytes\n');           
   fprintf(fid,'00_2d\n');                                  % SYNCRO WORD
   fprintf(fid,'03_01\n');                                  % Select Active Mode 1
   fprintf(fid,'00_00\n');                                  % CHECKSUM   
   fprintf(fid,'// packet 3: 6 bytes\n');           
   fprintf(fid,'00_2d\n');                                  % SYNCRO WORD
   fprintf(fid,'04_01\n');                                  % RUN FSM FROM INITIAL STATE
   fprintf(fid,'00_00\n');                                  % CHECKSUM   
   
   cout = 'stop';

   
%#########################################################################
%
% CFG_GEN
%     >>fplib = mfplib; ser = fplib.cfg_conv('q.txt', '_bin_4x4_2cds_msr1_LINES24.txt')
%
%##########################################################################
function cout = cfg_conv(rdfname, wrfname)
 %% Configuration File Generator
   clc; 
   path              =  '.\'; 
   rdfname_with_path = [path rdfname]; rdfid = fopen(rdfname_with_path);
   wrfname_with_path = [path wrfname]; wrfid = fopen(wrfname_with_path,'w');
        
   ns  = 1e-9;
   Ts  = 25*ns;
   Inf = 1638375*ns;

   idx = 1;  % used for 1-based index adjustment in array, i.e. reg(0+idx)
             % corresponds to ink_reg0 register in Flat Panel Design

   for i=1:15  tline = fgets(rdfid); end  % skip these comment lines
   
   %\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
   %  Analog DACs 
   %\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\   
   tline = fgets(rdfid); adac( 0+idx,:)=sscanf(tline(1,40:46),'%d'); % GOFFSET
   tline = fgets(rdfid); adac( 1+idx,:)=sscanf(tline(1,40:46),'%d'); % ABIAS_D
   tline = fgets(rdfid); adac( 2+idx,:)=sscanf(tline(1,40:46),'%d'); % PREINB_D
   tline = fgets(rdfid); adac( 3+idx,:)=sscanf(tline(1,40:46),'%d'); % G_CHCOMP_LVL
   tline = fgets(rdfid); adac( 4+idx,:)=sscanf(tline(1,40:46),'%d'); % IBPRE
   tline = fgets(rdfid); adac( 5+idx,:)=sscanf(tline(1,40:46),'%d'); % AVGL
   tline = fgets(rdfid); adac( 6+idx,:)=sscanf(tline(1,40:46),'%d'); % AVGH
   tline = fgets(rdfid); adac( 7+idx,:)=sscanf(tline(1,40:46),'%d'); % COMP_LEVEL
   tline = fgets(rdfid); adac( 8+idx,:)=sscanf(tline(1,40:46),'%d'); % IBCLAMP
   tline = fgets(rdfid); adac( 9+idx,:)=sscanf(tline(1,40:46),'%d'); % DM_REF_P
   tline = fgets(rdfid); adac(10+idx,:)=sscanf(tline(1,40:46),'%d'); % IBMUX
   tline = fgets(rdfid); adac(11+idx,:)=sscanf(tline(1,40:46),'%d'); % ????   
   
   for i=1:11  tline = fgets(rdfid); end  % skip these comment lines
   
   %\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
   %  REGISTERS 
   %\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\     
   
   for i=1 : 1:51 reg_num( i+idx,:) = 0;  end             % Init All
   
   for i=15:-1:7  tline = fgets(rdfid); reg_num( 0+idx,:)=sscanf(tline(1,41:45),'%d')*2^i + reg_num( 0+idx,:); end
   
   for i=1:4  tline = fgets(rdfid);       end  % skip these comment lines
   
   tline = fgets(rdfid); reg_num(23+idx,:)=round(sscanf(tline(1,41:48),'%d')*ns/Ts);
   tline = fgets(rdfid); reg_num(37+idx,:)=sscanf(tline(1,41:48),'%d');
   tline = fgets(rdfid); Tfr_time=sscanf(tline(1,41:48),'%d')*ns; t_fr = sprintf('%08x',round(Tfr_time/Ts)); t_frMSB=t_fr(1:4); t_frLSB=t_fr(5:8);
                         reg_num(24+idx,:) = hex2dec(t_frLSB); reg_num(25+idx,:) = hex2dec(t_frMSB);                            
   tline = fgets(rdfid); % skip this comment line
   tline = fgets(rdfid); reg_num( 1+idx,:)=round(sscanf(tline(1,41:48),'%d')*ns/Ts);
   tline = fgets(rdfid); reg_num( 2+idx,:)=round(sscanf(tline(1,41:48),'%d')*ns/Ts);

   tline = fgets(rdfid); % skip this comment line
   tline = fgets(rdfid); reg_num( 3+idx,:)=round(sscanf(tline(1,41:48),'%d')*ns/Ts);
   tline = fgets(rdfid); reg_num( 4+idx,:)=round(sscanf(tline(1,41:48),'%d')*ns/Ts);
   tline = fgets(rdfid); reg_num(40+idx,:)=round(sscanf(tline(1,41:48),'%d')*ns/Ts);
   tline = fgets(rdfid); reg_num(41+idx,:)=round(sscanf(tline(1,41:48),'%d')*ns/Ts);

   tline = fgets(rdfid); % skip this comment line
   tline = fgets(rdfid); reg_num( 5+idx,:)=round(sscanf(tline(1,41:48),'%d')*ns/Ts);
   tline = fgets(rdfid); reg_num( 6+idx,:)=round(sscanf(tline(1,41:48),'%d')*ns/Ts);
   tline = fgets(rdfid); reg_num( 7+idx,:)=round(sscanf(tline(1,41:48),'%d')*ns/Ts);
   tline = fgets(rdfid); reg_num( 8+idx,:)=round(sscanf(tline(1,41:48),'%d')*ns/Ts);

   tline = fgets(rdfid); % skip this comment line
   tline = fgets(rdfid); reg_num( 9+idx,:)=round(sscanf(tline(1,41:48),'%d')*ns/Ts);
   tline = fgets(rdfid); reg_num(10+idx,:)=round(sscanf(tline(1,41:48),'%d')*ns/Ts);

   tline = fgets(rdfid); % skip this comment line
   tline = fgets(rdfid); % skip this comment line
   tline = fgets(rdfid); reg_num(19+idx,:)=round(sscanf(tline(1,41:48),'%d')*ns/Ts);

   for i=1:10  tline = fgets(rdfid); end  % skip these comment lines
   
   tline = fgets(rdfid); reg_num(26+idx,:)=sscanf(tline(1,41:48),'%d')*2^12 + reg_num(26+idx,:); 
   tline = fgets(rdfid); reg_num(27+idx,:)=sscanf(tline(1,41:48),'%d')*2^10 + reg_num(27+idx,:); 
   tline = fgets(rdfid); reg_num(27+idx,:)=sscanf(tline(1,41:48),'%d')*2^5  + reg_num(27+idx,:); 
   
   tline = fgets(rdfid); % skip this comment line
   tline = fgets(rdfid); reg_num(28+idx,:)=sscanf(tline(1,41:48),'%d')      + reg_num(28+idx,:); 

   tline = fgets(rdfid); % skip this comment line
   tline = fgets(rdfid); reg_num(26+idx,:)=sscanf(tline(1,41:48),'%d')*2^8 + reg_num(26+idx,:); 

   tline = fgets(rdfid); % skip this comment line
   for i=5:-1:3  tline = fgets(rdfid); reg_num(26+idx,:)=sscanf(tline(1,41:48),'%d')*2^i + reg_num(26+idx,:); end
   
   tline = fgets(rdfid); % skip this comment line
   for i=15:-1:11  tline = fgets(rdfid); reg_num(27+idx,:)=sscanf(tline(1,41:48),'%d')*2^i + reg_num(27+idx,:); end

   tline = fgets(rdfid); % skip this comment line
   for i=2:-1:0  tline = fgets(rdfid); reg_num(26+idx,:)=sscanf(tline(1,41:48),'%d')*2^i + reg_num(26+idx,:); end
   
   tline = fgets(rdfid); % skip this comment line
   tline = fgets(rdfid); reg_num(27+idx,:)=sscanf(tline(1,41:48),'%d')*2^6 + reg_num(27+idx,:); 
   
   tline = fgets(rdfid); % skip this comment line
   for i=3:-1:0  tline = fgets(rdfid); reg_num(27+idx,:)=sscanf(tline(1,41:48),'%d')*2^i + reg_num(27+idx,:); end
   
   tline = fgets(rdfid); % skip this comment line
   tline = fgets(rdfid); reg_num(28+idx,:)=sscanf(tline(1,41:48),'%d')*2^15 + reg_num(28+idx,:); 

   tline = fgets(rdfid); % skip this comment line
   for i=15:-1:14  tline = fgets(rdfid); reg_num(29+idx,:)=sscanf(tline(1,41:48),'%d')*2^i + reg_num(29+idx,:); end
                   tline = fgets(rdfid); reg_num(29+idx,:)=sscanf(tline(1,41:48),'%d')     + reg_num(29+idx,:); 
   
   tline = fgets(rdfid); % skip this comment line
   tline = fgets(rdfid); reg_num(20+idx,:)=sscanf(tline(1,41:48),'%d') + reg_num(20+idx,:); 
   tline = fgets(rdfid); reg_num(30+idx,:)=sscanf(tline(1,41:48),'%d') + reg_num(30+idx,:); 
   tline = fgets(rdfid); reg_num(31+idx,:)=sscanf(tline(1,41:48),'%d') + reg_num(31+idx,:); 

   tline = fgets(rdfid); % skip this comment line
   tline = fgets(rdfid); reg_num(32+idx,:)=sscanf(tline(1,41:48),'%d') + reg_num(32+idx,:); 
   tline = fgets(rdfid); reg_num(33+idx,:)=sscanf(tline(1,41:48),'%d') + reg_num(33+idx,:); 

   for i=1 : 1:4  tline = fgets(rdfid); end   % skip these comment lines
   for i=15:-1:8  tline = fgets(rdfid); reg_num(38+idx,:)=sscanf(tline(1,41:48),'%d')*2^i + reg_num(38+idx,:); end
                  tline = fgets(rdfid); reg_num(38+idx,:)=sscanf(tline(1,41:48),'%d')     + reg_num(38+idx,:); 

   for i=1 : 1:3  tline = fgets(rdfid); end   % skip these comment lines
   for i=15:-1:0  tline = fgets(rdfid); reg_num(39+idx,:)=sscanf(tline(1,41:48),'%d')*2^i + reg_num(39+idx,:); end

   for i=1 : 1:4  tline = fgets(rdfid); end   % skip these comment lines
   for i= 9:-1:8  tline = fgets(rdfid); reg_num(27+idx,:)=sscanf(tline(1,41:48),'%d')*2^i + reg_num(27+idx,:); end
   tline = fgets(rdfid); % skip this comment line
   tline = fgets(rdfid); reg_num(26+idx,:)=sscanf(tline(1,41:48),'%d')*2^9 + reg_num(26+idx,:); 
   tline = fgets(rdfid); reg_num(26+idx,:)=sscanf(tline(1,41:48),'%d')*2^7 + reg_num(26+idx,:); 

   for i=1 : 1:4  tline = fgets(rdfid); end   % skip these comment lines
   tline = fgets(rdfid); reg_num(27+idx,:)=sscanf(tline(1,41:48),'%d')*2^4 + reg_num(27+idx,:); 
   for i=15:-1:13  tline = fgets(rdfid); reg_num(26+idx,:)=sscanf(tline(1,41:48),'%d')*2^i + reg_num(26+idx,:); end
   for i=11:-1:10  tline = fgets(rdfid); reg_num(26+idx,:)=sscanf(tline(1,41:48),'%d')*2^i + reg_num(26+idx,:); end
   tline = fgets(rdfid); reg_num(26+idx,:)=sscanf(tline(1,41:48),'%d')*2^6 + reg_num(26+idx,:); 
   tline = fgets(rdfid); reg_num(27+idx,:)=sscanf(tline(1,41:48),'%d')*2^7 + reg_num(27+idx,:); 
   tline = fgets(rdfid); reg_num(28+idx,:)=sscanf(tline(1,41:48),'%d')*16  + reg_num(28+idx,:);
   tline = fgets(rdfid); reg_num(36+idx,:)=sscanf(tline(1,41:48),'%d')     + reg_num(36+idx,:);
   for i=42:1:51  tline = fgets(rdfid); reg_num(i+idx,:)=sscanf(tline(1,41:48),'%d'); end 
   for i=11:1:18  tline = fgets(rdfid); reg_num(i+idx,:)=sscanf(tline(1,41:48),'%d'); end   
   for i=21:1:22  tline = fgets(rdfid); reg_num(i+idx,:)=sscanf(tline(1,41:48),'%d'); end
   for i=34:1:35  tline = fgets(rdfid); reg_num(i+idx,:)=sscanf(tline(1,41:48),'%d'); end
   

   for i = 1:12  % Convert 48 Quadrant DAC Settings into String Arrays
     tadac(i,:)  = 16+i;  tad(i,:) = sprintf('%04x',tadac(i,:)); ta_str(i,:) = [tad(i,1:2) '_' tad(i,3:4)];
     tbdac(i,:)  = 80+i;  tbd(i,:) = sprintf('%04x',tbdac(i,:)); tb_str(i,:) = [tbd(i,1:2) '_' tbd(i,3:4)];
     badac(i,:)  = 48+i;  bad(i,:) = sprintf('%04x',badac(i,:)); ba_str(i,:) = [bad(i,1:2) '_' bad(i,3:4)];
     bbdac(i,:)  = 32+i;  bbd(i,:) = sprintf('%04x',bbdac(i,:)); bb_str(i,:) = [bbd(i,1:2) '_' bbd(i,3:4)];     
   end
   for i = 1:12  % Convert 12 Analog DACs Settings into String Arrays
                          dac(i,:) = sprintf('%04x',adac(i,:));  da_str(i,:) = [dac(i,1:2) '_' dac(i,3:4)];     
   end
   for i = 1:52  % Convert 52 Registers into String Arrays
     reg(i,:) = round(reg_num(i,:));  rg(i,:) = sprintf('%04x',reg(i,:));  
                                                                 reg_str(i,:) = [rg(i,1:2) '_' rg(i,3:4)];                                                                
   end

   fprintf(wrfid,'// packet 0: 6 bytes\n');
   fprintf(wrfid,'00_2d\n');                                  % SYNCRO WORD
   fprintf(wrfid,'05_01\n');                                  % STOP FSM COMMAND
   fprintf(wrfid,'00_00\n');                                  % CHECKSUM
   fprintf(wrfid,'// packet 1: 188 bytes\n');           
   fprintf(wrfid,'00_2d\n');                                  % SYNCRO WORD
   fprintf(wrfid,'02_01\n');                                  % UPLOAD CFG COMMAND
   fprintf(wrfid,'00_00\n');                                  % CHECKSUM
   fprintf(wrfid,'00_72\n');                                  %  ????????
   for i = 1 : 12   fprintf(wrfid,'%s\n',ta_str(i,:));  end   % TA-GDACs
   for i = 1 : 12   fprintf(wrfid,'%s\n',tb_str(i,:));  end   % TB-GDACs
   for i = 1 : 12   fprintf(wrfid,'%s\n',ba_str(i,:));  end   % BA-GDACs
   for i = 1 : 12   fprintf(wrfid,'%s\n',bb_str(i,:));  end   % BB-GDACs
   for i = 1 : 12   fprintf(wrfid,'%s\n',da_str(i,:));  end   % ANALOG DACs
   fprintf(wrfid,'00_00\n');                                  % CHECKSUM ????
   for i = 1 : 52   fprintf(wrfid,'%s\n',reg_str(i,:)); end   % REGISTERS
   fprintf(wrfid,'00_00\n');                                  % CHECKSUM ????
   fprintf(wrfid,'// packet 2: 6 bytes\n');           
   fprintf(wrfid,'00_2d\n');                                  % SYNCRO WORD
   fprintf(wrfid,'03_01\n');                                  % Select Active Mode 1
   fprintf(wrfid,'00_00\n');                                  % CHECKSUM   
   fprintf(wrfid,'// packet 3: 6 bytes\n');           
   fprintf(wrfid,'00_2d\n');                                  % SYNCRO WORD
   fprintf(wrfid,'04_01\n');                                  % RUN FSM FROM INITIAL STATE
   fprintf(wrfid,'00_00\n');                                  % CHECKSUM                                                                   
                                                                
fclose(rdfid);
fclose(wrfid);
   cout = 'stop';

   
%#########################################################################
%
% CFG_GEN
%     >>fplib = mfplib; ser = fplib.xls2plot('xls.txt')
%
%     Launch KFG_K5.exe, open config.dat file of intrest, go to edit,
%     then to mode setup Edit, select Receptor Register Tab and make
%     selection of the 2nd column ==> copy it. Open external editor
%     and paste there a copied block. Save to the xls.txt  file.
%     The created file can be used as function call parameter.
%
%##########################################################################
function cout = xls2plot(rdfname)   
 %% Configuration File Generator 
   clc; 
   path              =  '.\'; 
   rdfname_with_path = [path rdfname]; rdfid = fopen(rdfname_with_path);
        
   ns  = 1e-9;
   Ts  = 25*ns;
   Inf = 1638375*ns;
   
   T_USEC     = 0;
   T_CLOCKS   = 1;
   cTIME_MODE = T_USEC;  % or # of 40MHZ CLOCKS
   
   if cTIME_MODE == T_USEC
      mxlabel = 'SEC';   xmin=0; xmax=0.0001; ymin=-18; ymax=2;   
   else
      mxlabel = 'CLOCKS'; xmin=0; xmax=4000;   ymin=-18; ymax=2;  
   end   

   idx = 1;  % used for 1-based index adjustment in array, i.e. reg(0+idx)
             % corresponds to ink_reg0 register in Flat Panel Design

   for i=1:51  
      tline           = fgets(rdfid); 
      ink_reg( :,0+i) = sscanf(tline(1,:),'%x');
   end 
   
   % Initialize Arrays to speedup clculations
   time(1,:)         = zeros(1,65535); 
   reset(1,:)        = zeros(1,65535);        
   clamp(1,:)        = zeros(1,65535);
   sample(1,:)       = zeros(1,65535);
   
   asic_shin(1,:)    = zeros(1,65535);
   
   glob_offs(1,:)    = zeros(1,65535);
   dr_oe(1,:)        = zeros(1,65535);
   dyn_gn_bypas(1,:) = zeros(1,65535);
   
   dr_shin(1,:)      = zeros(1,65535);   
   hsync(1,:)        = zeros(1,65535);

   charge_comp(1,:)  = zeros(1,65535);
   inv_dat_vld(1,:)  = zeros(1,65535);
   tst_mod_ovrd(1,:) = zeros(1,65535);

     
   % Time raw initialization     
      % TIME_REPRESENTATION IN USEC
    %    for i=1:length(time) time(1,i)=i;       end
      % TIME_REPRESENTATION IN USEC
        %for i=1:length(time) time(1,i)=i*25*ns; end
   if cTIME_MODE == T_CLOCKS
      for i=1:length(time) time(1,i)=i;       end  
   else
      for i=1:length(time) time(1,i)=i*25*ns; end 
   end   
        
   bin_str  = dec2bin(ink_reg(:, 0+1),16); 
     reset(1,1)        = bin2dec(bin_str(1,1));  % 15th bit
     clamp(1,1)        = bin2dec(bin_str(1,2));  % 14th bit
     sample(1,1)       = bin2dec(bin_str(1,3));  % 13th bit
     asic_shin(1,1)    = 0;                      % 
     glob_offs(1,1)    = bin2dec(bin_str(1,4));  % 12th bit
     dr_oe(1,1)        = bin2dec(bin_str(1,5));  % 11th bit
     dyn_gn_bypas(1,1) = bin2dec(bin_str(1,6));  % 10th bit
     dr_shin(1,1)      = 0;
     hsync(1,1)        = 0;
     charge_comp(1,1)  = bin2dec(bin_str(1,7));  %  9th bit
     inv_dat_vld(1,1)  = bin2dec(bin_str(1,8));  %  8th bit
     tst_mod_ovrd(1,1) = bin2dec(bin_str(1,9));  %  7th bit

   rg26bin = dec2bin(ink_reg(:,26+1),16); 
   rg27bin = dec2bin(ink_reg(:,27+1),16); 
  
   
     
   for i =       2                                : ink_reg(:,2)-1               if reset(1,1)>0  reset(1,i) = 1;  else reset(1,i)  = 0;  end; end
   for i = ink_reg(:,2)                           : ink_reg(:,2)+ink_reg(:,3)    if reset(1,1)>0  reset(1,i) = 0;  else reset(1,i)  = 1;  end; end
   
   for i =       2                                : ink_reg(:,4)-1               if clamp(1,1)>0  clamp(1,i) = 1;  else clamp(1,i)  = 0;  end; end
   for i = ink_reg(:,4)                           : ink_reg(:,4)+ink_reg(:,5)    if clamp(1,1)>0  clamp(1,i) = 0;  else clamp(1,i)  = 1;  end; end
   
   for i =       2                                : ink_reg(:,6)-1                                         if sample(1,1)>0 sample(1,i) = 1; else sample(1,i) = 0;  end; end
   for i = ink_reg(:,6)                           : ink_reg(:,6)+ink_reg(:,7)-1                            if sample(1,1)>0 sample(1,i) = 0; else sample(1,i) = 1;  end; end
   for i = ink_reg(:,6)+ink_reg(:,7)              : ink_reg(:,6)+ink_reg(:,7)+ink_reg(:,8)-1               if sample(1,1)>0 sample(1,i) = 1; else sample(1,i) = 0;  end; end
   for i = ink_reg(:,6)+ink_reg(:,7)+ink_reg(:,8) : ink_reg(:,6)+ink_reg(:,7)+ink_reg(:,8)+ink_reg(:,9)-1  if sample(1,1)>0 sample(1,i) = 0; else sample(1,i) = 1;  end; end
   
   for i =       2                                : ink_reg(:,10)-1                                            asic_shin(1,i) = 0;  end
   for i = ink_reg(:,10)                          : ink_reg(:,10)+ink_reg(:,11)-1                              asic_shin(1,i) = 1;  end
   for i = ink_reg(:,10)+ink_reg(:,11)            : 65535                                                      asic_shin(1,i) = 0;  end

   for i =       2                                : ink_reg(:,12)-1              if glob_offs(1,1)>0  glob_offs(1,i) = 1;  else glob_offs(1,i)  = 0;  end; end
   for i = ink_reg(:,12)                          : ink_reg(:,12)+ink_reg(:,13)  if glob_offs(1,1)>0  glob_offs(1,i) = 0;  else glob_offs(1,i)  = 1;  end; end
   
   for i =       2                                   : ink_reg(:,14)-1                                            if dr_oe(1,1)>0 dr_oe(1,i) = 1; else dr_oe(1,i) = 0;  end; end
   for i = ink_reg(:,14)                             : ink_reg(:,14)+ink_reg(:,15)-1                              if dr_oe(1,1)>0 dr_oe(1,i) = 0; else dr_oe(1,i) = 1;  end; end
   for i = ink_reg(:,14)+ink_reg(:,15)               : ink_reg(:,14)+ink_reg(:,15)+ink_reg(:,16)-1                if dr_oe(1,1)>0 dr_oe(1,i) = 1; else dr_oe(1,i) = 0;  end; end
   for i = ink_reg(:,14)+ink_reg(:,15)+ink_reg(:,16) : ink_reg(:,14)+ink_reg(:,15)+ink_reg(:,16)+ink_reg(:,17)-1  if dr_oe(1,1)>0 dr_oe(1,i) = 0; else dr_oe(1,i) = 1;  end; end

   for i =       2                                : ink_reg(:,18)-1              if dyn_gn_bypas(1,1)>0  dyn_gn_bypas(1,i) = 1;  else dyn_gn_bypas(1,i)  = 0;  end; end
   for i = ink_reg(:,18)                          : ink_reg(:,18)+ink_reg(:,19)  if dyn_gn_bypas(1,1)>0  dyn_gn_bypas(1,i) = 0;  else dyn_gn_bypas(1,i)  = 1;  end; end
   
   for i =       2                                : ink_reg(:,20)-1                                            dr_shin(1,i) = 0;  end
   for i = ink_reg(:,20)                          : ink_reg(:,20)+1                                            dr_shin(1,i) = 1;  end
   for i = ink_reg(:,20)+1                        : 65535                                                      dr_shin(1,i) = 0;  end
   
   if ink_reg(:,22) > 0 && ink_reg(:,23)>0
     for i =       2                                : ink_reg(:,22)-1                                          hsync(1,i) = 0;  end
     for i = ink_reg(:,22)                          : ink_reg(:,22)+ink_reg(:,23)-1                            hsync(1,i) = 1;  end
     for i = ink_reg(:,22)+ink_reg(:,23)            : 65535                                                    hsync(1,i) = 0;  end      
   end

   
   plot( time(1:65535), reset(1:65535),             ...
         time(1:65535), clamp(1:65535)        -2.0, ... 
         time(1:65535), sample(1:65535)       -4.0, ...
         time(1:65535), asic_shin(1:65535)    -6.0, ...
         time(1:65535), glob_offs(1:65535)    -8.0, ...
         time(1:65535), dr_oe(1:65535)       -10.0, ...
         time(1:65535), dyn_gn_bypas(1:65535)-12.0, ...
         time(1:65535), dr_shin(1:65535)     -14.0, ...
         time(1:65535), hsync(1:65535)       -16.0);   
     
   title('Flat Panel Timing','FontSize',14);

   xlabel(mxlabel); 
   axis([xmin xmax ymin ymax]); 
   
   set(gca,'ytick',[]);  % make y-ticks invisible
   legend_array = ['Reset         ';
                   'Clamp         ';
                   'Sample        ';
                   'ASIC\_shin    ';
                   'Glob\_offs    ';
                   'dr\_oe        ';
                   'dyn\_gn\_bypas';
                   'dr\_shin      '; 
                   'hsync(cap\_cw)'];

   [length1 width1]=size(legend_array);
   
   if cTIME_MODE == T_USEC
      for i=1:length1  
          text(-0.000012,(2.5-2*i), legend_array(i,:));  
      end       
      text(0.000007, 0.5,['T\_line = ',         num2str(0.025*ink_reg(:,24)),' usec']);
      text(0.000007,-0.5,['T\_frame= ',         num2str(0.025*(ink_reg(:,25)*2^8+ink_reg(:,25)) ),' usec (Ext.Trig when=0)']);
      text(0.00003,  0.5,['ROWS START / TOT = ',num2str(ink_reg(:,31)),' / ',num2str(ink_reg(:,32))]);
      text(0.000065, 0.5,['COLM START / TOT = ',num2str(ink_reg(:,33)),' / ',num2str(ink_reg(:,34))]);
      
      text(0.000101, 2.5,['Ilim[2:0]   =',      num2str( bin2dec(rg26bin(1,1))*2^2+bin2dec(rg26bin(1,2))*2^1 +bin2dec(rg26bin(1,3))*2^0)]);
      text(0.000101, 1.5,['ImL2R\_flip=',       num2str(                                                      bin2dec(rg26bin(1,4))*2^0)]);
      text(0.000101, 0.5,['B[4,2]      =',      num2str(                           bin2dec(rg26bin(1,5))*2^1 +bin2dec(rg26bin(1,6))*2^0)]);
      text(0.000101,-0.5,['dr\_pol     =',      num2str(                                                      bin2dec(rg26bin(1,7))*2^0)]);
      text(0.000101,-1.5,['AsicShDir=',         num2str(                                                      bin2dec(rg26bin(1,8))*2^0)]);
      text(0.000101,-2.5,['dr\_hz      =',      num2str(                                                      bin2dec(rg26bin(1,9))*2^0)]);
      text(0.000101,-3.5,['spare       =',      num2str(                                                      bin2dec(rg26bin(1,10))*2^0)]);
      text(0.000101,-4.5,['bin[1;0]    =',      num2str(                           bin2dec(rg26bin(1,12))*2^1+bin2dec(rg26bin(1,11))*2^0)]);
      text(0.000101,-5.5,['3x3 mode =',         num2str(                                                      bin2dec(rg26bin(1,13))*2^0)]);
      text(0.000101,-6.5,['Gain[2:0]  =',       num2str( bin2dec(rg26bin(1,14))*2^2+bin2dec(rg26bin(1,15))*2^1+bin2dec(rg26bin(1,16))*2^0)]);
      
      text(0.000101,-8.5,['DrBin[4:0] =',       num2str( bin2dec(rg27bin(1,1))*2^4+bin2dec(rg27bin(1,2))*2^3+bin2dec(rg27bin(1,3))*2^2+bin2dec(rg27bin(1,4))*2^1 +bin2dec(rg27bin(1,5))*2^0)]);
      text(0.000101,-9.5,['Bor2Top    =',       num2str(                                                      bin2dec(rg27bin(1,6))*2^0)]);
      text(0.000101,-10.5,['t\_dr\_shdir=',     num2str(                                                      bin2dec(rg27bin(1,7))*2^0)]);
      
      text(0.000101,-11.5,['b\_dr\_shdir=',     num2str(                                                      bin2dec(rg27bin(1,9))*2^0)]);
      text(0.000101,-12.5,['cen      =',        num2str(                                                      bin2dec(rg27bin(1,10))*2^0)]);
      text(0.000101,-13.5,['neg\_pix  =',       num2str(                                                      bin2dec(rg27bin(1,11))*2^0)]);
      text(0.000101,-14.5,['16b\_dsize=',       num2str(                                                      bin2dec(rg27bin(1,12))*2^0)]);
      text(0.000101,-15.5,['VirL[1:0] =',       num2str(                           bin2dec(rg27bin(1,13))*2^1+bin2dec(rg27bin(1,14))*2^0)]);      
      text(0.000101,-16.5,['MSR[1:0] =',        num2str(                           bin2dec(rg27bin(1,15))*2^1+bin2dec(rg27bin(1,16))*2^0)]);      
   else
      for i=1:length1  
          text(-500,(2.5-2*i), legend_array(i,:));  
      end
      text(300, 0.5, ['T\_line = ',          num2str(ink_reg(:,24)),' clks']);
      text(300,-0.5, ['T\_frame= ',          num2str( ink_reg(:,25)*2^8 +ink_reg(:,25) ),' clks (Ext.Trig when=0)']);
      text(1300,0.5, ['ROWS START / TOT = ', num2str(ink_reg(:,31)),' / ',num2str(ink_reg(:,32))]);
      text(2700,0.5, ['COLM START / TOT = ', num2str(ink_reg(:,33)),' / ',num2str(ink_reg(:,34))]);
      
      text(4050, 2.5, ['Ilim[2:0]   =',       num2str( bin2dec(rg26bin(1,1))*2^2+bin2dec(rg26bin(1,2))*2^1 +bin2dec(rg26bin(1,3))*2^0)]);
      text(4050, 1.5,['ImL2R\_flip=',        num2str(                                                      bin2dec(rg26bin(1,4))*2^0)]); 
      text(4050, 0.5,['B[4,2]      =',       num2str(                           bin2dec(rg26bin(1,5))*2^1 +bin2dec(rg26bin(1,6))*2^0)]);
      text(4050,-0.5,['dr\_pol     =',       num2str(                                                      bin2dec(rg26bin(1,7))*2^0)]);
      text(4050,-1.5,['AsicShDir=',          num2str(                                                      bin2dec(rg26bin(1,8))*2^0)]);
      text(4050,-2.5,['dr\_hz      =',       num2str(                                                      bin2dec(rg26bin(1,9))*2^0)]);
      text(4050,-3.5,['spare       =',       num2str(                                                      bin2dec(rg26bin(1,10))*2^0)]);
      text(4050,-4.5,['bin[1;0]    =',       num2str(                           bin2dec(rg26bin(1,12))*2^1+bin2dec(rg26bin(1,11))*2^0)]);
      text(4050,-5.5,['3x3 mode =',          num2str(                                                      bin2dec(rg26bin(1,13))*2^0)]);
      text(4050,-6.5,['Gain[2:0]  =',        num2str( bin2dec(rg26bin(1,14))*2^2+bin2dec(rg26bin(1,15))*2^1+bin2dec(rg26bin(1,16))*2^0)]);
      
      text(4050,-8.5,['DrBin[4:0] =',        num2str( bin2dec(rg27bin(1,1))*2^4+bin2dec(rg27bin(1,2))*2^3+bin2dec(rg27bin(1,3))*2^2+bin2dec(rg27bin(1,4))*2^1 +bin2dec(rg27bin(1,5))*2^0)]);
      text(4050,-9.5,['Bor2Top    =',        num2str(                                                      bin2dec(rg27bin(1,6))*2^0)]);
      text(4050,-10.5,['t\_dr\_shdir=',      num2str(                                                      bin2dec(rg27bin(1,7))*2^0)]);
      
      text(4050,-11.5,['b\_dr\_shdir=',      num2str(                                                      bin2dec(rg27bin(1,9))*2^0)]);
      text(4050,-12.5,['cen      =',         num2str(                                                      bin2dec(rg27bin(1,10))*2^0)]);
      text(4050,-13.5,['neg\_pix  =',        num2str(                                                      bin2dec(rg27bin(1,11))*2^0)]);
      text(4050,-14.5,['16b\_dsize=',        num2str(                                                      bin2dec(rg27bin(1,12))*2^0)]);
      text(4050,-15.5,['VirL[1:0] =',        num2str(                           bin2dec(rg27bin(1,13))*2^1+bin2dec(rg27bin(1,14))*2^0)]);      
      text(4050,-16.5,['MSR[1:0] =',         num2str(                           bin2dec(rg27bin(1,15))*2^1+bin2dec(rg27bin(1,16))*2^0)]);      
   end
   
   

   
   fclose(rdfid);
   cout = 'stop';
