
%---------------------------------------------------------------
%Copyright 2009, Xilinx Corporation
%
%Allows System Generator to be added to MATLAB dynamically
%for non-permission access into the MATLAB startup path.
%
%Please add this function to your personal startup.m file to allow
%for dynamic installation of this version of System Generator.
%
%This is build number : 1666
%
%File written on [ 07/21/09 12:11:32 ]
%

function sysgen_startup

%% -- Added by System Generator automatically during installation -- %%
%% --                                                             -- %%
%% --                Do not remove this banner                    -- %%
%% --                                                             -- %%

path_elements          = path;
tokptr                 = 1;

        while true
           if ( tokptr > length(path_elements) )
               break;
           end
           item   = strtok(path_elements(tokptr:end), pathsep);
           tokptr = tokptr + length(item) + 1;

           % This will return from this install function if sysgen in
   % already found to exist in the default path setup of matlab
           if ~isempty(findstr(item, 'sysgen')) 
               disp('System Generator currently found installed into matlab default path');
       try
          xlVersion;
  disp('Run << xlVersion >> at prompt to see installed versions of System Generator');
       catch
                  disp('Unable to ascertain if any versions of System Generator are currently installed');
               end
       return
           end
        end

xilinx_dsp = getenv('XILINX_DSP');
if isempty(xilinx_dsp)
   error('XILINX_DSP environment variable is not defined!');
end

sysgenbin = [ xilinx_dsp filesep 'sysgen' filesep 'bin' ];

if exist(sysgenbin, 'dir')
   addpath(sysgenbin);
   try
      mlsupport_file = xl_get_matlab_support_xmlfile(sysgenbin);
      xl_verify_matlab_support_xmlfile(mlsupport_file);
      [ mlsupport_table, okay ] = xl_read_matlab_support_xmlfile(mlsupport_file);
      if ~okay
  xl_test_matlab_support_xmlfile(mlsupport_table);
      end
      xlAddSysgen(xilinx_dsp);
      disp('Installed System Generator dynamically.');
   catch
      disp('Error occured while attempting to install System Generator into MATLAB path.');
      rmpath(sysgenbin); %% Need to remove addpath to not trip
                         %% condition when run more than once
      lasterr;
   end
%   disp(okay);
%   disp(mlsupport_table);
%   disp(mlsupport_file);
   clear xilinx_dsp;
   clear sysgenbin;
   clear mlsupport_file;
   clear mlsupport_table;
   clear okay;
   lasterr('');
else
   disp('Could not find bin directory for System Generator');
   disp('to be added into MATLAB paths.  Please check your XILINX_DSP');
   disp('environment variable.');
   clear sysgenbin;
end
%
%---------------------------------------------------------------
