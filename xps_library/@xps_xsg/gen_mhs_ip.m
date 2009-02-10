function [str,opb_addr_end,plb_addr_end,opb_addr_start] = gen_mhs_ip(blk_obj,opb_addr_start,plb_addr_start,plb_name,opb_name)

opb_addr_end = opb_addr_start;
plb_addr_end = plb_addr_start;

clk_src = get(blk_obj, 'clk_src');

if strcmp(clk_src, 'arb_clk')
  target_rate = get(blk_obj, 'clk_rate');
  D=floor((0:(31*32 - 1))/31) + 1;
  M=rem(0:(31*32 - 1), 31) + 2;
  % create a matrix of all the possible frequencies
  freq = 100 * (M ./ D);
  % find the best frequency match greater than the target frequency
  bestmatch = find(freq - 256 == min(abs(freq - 256) + ((freq - 256) < 0) * 1000000));
  bestM = M(bestmatch);
  bestD = D(bestmatch);

  %TODO: this is really a waste as the sys_clk dcm can be used to generate the arb_clk_scm
  %      also phase dcm could be replaced with PLL on V5
  str = [str, 'BEGIN dcm_module',                                            '\n'];
  str = [str, '  PARAMETER INSTANCE = arb_clk_dcm',                          '\n'];
  str = [str, '  PARAMETER HW_VER = 1.00.d',                                 '\n'];
  str = [str, '  PARAMETER C_EXT_RESET_HIGH = 0',                            '\n'];
  str = [str, '  PARAMETER C_CLK0_BUF = TRUE',                               '\n'];
  str = [str, '  PARAMETER C_CLKFX_BUF = TRUE',                              '\n'];
  str = [str, '  PARAMETER C_CLKIN_PERIOD = 10.000000',                      '\n'];
  str = [str, '  PARAMETER C_CLKFX_DIVIDE = ', sprintf('%d', bestD),         '\n']; 
  str = [str, '  PARAMETER C_CLKFX_MULTIPLY = ', sprintf('%d', bestM),       '\n'];  
  str = [str, '  PARAMETER C_DFS_FREQUENCY_MODE = HIGH',                     '\n'];
  str = [str, '  PORT RST    = sys_clk_lock',                                '\n'];
  str = [str, '  PORT CLKIN  = sys_clk',                                     '\n'];
  str = [str, '  PORT CLKFB  = arb_clk_fb',                                  '\n'];
  str = [str, '  PORT CLK0   = arb_clk_fb',                                  '\n'];
  str = [str, '  PORT CLKFX  = arb_clk_int',                                 '\n'];
  str = [str, '  PORT LOCKED = arb_clk_lock',                                '\n'];
  str = [str, 'END',                                                         '\n'];
  str = [str,                                                                '\n'];
  str = [str, 'BEGIN dcm_module',                                            '\n'];
  str = [str, '  PARAMETER INSTANCE = arb_clk_dcm_phasegen',                 '\n'];
  str = [str, '  PARAMETER HW_VER = 1.00.d',                                 '\n'];
  str = [str, '  PARAMETER C_EXT_RESET_HIGH = 0',                            '\n'];
  str = [str, '  PARAMETER C_CLK0_BUF = TRUE',                               '\n'];
  str = [str, '  PARAMETER C_CLK90_BUF = TRUE',                              '\n'];
  str = [str, '  PARAMETER C_CLK180_BUF = TRUE',                             '\n'];
  str = [str, '  PARAMETER C_CLK270_BUF = TRUE',                             '\n'];
  str = [str, '  PARAMETER C_CLKIN_PERIOD = ', sprintf('%d',10*bestD/bestM), '\n'];
  str = [str, '  PARAMETER C_DFS_FREQUENCY_MODE = HIGH',                     '\n'];
  str = [str, '  PORT RST = arb_clk_lock',                                   '\n'];
  str = [str, '  PORT CLKIN  = arb_clk_int',                                 '\n'];
  str = [str, '  PORT CLKFB  = arb_clk',                                     '\n'];
  str = [str, '  PORT CLK0   = arb_clk',                                     '\n'];
  str = [str, '  PORT CLK90  = arb_clk90',                                   '\n'];
  str = [str, '  PORT CLK180 = arb_clk180',                                  '\n'];
  str = [str, '  PORT CLK270 = arb_clk270',                                  '\n'];
  str = [str, 'END',                                                         '\n'];
  str = [str,                                                                '\n'];
  
end % if ~isempty(strcmp(s.clk_src, 'arbclk'))

str = [str, 'BEGIN signal_rename',                                         '\n'];
str = [str, '  PARAMETER INSTANCE = rename_fab_clk',                       '\n'];
str = [str, '  PARAMETER HW_VER = 1.00.a',                                 '\n'];
str = [str, '  PORT sig_in  = ',  clk_src                                  '\n'];
str = [str, '  PORT sig_out = fab_clk',                                    '\n'];
str = [str, 'END',                                                         '\n'];
str = [str,                                                                '\n'];
