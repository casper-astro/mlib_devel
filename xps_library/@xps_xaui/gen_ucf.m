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

function str = gen_ucf(blk_obj)
board = blk_obj.board;
port  = blk_obj.port;

str = gen_ucf(blk_obj.xps_block);
simulink_name = clear_name(get(blk_obj,'simulink_name'));

if ~strcmp(board, 'ROACH')
  str = [str, 'INST "', simulink_name, '/', simulink_name, '/transceiver0/mgt" CHAN_BOND_MODE = "MASTER";       \n'];
  str = [str, 'INST "', simulink_name, '/', simulink_name, '/transceiver1/mgt" CHAN_BOND_MODE = "SLAVE_1_HOP";  \n'];
  str = [str, 'INST "', simulink_name, '/', simulink_name, '/transceiver2/mgt" CHAN_BOND_MODE = "SLAVE_1_HOP";  \n'];
  str = [str, 'INST "', simulink_name, '/', simulink_name, '/transceiver3/mgt" CHAN_BOND_MODE = "SLAVE_1_HOP";  \n'];
  str = [str, 'INST "', simulink_name, '/', simulink_name, '/transceiver?/mgt" REF_CLK_V_SEL = "1";             \n'];
  str = [str, 'INST "', simulink_name, '/', simulink_name, '/transceiver?/mgt" RX_LOSS_OF_SYNC_FSM = "TRUE";    \n'];
  str = [str, 'INST "', simulink_name, '/', simulink_name, '/transceiver?/mgt" CHAN_BOND_ONE_SHOT = "FALSE";    \n'];
  str = [str, 'INST "', simulink_name, '/', simulink_name, '/transceiver?/mgt" TX_PREEMPHASIS = "', blk_obj.preemph, '";            \n'];
  str = [str, 'INST "', simulink_name, '/', simulink_name, '/transceiver?/mgt" TX_DIFF_CTRL = "', blk_obj.swing, '";            \n'];
  str = [str, 'INST "', simulink_name, '/', simulink_name, '/transceiver?/reclock_align" ASYNC_REG = TRUE;      \n'];
end

