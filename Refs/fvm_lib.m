
%%
%  The ferrite vector modulator fvm-suite provides FVM scan data 
%  processing and generation of inversed LUT in output file. It recognizes
%  file format used in the scan and retreives any selected channel 
%  0 through 5 by request for calculation. Each processing stage is
%  plotted in dedicated window and status is displayed on terminal.
%  The resultant output file is named after the processing cavity.
%
%  Exampe of the function call from command line:
%
%  >>fvm = fvm_lib; fvm.fvmScanCalcRevD('FVM Scan 2011-09-20 17-19-16b.txt',3,0,0,-55,0,0.8,3.6,0.1,-140,-20,5)
%
%  For more details address see descriptions in related functions below.
%
%
%  LLRF/VT  5 October 2011
%
%  REVISION HISTORY
%
%   2012, January 12  - 1) changed plot labels "sqrt(KW)" by "KW";
%                       2) renamed fvmScanCalcRevC to fvmScanCalcRevD





%%
function fvm = fvm_lib

fvm.crop2D            = @crop2D;
fvm.InterX            = @InterX;
fvm.placeNaNs         = @placeNaNs;
fvm.suptitle          = @suptitle;
fvm.fvmScanCalcRevD   = @fvmScanCalcRevD;


function X = crop2D( xi, left, bottom, right, top)
%%
%   crop2D crops the input 2D-arrays xi,yi,zi by specified number 
%   on each side.
%                                 (T)op
%          col 1  col 2  col 3    (R)ight
%        |----------------------| 
%  row 1 |   11     12    13    | jj=1:3
%  row 2 |   21     22    23    | Y      Z(2,3) = 23
%  row 3 |   31     32    33    | Vb
%        |______________________|
%  (L)ow        X, Va, ii=1:3
%  (B)ottom
%

N = size(xi); Nx = N(1); Ny=N(2);

cB = left;
cL = top;
cR = bottom;
cT = right;

% initialize to reduce calc time
X=zeros(Nx-cL-cR,Ny-cB-cT); %Y=X; Z=X;

%disp(' ');
for ii=(1+cL):(Nx-cR)           % x-axis

    for jj=(1+cB):(Ny-cT)       % y-axis
        X(ii-cL,jj-cB)=xi(ii,jj);
    end;
        
end;





function P = InterX(L1,varargin)
%INTERX Intersection of curves
%   P = INTERX(L1,L2) returns the intersection points of two curves L1 
%   and L2. The curves L1,L2 can be either closed or open and are described
%   by two-row-matrices, where each row contains its x- and y- coordinates.
%   The intersection of groups of curves (e.g. contour lines, multiply 
%   connected regions etc) can also be computed by separating them with a
%   column of NaNs as for example
%
%         L  = [x11 x12 x13 ... NaN x21 x22 x23 ...;
%               y11 y12 y13 ... NaN y21 y22 y23 ...]
%
%   P has the same structure as L1 and L2, and its rows correspond to the
%   x- and y- coordinates of the intersection points of L1 and L2. If no
%   intersections are found, the returned P is empty.
%
%   P = INTERX(L1) returns the self-intersection points of L1. To keep
%   the code simple, the points at which the curve is tangent to itself are
%   not included. P = INTERX(L1,L1) returns all the points of the curve 
%   together with any self-intersection points.
%   
%   Example:
%       t = linspace(0,2*pi);
%       r1 = sin(4*t)+2;  x1 = r1.*cos(t); y1 = r1.*sin(t);
%       r2 = sin(8*t)+2;  x2 = r2.*cos(t); y2 = r2.*sin(t);
%       P = InterX([x1;y1],[x2;y2]);
%       plot(x1,y1,x2,y2,P(1,:),P(2,:),'ro')

%   Author : NS
%   Version: 1.0, 12/12/08

%   Two words about the algorithm: Most of the code is self-explanatory.
%   The only trick lies in the calculation of C1 and C2. To be brief, this
%   is essentially the two-dimensional analog of the condition that needs
%   to be satisfied by a function F(x) that has a zero in the interval
%   [a,b], namely
%           F(a)*F(b) <= 0
%   C1 and C2 exactly do this for each segment of curves 1 and 2
%   respectively. If this condition is satisfied simultaneously for two
%   segments then we know that they will cross at some point. 
%   Each factor of the 'C' arrays is essentially a matrix containing 
%   the numerators of the signed distances between points of one curve
%   and line segments of the other.

    %...Argument checks and assignment of L2
    error(nargchk(1,2,nargin));
    if nargin == 1,
        L2 = L1;    hF = @lt;   %...Avoid the inclusion of common points
    else
        L2 = varargin{1}; hF = @le;
    end
       
    %...Preliminary stuff
    x1  = L1(1,:)';  x2 = L2(1,:);
    y1  = L1(2,:)';  y2 = L2(2,:);
    dx1 = diff(x1); dy1 = diff(y1);
    dx2 = diff(x2); dy2 = diff(y2);
    
    %...Determine 'signed distances'
    S1 = repmat(dx1.*y1(1:end-1) - dy1.*x1(1:end-1),1,size(L2,2)-1);
    S2 = repmat(dx2.*y2(1:end-1) - dy2.*x2(1:end-1),size(L1,2)-1,1);
    
    C1 = feval(hF,(kron(dx1,y2(1:end-1)) - kron(dy1,x2(1:end-1)) - S1).*...
         (kron(dx1,y2(2:end))- kron(dy1,x2(2:end)) - S1),0);       
    
    C2 = feval(hF,(kron(dx2,y1(1:end-1)) - kron(dy2,x1(1:end-1)) - S2).*...
         (kron(dx2,y1(2:end)) - kron(dy2,x1(2:end)) - S2),0);

    %...Obtain the points where an intersection is expected
    [i,j] = find(C1&C2);
    x2 = x2';dx2=dx2';y2=y2';dy2=dy2';  
    L = dy2(j).*dx1(i) - dy1(i).*dx2(j);
    i = i(L~=0); j=j(L~=0); L=L(L~=0);  %...Avoid divisions by 0
    
    %...Solve system of eqs to get the common points
    P = unique([(dx2(j).*(dx1(i).*y1(i) - dy1(i).*x1(i)) ...
         + dx1(i).*(dy2(j).*x2(j) - dx2(j).*y2(j))),...
           dy1(i).*(dy2(j).*x2(j) - dx2(j).*y2(j))...
         + dy2(j).*(dx1(i).*y1(i) - dy1(i).*x1(i))]./[L L],'rows')';


     
