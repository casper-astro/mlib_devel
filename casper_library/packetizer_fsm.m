function [ fifo_re, bram_addr_en, bram_we, serializer_shift, serializer_ld, shift_count_en, shift_count_rst, bram_addr_rst, data_count_en, data_count_rst, done] = pseudo_packetizer_fsm( fifo_empty, shift_count, data_per_word, data_count, n_words, sync_reset )

persistent state,
state=xl_state(0,{xlUnsigned,3,0});

state_idle = 0;
state_read = 1;
state_serialize = 2;
state_load_sr = 3;
state_done = 4;
state_init = 5;

switch double(state)

    case state_idle
        fifo_re = false;
        bram_addr_en = false;
        bram_we = false;
        serializer_shift = false;
        serializer_ld = false;
        shift_count_en = false;
        shift_count_rst = true;
        bram_addr_rst = false;
        data_count_en = false;
        data_count_rst = false;
        done = false;
        if data_count >= n_words
            state = state_done;
        elseif ~fifo_empty
            state = state_read;
        end
            
    case state_read
        fifo_re = true;
        bram_addr_en = false;
        bram_we = false;
        serializer_shift = false;
        serializer_ld = false;
        shift_count_en = false;
        shift_count_rst = false;
        bram_addr_rst = false;
        data_count_en = false;
        data_count_rst = false;        
                done = false;
                
        state = state_load_sr;
        
    case state_load_sr
        fifo_re = false;
        bram_addr_en = false;
        bram_we = false;
        serializer_shift = false;
        serializer_ld = true;
        shift_count_en = false;
        shift_count_rst = false;
        bram_addr_rst = false;
        data_count_en = false;
        data_count_rst = false;
                done = false;
                
        state = state_serialize;
        
    case state_serialize
        fifo_re = false;
        bram_addr_en = true;
        bram_we = true;
        serializer_shift = true;
        serializer_ld = false;
        shift_count_en = true;
        shift_count_rst = false;
        bram_addr_rst = false;
        data_count_en = true;
        data_count_rst = false;
                done = false;
        
        if (shift_count == data_per_word)
            state = state_idle;
        end
        
    case state_done
        fifo_re = false;
        bram_addr_en = false;
        bram_we = false;
        serializer_shift = false;
        serializer_ld = false;   
        shift_count_en = false;
        shift_count_rst = false;
        bram_addr_rst = true;
        data_count_en = false;
        data_count_rst = true;  
                done = true;
        
        if sync_reset
            state = state_init;
        end
        
    case state_init
        fifo_re = false;
        bram_addr_en = false;
        bram_we = false;
        serializer_shift = false;
        serializer_ld = false;   
        shift_count_en = false;
        shift_count_rst = false;
        bram_addr_rst = false;
        data_count_en = false;
        data_count_rst = false;
        done = false;        
        if ~fifo_empty
            state = state_idle;
        else
            state = state_init;
        end
        
    otherwise
        fifo_re = false;
        bram_addr_en = false;
        bram_we = false;
        serializer_shift = false;
        serializer_ld = false;   
        shift_count_en = false;
        shift_count_rst = false;
        bram_addr_rst = false;
        data_count_en = false;
        data_count_rst = false;
                done = false;
        
        state = state_done;
        
        
        
                
end