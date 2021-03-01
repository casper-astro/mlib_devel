% I am still looking for the exact clarafication but there is a difference and
% required use case between
%   msk.getParameter('param_name').Value (and = 'New Value')
% and
%   get_param(gcb, 'param_name')
%
% This primarily is important for function call backs becuase as I learned when
% first attempting to programatically update the mixer mode and type based on
% the digital output data.
%
% I could obviously see that my callback method 'validate_digital_data` would
% execute as soon as I made a selection from Digital Output popup box. However, a
% call using `msk.getParameter(...).Value = 'New Value`  would not yet have the
% updated value. The value was only applied after `Apply` was clicked in the
% GUI. Instead, `get_para(...)` returned the expected value and then am able to
% change the popup type options with `msk.getParameter(...).TypeOptions = ...`
% 
% This is incredibly counterintuitive. But, at least I know it is how MATLAB
% wants you to do that per their exmple 'slexMaskLayoutOptionsexample' model
% showing a 'Dynamic Popup Parameter'.
%
% So my best guess is that msk.getParameter(...).Value holds the current saved
% mask value, whereas get_param fetches the raw workspace value?


function [b] = chk_param(blk, p, v)
  param = get_param(blk, p);
  b = 0;
  if isempty(param)
    error(['Error: "', p, '" not a valid mask parameter']);
    return
  end

  b = strcmpi(param, v);
  
end
