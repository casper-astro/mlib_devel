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
%     tic
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

    % data input lines
    for ctr = 4 : 11
        block.InputPort(ctr).Dimensions = 1;
        block.InputPort(ctr).DatatypeID = 0;  % double
        block.InputPort(ctr).Complexity = 'Real';
        block.InputPort(ctr).DirectFeedthrough = true;
    end

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

    % override output port properties

    % data output lines
    for ctr = 1 : 8
        block.OutputPort(ctr).Dimensions = 1;
        block.OutputPort(ctr).DatatypeID = 0; % double
        block.OutputPort(ctr).Complexity = 'Real';
    end

    % dvalid
    block.OutputPort(9).Dimensions = 1;
    block.OutputPort(9).DatatypeID = 8; % boolean
    block.OutputPort(9).Complexity = 'Real';

    % tag out
    block.OutputPort(10).Dimensions = 1;
    block.OutputPort(10).DatatypeID = 1; % single
    block.OutputPort(10).Complexity = 'Real';

    % Register parameters
    block.NumDialogPrms = 3;

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

    block.NumDworks = 21;
    
    depth = pow2(block.DialogPrm(1).Data);
    latency = block.DialogPrm(2).Data;
    randomise = block.DialogPrm(3).Data;
    %fprintf('depth(%i) latency(%i) randomise(%i)\n', depth, latency, randomise);

    % storage for data (to level 'depth')
    for ctr = 1 : 8
        block.Dwork(ctr).Name            = sprintf('mem_storage_%i', ctr-1);
        block.Dwork(ctr).Dimensions      = depth;
        block.Dwork(ctr).DatatypeID      = 0;      % double
        block.Dwork(ctr).Complexity      = 'Real'; % real
        block.Dwork(ctr).UsedAsDiscState = true;
    end
    
    % fifo ptr
    block.Dwork(9).Name            = 'latency_fifo_ptr';
    block.Dwork(9).Dimensions      = 1;
    block.Dwork(9).DatatypeID      = 0;      % single
    block.Dwork(9).Complexity      = 'Real'; % real
    block.Dwork(9).UsedAsDiscState = true;
    
    block.Dwork(10).Name            = 'latency_fifo_tag';
    block.Dwork(10).Dimensions      = max(1, latency);
    block.Dwork(10).DatatypeID      = 1;      % single
    block.Dwork(10).Complexity      = 'Real'; % real
    block.Dwork(10).UsedAsDiscState = true;
    
    block.Dwork(11).Name            = 'latency_fifo_dv';
    block.Dwork(11).Dimensions      = max(1, latency);
    block.Dwork(11).DatatypeID      = 1;      % single
    block.Dwork(11).Complexity      = 'Real'; % real
    block.Dwork(11).UsedAsDiscState = true;
    
    % storage for latency data fifos
    for ctr = 12 : 19
        block.Dwork(ctr).Name            = sprintf('latency_fifo_data_%i', ctr-12);
        block.Dwork(ctr).Dimensions      = max(1, latency);
        block.Dwork(ctr).DatatypeID      = 0;      % double
        block.Dwork(ctr).Complexity      = 'Real'; % real
        block.Dwork(ctr).UsedAsDiscState = true;
    end
    
    block.Dwork(20).Name            = 'latency_fifo_swapped';
    block.Dwork(20).Dimensions      = max(1, latency);
    block.Dwork(20).DatatypeID      = 1;      % single
    block.Dwork(20).Complexity      = 'Real'; % real
    block.Dwork(20).UsedAsDiscState = true;
    
    block.Dwork(21).Name            = 'latency_fifo_counter';
    block.Dwork(21).Dimensions      = 1;
    block.Dwork(21).DatatypeID      = 1;      % single
    block.Dwork(21).Complexity      = 'Real'; % real
    block.Dwork(21).UsedAsDiscState = true;

% end /DoPostPropSetup
    
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
    % data
    for ctr = 1 : 8
        block.Dwork(ctr).Data = zeros(1, length(block.Dwork(ctr).Data));
    end
    % ptr
    block.Dwork(9).Data = 1;
    % tag fifo
    block.Dwork(10).Data = zeros(1, length(block.Dwork(10).Data), 'single');
    % tag dv
    block.Dwork(11).Data = zeros(1, length(block.Dwork(11).Data), 'single');
    % data fifos
    for ctr = 12 : 19
        block.Dwork(ctr).Data = zeros(1, length(block.Dwork(ctr).Data));
    end
    block.Dwork(20).Data = zeros(1, length(block.Dwork(11).Data), 'single');
    block.Dwork(21).Data = single(0);
    
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