function C_out = placeNaNs (C_in)
%%
% this function takes the output matrix of the function contourc, which
% consists of a 2xN matrix, with the 1,1 element being the contour value,
% val1, the 2,1 element being the number N1 of pairs (x,y) of values 
% defining the contour. The comes N1 pairs (x,y) defining the contour val1
% The next element on row 1 is val2, on row 2 is N2 followed by N2 pairs
% (x,y) defining the next contour val2, etc.... This function replaces
% every time the pair (val_i, N_i) and replaces it with NaN's. This formats
% the matrix for the function interX.m which finds out the interseciton
% points.

    if isempty(C_in)
        C_out = [];
    else
        C_out=C_in;
        % total number of points
        Ntot=numel(C_in)/2;
        Pt_i=1;
        while Pt_i<Ntot
            C_out(1,Pt_i)=nan;
            N=C_in(2,Pt_i);
            C_out(2,Pt_i)=nan;
            Pt_i=Pt_i+N+1;            
        end;
    end;
%end;




function hout=suptitle(str)
%SUPTITLE puts a title above all subplots.
%
%	SUPTITLE('text') adds text to the top of the figure
%	above all subplots (a "super title"). Use this function
%	after all subplot commands.
%
%   SUPTITLE is a helper function for yeastdemo.

%   Copyright 2003-2010 The MathWorks, Inc.
%   $Revision: 1.1.6.7 $   $Date: 2010/03/01 05:18:19 $

% Warning: If the figure or axis units are non-default, this
% will break.

% Parameters used to position the supertitle.

% Amount of the figure window devoted to subplots
plotregion = .92;

% Y position of title in normalized coordinates
titleypos  = .95;

% Fontsize for supertitle
fs = get(gcf,'defaultaxesfontsize')+4;

% Fudge factor to adjust y spacing between subplots
fudge=1;

haold = gca;
figunits = get(gcf,'units');

% Get the (approximate) difference between full height (plot + title
% + xlabel) and bounding rectangle.

if (~strcmp(figunits,'pixels')),
    set(gcf,'units','pixels');
    pos = get(gcf,'position');
    set(gcf,'units',figunits);
else
    pos = get(gcf,'position');
end
ff = (fs-4)*1.27*5/pos(4)*fudge;

% The 5 here reflects about 3 characters of height below
% an axis and 2 above. 1.27 is pixels per point.

% Determine the bounding rectangle for all the plots

% h = findobj('Type','axes');

% findobj is a 4.2 thing.. if you don't have 4.2 comment out
% the next line and uncomment the following block.

h = findobj(gcf,'Type','axes');  % Change suggested by Stacy J. Hills

max_y=0;
min_y=1;
oldtitle = NaN;
numAxes = length(h);
thePositions = zeros(numAxes,4);
for i=1:numAxes
    pos=get(h(i),'pos');
    thePositions(i,:) = pos;
    if (~strcmp(get(h(i),'Tag'),'suptitle')),
        if (pos(2) < min_y)
            min_y=pos(2)-ff/5*3;
        end;
        if (pos(4)+pos(2) > max_y)
            max_y=pos(4)+pos(2)+ff/5*2;
        end;
    else
        oldtitle = h(i);
    end
end

if max_y > plotregion,
    scale = (plotregion-min_y)/(max_y-min_y);
    for i=1:numAxes
        pos = thePositions(i,:);
        pos(2) = (pos(2)-min_y)*scale+min_y;
        pos(4) = pos(4)*scale-(1-scale)*ff/5*3;
        set(h(i),'position',pos);
    end
end

np = get(gcf,'nextplot');
set(gcf,'nextplot','add');
if ishghandle(oldtitle)
    delete(oldtitle);
end
axes('pos',[0 1 1 1],'visible','off','Tag','suptitle');
ht=text(.5,titleypos-1,str);set(ht,'horizontalalignment','center','fontsize',fs);
set(gcf,'nextplot',np);
axes(haold); %#ok<MAXES>
if nargout,
    hout=ht;
end











