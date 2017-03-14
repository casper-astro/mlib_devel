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
block.NumInputPorts  = 13;
block.NumOutputPorts = 10;

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

block.InputPort(5).Dimensions = 1;
block.InputPort(5).DatatypeID = 0;  % double
block.InputPort(5).Complexity = 'Real';
block.InputPort(5).DirectFeedthrough = true;

block.InputPort(6).Dimensions = 1;
block.InputPort(6).DatatypeID = 0;  % double
block.InputPort(6).Complexity = 'Real';
block.InputPort(6).DirectFeedthrough = true;

block.InputPort(7).Dimensions = 1;
block.InputPort(7).DatatypeID = 0;  % double
block.InputPort(7).Complexity = 'Real';
block.InputPort(7).DirectFeedthrough = true;

block.InputPort(8).Dimensions = 1;
block.InputPort(8).DatatypeID = 0;  % double
block.InputPort(8).Complexity = 'Real';
block.InputPort(8).DirectFeedthrough = true;

block.InputPort(9).Dimensions = 1;
block.InputPort(9).DatatypeID = 0;  % double
block.InputPort(9).Complexity = 'Real';
block.InputPort(9).DirectFeedthrough = true;

block.InputPort(10).Dimensions = 1;
block.InputPort(10).DatatypeID = 0;  % double
block.InputPort(10).Complexity = 'Real';
block.InputPort(10).DirectFeedthrough = true;

block.InputPort(11).Dimensions = 1;
block.InputPort(11).DatatypeID = 0;  % double
block.InputPort(11).Complexity = 'Real';
block.InputPort(11).DirectFeedthrough = true;



% read address
block.InputPort(12).Dimensions = 1;
block.InputPort(12).DatatypeID = 1;  % single
block.InputPort(12).Complexity = 'Real';
block.InputPort(12).DirectFeedthrough = true;

% read tag
block.InputPort(13).Dimensions = 1;
block.InputPort(13).DatatypeID = 1;  % single
block.InputPort(13).Complexity = 'Real';
block.InputPort(13).DirectFeedthrough = true;

% Override output port properties
% output data
block.OutputPort(1).Dimensions = 1;
block.OutputPort(1).DatatypeID = 0; % double
block.OutputPort(1).Complexity = 'Real';

block.OutputPort(2).Dimensions = 1;
block.OutputPort(2).DatatypeID = 0; % double
block.OutputPort(2).Complexity = 'Real';

block.OutputPort(3).Dimensions = 1;
block.OutputPort(3).DatatypeID = 0; % double
block.OutputPort(3).Complexity = 'Real';

block.OutputPort(4).Dimensions = 1;
block.OutputPort(4).DatatypeID = 0; % double
block.OutputPort(4).Complexity = 'Real';

block.OutputPort(5).Dimensions = 1;
block.OutputPort(5).DatatypeID = 0; % double
block.OutputPort(5).Complexity = 'Real';

block.OutputPort(6).Dimensions = 1;
block.OutputPort(6).DatatypeID = 0; % double
block.OutputPort(6).Complexity = 'Real';

block.OutputPort(7).Dimensions = 1;
block.OutputPort(7).DatatypeID = 0; % double
block.OutputPort(7).Complexity = 'Real';

block.OutputPort(8).Dimensions = 1;
block.OutputPort(8).DatatypeID = 0; % double
block.OutputPort(8).Complexity = 'Real';

% dvalid
block.OutputPort(9).Dimensions = 1;
block.OutputPort(9).DatatypeID = 8; % boolean
block.OutputPort(9).Complexity = 'Real';

% tag out
block.OutputPort(10).Dimensions = 1;
block.OutputPort(10).DatatypeID = 1; % single
block.OutputPort(10).Complexity = 'Real';

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
  block.OutputPort(4).SamplingMode  = fd;
  block.OutputPort(5).SamplingMode  = fd;
  block.OutputPort(6).SamplingMode  = fd;
  block.OutputPort(7).SamplingMode  = fd;
  block.OutputPort(8).SamplingMode  = fd;
  block.OutputPort(9).SamplingMode  = fd;
  block.OutputPort(10).SamplingMode  = fd;
  
%endfunction

