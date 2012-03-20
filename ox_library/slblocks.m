function blkStruct = slblocks
%SLBLOCKS Defines the Simulink library block representation
%   for the Xilinx Blockset.

% Copyright (c) 1998 Xilinx Inc. All Rights Reserved.

blkStruct.Name    = ['Oxford DSP Blockset'];
blkStruct.OpenFcn = '';
blkStruct.MaskInitialization = '';

blkStruct.MaskDisplay = ['disp(''Oxford DSP Blockset'')'];

% Define the library list for the Simulink Library browser.
% Return the name of the library model and the name for it
%
Browser(1).Library = 'ox_lib';
Browser(1).Name    = 'Oxford DSP Blockset';

blkStruct.Browser = Browser;

% End of slblocks.m

