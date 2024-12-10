## Copyright 

Copyright 2020
ASTRON (Netherlands Institute for Radio Astronomy) <http://www.astron.nl/>
P.O.Box 2, 7990 AA Dwingeloo, The Netherlands

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

## About this core

This is a collection of commonly used base functions, used in all of ASTRONs
other cores.

These source files can work in any environment, however it is recommended to
use the RadioHDL tool to easily generate project files for e.g. Modelsim,
Quartus and Vivado (see 'About hdllib.cfg and the RadioHDL tool').

## Test bench(es)
This core does not contain a test bench.

## Dependencies
This core does not have other cores as dependencies.

## Source files
The source files are listed hdllib.cfg.

## More information about this core
Each source file comes with a header containing more information.

## About hdllib.cfg and the RadioHDL tool
The hdllib.cfg file is included in all ASTRONs cores and is a config file that
is detected by the RadioHDL development tool (also on OpenCores). 

The source files are in order of dependency. However, some or all files could 
also be standalone.

The section 'test_bench_files' can list test benches, but also simulation-only
source files that are not test benches.