%% 3D-PLOT FOR FVM-SCAN
%
% Revision History:
%   
%   RevC 04 Oct. 2011  V.Tupikov   - a) Extended list of input parameters
%                                       
%   RevB 28 Sep. 2011  V.Tupikov   - a) used J.Branlard's generateLUT.m as  
%                      J.Branlard       template for contour plot intercept 
%                                       points and inverse LUT generation;
%                                    b) Added interX.m function.
%                                    c) Added placeNaNs.m function.
%
%   RevA 25 Sep. 2011  V.Tupikov   - a) original release (without coutour
%                                       plot intercept points & inverse 
%                                       LUTs).
%                                    
%
%%
%function voidout=fvmScanCalcRevD(fileName,   ...
function fvmScanCalcRevD(fileName,   ...
                         Ncav,       ... % 0-B1,1-C1,..4-C4,5-B2
                         Ncrop,      ... % crops input array (up to 5)
                         Ncontours,  ... % 0 - autocountoring
                         PhiRot,     ... % make a phase rotation (deg)
                         iqFormat,   ... %  0 /1 = AP / IQ
                         ai_min,     ... % output Ampl/I min
                         ai_max,     ... % output Ampl/I max
                         ai_step,    ... % output Qmpl/I step
                         pq_min,     ... % output Phase/Q min
                         pq_max,     ... % output Phase/Q max
                         pq_step     ... % output Phase/Q step                         
                         )
                               

%% DESCRIPTION
%
% fvm2plot function reads the data for selected cavity from file and plots
% it on 3D-format in either I-Q or Amplitude-Phase mode. Each 3D surface 
% plot is going along with plane contour plot with parameterizable lines
% number. To prevent phase wrapping, the input data, coming in I-Q 
% form, can be rotated on specified angle. There is possibility to crop 
% data on specified number of border points. Plotting format can be choosen 
% from either I-Q or Amplitude-Phase options.

  
  %%  G L O B A L    P A R A M E T E R S
  %
  %   To supress status output make enableOutput=false;
  %    

  fvm = fvm_lib;     
  
  
  debugMode    = false;  % in debug mode make sure that 
                         % "function fvmScanCalc" line above
                         % is comented out.
  
 
  
  
  if debugMode  
      
    clear; clc;      
    path = 'data\';
    fileName = 'FVM Scan 2011-09-20 17-19-16b.txt';      
    filename_with_path = [path fileName];  
    Ncav      = 2;   % B1=0,C1=1,..C4=4,B2=5
    Ncrop     = 0;   % peripherial points to crop
    Ncontours = 0;   %
    PhiRot    = 65;  % deg
    iqFormat  = 0;   % AP=0, IQ=1;
    
  else
    path='data\'; 
    filename_with_path = [path fileName];      
  end
  
  mDataIn = load(filename_with_path);
  
  
  
  enableOutput = true;  
      
  if enableOutput
    clc;  
    fprintf('\n   FVM Scan-data Processing Start...\n\n');
  end;
  
  close; close; close; close; close; close; % Close all Plot windows



    
 % which intersection point to keep FIRST, LAST, LOW
 FIRST=1;
 LAST =2;
 LOW  =3;
 retainSol=LOW;
 

  % Select the plots to display
  figID = 0;
  plotSource    = 1;
  plotFiltered  = 1;
  plotContour   = 1;
  %plotXslice=0;
  plotCH1CH2=1;
  plotCH1CH2contour=1;
  plotIntersect = 1;  % BE CAREFUL. EXTENDS CALC TIME WHEN = 1 !!!!
  plotCH1CH2array=1;
  
  plotCH1CH2clampedArray=1; 
  
  % Specify plot windows' sizes and screen positions
  X0 = 50;      Y0 = 100;      % pixels
  winWidth=800; winHight=600;  % pixels
  
  pos1 = [   0*X0,  0*Y0,  winWidth, winHight];
  pos2 = [   1*X0,  1*Y0,   winWidth, winHight];
  pos3 = [   2*X0,  2*Y0,   winWidth, winHight];
  pos4 = [   3*X0,  3*Y0,   winWidth, winHight];
  pos5 = [   4*X0,  4*Y0,   winWidth, winHight];
  pos6 = [   5*X0,  5*Y0,   winWidth, winHight];
  
%% #######################################################################
%
%  1)  C R E A T E   P L O T - C A P T U R E S 
%
%  #######################################################################
       
    switch Ncav
        case 0    
            cavName = 'Buncher1';
        case 1
            cavName = 'Cavity1';
        case 2
            cavName = 'Cavity2';
        case 3
            cavName = 'Cavity3';
        case 4
            cavName = 'Cavity4';
        case 5
            cavName = 'Buncher2';
        otherwise
            cavName = 'NoName';
    end;      
  
  
%% #######################################################################
%
%  2)  R E A D   D A T A  
%
%  #######################################################################
 
  if enableOutput
    fprintf('   Reading \"%s\" data from \"%s\" file\n',cavName,fileName);
  end;
  
%  -----------------------------------------------------------------------  
%  2.1)  S E R I A L I Z E D   D A T A   P A C K I N G   R E F E R E N C E
%
% Data Read from Reference File 'Reference_Template.txt'
%    ==============================
%     va    vb      i        q    
%    ------------------------------
%     11    21     1121     11210
%     12    21     1221     12210
%     13    21     1321     13210                      Thus is 
%     11    22     1122     11220         N = 3        an example
%     12    22     1222     12220                      for reference
%     13    22     1322     13220                      only
%     11    23     1123     11230
%     12    23     1223     12230
%     13    23     1323     13230       
%   ===============================
%
%  -----------------------------------------------------------------------  
%  2.2)  S E L E C T   C A V I T Y   C H A N N E L 

    va = mDataIn(:,3+4*Ncav);  vb = mDataIn(:,4+4*Ncav);
     i = mDataIn(:,5+4*Ncav);   q = mDataIn(:,6+4*Ncav);
     N = sqrt(length(va));  % axes length ( N^2 is data length )


%% #######################################################################
%
%   3)  D E S E R I A L I Z E R: Transform 1D data arrays into Matrices
%
%  #######################################################################

    % preallocate space to shorten loop time    
    xx=zeros(1,N-2*Ncrop); yy=xx; I=zeros(N-2*Ncrop,N-2*Ncrop); Q=I; 
    
    if N < (2*Ncrop) 
        N = 2*Ncrop;
    end;
 
    NN = N-2*Ncrop;
    
  if enableOutput    
    fprintf('   Converting serialized file\"s data (%s-1D array) into %dx%d Matrix\n',cavName,(N-2*Ncrop),(N-2*Ncrop));
  end;
    
    %for k=1:N-2*Ncrop
    for k=1:NN
        
         xx(k) = va(k+Ncrop);                %   xx = 1  2  3 
         yy(k) = vb((k+Ncrop)*N);            %   yy = 1  2  3 

%    ------------------------------------------------------------------                    
%    3.1 Crop data if needed 

              %for n=1:N-2*Ncrop
              for n=1:NN
                  switch Ncrop
                      case 0
                        I(k,n) = i(n+Ncrop+(k-1)*N);
                        Q(k,n) = q(n+Ncrop+(k-1)*N);
                      case 1
                        I(k,n) = i(n+Ncrop+k*N);
                        Q(k,n) = q(n+Ncrop+k*N);    
                      case 2                      
                        I(k,n) = i(n+Ncrop+(k+1)*N);
                        Q(k,n) = q(n+Ncrop+(k+1)*N);
                      case 3
                        I(k,n) = i(n+Ncrop+(k+2)*N);
                        Q(k,n) = q(n+Ncrop+(k+2)*N);
                      case 4                      
                        I(k,n) = i(n+Ncrop+(k+3)*N);
                        Q(k,n) = q(n+Ncrop+(k+3)*N);
                      otherwise                       
                        I(k,n) = i(n+Ncrop+(k+4)*N);
                        Q(k,n) = q(n+Ncrop+(k+4)*N);                        
                  end;
               
              end;
              
    end;     
%   ------------------------------------------------
%    3.2  M E S H G R I D (DESERIALIZED DATA)
% ==================================================
%
  if enableOutput
    fprintf('   Creating Va-. Vb- meashgrids\n');
  end;
    
    [Va,Vb] = meshgrid(xx,yy);        
% --------------------------------------------------  
%        11  12  13             21  21  21
%   Va = 11  12  13        Vb = 22  22  22             This is an example
%        11  12  13             23  23  23
% ==================================================
%        1121 1221 1321         11210 12210 13210
%   I =  1122 1222 1322     Q = 11220 12220 13220      This is an example
%        1123 1223 1323         11230 12230 13230
% ==================================================
%    

