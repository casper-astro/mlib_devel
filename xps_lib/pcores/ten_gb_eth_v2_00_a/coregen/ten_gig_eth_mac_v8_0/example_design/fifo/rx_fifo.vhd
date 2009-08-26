-------------------------------------------------------------------------------
-- Title      : XGMAC client to Local-link Receiver FIFO
-- Project    : 10 Gigabit Ethernet MAC Core
-------------------------------------------------------------------------------
-- File       : rx_fifo.vhd
-- Author     : Xilinx Inc.
-------------------------------------------------------------------------------
-- Copyright (c) 2004-2006 by Xilinx, Inc. All rights reserved.
-- This text/file contains proprietary, confidential
-- information of Xilinx, Inc., is distributed under license
-- from Xilinx, Inc., and may be used, copied and/or
-- disclosed only pursuant to the terms of a valid license
-- agreement with Xilinx, Inc. Xilinx hereby grants you
-- a license to use this text/file solely for design, simulation,
-- implementation and creation of design files limited
-- to Xilinx devices or technologies. Use with non-Xilinx
-- devices or technologies is expressly prohibited and
-- immediately terminates your license unless covered by
-- a separate agreement.
--
-- Xilinx is providing this design, code, or information
-- "as is" solely for use in developing programs and
-- solutions for Xilinx devices. By providing this design,
-- code, or information as one possible implementation of
-- this feature, application or standard, Xilinx is making no
-- representation that this implementation is free from any
-- claims of infringement. You are responsible for
-- obtaining any rights you may require for your implementation.
-- Xilinx expressly disclaims any warranty whatsoever with
-- respect to the adequacy of the implementation, including
-- but not limited to any warranties or representations that this
-- implementation is free from claims of infringement, implied
-- warranties of merchantability or fitness for a particular
-- purpose.
--
-- Xilinx products are not intended for use in life support
-- appliances, devices, or systems. Use in such applications are
-- expressly prohibited.
--
-- This copyright and support notice must be retained as part
-- of this text at all times. (c) Copyright 2004-2006 Xilinx, Inc.
-- All rights reserved.
-------------------------------------------------------------------------------
-- Description: This is the receiver side local link fifo for the client 
--              loopback design example of the 10 Gigabit Ethernet MAC core
--
--              The FIFO is created from Block RAMs and can be chosen to of 
--              size (in 8 bytes words) 512, 1024, 2048, 4096, 8192, or 2048.
--
--              Frame data received from the MAC receiver is written into the
--              data field of the BRAM on the rx_clk.  Start of Frame (SOF), 
--              End of Frame (EOF) and a binary encoded Remainder signal 
--              (indicating the number of valid bytes in the last word of the 
--              frame) are created and stored in the parity field of the BRAM
--
--              The rx_good_frame and rx_bad_frame signals are used to
--              qualify the frame.  A frame for which rx_bad_frame was
--              asserted will cause the FIFO write address pointer to be
--              reset to the base address of that frame.  In this way
--              the bad frame will be overwritten with the next received
--              frame and is therefore dropped from the FIFO.
--
--              When there is at least one complete frame in the FIFO,
--              the Local-link read interface will be enabled allowing
--              data to be read from the fifo.
--
--              NOTE: that all LocalLink signals in this file are active high!
-------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity rx_fifo is
   generic (
      fifo_size : integer := 512);
   port (
      -- MAC Rx Client I/F (FIFO write domain)
      rx_clk         : in  std_logic;
      rx_sreset      : in  std_logic;
      rx_data        : in  std_logic_vector(63 downto 0);
      rx_data_valid  : in  std_logic_vector(7 downto 0);
      rx_good_frame  : in  std_logic;
      rx_bad_frame   : in  std_logic;

      -- LocalLink I/F (FIFO read domain): 
      -- NOTE: all signals here are active high
      rd_clk         : in  std_logic;
      rd_sreset      : in  std_logic;
      dst_rdy_in     : in  std_logic;
      data_out       : out std_logic_vector(63 downto 0);
      rem_out        : out std_logic_vector(2 downto 0);
      sof_out        : out std_logic;
      eof_out        : out std_logic;
      src_rdy_out    : out std_logic;
      
      -- FIFO Status Signals
      rx_fifo_status : out std_logic_vector(3 downto 0);
      fifo_full      : out std_logic);

end rx_fifo;


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library unisim;
use unisim.vcomponents.all;

library work;
use work.xgmac_fifo_pack.all;


