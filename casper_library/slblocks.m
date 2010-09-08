function blkStruct = slblocks
%SLBLOCKS Defines the Simulink library block representation
%   for the Xilinx Blockset.

% Copyright (c) 1998 Xilinx Inc. All Rights Reserved.

blkStruct.Name    = ['CASPER DSP Blockset'];
blkStruct.OpenFcn = '';
blkStruct.MaskInitialization = '';

blkStruct.MaskDisplay = ['disp(''CASPER DSP Blockset'')'];

% Define the library list for the Simulink Library browser.
% Return the name of the library model and the name for it
%
Browser(1).Library = 'casper_library';
Browser(1).Name    = 'CASPER DSP Blockset';

blkStruct.Browser = Browser;

% End of slblocks.m