%% #######################################################################
%
%  4)  R O T A T E    D A T A  
%
%  #######################################################################

  if enableOutput
    fprintf('   Rotating data by %3.2f degrees\n',PhiRot);
  end;
    
    Rotation = cos(PhiRot*pi/180)+1i*sin(PhiRot*pi/180);
   
    C = I +1i*Q;  % complex array simplifyes magnitude & phase processing
    C = C*Rotation;

    
%% #######################################################################
%
%  5)  S E L E C T   P L O T - F O R M A T  ( I-Q  or  A-PHI )
%
%  #######################################################################
    
    if iqFormat              % comes as an input parameter
        AI = real(C);             % I
        PQ = imag(C);             % Q        
        zlabx  = 'I (Unit)';    zlaby  = 'Q (Unit)';        
        zlabxc = 'I Contours (Not normalized)';  zlabyc = 'Q Contours (Not normalized)';
        zlabxyc= 'I and Q Contours (Not normalized)';
        if enableOutput        
            fprintf('   Plotting  I(Va,Vb) and Q(Va,Vb)\n');
        end;
    else
        AI = abs(C);             % M A G N I T U D E
        PQ = angle(C)*180/pi;    % P H A S E
        zlabx  = 'Amplitude (KW)';          zlaby  = 'Phase (Deg)'; 
        zlabxc = 'Amplitude Contours (KW)'; zlabyc = 'Phase Contours (Deg)';
        zlabxyc= 'Amplitude (KW) & Phase (Deg) Contours';
        if enableOutput
            fprintf('   Plotting Amplitude(Va,Vb) and Phase(Va,Vb)\n');
        end;
    end;

     
    

%% #######################################################################
%
%  6)  S O U R C E - D A T A   P L O T T I N G  
%
%  #######################################################################
  if plotSource
    
   figID = figID + 1; figure(figID); set(figID,'OuterPosition',pos1);
      
   % 3-D   P L O T S ---------------------------------------------------
   subplot(2,2,1); meshc(Va,Vb,AI);
    xlabel('Va (V)'); ylabel('Vb (V)'); zlabel(zlabx);
    colorbar('vertical');   

   subplot(2,2,2); meshc(Va,Vb,PQ);
    xlabel('Va (V)'); ylabel('Vb (V)'); zlabel(zlaby); 
    colorbar('vertical');   
    
    % C O N T O U R S --------------------------------------------------
    if Ncontours==0 
        subplot(2,2,3); [C,h] = contour(Va,Vb,AI); clabel(C,h); 
        xlabel('Va (V)'); ylabel('Vb (V)'); title(zlabxc);

        subplot(2,2,4); [C,h] = contour(Va,Vb,PQ); clabel(C,h); 
        xlabel('Va (V)'); ylabel('Vb (V)'); title(zlabyc);
    else
        subplot(2,2,3); [C,h] = contour(Va,Vb,AI,Ncontours); clabel(C,h); 
        xlabel('Va (V)'); ylabel('Vb (V)'); title(zlabxc);

        subplot(2,2,4); [C,h] = contour(Va,Vb,PQ,Ncontours); clabel(C,h); 
        xlabel('Va (V)'); ylabel('Vb (V)'); title(zlabyc);
    end;
   
    % F I G U R E    T I T L E  -----------------------------------------
    plotModeLabel = [cavName,' from "',fileName,'" (',num2str(NN),'x',num2str(NN),' SOURCE DATA)']; 
    fvm.suptitle(plotModeLabel);   
    
  end;

%% #######################################################################
%
%  8)  D A T A   F I L T E R I N G  
%      http://www.mathworks.com/help/techdoc/creating_plots/f10-2524.html
%
%      If the surface you are contouring is "noisy," contours depicting 
%      the surface exhibit jaggedness. When you analyze and explore such 
%      data, you can filter it to attentuate high-frequency variations. 
%      One way to do this is with a convolution (with conv2 or filter2)
%      filter, as the following example demonstrates:
%
%  #######################################################################

  
  if enableOutput
        fprintf('   Filtering data\n');
  end;

  
   %  Specify a 3-by-3 convolution kernal, F, for smoothing the matrix and 
   %  use the conv2 function to attenuate high spatial frequencies in the 
   %  surface data:

   % F i l t e r i n g --------------------------------------------------
    F = [.05 .1 .05; .1 .4 .1; .05 .1 .05];
    AIF = conv2(AI,F,'same');   % Amplitude-I filtering 
    PQF = conv2(PQ,F,'same');   % Phase-Q     filtering 
    
    % crop data to remove edge destortion after filtering ---------------
    
    N_crop_pts=1;
    
    if enableOutput
        fprintf('   Cropping data by %d point(s) \n',N_crop_pts);
    end;
    
    
    AIF = fvm.crop2D(AIF,N_crop_pts,N_crop_pts,N_crop_pts,N_crop_pts);
    PQF = fvm.crop2D(PQF,N_crop_pts,N_crop_pts,N_crop_pts,N_crop_pts);
    Va  = fvm.crop2D(Va, N_crop_pts,N_crop_pts,N_crop_pts,N_crop_pts);
    Vb  = fvm.crop2D(Vb, N_crop_pts,N_crop_pts,N_crop_pts,N_crop_pts);
    
    NN = N-2*2;
        

if plotFiltered

  % Selecting a handle and position for n e w   f i g u r e ------------
  figID = figID + 1; figure(figID); set(figID,'OuterPosition',pos2);
      
   % 3-D   P L O T S ---------------------------------------------------
   subplot(2,2,1); meshc(Va,Vb,AIF);
    xlabel('Va (V)'); ylabel('Vb (V)'); zlabel(zlabx);
    colorbar('vertical');   

   subplot(2,2,2); meshc(Va,Vb,PQF);
    xlabel('Va (V)'); ylabel('Vb (V)'); zlabel(zlaby); 
    colorbar('vertical');   
    
    % C O N T O U R S --------------------------------------------------      
        
    if Ncontours==0 
        subplot(2,2,3); [C,h] = contour(Va,Vb,AIF); clabel(C,h); 
        xlabel('Va (V)'); ylabel('Vb (V)'); title(zlabxc);

        subplot(2,2,4); [C,h] = contour(Va,Vb,PQF); clabel(C,h); 
        xlabel('Va (V)'); ylabel('Vb (V)'); title(zlabyc);
    else
        subplot(2,2,3); [C,h] = contour(Va,Vb,AIF,Ncontours); clabel(C,h); 
        xlabel('Va (V)'); ylabel('Vb (V)'); title(zlabxc);

        subplot(2,2,4); [C,h] = contour(Va,Vb,PQF,Ncontours); clabel(C,h); 
        xlabel('Va (V)'); ylabel('Vb (V)'); title(zlabyc);
    end;
        
        
    % F I G U R E    T I T L E  -----------------------------------------
    plotModeLabel = [cavName,' from "',fileName,'" ( ',num2str(NN),'x',num2str(NN),' FILTERED DATA)']; 
    fvm.suptitle(plotModeLabel);   

