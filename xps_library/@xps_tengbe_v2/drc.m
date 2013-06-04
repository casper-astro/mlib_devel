%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                             %
%   Center for Astronomy Signal Processing and Electronics Research           %
%   http://seti.ssl.berkeley.edu/casper/                                      %
%   Copyright (C) 2006 University of California, Berkeley                     %
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

function [result,msg] = drc(blk_obj, xps_objs)
result = 0;
msg = '';

for i=1:length(xps_objs)
  try
    our_hw = get(blk_obj, 'hw_sys');

    our_port = get(blk_obj, 'port');
    their_port = get(xps_objs{i},'port');
    our_name = get(blk_obj, 'simulink_name');
    their_name = get(xps_objs{i},'simulink_name');

    %check two blocks not assigned to same port
    if strcmp(our_port, their_port),   %same port
      if ~strcmp(our_name, their_name) % and name not the same
        msg = ['10Ge port ', our_name,' and 10Ge port ', their_name,' are located on the same port.'];
        result = 1;
      end
    end
    
    %check ports in the same slot are using the same mezzanine flavour
    our_flavour = get(blk_obj,'flavour');    
    their_flavour = get(xps_objs{i},'flavour');      
    our_slot = get(blk_obj,'slot');    
    their_slot = get(xps_objs{i},'slot');    
    if strcmp(our_hw, 'ROACH2'),                %roach2      
      if strcmp(our_slot, their_slot),          % and card in the same slot
        if ~strcmp(our_flavour, their_flavour), % and not the same mezzanine flavour
          msg = ['10Ge ports ''', our_name,''' and ''', their_name,''' are both located in mezzanine slot ',our_slot,', but have different mezzanine flavours.'];
          result = 1;
        end
      end
    end

  end %try
end