architecture rtl of rx_fifo is


   -- the address width required is a function of FIFO size
   constant addr_width        : integer := log2(fifo_size);

   -- write clock domain
   signal wr_addr             : unsigned(addr_width-1 downto 0);            -- current write address
   signal wr_addr_last        : unsigned(addr_width-1 downto 0);            -- store last address for frame drop
   signal wr_rd_addr_gray     : unsigned(addr_width-1 downto 0);            -- rd_addr in wr domain (grey code)
   signal wr_rd_addr          : unsigned(addr_width-1 downto 0);            -- rd_addr in wr domain
   signal wr_enable           : std_logic;                                  -- write enable
   signal wr_enable_pipe      : std_logic;                                  -- write enable pipelined
   signal wr_fifo_full        : std_logic;                                  -- fifo full
   signal wr_data_pipe        : std_logic_vector(63 downto 0);              -- write data pipelined
   signal wr_ctrl_pipe        : std_logic_vector(3 downto 0);               -- contains SOF, EOF and Remainder information for the frame: stored in the parity bits of BRAM.
   signal wr_drop_frame       : std_logic;                                  -- decision to drop the previous received frame
   signal wr_store_frame      : std_logic;                                  -- decision to keep the previous received frame 
   signal wr_store_frame_reg  : std_logic;                                  -- wr_store_frame pipelined 
   signal wr_store_frame_tog  : std_logic;                                  -- toggle everytime a frame is kept: this crosses onto the read clock domain 
   signal wr_rem              : std_logic_vector(2 downto 0);               -- Number of bytes valiod in last word of frame encoded as a binary remainder 
   signal wr_sof              : std_logic;                                  -- asserted with the 1st word of the frame 
   signal wr_eof              : std_logic;                                  -- asserted with the last word of the frame 

   
   -- read clock domain
   signal rd_addr             : unsigned(addr_width-1 downto 0);            -- current read address
   signal rd_addr_gray        : unsigned(addr_width-1 downto 0);            -- read address grey encoded 
   signal rd_addr_gray_reg    : unsigned(addr_width-1 downto 0);            -- read address grey encoded 
   signal rd_frames           : unsigned(addr_width-2 downto 0);            -- A count of the number of frames currently stored in the FIFO
   signal rd_store_frame_tog  : std_logic;                                  -- sample wr_store_frame_tog on the read clock 
   signal rd_store_frame_sync : std_logic;                                  -- register wr_store_frame_tog a 2nd time 
   signal rd_store_frame      : std_logic;                                  -- edge detector for wr_store_frame_tog 
   signal rd_enable           : std_logic;                                  -- read enable 
   signal rd_data             : std_logic_vector(63 downto 0);              -- data word output from BRAM 
   signal rd_ctrl             : std_logic_vector(3 downto 0);               -- data control output from BRAM parity (contains SOF, EOF and Remainder information for the frame) 
   signal rd_avail            : std_logic;                                  -- there is at least 1 frame stored in the FIFO
   signal rd_state            : std_logic_vector(2 downto 0);               -- frame read state machine
   signal wr_addr_diff        : unsigned(addr_width-1 downto 0);            -- the difference between read and write address 
   signal wr_addr_diff_2s_comp : unsigned(addr_width-1 downto 0);            -- 2's compl of read and write address diff
   	  
   attribute async_reg                      : string;
   attribute async_reg of wr_rd_addr_gray   : signal is "true";