end;
         
    


%% #######################################################################
%
%  9)  C O N T O U R   P L O T S 
%      
%  #######################################################################

  if enableOutput
        fprintf('   Plotting Combined Amplitude and Phase contours\n');
  end;

  
 
  iso_ampl = ai_min:ai_step:ai_max;
  iso_phas = pq_min:pq_step:pq_max;  
    
  row_NB = numel(iso_phas);  
  col_NB = numel(iso_ampl);  
  
  
  
    % C O N T O U R S --------------------------------------------------      
 if plotContour

    % Selecting a handle and position for n e w   f i g u r e ------------ 
    figID = figID + 1; figure(figID); clf(figID); 
    set(figID,'OuterPosition',pos3); 
  
    hold on; 
    box on; 
    grid on;
        
    [C h]=contour(Va,Vb,AIF,[iso_ampl iso_ampl],'Color','b');
          clabel(C,h,'FontSize',8,'LabelSpacing',400,'Color','b');
    
    [Cc hh]=contour(Va,Vb,PQF,[iso_phas iso_phas],'Color','r');
          clabel(Cc,hh,'FontSize',8,'LabelSpacing',400,'Color','r');                
        

   % --------------------------------------------------------------------
        
    xlabel('Va (V)'); ylabel('Vb (V)'); title(zlabxyc);
   
    % F I G U R E    T I T L E  -----------------------------------------
    plotModeLabel = [cavName,' from "',fileName,'" ( NAI=',num2str(col_NB),' NPQ=',num2str(row_NB),' CONTOURS)'];
    fvm.suptitle(plotModeLabel);   
             
    
 end;
    
 
%% #######################################################################
%
% 10)  I N T E R S E C T I O N   P O I N S  
%      
%  #######################################################################
    
if plotIntersect
    
  if enableOutput
        fprintf('   Finding LUT-Solution: amplitude and phase contours (isoliness) intersection points.\n');
  end;
    
    % Calculate ---------------------------------------------------------
    
    ampl_jj=ai_min:ai_step:ai_max;
    phas_ii=pq_min:pq_step:pq_max;

    rowNB=numel(phas_ii);
    colNB=numel(ampl_jj);    
    
    CH1array=zeros(rowNB,colNB);
    CH2array=zeros(rowNB,colNB);
    
    CH1arrayNaN=zeros(rowNB,colNB);
    CH2arrayNaN=zeros(rowNB,colNB);

    hold on
    box on
    grid on
    
    
    for jj=1:colNB
        for ii=1:rowNB
          
            ampl=ai_min+(jj-1)*ai_step; 
            phas=pq_min+(ii-1)*pq_step;
            
            %phas=phas*pi/180;            
            % compute the contour matrix with iso-ampl and iso-phas elements
            C_A = contourc(Va(1,:),Vb(:,1),AIF,[ampl ampl]);
            C_P = contourc(Va(1,:),Vb(:,1),PQF,[phas phas]);          
            
            
            % format the matrices C_A and C_P to be used by InterX.m (i.e.,
            % replace values and number of points by nan)
            C_A_sol=fvm.placeNaNs(C_A);
            C_P_sol=fvm.placeNaNs(C_P);
            % can't find an intersection with less than 2 points
            if numel(C_A_sol)<=2 || numel(C_P_sol)<=2
                %fprintf('  Cant find an intersection with less than 2 points\n');
            else
                C_sol=fvm.InterX(C_A_sol,C_P_sol); 
            end
            
            % retain first solution only
            if retainSol==FIRST
                if isempty(C_sol)
                else
                    CH1array(ii,jj)=C_sol(1);
                    CH2array(ii,jj)=C_sol(2);
                end
            elseif retainSol==LAST
                if isempty(C_sol)
                else
                    Nsol=numel(C_sol)/2;
                    CH1array(ii,jj)=C_sol(1,Nsol);
                    CH2array(ii,jj)=C_sol(2,Nsol);
                end
            elseif retainSol==LOW
                if isempty(C_sol)
                else
                    Nsol=numel(C_sol)/2;
                    if C_sol(1,Nsol)>=C_sol(2,Nsol)
                        CH1array(ii,jj)=C_sol(1,Nsol);
                        CH2array(ii,jj)=C_sol(2,Nsol);
                    end
                end
            end                        
          
        end
    end
 
    
  % Generating Output File --------------------------------------------

  %fileNameLUT = [cavName 'LUT.txt'];
    
  if enableOutput
        fprintf('   Generating output LUT-File \"%s_VaVb_LUT.txt\"\n',cavName);
        %fprintf('   Generating Output LUT-File %s\n',fileNameLUT);
  end;

  

% ### Julien's file output START
    %fID=fopen('ch12LUT.txt','w');
    %for ii=1:rowNB
    %    for jj=1:colNB
    %        fprintf(fID,'(%1.1f , %1.1f)\t',CH1array(ii,jj),CH2array(ii,jj));
    %    end
    %    fprintf(fID,'\n');
    %end
    %fclose(fID);
% ### Julien's file output END   




left_flag     = false;
bottom_border = rowNB;
right_border  = colNB;
right_flag    = false;
top_flag      = false;
top_border    = 0;


