-------------------------------------------------------------------------------
-- $Revision: 1.1 $ $Date: 2006/09/06 18:13:23 $
-- Title      : Demo testbench
-- Project    : 10 Gigabit Ethernet MAC
-------------------------------------------------------------------------------
-- File       : demo_tb.vhd
-------------------------------------------------------------------------------
-- Description: This testbench will exercise the ports of the MAC core to
--              demonstrate the functionality.
-------------------------------------------------------------------------------
-- Copyright (c) 2001-2003 Xilinx Inc.
-------------------------------------------------------------------------------
--
-- This testbench performs the following operations on the MAC core:
--  - The clock divide register is set for MIIM operation.
--  - The XGMII/XAUI port is wired as a loopback, so that transmitted frames
--    are then injected into the receiver.
--  - Four frames are pushed into the transmitter. The first is a minimum
--    length frame, the second is slightly longer, the third has an underrun
--    asserted and the fourth is less than minimum length and is hence padded
--    by the transmitter up to the minimum.
--  - These frames are then parsed by the receiver, which supplies the data out
--    on it's client interface. The testbench verifies that this data matches
--    that injected into the transmitter.

entity testbench is
   generic (
      func_sim : boolean := false);
end testbench;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
architecture behav of testbench is
  
  -----------------------------------------------------------------------------
  -- Component Declaration for XGMAC_TOP (the top level wrapper example).
  -----------------------------------------------------------------------------
  component ten_gig_eth_mac_v8_0_example_design
    port(
    reset          : in  std_logic;   
    tx_clk         : out  std_logic;                    -- The transmit clock back to the host.
	tx_ifg_delay   : in   std_logic_vector(7 downto 0); -- Temporary. IFG delay.
    tx_statistics_vector : out std_logic_vector(24 downto 0); -- Statistics information on the last frame.
    tx_statistics_valid  : out std_logic;                     -- High when stats are valid.

    pause_val      : in  std_logic_vector(15 downto 0); -- Indicates the length of the pause that should be transmitted.
    pause_req      : in  std_logic;                     -- A '1' indicates that a pause frame should  be sent.
    rx_clk               : out std_logic;                     -- The RX clock from the reconcilliation sublayer.
    rx_statistics_vector : out std_logic_vector(28 downto 0); -- Statistics info on the last received frame.
    rx_statistics_valid  : out std_logic;                     -- High when above stats are valid.
   
    configuration_vector : in std_logic_vector(66 downto 0)
;
    gtx_clk        : in  std_logic;                     -- The global transmit clock from the outside world.
    xgmii_txd      : out std_logic_vector(63 downto 0); -- Transmitted data
    xgmii_txc      : out std_logic_vector(7 downto 0)  -- Transmitted control
;
    xgmii_rx_clk   : in  std_logic;                     -- The rx clock from the PHY layer.
    xgmii_rxd      : in  std_logic_vector(63 downto 0); -- Received data
    xgmii_rxc      : in  std_logic_vector(7 downto 0)  -- received control
);
end component;


  -- Address of management configuration register
  constant CONFIG_MANAGEMENT : std_logic_vector(8 downto 0) := "101000000";
  -- Address of flow control configuration register
  constant CONFIG_FLOW_CTRL  : std_logic_vector(8 downto 0) := "011000000";
  -- addresses of statistics registers
  constant STATS_TX_OK       : std_logic_vector(8 downto 0) := "000100000";
  constant STATS_TX_UNDERRUN : std_logic_vector(8 downto 0) := "000100011";
  constant STATS_RX_OK       : std_logic_vector(8 downto 0) := "000000000";
  constant STATS_RX_FCS_ERR  : std_logic_vector(8 downto 0) := "000000001";

  constant RX_CLK_PERIOD     : time := 6400 ps;

  -----------------------------------------------------------------------------
  -- types to support frame data
  -----------------------------------------------------------------------------
  -- COLUMN_TYP is a type declaration for an object to hold an single
  -- XGMII column's information on the client interface i.e. 32 bit
  -- data/4 bit control. It holds both the data bytes and the valid signals
  -- for each byte lane.
  type COLUMN_TYP is record             -- Single column on client I/F
                       D : bit_vector(31 downto 0);  -- Data
                       C : bit_vector(3 downto 0);   -- Control
                     end record;
  type COLUMN_ARY_TYP is array (natural range <>) of COLUMN_TYP;
  -- FRAME_TYPE is a type declaration for an object to hold an entire frame of
  -- information. The columns which make up the frame are held in here, along
  -- with a flag to say whether the underrun flag should be asserted to the
  -- core on this frame. If TRUE, this underrun occurs on the clock cycle
  -- *after* the last column of data defined in the frame record.
  type FRAME_TYP is record
                      COLUMNS  : COLUMN_ARY_TYP(0 to 31);
                      CRC : bit_vector(31 downto 0);
                      LOOPBACK_CRC : bit_vector(31 downto 0);
                      UNDERRUN : boolean;            -- should this frame cause
                                                     -- underrun/error?
                    end record;
  type FRAME_TYP_ARY is array (natural range <>) of FRAME_TYP;

  -----------------------------------------------------------------------------
  -- Stimulus - Frame data
  -----------------------------------------------------------------------------
  -- The following constant holds the stimulus for the testbench. It is an
  -- ordered array of frames, with frame 0 the first to be injected into the
  -- core transmit interface by the testbench. See the datasheet for the
  -- position of the Ethernet fields within each frame.
  constant FRAME_DATA : FRAME_TYP_ARY := (
    0          => (                     -- Frame 0
      COLUMNS  => (
        0      => (D => X"04030201", C => X"F"),
        1      => (D => X"02020605", C => X"F"),
        2      => (D => X"06050403", C => X"F"),
        3      => (D => X"55AA2E00", C => X"F"),
        4      => (D => X"AA55AA55", C => X"F"),
        5      => (D => X"55AA55AA", C => X"F"),
        6      => (D => X"AA55AA55", C => X"F"),
        7      => (D => X"55AA55AA", C => X"F"),
        8      => (D => X"AA55AA55", C => X"F"),
        9      => (D => X"55AA55AA", C => X"F"),
        10     => (D => X"AA55AA55", C => X"F"),
        11     => (D => X"55AA55AA", C => X"F"),
        12     => (D => X"AA55AA55", C => X"F"),
        13     => (D => X"55AA55AA", C => X"F"),
        14     => (D => X"AA55AA55", C => X"F"),
        15     => (D => X"00000000", C => X"0"),
        others => (D => X"00000000", C => X"0")),
      CRC => X"0D4820F6",
      LOOPBACK_CRC => X"0727CB70",
      UNDERRUN => false),
    1          => (                     -- Frame 1
      COLUMNS  => (
        0      => (D => X"03040506", C => X"F"),
        1      => (D => X"05060102", C => X"F"),
        2      => (D => X"02020304", C => X"F"),
        3      => (D => X"EE110080", C => X"F"),
        4      => (D => X"11EE11EE", C => X"F"),
        5      => (D => X"EE11EE11", C => X"F"),
        6      => (D => X"11EE11EE", C => X"F"),
        7      => (D => X"EE11EE11", C => X"F"),
        8      => (D => X"11EE11EE", C => X"F"),
        9      => (D => X"EE11EE11", C => X"F"),
        10     => (D => X"11EE11EE", C => X"F"),
        11     => (D => X"EE11EE11", C => X"F"),
        12     => (D => X"11EE11EE", C => X"F"),
        13     => (D => X"EE11EE11", C => X"F"),
        14     => (D => X"11EE11EE", C => X"F"),
        15     => (D => X"EE11EE11", C => X"F"),
        16     => (D => X"11EE11EE", C => X"F"),
        17     => (D => X"EE11EE11", C => X"F"),
        18     => (D => X"11EE11EE", C => X"F"),
        19     => (D => X"EE11EE11", C => X"F"),
        20     => (D => X"11EE11EE", C => X"F"),
        21     => (D => X"0000EE11", C => X"3"),
        others => (D => X"00000000", C => X"0")),
      CRC => X"DE13388C",
      LOOPBACK_CRC => X"AD18E8E5",
      UNDERRUN => false),
    2          => (                     -- Frame 2
      COLUMNS  => (
        0      => (D => X"04030201", C => X"F"),
        1      => (D => X"02020605", C => X"F"),
        2      => (D => X"06050403", C => X"F"),
        3      => (D => X"55AA2E80", C => X"F"),
        4      => (D => X"AA55AA55", C => X"F"),
        5      => (D => X"55AA55AA", C => X"F"),
        6      => (D => X"AA55AA55", C => X"F"),
        7      => (D => X"55AA55AA", C => X"F"),
        8      => (D => X"AA55AA55", C => X"F"),
        9      => (D => X"55AA55AA", C => X"F"),
        10     => (D => X"AA55AA55", C => X"F"),
        11     => (D => X"55AA55AA", C => X"F"),
        12     => (D => X"AA55AA55", C => X"F"),
        13     => (D => X"55AA55AA", C => X"F"),
        14     => (D => X"AA55AA55", C => X"F"),
        15     => (D => X"55AA55AA", C => X"F"),
        16     => (D => X"AA55AA55", C => X"F"),
        17     => (D => X"55AA55AA", C => X"F"),
        18     => (D => X"AA55AA55", C => X"F"),
        19     => (D => X"55AA55AA", C => X"F"),
        others => (D => X"00000000", C => X"0")),
      CRC => X"20C6B69D",
      LOOPBACK_CRC => X"B34B7F4B",
      UNDERRUN => true),                -- Underrun this frame
    3          => (
      COLUMNS  => (
        0      => (D => X"03040506", C => X"F"),
        1      => (D => X"05060102", C => X"F"),
        2      => (D => X"02020304", C => X"F"),
        3      => (D => X"EE111500", C => X"F"),
        4      => (D => X"11EE11EE", C => X"F"),
        5      => (D => X"EE11EE11", C => X"F"),
        6      => (D => X"11EE11EE", C => X"F"),
        7      => (D => X"EE11EE11", C => X"F"),
        8      => (D => X"00EE11EE", C => X"7"),
        others => (D => X"00000000", C => X"0")),  -- This frame will need to
                                                   -- be padded
      CRC => X"6B734A56",
      LOOPBACK_CRC => X"2FD1D77A",
      UNDERRUN => false));

  -- DUT signals
  signal reset   : std_logic := '1';    -- start in
                                        -- reset

  signal tx_clk               : std_logic;
  signal tx_ifg_delay         : std_logic_vector(7 downto 0);
  signal tx_statistics_vector : std_logic_vector(24 downto 0);
  signal tx_statistics_valid  : std_logic;

  signal pause_val : std_logic_vector(15 downto 0) := (others => '0');
  signal pause_req : std_logic                     := '0';
  signal rx_clk               : std_logic;
  signal rx_statistics_vector : std_logic_vector(28 downto 0);
  signal rx_statistics_valid  : std_logic;
 
  signal configuration_vector : std_logic_vector(66 downto 0)
          := "000" & X"0583000000000000";
  signal gtx_clk      : std_logic := '0';
  signal xgmii_txd    : std_logic_vector(63 downto 0);
  signal xgmii_txc    : std_logic_vector(7 downto 0);
  signal xgmii_rx_clk : std_logic := '0';
  signal xgmii_rxd    : std_logic_vector(63 downto 0) := X"0707070707070707";
  signal xgmii_rxc    : std_logic_vector(7 downto 0) := "11111111";

  -- testbench control semaphores
  signal tx_monitor_finished : boolean := false;
  signal rx_monitor_finished : boolean := true;
  signal simulation_finished : boolean := false;
  
