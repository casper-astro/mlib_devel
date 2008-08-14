----------------------------------------------------------------------------
-- $RCSfile: tx_fifo.vhd,v $
-- $Revision: 1.1 $
-- $Date: 2006/09/06 18:13:23 $
----------------------------------------------------------------------------
-- Title      : Transmit FIFO
-- Project    : Ten Gigabit Ethernet MAC Core
----------------------------------------------------------------------------
-- File       : tx_fifo.vhd
-- Author     : Xilinx, Inc.
----------------------------------------------------------------------------
-- Description: This is the frame and address counter logic for the transmit
--              FIFO.   Once a complete frame is present in the Fifo it
--              will be presented to the core for transmission.
----------------------------------------------------------------------------
-- Copyright (c) 2006 by Xilinx, Inc. All rights reserved.
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
-- of this text at all times. (c) Copyright 2006 Xilinx, Inc.
-- All rights reserved.
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tx_fifo is
   generic (
      fifo_size     : integer := 512);
   port (
      wr_clk         : in  std_logic;
      wr_sreset      : in  std_logic;
      data_in        : in  std_logic_vector(63 downto 0);
      rem_in         : in  std_logic_vector(2 downto 0);
      sof_in         : in  std_logic;
      eof_in         : in  std_logic;
      src_rdy_in     : in  std_logic;
      dst_rdy_out    : out std_logic;
      fifo_full      : out std_logic;
      rd_clk         : in  std_logic;
      rd_sreset      : in  std_logic;
      tx_data        : out std_logic_vector(63 downto 0);
      tx_data_valid  : out std_logic_vector(7 downto 0);
      tx_start       : out std_logic;
      tx_ack         : in  std_logic);
end tx_fifo;
------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library unisim;
use unisim.vcomponents.all;

library work;
use work.xgmac_fifo_pack.all;

architecture rtl of tx_fifo is

   constant addr_width        : integer := log2(fifo_size);

   -- write clock domain
   signal wr_addr             : unsigned(addr_width-1 downto 0); -- current write address
   signal wr_addr_last        : unsigned(addr_width-1 downto 0); -- store last address for frame drop
   signal wr_rd_addr          : unsigned(addr_width-1 downto 0); -- rd_addr in wr domain
   signal wr_rd_addr_gray     : unsigned(addr_width-1 downto 0); -- rd_addr in wr domain
   signal wr_frame_done       : std_logic; -- convert to toggle and pass to rd domain
   signal wr_enable           : std_logic; -- global write enable
   signal wr_enable_pipe      : std_logic; -- global write enable
   signal wr_fifo_full        : std_logic; -- fifo full
   signal wr_data_pipe        : std_logic_vector(63 downto 0);
   signal wr_ctrl_pipe        : std_logic_vector(3 downto 0);
   signal wr_drop_frame       : std_logic; -- error on tx (double SOF)
   signal wr_store_frame      : std_logic; 
   signal wr_store_frame_tog  : std_logic; 
   signal wr_inframe          : std_logic; 
   signal wr_addr_diff        : unsigned(addr_width-1 downto 0);

   
   -- read clock domain
   signal rd_addr             : unsigned(addr_width-1 downto 0); -- current read address
   signal rd_addr_gray        : unsigned(addr_width-1 downto 0); 
   signal rd_addr_gray_reg    : unsigned(addr_width-1 downto 0); 
   signal rd_frames           : unsigned(addr_width-2 downto 0); -- current frame queue
   signal rd_store_frame_tog  : std_logic;
   signal rd_store_frame_sync : std_logic;
   signal rd_store_frame      : std_logic;
   signal rd_enable           : std_logic;
   signal rd_data_pipe        : std_logic_vector(63 downto 0);
   signal rd_valid_pipe       : std_logic_vector(7 downto 0);
   signal rd_data             : std_logic_vector(63 downto 0);
   signal rd_ctrl             : std_logic_vector(3 downto 0);
   signal rd_avail            : std_logic;
   
   type   rd_states is (IDLE, INIT, PAUSE, RUN);
   signal rd_state            : rd_states;

   attribute async_reg                      : string;
   attribute async_reg of wr_rd_addr_gray   : signal is "true";

