----------------------------------------------------------------------------------
-- Company: Peralex Electronics
-- Engineer: GT
-- 
-- Create Date: 05.09.2014 10:19:29
-- Design Name: 
-- Module Name: adc_data_sync - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Use the TLAST to synchronise the start of data output.
--
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity adc_data_sync is
	port (
		adc_user_clk : in std_logic;
		adc_user_rst : in std_logic;
		
        block_capture_data        : in std_logic_vector(127 downto 0);
        block_capture_data_val    : in std_logic;
        block_capture_data_last   : in std_logic;
        
        block_capture_sync_ready             : out std_logic;
        block_capture_sync_output_enable     : in std_logic;
        block_capture_data_sync              : out std_logic_vector(127 downto 0);
        block_capture_data_val_sync          : out std_logic;
        block_capture_data_last_sync         : out std_logic);
end adc_data_sync;

architecture arch_adc_data_sync of adc_data_sync is

    component adc_data_sync_fifo
    port (
        clk     : in std_logic;
        srst    : in std_logic;
        din     : in std_logic_vector(128 downto 0);
        wr_en   : in std_logic;
        rd_en   : in std_logic;
        dout    : out std_logic_vector(128 downto 0);
        full    : out std_logic;
        empty   : out std_logic);
    end component;
      
    signal adc_data_sync_fifo_din : std_logic_vector(128 downto 0);
    signal adc_data_sync_fifo_write_enable : std_logic;
    signal adc_data_sync_fifo_wrreq : std_logic;
    signal adc_data_sync_fifo_rdreq : std_logic;
    signal adc_data_sync_fifo_dout : std_logic_vector(128 downto 0);
    signal adc_data_sync_fifo_full : std_logic;
    signal adc_data_sync_fifo_empty : std_logic;
       
begin

----------------------------------------------------------------------------------------------
-- WAIT FOR THE FIRST LAST TO SYNCHRONISE
----------------------------------------------------------------------------------------------

    gen_adc_data_sync_fifo_write_enable : process(adc_user_rst, adc_user_clk)
    begin
        if (adc_user_rst = '1')then
            adc_data_sync_fifo_write_enable <= '0';        
        elsif (rising_edge(adc_user_clk))then
            if (block_capture_data_last = '1')then    
                adc_data_sync_fifo_write_enable <= '1';
            end if;    
        end if;
    end process;

----------------------------------------------------------------------------------------------
-- FIFO TO PROVIDE ELASTIC ALIGNMENT BUFFERING
----------------------------------------------------------------------------------------------

    adc_data_sync_fifo_wrreq <= (block_capture_data_val and adc_data_sync_fifo_write_enable) when (adc_data_sync_fifo_full = '0') else '0';
    
    adc_data_sync_fifo_din(127 downto 0) <= block_capture_data;
    adc_data_sync_fifo_din(128) <= block_capture_data_last;

    adc_data_sync_fifo_0 : adc_data_sync_fifo
    port map(
        clk     => adc_user_clk,
        srst    => adc_user_rst,
        din     => adc_data_sync_fifo_din,
        wr_en   => adc_data_sync_fifo_wrreq,
        rd_en   => adc_data_sync_fifo_rdreq,
        dout    => adc_data_sync_fifo_dout,
        full    => adc_data_sync_fifo_full,
        empty   => adc_data_sync_fifo_empty);   

    adc_data_sync_fifo_rdreq <= (not adc_data_sync_fifo_empty) when (block_capture_sync_output_enable = '1') else '0';

    block_capture_data_sync <= adc_data_sync_fifo_dout(127 downto 0);  
    block_capture_data_last_sync <= adc_data_sync_fifo_dout(128);

    gen_block_capture_data_val_sync : process(adc_user_clk)
    begin
        if (rising_edge(adc_user_clk))then
            block_capture_data_val_sync <= adc_data_sync_fifo_rdreq;
        end if;
    end process;

----------------------------------------------------------------------------------------------
-- WAIT FOR THE FIRST WRITE IN FIFO TO BE READY
----------------------------------------------------------------------------------------------
    
    gen_block_capture_sync_ready : process(adc_user_rst, adc_user_clk)
    begin
        if (adc_user_rst = '1')then
            block_capture_sync_ready <= '0';
        elsif (rising_edge(adc_user_clk))then
            if (adc_data_sync_fifo_empty = '0')then    
                block_capture_sync_ready <= '1';
            end if;
        end if;    
    end process;    
    
end arch_adc_data_sync;
