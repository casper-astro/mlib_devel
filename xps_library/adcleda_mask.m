
cursys = gcb;

delete_lines(cursys);

gw_name = clear_name(cursys);

reuse_block(cursys, [gw_name, '_p_data_a'], 'xbsIndex_r4/Gateway In', 'arith_type', 'Unsigned', 'n_bits', '32', 'bin_pt', '0', 'Position', [335    65+100   405    85+100])
add_line(cursys, 'Constant/1', [gw_name, '_p_data_a','/1']);
add_line(cursys, [gw_name, '_p_data_a','/1'], 'p_data_a/1');

reuse_block(cursys, [gw_name, '_p_data_b'], 'xbsIndex_r4/Gateway In', 'arith_type', 'Unsigned', 'n_bits', '32', 'bin_pt', '0', 'Position', [345    65+200   415    85+200])
add_line(cursys, 'Constant/1', [gw_name, '_p_data_b','/1']);
add_line(cursys, [gw_name, '_p_data_b','/1'], 'p_data_b/1');

reuse_block(cursys, [gw_name, '_p_data_c'], 'xbsIndex_r4/Gateway In', 'arith_type', 'Unsigned', 'n_bits', '32', 'bin_pt', '0', 'Position', [355    65+300   425    85+300])
add_line(cursys, 'Constant/1', [gw_name, '_p_data_c','/1']);
add_line(cursys, [gw_name, '_p_data_c','/1'], 'p_data_c/1');

reuse_block(cursys, [gw_name, '_p_data_d'], 'xbsIndex_r4/Gateway In', 'arith_type', 'Unsigned', 'n_bits', '32', 'bin_pt', '0', 'Position', [365    65+400   435    85+400])
add_line(cursys, 'Constant/1', [gw_name, '_p_data_d','/1']);
add_line(cursys, [gw_name, '_p_data_d','/1'], 'p_data_d/1');

clean_blocks(cursys);