begin


  ----------------------------------------------------------------------
  -- FIFO Read domain
  ----------------------------------------------------------------------

  tx_data  <= rd_data_pipe;
  tx_data_valid <= rd_valid_pipe;

  -- Edge detector to register that a new frame was written into the 
  -- FIFO
  p_sync_rd_store : process (rd_clk)
  begin 
    if rd_clk'event and rd_clk = '1' then 
      if rd_sreset = '1' then
        rd_store_frame_tog <= '0';
        rd_store_frame_sync <= '0';
        rd_store_frame  <= '0';
      else
        rd_store_frame_tog <= wr_store_frame_tog;
        rd_store_frame_sync <= rd_store_frame_tog;
        if (rd_store_frame_sync xor rd_store_frame_tog) = '1' then
          rd_store_frame  <= '1';
        else
          rd_store_frame  <= '0';
        end if;
      end if;
    end if;
  end process p_sync_rd_store; 

  
    
  -- Up/Down counter to monitor the number of frames stored within the
  -- FIFO. Note:  
  --    * decrements at the beginning of a frame read cycle
  --    * increments at the end of a frame write cycle
  p_rd_frames : process (rd_clk)
  begin 
    if rd_clk'event and rd_clk = '1' then 
      if rd_sreset = '1' then
        rd_frames <= (others => '0');
      else 
        if rd_store_frame = '1' then
          if rd_state = INIT then -- one in, one out = no change
            rd_frames <= rd_frames;
          else
            if rd_frames /= (rd_frames'range => '1') then -- if we max out error!
              rd_frames <= rd_frames + 1;
            end if;
          end if;
        else
          if rd_state = INIT then -- one out = take 1
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
        rd_state <= IDLE;
      else 
        case rd_state is 
          -- Idle state
          when IDLE =>
            -- check for at least 1 frame stored in the FIFO:
            if rd_avail = '1' then
              rd_state <= INIT; 
            end if;

          -- Read Initialisation: state lasts for a single clock
          when INIT =>
            rd_state <= PAUSE;

          -- Wait for tx_ack from MAC
          when PAUSE =>
            if tx_ack = '1' then
              if rd_ctrl(3) = '1' then 
                rd_state <= IDLE;
              else
                rd_state <= RUN;
              end if;
            end if;

          -- Frame Read in Progress
          when RUN =>
            if rd_ctrl(3) = '1' then -- eof from RAM
              rd_state <= IDLE;
            end if;

          when others =>
            null;
            
        end case;
      end if;
    end if;
  end process p_rd_state;   



  -- Add a wr_addr to rd_addr sync so we can check for error if we go empty
  -- We'll rely on the frame count only for now.



  -- Read Enable signal based on Read State Machine 
  rd_enable <= '1' when rd_state = INIT or rd_state = RUN or 
                        (rd_state = IDLE and rd_avail = '1') or
                        (rd_state = PAUSE and tx_ack = '1') else '0';
  


  -- Create the Read Address Pointer 
  p_rd_addr : process (rd_clk)
  begin 
    if rd_clk'event and rd_clk = '1' then 
      if rd_sreset = '1' then
        rd_addr <= (others => '0');
      else 
        --if (rd_ctrl(3) = '0' or rd_state = IDLE) and rd_enable = '1' then
        if (rd_ctrl(3) = '0' or rd_state = IDLE) and rd_enable = '1' then
          rd_addr <= rd_addr + 1;
        end if;
      end if;
    end if;
  end process p_rd_addr;
     


  -- Create the byte valid signals for the frame read out of the FIFO 
  p_rd_pipe : process (rd_clk)
  begin 
    if rd_clk'event and rd_clk = '1' then 
      if rd_sreset = '1' then
        rd_data_pipe <= (others => '0');
        rd_valid_pipe <= (others => '0');
      else
        if rd_enable = '1' then
          rd_data_pipe <= rd_data;
        end if;
        if rd_state = IDLE then
          rd_valid_pipe <= "00000000";
        elsif rd_enable = '1' then
          case rd_ctrl is
            -- Deal with the last word of the frame (not all bytes may be valid)
            when "1000" => rd_valid_pipe <= "00000001";
            when "1001" => rd_valid_pipe <= "00000011";
            when "1010" => rd_valid_pipe <= "00000111";
            when "1011" => rd_valid_pipe <= "00001111";
            when "1100" => rd_valid_pipe <= "00011111";
            when "1101" => rd_valid_pipe <= "00111111";
            when "1110" => rd_valid_pipe <= "01111111";
            when "1111" => rd_valid_pipe <= "11111111";

            -- All words in the frame with the exception of the last word
            -- (all bytes will be valid)
            when others => rd_valid_pipe <= "11111111";
          end case;
        end if;
      end if;
    end if;
  end process p_rd_pipe;   


 
  -- Request to the MAC to transmit a new frame
  tx_start <= '1' when rd_state = INIT else '0';
  
  
  -- Take the Read Address Pointer and convert it into a grey code 
  rd_addr_gray <= unsigned(bin_to_gray(std_logic_vector(rd_addr)));

  -- Create the Read Address Pointer 
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
  p_sync_rd_addr : process (wr_clk)
  begin 
     if wr_clk'event and wr_clk = '1' then
       if wr_sreset = '1' then
         wr_rd_addr_gray <= (others => '0');
       else 
         wr_rd_addr_gray <= rd_addr_gray_reg;
       end if;
     end if;
  end process p_sync_rd_addr;   

  -- Convert the resync'd  Read Address Pointer grey code back to binary
  wr_rd_addr <= unsigned(gray_to_bin(std_logic_vector(wr_rd_addr_gray)));


  -- Create the Write Address Pointer 
  p_wr_addr : process (wr_clk)
  begin 
     if wr_clk'event and wr_clk = '1' then
       if wr_sreset = '1' then
         wr_addr <= (others => '0');
       else
         if wr_enable_pipe = '1' then
           if wr_drop_frame = '1' then
             wr_addr <= wr_addr_last;
           else
             wr_addr <= wr_addr + 1;
           end if;
         end if;
       end if;
     end if;
  end process p_wr_addr;   


  -- Record the starting address of a new frame in case it needs to be 
  -- overwritten. Mainly RX for bad frame but tx could be soft reset mid frame.
  -- rewind the FIFO if we get a double sof in tx.
  p_wr_addr_last : process (wr_clk)
  begin 
     if wr_clk'event and wr_clk = '1' then
       if wr_sreset = '1' then
         wr_addr_last <= (others => '0');
       else
         if wr_store_frame = '1' then
           wr_addr_last <= wr_addr;
         end if;
       end if;
    end if;
  end process p_wr_addr_last; 
  
  
  -- Obtain the difference between write and read pointers
  wr_addr_diff <= wr_rd_addr - wr_addr;
    
  -- Detect when the FIFO is full
  p_wr_full : process (wr_clk)
  begin 
     if wr_clk'event and wr_clk = '1' then
       if wr_sreset = '1' then
         wr_fifo_full <= '0';
       else
         -- The FIFO is considered to be full if the write address
         -- pointer is within 1 to 3 of the read address pointer.
         if wr_addr_diff(addr_width-1 downto 2) = 0 and wr_addr_diff(1 downto 0) /= "00" then
           wr_fifo_full <= '1';
         else 
           wr_fifo_full <= '0';
         end if;
       end if;
    end if;
  end process p_wr_full;   

  -- Data can be written to the FIFO at any time (unless it is full)
  dst_rdy_out <= not wr_fifo_full;
  fifo_full   <= wr_fifo_full;  

  -- Determine when we are in the process of writing a frame
  p_wr_inframe : process (wr_clk)
  begin 
     if wr_clk'event and wr_clk = '1' then
       if wr_sreset = '1' then
         wr_inframe <= '0';
       else
         -- Ignore inframe we'll start on a SOF mid frame and flush
         if wr_fifo_full = '0' then
           if sof_in = '1' and src_rdy_in = '1' then
             wr_inframe <= '1';
           elsif eof_in = '1' and src_rdy_in = '1' then
             wr_inframe <= '0';
           end if;
         end if;
       end if;
    end if;
  end process p_wr_inframe;   

 
  -- Write Enable signal based on Local link signalling and FIFO status 
  wr_enable <= '1' when (wr_inframe = '1' or sof_in = '1') and src_rdy_in = '1' and wr_fifo_full = '0' else '0';



  -- drop/store can be generated only until the next sof
  -- do it here and generate toggle too.
  -- Drop on error (double sof)
  p_wr_end : process (wr_clk)
  begin 
     if wr_clk'event and wr_clk = '1' then
       if wr_sreset = '1' then
         wr_store_frame <= '0';
         wr_store_frame_tog <= '0';
         wr_drop_frame <= '0';
       else
         if wr_inframe = '1' and wr_fifo_full = '0' and eof_in = '1' and src_rdy_in = '1' then
           wr_store_frame <= '1';
           wr_store_frame_tog <= not wr_store_frame_tog;
           wr_drop_frame <= '0';
         -- if we are in a frame and get a SOF then flush and start again
         elsif wr_inframe = '1' and sof_in = '1' and wr_fifo_full = '0' and src_rdy_in = '1' then
           wr_store_frame <= '0';
           wr_drop_frame <= '1';
         else
           wr_store_frame <= '0';
           wr_drop_frame <= '0';
         end if;
       end if;
    end if;
  end process p_wr_end;   



  -- pipeline the data to RAM
  -- We have plenty time because the frame end is delayed as it is sync'd 
  
  p_wr_pipe : process (wr_clk)
  begin 
     if wr_clk'event and wr_clk = '1' then
       if wr_sreset = '1' then
         wr_data_pipe <= (others => '0');
         wr_ctrl_pipe <= (others => '0');
         wr_enable_pipe <= '0';
       else
         wr_enable_pipe <= wr_enable;
         if wr_enable = '1' then
           wr_data_pipe <= data_in;
           wr_ctrl_pipe <= eof_in & rem_in;
         end if;
       end if;
    end if;
  end process p_wr_pipe;   
 


  ----------------------------------------------------------------------
  -- Instantiate BRAMs to produce the dual port memory
  ----------------------------------------------------------------------
  
  fifo_ram_inst : fifo_ram 
     generic map (                           
        addr_width => log2(fifo_size))       
     port map (                              
        wr_clk    => wr_clk,                 
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