% Create array for the output file with NaNs for no-solution nodes.
    % Calculate left bottom conner for existed solution
    for jj=1:colNB        
        for ii=1:rowNB
           
          if (CH1array(ii,jj) == 0 ) 
              CH1arrayNaN(ii,jj) = nan;
          else
              CH1arrayNaN(ii,jj) = CH1array(ii,jj);
          end;
          
          if (CH2array(ii,jj) == 0 ) 
              CH2arrayNaN(ii,jj) = nan;
          else
              CH2arrayNaN(ii,jj) = CH2array(ii,jj);               
              
                if (left_flag == false)
                        left_border   = jj;  left_flag = true;
                elseif (ii < bottom_border) 
                        bottom_border = ii;
                end;                                                         
          end;           
          
       end;                    
    end;
    
     

    % Calculate right border for existed solution
    for jj=colNB:-1:left_border;
        for ii=bottom_border:rowNB;
            
            if ( (CH1array(ii,jj) > 0 )&&(~right_flag) ) % 0 means NaN
                %fprintf('\n %d %d %d\n',ii,jj,CH1array(ii,jj));
                right_flag = true;
                right_border=jj;                
                break;
            else
                
            end;                      
        end;
        
        if (right_flag)
              break;
        end;
        
    end;
    
      

    % Calculate top border for existed solution
    for ii=rowNB:-1:bottom_border;
       for jj=left_border:right_border;

            
            if ( (CH1array(ii,jj) > 0 )&&(~top_flag) ) % 0 means NaN
                %fprintf('\n %d %d %d\n',ii,jj,CH1array(ii,jj));
                top_flag = true;
                top_border=ii;                
                break;
            else
                
            end;                      
        end;
        
        if (top_flag)
              break;
        end;
        
    end;
    
            
                
    % account for disregarded left/bottom offset 
    %right_border = right_border + left_border;
    %top_border   = top_border   + bottom_border;
    
   
     for jj=left_border:right_border        
        for ii=bottom_border:top_border
           
          if (CH1array(ii,jj) == 0 ) 
              CH1arrayOneNaN(ii-bottom_border+1,jj-left_border+1) = nan;
          else
              CH1arrayOneNaN(ii-bottom_border+1,jj-left_border+1) = CH1array(ii,jj);
          end;
          
          if (CH2array(ii,jj) == 0 ) 
              CH2arrayOneNaN(ii-bottom_border+1,jj-left_border+1) = nan;
          else
              CH2arrayOneNaN(ii-bottom_border+1,jj-left_border+1) = CH2array(ii,jj);                                                                  
          end;           
          
       end;                    
    end;
 
    lut_size=size(CH1arrayOneNaN);
    lut_length = lut_size(1);
    lut_width  = lut_size(2);
    
    for jj=1:lut_width+2  % "+1" is required to compensate for two NaN columns
        nanRow(jj) = nan;
    end;
    
    for jj=1:lut_length
        nanCol(jj) = nan;
    end;
       

    %fprintf('\nORIGINAL   colNB  = %f;   rowNB = %f;\n\n',colNB,rowNB);
    
    %fprintf('left_border   = %f;\n',   left_border);    
    %fprintf('right_border  = %f;\n',   right_border);
    %fprintf('bottom_border = %f;\n',   bottom_border);
    %fprintf('top_border    = %f \n\n', top_border);
    %fprintf('lut_length    = %f \n',   lut_length);    
    %fprintf('lut_width     = %f \n\n', lut_width);    
     
       
%save CH1array        CH1array       -ascii -tabs;   
%save CH1arrayNaN     CH1arrayNaN    -ascii -tabs;   
%save CH1arrayOneNaN  CH1arrayOneNaN -ascii -tabs;



    for jj = 1:(right_border-left_border)+1
        ampl_jjj(jj) = ampl_jj(jj+left_border-1);
    end;
    
    amplRow_w = [0 (2*ampl_jjj(1)-ampl_jjj(2)) ampl_jjj (2*ampl_jjj(right_border-left_border+1)-ampl_jjj(right_border-left_border))]; % stuffed with aligning zero and ampl(0) compensating for NaN column
  
