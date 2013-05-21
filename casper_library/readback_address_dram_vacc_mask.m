% this address generator will (hopefully!) work for any vector length and it
% doesn't necessary need to be a power of 2. 

cursys = gcb;
disp(cursys);

delete_lines(cursys);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% acc_length is in terms of 128-bit (144-bit!) words!
rowsPerBlock = ceil(acc_length/512.);
if rowsPerBlock > 1
    blockRowBits = ceil(log2(rowsPerBlock));
else 
    blockRowBits = 0;
end

% 8 bits to go through 256*4*72 of 1K length row
% basically 2 bits (representing 144 bits of data) is not counted in this
% counters and its attached later. 
if acc_length < 512
	colCountBits = ceil(log2(acc_length/2));
else 
	colCountBits = 8;
end

% number of rows can be any number and it is not necessary to be a power of
% two!  
%numBlocks = floor(2^14./rowsPerBlock)*8
numBlocks = 2^(14-blockRowBits)*8;
blockCountBits = ceil(log2(numBlocks));
counterBitWidth =  blockRowBits+colCountBits;

readAddrInitVal = valid_length/2;

%disp('acc_length/2-1 is:'); 

acc_length/2-1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

reuse_block(cursys, 'sync', 'built-in/inport', 'Position', [30 65 60 79], 'Port', '1');
reuse_block(cursys, 'en', 'built-in/inport', 'Position', [30 115 60 129], 'Port', '2');
reuse_block(cursys, 'readback_addr', 'built-in/outport', 'Position', [765   150   795  170], 'Port', '1');
reuse_block(cursys, 'block_counter', 'xbsIndex_r4/Counter', ...                                             
        'Position', [95    41   145   94], 'n_bits', 'blockCountBits', 'cnt_type', 'Free Running', ...  
        'arith_type', 'Unsigned', 'en', 'on','start_count', '2^blockCountBits-2');                                                
reuse_block(cursys, 'read_counter', 'xbsIndex_r4/Counter', ...
        'Position', [115    241   165   294], 'n_bits', 'counterBitWidth', 'cnt_type', 'Count Limited', ...
        'arith_type', 'Unsigned', 'en', 'on', 'rst', 'on', 'start_count', '0', 'cnt_to', 'acc_length/2-1');  
reuse_block(cursys, 'concat1', 'xbsIndex_r4/Concat',...       
				'Position', [245 341 295 394], 'num_inputs', '2');  		                 
reuse_block(cursys, 'const0', 'xbsIndex_r4/Constant',...                                                 		
				'Position', [445 190 475 205], 'n_bits', '5', 'bin_pt','0', 'arith_type', 'Unsigned', 'const' , '0');  
reuse_block(cursys, 'const1', 'xbsIndex_r4/Constant',...                                                 		    
				'Position', [445 210 475 225], 'n_bits', '2', 'bin_pt','0', 'arith_type', 'Unsigned', 'const' , '0');
reuse_block(cursys, 'slice6', 'xbsIndex_r4/Slice',...       
				'Position', [345 451 375 471], 'mode' , 'Lower Bit Location + Width','nbits','colCountBits');  
reuse_block(cursys, 'slice7', 'xbsIndex_r4/Slice',...                                                   
				'Position', [345 391 375 411], 'mode' , 'Upper Bit Location + Width','nbits','blockCountBits+blockRowBits'); 
reuse_block(cursys, 'cast1', 'xbsIndex_r4/Convert', ...                                                     
       'Position', [395 451 425 471], 'arith_type', 'Unsigned', 'n_bits', '8', 'bin_pt', '0' ...  
       ,'latency', '0');     
reuse_block(cursys, 'slice9', 'xbsIndex_r4/Slice',...                                                 
				'Position', [395 351 425 371], 'mode' , 'Upper Bit Location + Width','nbits','blockCountBits');
reuse_block(cursys, 'slice10', 'xbsIndex_r4/Slice',...                                                 				
				'Position', [445 351 475 371], 'mode' , 'Lower Bit Location + Width','nbits','2');                                                                                                                                         
reuse_block(cursys, 'slice11', 'xbsIndex_r4/Slice',...                                                 				
				'Position', [445 301 475 321], 'mode' , 'Upper Bit Location + Width','nbits','blockCountBits-2'); 
reuse_block(cursys, 'slice14', 'xbsIndex_r4/Slice',...                                                 				
				'Position', [495 301 525 321], 'mode' , 'Upper Bit Location + Width','nbits','1'); 
reuse_block(cursys, 'slice15', 'xbsIndex_r4/Slice',...                                                 				
				'Position', [495 361 525 381], 'mode' , 'Lower Bit Location + Width','nbits','blockCountBits-3');

if blockRowBits == 0 	 
  reuse_block(cursys, 'concat3', 'xbsIndex_r4/Concat',...     
  				'Position', [595 310 635 460], 'num_inputs', '6'); 
  add_line(cursys, 'const1/1', 'concat3/1');
  add_line(cursys, 'slice10/1', 'concat3/2');
  add_line(cursys, 'slice15/1', 'concat3/3');  
  add_line(cursys, 'slice14/1', 'concat3/4');
  add_line(cursys, 'cast1/1', 'concat3/5'); 
  add_line(cursys, 'const0/1', 'concat3/6');	  
else	  
  reuse_block(cursys, 'concat3', 'xbsIndex_r4/Concat',...     
  				'Position', [595 310 635 460], 'num_inputs', '7'); 
  reuse_block(cursys, 'slice8', 'xbsIndex_r4/Slice',...                                                                                                                                       
				'Position', [395 401 425 421], 'mode' , 'Lower Bit Location + Width','nbits','blockRowBits');
	add_line(cursys, 'slice7/1', 'slice8/1');
  add_line(cursys, 'const1/1', 'concat3/1');
  add_line(cursys, 'slice10/1', 'concat3/2');
  add_line(cursys, 'slice15/1', 'concat3/3');  
  add_line(cursys, 'slice8/1', 'concat3/4');
  add_line(cursys, 'slice14/1', 'concat3/5');
  add_line(cursys, 'cast1/1', 'concat3/6'); 
  add_line(cursys, 'const0/1', 'concat3/7');    
end    				

add_line(cursys, 'sync/1', 'read_counter/1'); 
add_line(cursys, 'en/1', 'read_counter/2'); 
add_line(cursys, 'sync/1', 'block_counter/1');
add_line(cursys, 'block_counter/1', 'concat1/1');                                                 
add_line(cursys, 'read_counter/1', 'concat1/2');  
add_line(cursys, 'concat1/1', 'slice6/1');    
add_line(cursys, 'concat1/1', 'slice7/1');                                               
add_line(cursys, 'slice6/1', 'cast1/1');
add_line(cursys, 'slice7/1', 'slice9/1');
add_line(cursys, 'slice9/1', 'slice10/1');
add_line(cursys, 'slice9/1', 'slice11/1');
add_line(cursys, 'concat3/1', 'readback_addr/1'); 
add_line(cursys, 'slice11/1', 'slice14/1');
add_line(cursys, 'slice11/1', 'slice15/1');

clean_blocks(cursys);