function do_read(block)
    fifo_ptr = block.Dwork(9).Data;
    %fprintf('fifo_ptr(%i)\n', fifo_ptr);
    % rd_en high
    if block.InputPort(1).Data == 1
        
        % get the current address and tag values on the ports
        read_tag = block.InputPort(13).Data;
        read_addr = block.InputPort(12).Data + 1;  
        
        % Check if the read address exceeds the depth. If not, proceed. If yes,
        % bail hard.
        depth = pow2(block.DialogPrm(1).Data);
        if (read_addr > depth)
            error('Read address exceeds HMC simulation depth. Change the depth field in the mask');
        else
            % put the tag and valids into the fifos
            block.Dwork(10).Data(fifo_ptr) = read_tag;
            block.Dwork(11).Data(fifo_ptr) = 1;


            % put the value read from memory and the tag into the fifos
            for ctr = 0 : 7
                block.Dwork(ctr+12).Data(fifo_ptr) = block.Dwork(ctr+1).Data(read_addr);
            end
            block.Dwork(21).Data = block.Dwork(21).Data + 1;
            %fprintf('rd_tag(%i) rd_addr(%i) fifo_ctr(%i)\n', read_tag, read_addr, block.Dwork(21).Data);
        end
        
    else
        block.Dwork(11).Data(fifo_ptr) = 0;
    end
    block.Dwork(20).Data(fifo_ptr) = 0;
    
    % is there any read data in the fifo?
    if block.Dwork(21).Data == 0
        block.OutputPort(9).Data = boolean(0);
        return
    end
    
    % increment the fifo ptr
    fifo_ptr = fifo_ptr + 1;
    if fifo_ptr > length(block.Dwork(11).Data)
        fifo_ptr = 1;
        %fprintf('reset fifo_ptr to 1\n');
    end
    block.Dwork(9).Data = fifo_ptr;
    
    % should we add a bit of randomisation?
    randomise = block.DialogPrm(3).Data;
    if (randomise == 1) && (rand > 0.5)
%         fprintf('randomising some data');
        fifo_len = length(block.Dwork(11).Data);
        rand_pos = ceil(rand * fifo_len);
        if (rand_pos ~= fifo_ptr) && (block.Dwork(20).Data(rand_pos) == 0) && (block.Dwork(11).Data(rand_pos) == 1) && (block.Dwork(11).Data(fifo_ptr) == 1)
            for ctr = 0 : 7
                temp_val = block.Dwork(ctr+12).Data(fifo_ptr);
                block.Dwork(ctr+12).Data(fifo_ptr) = block.Dwork(ctr+12).Data(rand_pos);
                block.Dwork(ctr+12).Data(rand_pos) = temp_val;
            end
            temp_val = block.Dwork(11).Data(fifo_ptr);
            block.Dwork(11).Data(fifo_ptr) = block.Dwork(11).Data(rand_pos);
            block.Dwork(11).Data(rand_pos) = temp_val;
            temp_val = block.Dwork(10).Data(fifo_ptr);
            block.Dwork(10).Data(fifo_ptr) = block.Dwork(10).Data(rand_pos);
            block.Dwork(10).Data(rand_pos) = temp_val;
            block.Dwork(20).Data(rand_pos) = 1;
            block.Dwork(20).Data(fifo_ptr) = 1;
%             fprintf(' - swapped %i and %i\n', rand_pos, fifo_ptr);
        else
%             fprintf(' - target already swapped\n');
        end
    end
    
    % place the items at the new fifo_ptr (oldest value) on the output
    for ctr = 0 : 7
        block.OutputPort(ctr+1).Data = block.Dwork(ctr+12).Data(fifo_ptr);
    end
    block.OutputPort(9).Data = boolean(block.Dwork(11).Data(fifo_ptr));
    block.OutputPort(10).Data = block.Dwork(10).Data(fifo_ptr);
    block.Dwork(10).Data(fifo_ptr)
    
    if block.Dwork(11).Data(fifo_ptr) == 1
        block.Dwork(21).Data = block.Dwork(21).Data - 1;
    end
    
% end \do_read


%%
%% Update:
%%   Functionality    : Called to update discrete states
%%                      during simulation step
%%   Required         : No
%%   C-MEX counterpart: mdlUpdate
%%
function Update(block)
%     % fprintf('call Update\n')
    % write data to the array if wr_en is high
    if block.InputPort(2).Data == 1
        % grab address (+1 as Matlab has indexing from 1)
        addr = block.InputPort(3).Data + 1;
        % grab data from input port and put it in state storage
        for ctr = 0 : 7
            block.Dwork(ctr+1).Data(addr) = block.InputPort(ctr+4).Data; 
        end
    end % /if wr_en high
    

    % there's more to the reading
    do_read(block)

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
%     toc

%end Terminate