%    conversion_from_KW_2_ATEN = max(amplRow_w);    
%    disp(conversion_from_KW_2_ATEN);    
    
   % aligning phase request to zero
   phas_ii = phas_ii + 55.0;
 
    for ii = 1:(top_border-bottom_border)+1
        phas_iii(ii) = phas_ii(ii+bottom_border-1);
        nan_iii(ii)  = nan;
    end;

    nanCol_extendedA = [phas_iii' nan_iii'];
    nanCol_extendedB = [nan_iii'];    
    
  % xxx DEBIG 
  %fprintf('size(ampl_jj)        = %f; \n',size(ampl_jj));
  %fprintf('size(phas_ii)        = %f; \n',size(phas_ii));  
  %fprintf('size(ampl_jjj)       = %f; \n',size(ampl_jjj));
  %fprintf('size(phas_iii)       = %f; \n',size(phas_iii));
  %fprintf('size(CH1arrayOneNaN) = %f; \n',size(CH1arrayOneNaN));
    


   
   % attach phase column in front of Va-solution-aaray
    PhasColumn_ww_VaArray = [nanCol_extendedA CH1arrayOneNaN nanCol_extendedB]; % "'" - means column
    
   
   % attach phase column in front of Vb-solution-aaray
    PhasColumn_ww_VbArray = [nanCol_extendedA CH2arrayOneNaN nanCol_extendedB]; % "'" - means column

    nanRow_extendedA = [(2*phas_iii(1)-phas_iii(2)) nanRow];
    nanRow_extendedB = [(2*phas_iii((top_border-bottom_border)+1)-phas_iii((top_border-bottom_border))) nanRow];
   

     
  save VaVb_LUT.txt amplRow_w              -ascii -tabs;         % Amplitude row
  save VaVb_LUT.txt nanRow_extendedA       -ascii -tabs -append; % NaN row extended with Phase in 1st column for 1st row
  save VaVb_LUT.txt PhasColumn_ww_VaArray  -ascii -tabs -append; % Phase Column + Va Array
  save VaVb_LUT.txt nanRow_extendedB       -ascii -tabs -append; % NaN row extended with Phase in 1st column for last eow
  
  save VaVb_LUT.txt amplRow_w              -ascii -tabs -append; % Amplitude row (separator)
  save VaVb_LUT.txt nanRow_extendedA       -ascii -tabs -append; % NaN row extended with Phase in 1st column for 1st row  
  save VaVb_LUT.txt PhasColumn_ww_VbArray  -ascii -tabs -append; % Phase Column + Vb Array  
  save VaVb_LUT.txt nanRow_extendedB       -ascii -tabs -append; % NaN row extended with Phase in 1st column for last eow
   
   
   
   
   %-----------------------------------------------------------------
   % Output LUT File Format
   % 
   % Line#
   %   1     0     Amp_1   Amp_2    ....    Amp_N
   %   1a  Phas_0   NaN     NaN     ....     NaN    NaN
   %   2   Phas_1  Va_11   Va_12    ....    Va_1N   NaN
   %   3   Phas_2  Va_21   Va_22    ....    Va_2N   Nan
   %            .............................
   % M+1   Phas_M  Va_M1   Va_M2    ....    Va_MN   NaN
   % M+2     0     Amp_1   Amp_2    ....    Amp_N   NaN
   % M+2a  Phas_0   NaN     NaN     ....     NaN    NaN   
   % M+3   Phas_1  Vb_11   Vb_12    ....    Vb_1N   NaN
   % M+4   Phas_2  Vb_21   Vb_22    ....    Vb_2N   NaN
   %            .............................
   % 2M+2  Phas_M  Vb_M1   Vb_M2    ....    Vb_MN   NaN
   % 2M+2a Phas_Ma  NaN     NaN     ....     NaN    NaN
   %
   %


   
  switch Ncav
      case 0
        movefile VaVb_LUT.txt Buncher1_VaVb_LUT.txt
      case 1
        movefile VaVb_LUT.txt Cavity1_VaVb_LUT.txt
      case 2
        movefile VaVb_LUT.txt Cavity2_VaVb_LUT.txt
      case 3
        movefile VaVb_LUT.txt Cavity3_VaVb_LUT.txt
      case 4
        movefile VaVb_LUT.txt Cavity4_VaVb_LUT.txt
      case 5
        movefile VaVb_LUT.txt Buncher2_VaVb_LUT.txt                       
      otherwise
            cavName = 'NoName';          
  end;
  
   
  
  % Plot --------------------------------------------------------------
            
  if enableOutput
        fprintf('   Plotting intersection points on combined Amp-Phi contour plot\n');
  end;
    
    
    for ii=1:rowNB
        for jj=1:colNB
            CH1=CH1array(ii,jj);
            CH2=CH2array(ii,jj);
            if (CH1 && CH2)
                plot(CH1,CH2,'+k','LineWidth',1,'MarkerSize',10);
            end
        end
    end
    hold off

end


 
%% ####################################################################### 
%
%  11)  I N V E R S E D   P L O T :   Va(AI,PQ) & Vb(Ai,PQ)
%
%  #######################################################################
 
 if plotCH1CH2

  if enableOutput
        fprintf('   Plotting Inversed Va and Vb\n',cavName);
  end;
     
     
   figID = figID + 1; figure(figID); set(figID,'OuterPosition',pos4); clf(figID);
   
    % 3-D   P L O T S ---------------------------------------------------
   subplot(2,1,1); 
   meshc(AIF,PQF,Va); 
    xlabel(zlabx);
    ylabel(zlaby);
    zlabel('Va [V]');
    %title(' === Va ===');   
    %colorbar('vertical');          

   subplot(2,1,2);
   meshc(AIF,PQF,Vb);
    xlabel(zlabx);
    ylabel(zlaby);
    zlabel('Vb [V]');
    %title(' === Vb ===');   
    %colorbar('vertical');  
    
    % F I G U R E    T I T L E  -----------------------------------------
    plotModeLabel = [cavName,' from "',fileName,'" ( ',num2str(NN),'x',num2str(NN),' INVERSED PLOT)']; 
    fvm.suptitle(plotModeLabel);   

    
 end;
 

%% ####################################################################### 
%
%  12)  Va  &  Vb   L U T    P L O T :   Va(AI,PQ) & Vb(Ai,PQ)
%
%  #######################################################################
 
 
if plotCH1CH2array

  if enableOutput
        fprintf('   Plotting Solutions\n',cavName);
  end;
    
    
   figID = figID + 1; figure(figID); set(figID,'OuterPosition',pos5); clf(figID);

    [mesh_A mesh_Phi]=meshgrid(ampl_jjj,phas_iii);
    
    subplot(2,1,1)
    %mesh(mesh_A,mesh_Phi,CH1arrayNaN)
    mesh(mesh_A,mesh_Phi,CH1arrayOneNaN)    
    xlabel('Amplitude   [KW]');
    ylabel('Phase   [deg]');
    zlabel('Va [V]');

    subplot(2,1,2)
    mesh(mesh_A,mesh_Phi,CH2arrayOneNaN)
    xlabel('Amplitude   [KW]');
    ylabel('Phase   [deg]');
    zlabel('Vb [V]');
    
    % F I G U R E    T I T L E  -----------------------------------------
    plotModeLabel = [cavName,' from "',fileName,'" ( ',num2str(length(ampl_jj)),'x',num2str(length(phas_ii)),' Va/Vb LUT PLOT)'];
    fvm.suptitle(plotModeLabel);   
    
    
end 
 



%% #######################################################################
%
%  99)  D A T A   I N T E R P O L A T I O N 
%      http://www.mathworks.com/help/techdoc/ref/interp2.html
%  #######################################################################

  %if enableOutput
  %      fprintf('   Interpolating (Increasing mesh resolution)\n');
  %end;

%figure(2)


 
%% #######################################################################
%
%  100)  R E A R A N G I N G   F I G U R E   O R D E R S  O N  S C R E E N
%     
%  #######################################################################

  while figID
  
      figure(figID);
      figID = figID-1;
      
  end;
  
  
    if enableOutput
        fprintf('\n   FVM Scan-data Processing is done \n\n');
    end;


  %voidout = [left_border bottom_border right_border top_border];
%  voidout = [AI PQ];
  
% C R O P P I N G   by Magnitude threshold ( NOT USED )
%Xthreshold = 0.3;
%X = X.*heaviside(X - Xthreshold);    % HEAVISIDE(a)=0(1) for a<0(A>0)

% CUBIC SPLINE:
% Applied Numerical Methods Using MATLAB - Yang Cao Chung p133