begin


  ----------------------------------------------------------------------
  -- FIFO Read domain
  ----------------------------------------------------------------------


  -- Edge detector to register that a new frame was written into the 
  -- FIFO.  
  -- NOTE: wr_store_frame_tog crosses clock domains from FIFO write
  p_sync_rd_store : process (rd_clk)
  begin 
    if rd_clk'event and rd_clk = '1' then 
      if rd_sreset = '1' then
        rd_store_frame_tog  <= '0';
        rd_store_frame_sync <= '0';
        rd_store_frame      <= '0';

      else
        rd_store_frame_tog  <= wr_store_frame_tog;
        rd_store_frame_sync <= rd_store_frame_tog;

        -- edge detector
        if (rd_store_frame_sync xor rd_store_frame_tog) = '1' then
          rd_store_frame    <= '1';
        else
          rd_store_frame    <= '0';
        end if;
      end if;
    end if;
  end process p_sync_rd_store;
   

    																
  -- Up/Down counter to monitor the number of frames stored within the
  -- the FIFO. Note:  
  --    * decrements at the beginning of a frame read cycle
  --    * increments at the end of a frame write cycle
  p_rd_frames : process (rd_clk)
  begin 
    if rd_clk'event and rd_clk = '1' then 
      if rd_sreset = '1' then
        rd_frames <= (others => '0');

      else
        -- A frame has been written into the FIFO
        if rd_store_frame = '1' then
          if rd_state = "001" then 
            -- one in, one out = no change
            rd_frames <= rd_frames;
          else
            if rd_frames /= (rd_frames'range => '1') then -- if we max out error!
              rd_frames <= rd_frames + 1;
            end if;
          end if;
        else
          -- A frame is about to be read out of the FIFO
          if rd_state = "001" then -- one out = take 1
            if rd_frames /= (rd_frames'range => '0') then -- if we bottom out error!
              rd_frames <= rd_frames - 1;
            end if;
          end if;
        end if;
      end if;
    end if;
  end process p_rd_frames;
    


  -- Data is available if there is at leat one frame stored in the FIFO.
  p_rd_avail : process (rd_clk)
  begin 
    if rd_clk'event and rd_clk = '1' then 
      if rd_sreset = '1' then
        rd_avail <= '0';

      else
        if rd_frames /= (rd_frames'range => '0') then
          rd_avail <= '1';
        else
          rd_avail <= '0';
        end if;
      end if;
    end if;
  end process p_rd_avail;
    
   

  -- Read State Machine: to run through the frame read cycle.
  p_rd_state : process (rd_clk)
  begin 
    if rd_clk'event and rd_clk = '1' then 
      if rd_sreset = '1' then
        rd_state <= "000";

      else
        case rd_state is 
          -- Idle state
          when "000" =>
            -- check for at least 1 frame stored in the FIFO:
            if rd_avail = '1' then
              rd_state <= "001"; 
            end if;

          -- Read Initialisation 1: read 1st frame word out of FIFO
          when "001" =>
              rd_state <= "010";

          -- Read Initialisation 2: 1st word and SOF are registered onto
          --                        LocalLink whilst 2nd word is fetched
          when "010" =>
              rd_state <= "011";

          -- Frame Read in Progress
          when "011" =>
            -- detect the end of the frame
            if dst_rdy_in = '1' and rd_ctrl(3) = '1' then  
              rd_state <= "100";
            end if;

          -- End of Frame Read: EOF is driven onto LocalLink
          when "100" =>
            if dst_rdy_in = '1' then  -- wait until EOF is sampled  
              if rd_avail = '1' then  -- frame is waiting
                rd_state <= "001"; 
              else                    -- go to Idle state
                rd_state <= "000";
              end if;
            end if;

          when others =>
            rd_state <= "000";
        end case;
      end if;
    end if;
  end process p_rd_state;
     
  

  -- Read Enable signal based on Read State Machine 
  rd_enable <= '1' when rd_state = "001" or rd_state = "010" or   -- Read Initialisation States
                       (rd_state = "011" and rd_ctrl(3) = '0'     -- Frame Read in Progress but not EOF 
                         and dst_rdy_in = '1')
                   else '0';

  

  -- Create the Read Address Pointer 
  p_rd_addr : process (rd_clk)
  begin 
    if rd_clk'event and rd_clk = '1' then 
      if rd_sreset = '1' then
        rd_addr <= (others => '0');

      elsif rd_enable = '1' then
        rd_addr <= rd_addr + 1;
      end if;
    end if;
  end process p_rd_addr;

     

  -- Create the LocalLink Output Packet Signals
  p_rd_pipe : process (rd_clk)
  begin 
    if rd_clk'event and rd_clk = '1' then
      if rd_sreset = '1' then
        data_out      <= (others => '0');
        rem_out       <= "111";  
        eof_out       <= '0';
        sof_out       <= '0';

      elsif rd_state = "010" or (rd_state /= "000" and dst_rdy_in = '1') then
        -- pipeline appropriately for registered read
        data_out      <= rd_data;

        -- The remainder is encoded into rx_ctrl[2:0]
        rem_out       <= rd_ctrl(2 downto 0);

        -- The EOF is encoded into rx_ctrl[3] but needs to be qualified to 
        -- ensure that its deasserted once its been read.
        if rd_state = "011" then
          eof_out       <= rd_ctrl(3);
        else 
          eof_out       <= '0';  
        end if;

        -- The SOF is indicated by rx_ctrl[3:0] = "0001"
        if rd_ctrl = "0001" then
          sof_out     <= '1';
        else
          sof_out     <= '0';
        end if;

      end if;
    end if;
  end process p_rd_pipe;
     


  -- Create the LocalLink Output Source Ready Signal
  p_src_rdy : process (rd_clk)
  begin 
    if rd_clk'event and rd_clk = '1' then
      if rd_sreset = '1' then
        src_rdy_out    <= '0';

      else
        -- Assert during Read Initialisation 2 state (when SOF is driven onto LocalLink)
        if rd_state = "010" then
          src_rdy_out   <= '1';

        -- Remove on End of Frame Read state (when EOF has been sampled on LocalLink)
        elsif rd_state = "100" and dst_rdy_in = '1' then
          src_rdy_out   <= '0';
        end if;
      end if;
    end if;
  end process p_src_rdy;   
  

    
  -- Take the Read Address Pointer and convert it into a grey code 
  rd_addr_gray <= unsigned(bin_to_gray(std_logic_vector(rd_addr)));

  -- register the gray code read address pointer in read clock domain.
  p_rd_addr_reg : process (rd_clk)
  begin 
     if rd_clk'event and rd_clk = '1' then
       if rd_sreset = '1' then
         rd_addr_gray_reg <= (others => '0');
       else
         rd_addr_gray_reg <= rd_addr_gray;
       end if;
     end if;
  end process p_rd_addr_reg;

  ----------------------------------------------------------------------
  -- FIFO Write Domain
  ----------------------------------------------------------------------

  
  -- Resync the Read Address Pointer grey code onto the write clock
  -- NOTE: rd_addr_gray signal crosses clock domains
  p_sync_rd_addr : process (rx_clk)
  begin 
     if rx_clk'event and rx_clk = '1' then 
        if rx_sreset = '1' then
          wr_rd_addr_gray <= (others => '0');
        else
          wr_rd_addr_gray <= rd_addr_gray_reg;
        end if;
     end if;
  end process p_sync_rd_addr;   

  -- Convert the resync'd Read Address Pointer grey code back to binary
  wr_rd_addr <= unsigned(gray_to_bin(std_logic_vector(wr_rd_addr_gray)));



  -- Obtain the difference between write and read pointers
  wr_addr_diff <= wr_rd_addr - wr_addr;


  ----------------------------------------------------------------------
  -- Create FIFO Status Signals 
  ----------------------------------------------------------------------
  -- The FIFO status signal is four bits which represents the occupancy
  -- of the FIFO in 16'ths.  To generate this signal we need use the 
  -- 2's complement of the difference between the read and write 
  -- pointers and take the top 4 bits.

  wr_addr_diff_2s_comp <= not(wr_addr_diff) + 1;
  
  -- The 4 most significant bits of the write pointer minus the 4 msb of
  -- the read pointer gives us our FIFO status.
  p_fifo_status : process (rx_clk)
  begin 
     if rx_clk'event and rx_clk = '1' then
       if rx_sreset = '1' then
         rx_fifo_status <= "0000";
       else
         rx_fifo_status <= std_logic_vector(wr_addr_diff_2s_comp(addr_width-1 downto addr_width-4));
       end if;
     end if;
  end process p_fifo_status;

    

  -- Detect when the FIFO is full
  p_wr_full : process (rx_clk)
  begin 
     if rx_clk'event and rx_clk = '1' then
       if rx_sreset = '1' then
         wr_fifo_full <= '0';
       else

         -- The FIFO is considered to be full if the write address
         -- pointer is within 1 to 3 of the read address pointer.
         if wr_addr_diff(addr_width-1 downto 2) = 0 and wr_addr_diff(1 downto 0) /= "00" then
           wr_fifo_full <= '1';

         -- We hold the full signal until the end of frame reception to guarantee that this
         -- frame will be dropped
         elsif (rx_good_frame or rx_bad_frame) = '1' then
           wr_fifo_full <= '0';
         end if;
       end if;
     end if;
  end process p_wr_full;   

  fifo_full <= wr_fifo_full;

  -- Create the Write Address Pointer 
  p_wr_addr : process (rx_clk)
  begin 
     if rx_clk'event and rx_clk = '1' then
        if rx_sreset = '1' then
          wr_addr <= (others => '0');
        else
          -- If the received frame contained an error, it will be over-
          -- written: reload the starting address for that frame
          if wr_drop_frame = '1' then
            wr_addr <= wr_addr_last;

          -- increment write pointer as frame is written.
          elsif wr_enable_pipe = '1' then
            wr_addr <= wr_addr + 1;
          end if;
        end if;
     end if;
  end process p_wr_addr;   

  -- Record the starting address of a new frame in case it needs to be 
  -- overwritten
  p_wr_addr_last : process (rx_clk)
  begin 
     if rx_clk'event and rx_clk = '1' then
       if rx_sreset = '1' then
         wr_addr_last <= (others => '0');
       elsif wr_store_frame_reg = '1' then
         wr_addr_last <= wr_addr;
       end if;
     end if;
  end process p_wr_addr_last; 

  
  
  -- Write Enable signal based on MAC Rx Client signals and FIFO status 
  wr_enable <= '1' when rx_data_valid(0) = '1' and wr_fifo_full = '0' else '0';



  -- At the end of frame reception, decide whether to keep the frame or
  -- to overwrite it with the next.
  p_wr_end : process (rx_clk)
  begin 
     if rx_clk'event and rx_clk = '1' then
       if rx_sreset = '1' then
         wr_store_frame       <= '0';
         wr_store_frame_reg   <= '0';
         wr_drop_frame        <= '0';
         wr_store_frame_tog   <= '0';

       else
         wr_store_frame_reg   <= wr_store_frame;

         -- Error free frame is received and has fit in the FIFO: keep
         if rx_good_frame = '1' and wr_fifo_full = '0' then
           wr_store_frame     <= '1';
           wr_drop_frame      <= '0';
           wr_store_frame_tog <= not wr_store_frame_tog;

         -- Error free frame is received but does not fit in FIFO or
         -- an error-ed frame is received: discard frame
         elsif (rx_good_frame = '1' and wr_fifo_full = '1') or rx_bad_frame = '1' then
           wr_store_frame     <= '0';
           wr_drop_frame      <= '1';

         else
           wr_store_frame     <= '0';
           wr_drop_frame      <= '0';
         end if;
       end if;
     end if;
  end process p_wr_end;   



  -- Pipeline the data and control signals to BRAM
  p_wr_pipe : process (rx_clk)
  begin 
     if rx_clk'event and rx_clk = '1' then
       if rx_sreset = '1' then
         wr_data_pipe   <= (others => '0');
         wr_enable_pipe <= '0';
         wr_rem         <= "000";
         wr_sof         <= '0';

       else
         -- pipeline write enable and the data
         wr_enable_pipe <= wr_enable;
         wr_data_pipe   <= rx_data;

         -- the rising edge of the write enable indicates SOF
         wr_sof <= wr_enable and not wr_enable_pipe;

         -- Encode the data valid signals as a binary remainder:

         -- rx_data_valid   wr_rem
         -- -------------   ------
         -- 0x00000001      000
         -- 0x00000011      001
         -- 0x00000111      010
         -- 0x00001111      011
         -- 0x00011111      100
         -- 0x00111111      101
         -- 0x01111111      110
         -- 0x11111111      111

         wr_rem(2) <= rx_data_valid(4);

         case rx_data_valid is
         when "00000001" | "00011111" =>
           wr_rem(1 downto 0) <= "00";
         when "00000011" | "00111111" =>
           wr_rem(1 downto 0) <= "01";
         when "00000111" | "01111111" =>
           wr_rem(1 downto 0) <= "10";
         when others =>
           wr_rem(1 downto 0) <= "11";
         end case;
       end if;

     end if;
  end process p_wr_pipe; 
   


  -- the falling edge of the write enable indicates EOF
  wr_eof <= not wr_enable and wr_enable_pipe;



  -- This signal, stored in the parity bits of the BRAM, contains SOF,
  -- EOF and Remainder information for the stored frame:
  
  -- when wr_ctrl = 0x0001 : SOF indication
  -- otherwise:
  -- wr_ctrl[3]    = EOF
  -- wr_ctrl([2:0] = remainder 
  
  -- Note that remainder is only valid when EOF is asserted.
               
  wr_ctrl_pipe <= wr_eof & wr_rem when (wr_sof = '0') else "0001"; 



  ----------------------------------------------------------------------
  -- Instantiate BRAMs to produce the dual port memory
  ----------------------------------------------------------------------
  
  fifo_ram_inst : fifo_ram 
     generic map (                           
        addr_width => log2(fifo_size))       
     port map (                              
        wr_clk    => rx_clk,                 
        wr_addr   => std_logic_vector(wr_addr),            
        data_in   => wr_data_pipe,                
        ctrl_in   => wr_ctrl_pipe,                
        wr_allow  => wr_enable_pipe,               
        rd_clk    => rd_clk,                 
        rd_sreset => rd_sreset,              
        rd_addr   => std_logic_vector(rd_addr),            
        data_out  => rd_data,               
        ctrl_out  => rd_ctrl,               
        rd_allow  => rd_enable);          
 

end rtl;
