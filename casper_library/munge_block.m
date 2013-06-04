% Performs various munges on a block.
%
% munge_block(blk,varargin)
%
% blk - The block whose mask will be dumbed down or turned off
% varargin - A cell array of strings indicating the munges to do.
%
% Supported munges:
%
% 'dumbdown'
%
%   Dumbing down a block's mask makes the block's mask informative only;
%   the mask can no longer be used to configure the subsystem.  Here is
%   a list of what happens to a mask that is dumbed down...
%
%   o MaskInitialization code is deleted.
%   o All mask parameters are marked as disabled, non-tunable, and
%     do-not-evaluate. 
%
% 'unmask'
%
%   Turns off the block's mask.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   Center for Astronomy Signal Processing and Electronics Research           %
%   http://seti.ssl.berkeley.edu/casper/                                      %
%   Copyright (C) 2006 David MacMahon, Aaron Parsons                          %
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

function munge_block(blk,varargin)

try

  % Don't munge if blk lives in a library
  if is_library_block(blk), return, end
  
  % Disable link
  set_param(blk,'LinkStatus','inactive');
  
  % Take appropriate munge action
  switch get_var('munge', varargin{:})
      case 'dumbdown'
        % Nuke any mask initialization code
        set_param(blk,'MaskInitialization','');
        % Make mask params disabled
        mes=get_param(blk,'MaskEnableString');
        mes=strrep(mes,'on','off');
        set_param(blk,'MaskEnableString',mes);
        % Make mask params non-tunable
        mtvs=get_param(blk,'MaskTunableValueString');
        mtvs=strrep(mtvs,'on','off');
        set_param(blk,'MaskTunableValueString',mtvs);
        % Make mask params literal (non-evaluated)
        mv=get_param(blk,'MaskVariables');
        mv=strrep(mv,'@','&');
        set_param(blk,'MaskVariables',mv);
      case 'unmask'
        set_param(blk,'Mask','off');
  end
catch ex
  dump_and_rethrow(ex);
end
