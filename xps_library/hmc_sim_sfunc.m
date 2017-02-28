function hmc_sim_sfunc(block)
%MSFUNTMPL_BASIC A Template for a Level-2 MATLAB S-Function
%   The MATLAB S-function is written as a MATLAB function with the
%   same name as the S-function. Replace 'msfuntmpl_basic' with the 
%   name of your S-function.
%
%   It should be noted that the MATLAB S-function is very similar
%   to Level-2 C-Mex S-functions. You should be able to get more
%   information for each of the block methods by referring to the
%   documentation for C-Mex S-functions.
%
%   Copyright 2003-2010 The MathWorks, Inc.

%%
%% The setup method is used to set up the basic attributes of the
%% S-function such as ports, parameters, etc. Do not add any other
%% calls to the main body of the function.
%%
setup(block);

%endfunction

%% Function: setup ===================================================
%% Abstract:
%%   Set up the basic characteristics of the S-function block such as:
%%   - Input ports
%%   - Output ports
%%   - Dialog parameters
%%   - Options
%%
%%   Required         : Yes
%%   C-Mex counterpart: mdlInitializeSizes
%%
function setup(block)

% Register number of ports
block.NumInputPorts  = 6;
block.NumOutputPorts = 3;

% Setup port properties to be inherited or dynamic
block.SetPreCompInpPortInfoToDynamic;
block.SetPreCompOutPortInfoToDynamic;

% Override input port properties
% read-enable
block.InputPort(1).Dimensions = 1;
block.InputPort(1).DatatypeID = 8;  % boolean
block.InputPort(1).Complexity = 'Real';
block.InputPort(1).DirectFeedthrough = true;

% write-enable
block.InputPort(2).Dimensions = 1;
block.InputPort(2).DatatypeID = 8;  % boolean
block.InputPort(2).Complexity = 'Real';
block.InputPort(2).DirectFeedthrough = true;

% write address
block.InputPort(3).Dimensions = 1;
block.InputPort(3).DatatypeID = 1;  % single
block.InputPort(3).Complexity = 'Real';
block.InputPort(3).DirectFeedthrough = true;

% data
block.InputPort(4).Dimensions = 1;
block.InputPort(4).DatatypeID = 0;  % double
block.InputPort(4).Complexity = 'Real';
block.InputPort(4).DirectFeedthrough = true;

% read address
block.InputPort(5).Dimensions = 1;
block.InputPort(5).DatatypeID = 1;  % single
block.InputPort(5).Complexity = 'Real';
block.InputPort(5).DirectFeedthrough = true;

% read tag
block.InputPort(6).Dimensions = 1;
block.InputPort(6).DatatypeID = 1;  % single
block.InputPort(6).Complexity = 'Real';
block.InputPort(6).DirectFeedthrough = true;

% Override output port properties
% output data
block.OutputPort(1).Dimensions = 1;
block.OutputPort(1).DatatypeID = 0; % double
block.OutputPort(1).Complexity = 'Real';

block.OutputPort(2).Dimensions = 1;
block.OutputPort(2).DatatypeID = 8; % boolean
block.OutputPort(2).Complexity = 'Real';

block.OutputPort(3).Dimensions = 1;
block.OutputPort(3).DatatypeID = 1; % single
block.OutputPort(3).Complexity = 'Real';

% Register parameters
block.NumDialogPrms     = 2;

% Register sample times
%  [0 offset]            : Continuous sample time
%  [positive_num offset] : Discrete sample time
%
%  [-1, 0]               : Inherited sample time
%  [-2, 0]               : Variable sample time
block.SampleTimes = [-1 0];

% Specify the block simStateCompliance. The allowed values are:
%    'UnknownSimState', < The default setting; warn and assume DefaultSimState
%    'DefaultSimState', < Same sim state as a built-in block
%    'HasNoSimState',   < No sim state
%    'CustomSimState',  < Has GetSimState and SetSimState methods
%    'DisallowSimState' < Error out when saving or restoring the model sim state
block.SimStateCompliance = 'DefaultSimState';

%% -----------------------------------------------------------------
%% The MATLAB S-function uses an internal registry for all
%% block methods. You should register all relevant methods
%% (optional and required) as illustrated below. You may choose
%% any suitable name for the methods and implement these methods
%% as local functions within the same file. See comments
%% provided for each function for more information.
%% -----------------------------------------------------------------

block.RegBlockMethod('PostPropagationSetup',    @DoPostPropSetup);
block.RegBlockMethod('InitializeConditions', @InitializeConditions);
block.RegBlockMethod('Start', @Start);
block.RegBlockMethod('Outputs', @Outputs);     % Required
block.RegBlockMethod('Update', @Update);
block.RegBlockMethod('Derivatives', @Derivatives);
block.RegBlockMethod('Terminate', @Terminate); % Required

block.RegBlockMethod('SetInputPortSamplingMode', @SetInpPortFrameData);

%end setup

function SetInpPortFrameData(block, idx, fd)
  
  block.InputPort(idx).SamplingMode = fd;
  block.OutputPort(1).SamplingMode  = fd;
  block.OutputPort(2).SamplingMode  = fd;
  block.OutputPort(3).SamplingMode  = fd;
  