%%
% REFERENCES
%
% 1) Essential MATLAB for Engineers and Scientists, 3rd 2007, 
%      "Importing and exporting data" p.110;
%      "Cropping a surface with NaNs" p.187;
% 2) Graphics and GUI with MATLAB, 3d Ed., � 2003 by Chapman & Hall/CRC;
%      "Meash" p.117+,
%      "Contour Plot and its property manululations" p.128+   
%
%
% APPENDIX A. MAPPING ONE PLANE TO ANOTHER
%
% /\ Vb                            /\ Q
% |   ___________      each point  | 
% |  |///////////|  on Va-Vb plane |      ________
% |  |//.(Va,Vb)/|  is mapped to a |     /////////\
% |  |///////////| <-------------> |    //.(i,q)///\
% |  |///////////|   point on I-Q  |   ////////////
% |  |///////////|     plane       |  /////////
% |                                |  |////
% |-------------------> Va         |-----------------------> I
%
% If there is a transform F which maps point (Va,Vb) on Va-Vb plane to a
% point (I,Q) on I-Q plane, then there is an inverse transform invF which   
% makes opposite mapping - point (I,Q) on I-Q plane to point (Va,Vb) on 
% Va-Vb plane.
%
% Instead of finding analitical F and invF transforms we'll use LUT table.
% Indeed, after FVM measurement-characterization we'll have one-to-one
% transform in between two planes Va-Vb & I-Q (though on limited area).
% More precise measurement which would provide more accurate LUT table 
% is time consuming. If we would allocate 1 hour for characterization
% measurements, at 2Hz of rf repeatition rate we would end up with 
% 3600 points (i.e. 60-by-60 plane area). 4-hours of measurements would
% double the resolution to 120-by-120. To acheave 1000-by-1000 resolution,
% we would require to spend 1000000 Msec or 278 hours on 1 cavity 
% measurement.
%
%
%  APPENDIX B. INVERSE MAPPING ( (A,PHI)-->(I,Q) ) --> (Va,Vb)
%
%  First verification of the inverse mapping from (A,PHI) request 
%  to DAC's (Va,Vb) outputs can be done in LabView. 
%
%  1) After FVM measurements each channel is characterized by
%     one-to-one mapping LUT (A,PHI) <--> (I,Q). The dynamic 
%     range of transform is limited by (A0+/-dA,PHI0+/-dPHI) or in
%     I-Q domain by (I0-+/-dI, Q0+/-dQ).
%
%  2) Transform operator's request for selected FVM channel in a form of 
%     (Ar,PHIr) into (Ir,Qr) request.
%
%  3) Approximate requested (Ir,Qr) to closest (I,Q) from the LUT (1).
%
%  4) For (I,Q) find corresponding (Va,Vb) pair in the LUT.
%
%  5) Program selected FVM channel DACs with new settings (Va,Vb).
%
%  NOTE: keep 6 FVM channels LUTs in external files. Load the LUTs 
%        from files into VI's memory on program start-up.
%
% APPENDIX D. SOME LABVIEW USEFUL VIs
%
%  a) Example\Fundamentals\Arrays and Clusters\Using Spreadsheet Format.vi
%  b) Example\Fundamentals\Files Inputs and Outputs\Read frm Text File.vi
%  c) Example\Fundamentals\Strings\Array to Cluster.vi
%
%
%
% APPENDIX C. SOME USEFUL MATLAB MACROS:
%
% A) N=40;i=0:N^2-1;j=0:N^2-1; x=uint16(i/N-0.5); y=mod(j,N); [i' x' y']
% B) N=3; M=N; i=0:(N^2-1); x=floor(i/N); j=0:(M^2-1); y=mod(j,M); z=4.0*i; [x' y' z']
% C) N=3; M=N; i=0:(N^2-1); x=floor(i/N); j=0:(M^2-1); y=mod(j,M); z=4.0*i; mDATA=[x', y', z']; save FileName mDATA -ascii;
% D) mDataIn = load('FileName');
% E) Z = sin(2*Va/Vmax*pi).*cos(0.5*Vb/Vmax*pi);
%






%% #######################################################################
%
%  101)  D A T A   P R O C E S S I N G   A N D   S T O R A G E 
%
%  GUIDANCE:
%
%  The suite simplifies processing of large amount of raw data  with its 
%  subsequent storage. There is no need to keep all of output plots and
%  LUT files separately. Instead, make a copy of the function call with 
%  fine-tuned input parameters (file name, channel number, etc..) in the 
%  dedicated area below. When you'll need to revisit the result, paste
%  the line back to Matlab's command line and execute.
%
%  #######################################################################

%% ======================================================================
% Coerse FVM1/2 scans vs FVM Trigger Time  (B1/C1)
%------------------------------------------------------------------------
% "FVM Trig: H:LRFT1D = 6.5 ms;   LLRF Trig: H:LRFT2D = 9.5 ms;"
% 
% >>fvmScanCalc('data\FVM Scan 2011-09-23 12-50-02.txt',0,4,0,45,0) BAD
% >>fvmScanCalc('data\FVM Scan 2011-09-23 12-50-02.txt',1,4,0,45,0) BAD
%-----------------------------------------------------------------------
% "FVM Trig: H:LRFT1D = 6.0 ms;   LLRF Trig: H:LRFT2D = 9.5 ms;"
% 
% fvm=fvm_lib; fvm.fvmScanCalcRevD('FVM Scan 2011-09-23 13-06-06a.txt',0,0,0, 30,0,1.2,4.0,0.1,-80,10,5)
% fvm=fvm_lib; fvm.fvmScanCalcRevD('FVM Scan 2011-09-23 13-06-06a.txt',1,0,0,-35,0,0.6,1.8,0.1,-90, 0,5)
%-----------------------------------------------------------------------
% "FVM Trig: H:LRFT1D = 7.0 ms;   LLRF Trig: H:LRFT2D = 9.5 ms;"
% 
% fvm=fvm_lib; fvm.fvmScanCalcRevD('FVM Scan 2011-09-23 13-21-27a.txt',0,0,0, 30,0,1.2,4.0,0.1,-80,10,5)
% fvm=fvm_lib; fvm.fvmScanCalcRevD('FVM Scan 2011-09-23 13-21-27a.txt',1,0,0,-35,0,0.6,1.8,0.1,-90, 0,5)
%-----------------------------------------------------------------------


% fvm=fvm_lib; fvm.fvmScanCalcRevD('FVM Scan 2011-09-20 17-19-16b.txt',2,0,0,65,0,0.8,2.6,0.1,-120,-20,5)
% fvm=fvm_lib; fvm.fvmScanCalcRevD('FVM Scan 2011-09-20 17-19-16b.txt',3,0,0,-55,0,0.8,3.6,0.1,-140,-20,5)


%========================================================================


