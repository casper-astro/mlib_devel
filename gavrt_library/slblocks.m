function blkStruct = slblocks
%SLBLOCKS Defines the Simulink library block representation
%   for the Xilinx Blockset.

% Copyright (c) 1998 Xilinx Inc. All Rights Reserved.

blkStruct.Name    = ['GAVRT Blockset'];
blkStruct.OpenFcn = '';
blkStruct.MaskInitialization = '';

blkStruct.MaskDisplay = ['disp(''GAVRT Blockset'')'];

% Define the library list for the Simulink Library browser.
% Return the name of the library model and the name for it
%
Browser(1).Library = 'gavrt_library';
Browser(1).Name    = 'GAVRT Blockset';
%Browser(2).Library = 'testbench_lib';
%Browser(2).Name    = 'Testbench Blockset';
Browser(3).Library = 'gtkWave';
Browser(3).Name = 'GtkWaveCapture';

blkStruct.Browser = Browser;

% End of slblocks.m