%%
%% PostPropagationSetup:
%%   Functionality    : Setup work areas and state variables. Can
%%                      also register run-time methods here
%%   Required         : No
%%   C-Mex counterpart: mdlSetWorkWidths
%%
function DoPostPropSetup(block)
    block.NumDworks = 18;

    depth_bits = block.DialogPrm(1).Data;
    latency = block.DialogPrm(2).Data - 1;

    block.Dwork(1).Name            = 'latency_fifo_tag';
    block.Dwork(1).Dimensions      = max(1, latency);
    block.Dwork(1).DatatypeID      = 1;      % single
    block.Dwork(1).Complexity      = 'Real'; % real
    block.Dwork(1).UsedAsDiscState = true;

    block.Dwork(2).Name            = 'latency_fifo_dvalid';
    block.Dwork(2).Dimensions      = max(1, latency);
    block.Dwork(2).DatatypeID      = 8;      % bool
    block.Dwork(2).Complexity      = 'Real'; % real
    block.Dwork(2).UsedAsDiscState = true;
    
    % Storage for data (to level 'depth')
    depth = pow2(depth_bits);
    block.Dwork(3).Name            = 'mem_storage_0';
    block.Dwork(3).Dimensions      = depth;
    block.Dwork(3).DatatypeID      = 0;      % double
    block.Dwork(3).Complexity      = 'Real'; % real
    block.Dwork(3).UsedAsDiscState = true;

    block.Dwork(4).Name            = 'mem_storage_1';
    block.Dwork(4).Dimensions      = depth;
    block.Dwork(4).DatatypeID      = 0;      % double
    block.Dwork(4).Complexity      = 'Real'; % real
    block.Dwork(4).UsedAsDiscState = true;
    
    block.Dwork(5).Name            = 'mem_storage_2';
    block.Dwork(5).Dimensions      = depth;
    block.Dwork(5).DatatypeID      = 0;      % double
    block.Dwork(5).Complexity      = 'Real'; % real
    block.Dwork(5).UsedAsDiscState = true;
    
    block.Dwork(6).Name            = 'mem_storage_3';
    block.Dwork(6).Dimensions      = depth;
    block.Dwork(6).DatatypeID      = 0;      % double
    block.Dwork(6).Complexity      = 'Real'; % real
    block.Dwork(6).UsedAsDiscState = true;
    
    block.Dwork(7).Name            = 'mem_storage_4';
    block.Dwork(7).Dimensions      = depth;
    block.Dwork(7).DatatypeID      = 0;      % double
    block.Dwork(7).Complexity      = 'Real'; % real
    block.Dwork(7).UsedAsDiscState = true;
    
    block.Dwork(8).Name            = 'mem_storage_5';
    block.Dwork(8).Dimensions      = depth;
    block.Dwork(8).DatatypeID      = 0;      % double
    block.Dwork(8).Complexity      = 'Real'; % real
    block.Dwork(8).UsedAsDiscState = true;
    
    block.Dwork(9).Name            = 'mem_storage_6';
    block.Dwork(9).Dimensions      = depth;
    block.Dwork(9).DatatypeID      = 0;      % double
    block.Dwork(9).Complexity      = 'Real'; % real
    block.Dwork(9).UsedAsDiscState = true;
    
    block.Dwork(10).Name            = 'mem_storage_7';
    block.Dwork(10).Dimensions      = depth;
    block.Dwork(10).DatatypeID      = 0;      % double
    block.Dwork(10).Complexity      = 'Real'; % real
    block.Dwork(10).UsedAsDiscState = true;
    
    % Storage for latency fifo
    block.Dwork(11).Name            = 'latency_fifo_data_0';
    block.Dwork(11).Dimensions      = max(1, latency);
    block.Dwork(11).DatatypeID      = 0;      % double
    block.Dwork(11).Complexity      = 'Real'; % real
    block.Dwork(11).UsedAsDiscState = true;
    
    block.Dwork(12).Name            = 'latency_fifo_data_1';
    block.Dwork(12).Dimensions      = max(1, latency);
    block.Dwork(12).DatatypeID      = 0;      % double
    block.Dwork(12).Complexity      = 'Real'; % real
    block.Dwork(12).UsedAsDiscState = true;

    block.Dwork(13).Name            = 'latency_fifo_data_2';
    block.Dwork(13).Dimensions      = max(1, latency);
    block.Dwork(13).DatatypeID      = 0;      % double
    block.Dwork(13).Complexity      = 'Real'; % real
    block.Dwork(13).UsedAsDiscState = true;

    block.Dwork(14).Name            = 'latency_fifo_data_3';
    block.Dwork(14).Dimensions      = max(1, latency);
    block.Dwork(14).DatatypeID      = 0;      % double
    block.Dwork(14).Complexity      = 'Real'; % real
    block.Dwork(14).UsedAsDiscState = true;

    block.Dwork(15).Name            = 'latency_fifo_data_4';
    block.Dwork(15).Dimensions      = max(1, latency);
    block.Dwork(15).DatatypeID      = 0;      % double
    block.Dwork(15).Complexity      = 'Real'; % real
    block.Dwork(15).UsedAsDiscState = true;

    block.Dwork(16).Name            = 'latency_fifo_data_5';
    block.Dwork(16).Dimensions      = max(1, latency);
    block.Dwork(16).DatatypeID      = 0;      % double
    block.Dwork(16).Complexity      = 'Real'; % real
    block.Dwork(16).UsedAsDiscState = true;

    block.Dwork(17).Name            = 'latency_fifo_data_6';
    block.Dwork(17).Dimensions      = max(1, latency);
    block.Dwork(17).DatatypeID      = 0;      % double
    block.Dwork(17).Complexity      = 'Real'; % real
    block.Dwork(17).UsedAsDiscState = true;
    
    block.Dwork(18).Name            = 'latency_fifo_data_7';
    block.Dwork(18).Dimensions      = max(1, latency);
    block.Dwork(18).DatatypeID      = 0;      % double
    block.Dwork(18).Complexity      = 'Real'; % real
    block.Dwork(18).UsedAsDiscState = true;
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
    block.Dwork(1).Data = zeros(1, length(block.Dwork(1).Data), 'single');
    block.Dwork(2).Data = zeros(1, length(block.Dwork(2).Data), 'logical');
    
    block.Dwork(3).Data = zeros(1, length(block.Dwork(3).Data));
    block.Dwork(4).Data = zeros(1, length(block.Dwork(4).Data));
    block.Dwork(5).Data = zeros(1, length(block.Dwork(5).Data));
    block.Dwork(6).Data = zeros(1, length(block.Dwork(6).Data));
    block.Dwork(7).Data = zeros(1, length(block.Dwork(7).Data));
    block.Dwork(8).Data = zeros(1, length(block.Dwork(8).Data));
    block.Dwork(9).Data = zeros(1, length(block.Dwork(9).Data));
    block.Dwork(10).Data = zeros(1, length(block.Dwork(10).Data));
    
    block.Dwork(11).Data = zeros(1, length(block.Dwork(11).Data));
    block.Dwork(12).Data = zeros(1, length(block.Dwork(11).Data));
    block.Dwork(13).Data = zeros(1, length(block.Dwork(11).Data));
    block.Dwork(14).Data = zeros(1, length(block.Dwork(11).Data));
    block.Dwork(15).Data = zeros(1, length(block.Dwork(11).Data));
    block.Dwork(16).Data = zeros(1, length(block.Dwork(11).Data));
    block.Dwork(17).Data = zeros(1, length(block.Dwork(11).Data));
    block.Dwork(18).Data = zeros(1, length(block.Dwork(11).Data));
    
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
        % Grab address (+1 as Matlab has indexing from 1)
        addr = block.InputPort(3).Data + 1;
        %Grab data
        block.Dwork(3).Data(addr) = block.InputPort(4).Data; 
        block.Dwork(4).Data(addr) = block.InputPort(5).Data; 
        block.Dwork(5).Data(addr) = block.InputPort(6).Data; 
        block.Dwork(6).Data(addr) = block.InputPort(7).Data; 
        block.Dwork(7).Data(addr) = block.InputPort(8).Data; 
        block.Dwork(8).Data(addr) = block.InputPort(9).Data; 
        block.Dwork(9).Data(addr) = block.InputPort(10).Data; 
        block.Dwork(10).Data(addr) = block.InputPort(11).Data; 
    end
    

    % rd_en high
    if block.InputPort(1).Data == 1
        read_tag = block.InputPort(13).Data;
        read_addr = block.InputPort(12).Data + 1;
        latency = block.DialogPrm(2).Data - 1;
        
        % read data from memory storage
        read_val_0 = block.Dwork(3).Data(read_addr);
        read_val_1 = block.Dwork(4).Data(read_addr);
        read_val_2 = block.Dwork(5).Data(read_addr);
        read_val_3 = block.Dwork(6).Data(read_addr);
        read_val_4 = block.Dwork(7).Data(read_addr);
        read_val_5 = block.Dwork(8).Data(read_addr);
        read_val_6 = block.Dwork(9).Data(read_addr);
        read_val_7 = block.Dwork(10).Data(read_addr);
        
        dvalid = block.InputPort(1).Data;
        %fprintf('rd_tag(%i) rd_addr(%i) lat(%i) rd_val(%i)\n', read_tag, read_addr, latency, read_val);
        
        if latency > 1
            fifo_val_0 = block.Dwork(11).Data(end);
            fifo_val_1 = block.Dwork(12).Data(end);
            fifo_val_2 = block.Dwork(13).Data(end);
            fifo_val_3 = block.Dwork(14).Data(end);
            fifo_val_4 = block.Dwork(15).Data(end);
            fifo_val_5 = block.Dwork(16).Data(end);
            fifo_val_6 = block.Dwork(17).Data(end);
            fifo_val_7 = block.Dwork(18).Data(end);
            
            
            fifo_tag = block.Dwork(1).Data(end);
            fifo_dvalid = block.Dwork(2).Data(end);

            last_bit_data_0 = block.Dwork(11).Data(1:end-1).';
            last_bit_data_1 = block.Dwork(12).Data(1:end-1).';
            last_bit_data_2 = block.Dwork(13).Data(1:end-1).';
            last_bit_data_3 = block.Dwork(14).Data(1:end-1).';
            last_bit_data_4 = block.Dwork(15).Data(1:end-1).';
            last_bit_data_5 = block.Dwork(16).Data(1:end-1).';
            last_bit_data_6 = block.Dwork(17).Data(1:end-1).';
            last_bit_data_7 = block.Dwork(18).Data(1:end-1).';
            
            last_bit_tag = block.Dwork(1).Data(1:end-1).';
            last_bit_dvalid = block.Dwork(2).Data(1:end-1).';
            
            tmp_data_0 =  [read_val_0, last_bit_data_0];
            tmp_data_1 =  [read_val_1, last_bit_data_1];
            tmp_data_2 =  [read_val_2, last_bit_data_2];
            tmp_data_3 =  [read_val_3, last_bit_data_3];
            tmp_data_4 =  [read_val_4, last_bit_data_4];
            tmp_data_5 =  [read_val_5, last_bit_data_5];
            tmp_data_6 =  [read_val_6, last_bit_data_6];
            tmp_data_7 =  [read_val_7, last_bit_data_7];
            
            tmp_tag =  [read_tag, last_bit_tag];
            tmp_dvalid = [dvalid, last_bit_dvalid];
            
            block.Dwork(11).Data = tmp_data_0.';
            block.Dwork(12).Data = tmp_data_1.';
            block.Dwork(13).Data = tmp_data_2.';
            block.Dwork(14).Data = tmp_data_3.';
            block.Dwork(15).Data = tmp_data_4.';
            block.Dwork(16).Data = tmp_data_5.';
            block.Dwork(17).Data = tmp_data_6.';
            block.Dwork(18).Data = tmp_data_7.';
            
            block.Dwork(1).Data = tmp_tag.';
            block.Dwork(2).Data = tmp_dvalid.';
            
            output_val_0 = fifo_val_0;
            output_val_1 = fifo_val_1;
            output_val_2 = fifo_val_2;
            output_val_3 = fifo_val_3;
            output_val_4 = fifo_val_4;
            output_val_5 = fifo_val_5;
            output_val_6 = fifo_val_6;
            output_val_7 = fifo_val_7;
            
            output_tag = fifo_tag;
            output_dvalid = fifo_dvalid;
        else
            output_val_0 = read_val_0;
            output_val_1 = read_val_1;
            output_val_2 = read_val_2;
            output_val_3 = read_val_3;
            output_val_4 = read_val_4;
            output_val_5 = read_val_5;
            output_val_6 = read_val_6;
            output_val_7 = read_val_7;
            output_tag = read_tag;
            output_dvalid = dvalid;
        end
        block.OutputPort(1).Data = output_val_0;
        block.OutputPort(2).Data = output_val_1;
        block.OutputPort(3).Data = output_val_2;
        block.OutputPort(4).Data = output_val_3;
        block.OutputPort(5).Data = output_val_4;
        block.OutputPort(6).Data = output_val_5;
        block.OutputPort(7).Data = output_val_6;
        block.OutputPort(8).Data = output_val_7;
        
        block.OutputPort(10).Data = output_tag;
        block.OutputPort(9).Data = output_dvalid;

    else
        % data out
        block.OutputPort(1).Data = 0;
        block.OutputPort(2).Data = 0;
        block.OutputPort(3).Data = 0;
        block.OutputPort(4).Data = 0;
        block.OutputPort(5).Data = 0;
        block.OutputPort(6).Data = 0;
        block.OutputPort(7).Data = 0;
        block.OutputPort(8).Data = 0;
        
        % dvalid
        block.OutputPort(9).Data = false;
        
        % tag
        block.OutputPort(10).Data = single(0);
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