%endfunction

%%
%% PostPropagationSetup:
%%   Functionality    : Setup work areas and state variables. Can
%%                      also register run-time methods here
%%   Required         : No
%%   C-Mex counterpart: mdlSetWorkWidths
%%
function DoPostPropSetup(block)
    block.NumDworks = 3;

    depth_bits = block.DialogPrm(1).Data;
    latency = block.DialogPrm(2).Data - 1;

    depth = pow2(depth_bits);
    block.Dwork(1).Name            = 'mem_storage';
    block.Dwork(1).Dimensions      = depth;
    block.Dwork(1).DatatypeID      = 0;      % double
    block.Dwork(1).Complexity      = 'Real'; % real
    block.Dwork(1).UsedAsDiscState = true;

    block.Dwork(2).Name            = 'latency_fifo_data';
    block.Dwork(2).Dimensions      = max(1, latency);
    block.Dwork(2).DatatypeID      = 0;      % double
    block.Dwork(2).Complexity      = 'Real'; % real
    block.Dwork(2).UsedAsDiscState = true;
    
    block.Dwork(3).Name            = 'latency_fifo_tag';
    block.Dwork(3).Dimensions      = max(1, latency);
    block.Dwork(3).DatatypeID      = 1;      % single
    block.Dwork(3).Complexity      = 'Real'; % real
    block.Dwork(3).UsedAsDiscState = true;


%%
%% InitializeConditions:
%%   Functionality    : Called at the start of simulation and if it is 
%%                      present in an enabled subsystem configured to reset 
%%                      states, it will be called when the enabled subsystem
%%                      restarts execution to reset the states.
%%   Required         : No
%%   C-MEX counterpart: mdlInitializeConditions
%%
function InitializeConditions(block)

%end InitializeConditions


%%
%% Start:
%%   Functionality    : Called once at start of model execution. If you
%%                      have states that should be initialized once, this 
%%                      is the place to do it.
%%   Required         : No
%%   C-MEX counterpart: mdlStart
%%
function Start(block)
    block.Dwork(1).Data = zeros(1, length(block.Dwork(1).Data));
    block.Dwork(2).Data = zeros(1, length(block.Dwork(2).Data));
    block.Dwork(3).Data = zeros(1, length(block.Dwork(3).Data), 'single');
%end Start

%%
%% Outputs:
%%   Functionality    : Called to generate block outputs in
%%                      simulation step
%%   Required         : Yes
%%   C-MEX counterpart: mdlOutputs
%%
function Outputs(block)
%     fprintf('call Outputs\n')
%     addr = block.InputPort(1).Data + 1
%     block.Dwork(1).Data(addr)
%     block.OutputPort(1).Data = block.Dwork(1).Data(addr);
% end Outputs

%%
%% Update:
%%   Functionality    : Called to update discrete states
%%                      during simulation step
%%   Required         : No
%%   C-MEX counterpart: mdlUpdate
%%
function Update(block)
    % fprintf('call Update\n')
    % write data to the array if wr_en is high
    if block.InputPort(2).Data == 1
        addr = block.InputPort(3).Data + 1;
        block.Dwork(1).Data(addr) = block.InputPort(4).Data; 
    end
    
    % rd_en high
    if block.InputPort(1).Data == 1
        read_tag = block.InputPort(6).Data;
        read_addr = block.InputPort(5).Data + 1;
        latency = block.DialogPrm(2).Data - 1;
        read_val = block.Dwork(1).Data(read_addr);
        %fprintf('rd_tag(%i) rd_addr(%i) lat(%i) rd_val(%i)\n', read_tag, read_addr, latency, read_val);
        
        if latency > 1
            fifo_val = block.Dwork(2).Data(end);
            fifo_tag = block.Dwork(3).Data(end);
            last_bit_data = block.Dwork(2).Data(1:end-1).';
            last_bit_tag = block.Dwork(3).Data(1:end-1).';
            tmp_data =  [read_val, last_bit_data];
            tmp_tag =  [read_tag, last_bit_tag];
            block.Dwork(2).Data = tmp_data.';
            block.Dwork(3).Data = tmp_tag.';
            output_val = fifo_val;
            output_tag = fifo_tag;
        else
            output_val = read_val;
            output_tag = read_tag;
        end
        block.OutputPort(1).Data = output_val;
        block.OutputPort(2).Data = true;
        block.OutputPort(3).Data = output_tag;
    else
        block.OutputPort(2).Data = false;
    end

    % get a random read/tag pair from the queue
    % return it
    % place the new one in the queue
    
% end Update

%%
%% Derivatives:
%%   Functionality    : Called to update derivatives of
%%                      continuous states during simulation step
%%   Required         : No
%%   C-MEX counterpart: mdlDerivatives
%%
function Derivatives(block)

%end Derivatives

%%
%% Terminate:
%%   Functionality    : Called at the end of simulation for cleanup
%%   Required         : Yes
%%   C-MEX counterpart: mdlTerminate
%%
function Terminate(block)

%end Terminate

