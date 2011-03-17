% Run unit tests for a particular library
%
% test_init(blk, varargin)
%
% blk = The block to be configured.
% varargin = {'varname', 'value', ...} pairs
%
% Valid varnames for this block are:
% tests_location = location of unit tests and test scripts
% tests_file - The file containing the module components to test
% test_type = Type of test to run ('all', library 'section', individual 'unit')
% section = Name of section when testing library subsection or section containing unit
% block = Name of individual block to run unit tests for

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   Karoo Array Telescope Project                                             %
%   www.kat.ac.za                                                             %
%   Copyright (C) 2011 Andrew Martens                                         %
%                                                                             %
%   This program is free software; you can redistribute it and/or modify      %
%   it under the terms of the GNU General Public License as published by      %
%   the Free Software Foundation; either version 2 of the License, or         %
%   (at your option) any later version.                                       %
%                                                                             %
%   This program is distributed in the hope that it will be useful,           %
%   but WITHOUT ANY WARRANTY; without even the implied warranty of            %
%   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the             %
%   GNU General Public License for more details.                              %
%                                                                             %
%   You should have received a copy of the GNU General Public License along   %
%   with this program; if not, write to the Free Software Foundation, Inc.,   %
%   51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.               %
%                                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function test_init(blk, varargin)
  clog('entering test_init','trace');

  check_mask_type(blk, 'test');
 
  defaults = {'tests_location', '/opt/casper_git_devel/casper_library/Tests', ...
    'tests_file', 'tester_input.txt', 'test_type', 'unit', ...
    'subsection', 'Misc', 'block', 'adder_tree', 'stop_first_fail', 'on'};
  
  tests_location = get_var('tests_location', 'defaults', defaults, varargin{:});
  tests_file = get_var('tests_file', 'defaults', defaults, varargin{:});
  test_type = get_var('test_type', 'defaults', defaults, varargin{:});
  subsection = get_var('subsection', 'defaults', defaults, varargin{:});
  block = get_var('block', 'defaults', defaults, varargin{:});
  stop_first_fail = get_var('stop_first_fail', 'defaults', defaults, varargin{:});
  clog('got variables','test_init_detailed_trace');

  %make tests folder accessible
  addpath(tests_location);
  clog('added tests_location path','test_init_detailed_trace');
  %may not actually be testing casper_library so unpollute namespace
  close_system('casper_library',0);
  clog('closed casper_library','test_init_detailed_trace');

  test_library('tests_file', tests_file, 'test_type', ...
  test_type, 'subsection', subsection, 'block', block, ...
  'stop_first_fail', stop_first_fail);        
  
  %reload casper_library
  load_system('casper_library');
  rmpath(tests_location);

  clog('exiting test_init', 'trace');