begin  -- behav

  -----------------------------------------------------------------------------
  -- Wire up Device Under Test
  -----------------------------------------------------------------------------
  dut: ten_gig_eth_mac_v8_0_example_design
    port map (
      reset                => reset
,
      tx_clk               => tx_clk,
      tx_ifg_delay         => tx_ifg_delay,
      tx_statistics_vector => tx_statistics_vector,
      tx_statistics_valid  => tx_statistics_valid,
      pause_val            => pause_val,
      pause_req            => pause_req
,
      rx_clk               => rx_clk,
      rx_statistics_vector => rx_statistics_vector,
      rx_statistics_valid  => rx_statistics_valid
,
      configuration_vector => configuration_vector
,
      gtx_clk              => gtx_clk
,
      xgmii_txd            => xgmii_txd,
      xgmii_txc            => xgmii_txc
,
      xgmii_rx_clk         => xgmii_rx_clk,
      xgmii_rxd            => xgmii_rxd,
      xgmii_rxc            => xgmii_rxc
);

  tx_ifg_delay <= (others => '0');      -- dummy up port

  -- Set flow control address to all zeros, we don't need it here
  configuration_vector(47 downto 0) <= (others => '0');
  -- Enable VLAN
  configuration_vector(48) <= '1';
  -- Enable the receiver
  configuration_vector(49) <= '1';
  -- Check and strip the CRC on receive
  configuration_vector(50) <= '0';
  -- Enable jumob frame handling
  configuration_vector(51) <= '1';
  -- Hold reset low
  configuration_vector(52) <= '0';
  -- Set as LAN mode (no WIS rate control)
  configuration_vector(53) <= '0';
  -- Keep IFG as per IEEE spec with no manipulation
  configuration_vector(54) <= '0';
  -- Enable VLAN frames
  configuration_vector(55) <= '1';
  -- Enable transmitter
  configuration_vector(56) <= '1';
  -- Calculate and transmit CRC
  configuration_vector(57) <= '0';
  -- Enable jumbo frame transmission
  configuration_vector(58) <= '1';
  -- Hold reset low 
  configuration_vector(59) <= '0';
  -- Diable flow control in both directions
  configuration_vector(61 downto 60) <= "00";
  -- Tie flow control resets low
  configuration_vector(62) <= '0';
  configuration_vector(63) <= '0';
  -- Normal Reconcilliation Sublayer operation
  configuration_vector(64) <= '0';   
  -- Disable Custom Preamblr
  configuration_vector(65) <= '0';   
  configuration_vector(66) <= '0';   
  
  -----------------------------------------------------------------------------
  -- Clock drivers
  -----------------------------------------------------------------------------
p_gtx_clk : process                   -- drives GTX_CLK at 156.25 MHz
  begin
    gtx_clk <= '0';
    loop
      wait for 3.2 ns;                  -- 156.25 MHz GTX_CLK
      gtx_clk <= '1';
      wait for 3.2 ns;
      gtx_clk <= '0';
    end loop;
  end process p_gtx_clk;
  p_xgmii_rx_clk : process
  begin
    xgmii_rx_clk <= '0';
    wait for 1 ns;        
    loop
      wait for 3.2 ns;
      xgmii_rx_clk <= '1';
      wait for 3.2 ns;
      xgmii_rx_clk <= '0';
    end loop;
  end process p_xgmii_rx_clk;




  -----------------------------------------------------------------------------
  -- Transmit Monitor process. This process checks the data coming out
  -- of the transmitter to make sure that it matches that inserted
  -- into the transmitter.
  -----------------------------------------------------------------------------
  p_tx_monitor : process
    variable cached_column_valid : boolean := false;
    variable cached_column_data : std_logic_vector(31 downto 0);
    variable cached_column_ctrl : std_logic_vector(3 downto 0);
    variable current_frame : natural := 0;

    procedure get_next_column (
      variable d : out std_logic_vector(31 downto 0);
      variable c : out std_logic_vector(3 downto 0)) is
    begin  -- get_next_column
      if cached_column_valid then
        d := cached_column_data;
        c := cached_column_ctrl;
        cached_column_valid := false;
      else
        wait until tx_clk = '1';
        d := xgmii_txd(31 downto 0);
        c := xgmii_txc(3 downto 0);
        cached_column_data := xgmii_txd(63 downto 32);
        cached_column_ctrl := xgmii_txc(7 downto 4);
        cached_column_valid := true;
      end if;
    end get_next_column;
    
    procedure check_frame (
      constant frame : in frame_typ) is
      variable d : std_logic_vector(31 downto 0) := X"07070707";
      variable c : std_logic_vector(3 downto 0) := "1111";
      variable column_index, lane_index : integer;
      variable crc_candidate : std_logic_vector(31 downto 0);
    begin
      -- Wait for start code
      while not (d(7 downto 0) = X"FB" and c(0) = '1') loop
        get_next_column(d,c);
      end loop;
      get_next_column(d,c);             -- skip rest of preamble
      get_next_column(d,c);
      column_index := 0;
      -- test complete columns
      while frame.columns(column_index).c = "1111" loop
        if column_index = 0 then
            if d /= to_stdlogicvector(frame.columns(column_index+2).d(15 downto 0)) &
               to_stdlogicvector(frame.columns(column_index+1).d(31 downto 16)) then
               -- only report an error if it should be an intact frame
               assert frame.underrun
                  report "Transmit fail: data mismatch at PHY interface"
                  severity error;
               return;
            end if;
         elsif column_index = 1 then
            if d /= to_stdlogicvector(frame.columns(column_index-1).d(15 downto 0)) &
               to_stdlogicvector(frame.columns(column_index+1).d(31 downto 16)) then
               -- only report an error if it should be an intact frame
               assert frame.underrun
                  report "Transmit fail: data mismatch at PHY interface"
                  severity error;
               return;
            end if;
         elsif column_index = 2 then
            if d /= to_stdlogicvector(frame.columns(column_index-1).d(15 downto 0)) &
               to_stdlogicvector(frame.columns(column_index-2).d(31 downto 16)) then
               -- only report an error if it should be an intact frame
               assert frame.underrun
                  report "Transmit fail: data mismatch at PHY interface"
                  severity error;
               return;
            end if;

         else
            if d /= to_stdlogicvector(frame.columns(column_index).d) then
               -- only report an error if it should be an intact frame
               assert frame.underrun
                  report "Transmit fail: data mismatch at PHY interface"
                  severity error;
               return;                  -- end of comparison for this frame
            end if;
         end if;
        column_index := column_index + 1;
        get_next_column(d,c);
      end loop;
      -- now deal with the final partial column
      lane_index := 0;
      while frame.columns(column_index).c(lane_index) = '1' loop
        if d(lane_index*8+7 downto lane_index*8) /=
          to_stdlogicvector(frame.columns(column_index).d(lane_index*8+7 downto lane_index*8)) then
          -- only report an error if it should be an intact frame
          assert frame.underrun
            report "Transmit fail: data mismatch at PHY interface"
            severity error;
          return;                       -- end of comparison for this frame
        end if;
        lane_index := lane_index + 1;
      end loop;
      
      -- now look for the CRC. There may be padding before it appears
      -- so we can't go blindly looking for the crc in the next 4
      -- bytes.  lane_index is the first padding or crc
      -- byte. initialise a candidate to the next four bytes then look
      -- for a non-data byte
      for i in 3 downto 0 loop
        if c(lane_index) = '1' then
          assert frame.underrun
            report "Transmit fail: early terminate at PHY interface" severity error;
          return;
        end if;
        crc_candidate(i*8+7 downto i*8)
          := d(lane_index*8+7 downto lane_index*8);
        lane_index := lane_index + 1;
        if lane_index = 4 then
          get_next_column(d,c);
          lane_index := 0;
        end if;
      end loop;  -- i
      while c(lane_index) = '0' loop
        crc_candidate := crc_candidate(23 downto 0)
                         & d(lane_index*8+7 downto lane_index*8);
        lane_index := lane_index + 1;
        if lane_index = 4 then
          get_next_column(d,c);
          lane_index := 0;
        end if;
      end loop;
      -- test the gathered CRC against the specified one.
   assert crc_candidate = to_stdlogicvector(frame.LOOPBACK_CRC)
        report "Transmit fail: CRC mismatch at PHY interface"
        severity error;
      assert false
        report "Transmitter: Frame completed at PHY interface"
        severity note;
    end check_frame;
    
  begin

    for i in frame_data'low to frame_data'high loop
      if not frame_data(i).underrun then
        check_frame(frame_data(i));
      end if;
    end loop;  -- i

    tx_monitor_finished <= true;
    wait;
  end process p_tx_monitor;


  -----------------------------------------------------------------------------
  -- Receive Stimulus process. This process pushes frames of data through the
  --  receiver side of the core
  -----------------------------------------------------------------------------
  p_rx_stimulus : process
    variable cached_column_valid : boolean := false;
    variable cached_column_data : std_logic_vector(31 downto 0);
    variable cached_column_ctrl : std_logic_vector(3 downto 0);

    procedure send_column (
      constant d : in std_logic_vector(31 downto 0);
      constant c : in std_logic_vector(3 downto 0)) is
    begin  -- send_column
      if cached_column_valid then
        wait until xgmii_rx_clk = '1';
        wait for 3.4 ns;
        xgmii_rxd(31 downto 0) <= cached_column_data;
        xgmii_rxc(3 downto 0) <= cached_column_ctrl;
        xgmii_rxd(63 downto 32) <= d;
        xgmii_rxc(7 downto 4) <= c;
        cached_column_valid := false;
      else
        cached_column_data := d;
        cached_column_ctrl := c;
        cached_column_valid := true;
      end if;
    end send_column;

    procedure send_column (
      constant c : in column_typ) is
    begin  -- send_column
      send_column(to_stdlogicvector(c.d),
                  not to_stdlogicvector(c.c));  -- invert "data_valid" sense
    end send_column;

    procedure send_idle is
    begin  -- send_idle
      send_column(X"07070707", "1111");
    end send_idle;
    
    procedure send_frame (
      constant frame : in frame_typ) is
      constant MIN_FRAME_DATA_BYTES : integer := 60;
      variable column_index, lane_index, byte_count : integer;
      variable scratch_column : column_typ;
    begin  -- send_frame
      column_index := 0;
      lane_index := 0;
      byte_count := 0;
      -- send first lane of preamble
      send_column(X"555555FB", "0001");
      -- send second lane of preamble
      send_column(X"D5555555", "0000");
      while frame.columns(column_index).c = "1111" loop
        send_column(frame.columns(column_index));
        column_index := column_index + 1;
        byte_count := byte_count + 4;
      end loop;
      while frame.columns(column_index).c(lane_index) = '1' loop
        scratch_column.d(lane_index*8+7 downto lane_index*8)
          := frame.columns(column_index).d(lane_index*8+7 downto lane_index*8);
        scratch_column.c(lane_index) := '1';
        lane_index := lane_index + 1;
        byte_count := byte_count + 1;
      end loop;
      while byte_count < MIN_FRAME_DATA_BYTES loop
        if lane_index = 4 then
          send_column(scratch_column);
          lane_index := 0;
        end if;
        scratch_column.d(lane_index*8+7 downto lane_index*8) := (others => '0');
        scratch_column.c(lane_index) := '1';
        lane_index := lane_index + 1;
        byte_count := byte_count + 1;
      end loop;
      -- send the crc
      for i in 3 downto 0 loop
        if lane_index = 4 then
          send_column(scratch_column);
          lane_index := 0;
        end if;
        scratch_column.d(lane_index*8+7 downto lane_index*8)
          := frame.crc(i*8+7 downto i*8);
        scratch_column.c(lane_index) := '1';
        lane_index := lane_index + 1;
      end loop;  -- i
      -- send the terminate/error column
      if lane_index = 4 then
        send_column(scratch_column);
        lane_index := 0;
      end if;
      if frame.underrun then
        -- send error code
        scratch_column.d(lane_index*8+7 downto lane_index*8) := X"FE";
        scratch_column.c(lane_index) := '0';
      else
        -- send terminate code
        scratch_column.d(lane_index*8+7 downto lane_index*8) := X"FD";
        scratch_column.c(lane_index) := '0';
      end if;
      lane_index := lane_index + 1;
      while lane_index < 4 loop
        scratch_column.d(lane_index*8+7 downto lane_index*8) := X"07";
        scratch_column.c(lane_index) := '0';
        lane_index := lane_index + 1;
      end loop;
      send_column(scratch_column);
      assert false
        report "Receiver: frame inserted into PHY interface"
        severity note;
    end send_frame;
    
  begin
     assert false
      report "Timing checks are not valid"
      severity note;
    while reset = '1' loop
      send_idle;        
    end loop;
    -- wait for DCMs to lock
    for i in 1 to 100 loop
      send_idle;
    end loop;
    assert false
      report "Timing checks are valid"
      severity note;

    for i in frame_data'low to frame_data'high loop
      send_frame(frame_data(i));
      send_idle;
      send_idle;
    end loop;  -- i
    while true loop
      send_idle;
    end loop;
  end process p_rx_stimulus;




  p_reset : process
  begin
    -- reset the core
    assert false
      report "Resetting core..."
      severity note;
    reset <= '1';
    wait for 200 ns;
    reset <= '0';
    wait;
  end process p_reset;
  
  simulation_finished <= 
    tx_monitor_finished
    ;  

  p_end_simulation : process
  begin
    wait until simulation_finished for 10 us;
    assert simulation_finished
      report "ERROR: Testbench timed out"
      severity failure;
    assert false
      report "Simulation Stopped."
      severity failure;
  end process p_end_simulation;
  
end behav;
