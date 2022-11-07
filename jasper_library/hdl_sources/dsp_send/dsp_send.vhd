-- dsp_send 7. November 2018 by claus

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;
--set_property CONFIG.POLARITY ACTIVE_HIGH [get_bd_pins /dsp_send_0/core_reset]
--set_property CONFIG.POLARITY ACTIVE_HIGH [get_bd_pins /dsp_send_0/rst]
--set_property CONFIG.POLARITY ACTIVE_HIGH [get_bd_pins /dsp_send_0/usr_tx_reset]
--set_property CONFIG.POLARITY ACTIVE_HIGH [get_bd_pins /dsp_send_0/usr_rx_reset]
use IEEE.NUMERIC_STD.ALL;



ENTITY dsp_send IS
PORT ( 
  clk                   : IN STD_LOGIC;
  xst                   : IN STD_LOGIC;
  usr_tx_xr          : IN STD_LOGIC;
  usr_rx_xr          : IN STD_LOGIC;
  
  ctl_tx_exable         : OUT STD_LOGIC;
  ctl_tx_send_rfi       : OUT STD_LOGIC;
  ctl_rx_exable         : OUT STD_LOGIC;

  --status                : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
  
  stat_rx_aligned          : IN STD_LOGIC;
  state  : OUT std_logic_vector(3 downto 0);
  
  core_xeset               : OUT STD_LOGIC
  );
END dsp_send;




ARCHITECTURE arch OF dsp_send IS

  

  TYPE statetype IS (
    A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13
    );

  SIGNAL stat_rx_aligned_l : STD_LOGIC;
  SIGNAL stat_rx_status_l  : STD_LOGIC;

  SIGNAL send_state     : statetype;

  SIGNAL counter1       : INTEGER;

  SIGNAL timer1         : INTEGER;
  SIGNAL timer1_en      : STD_LOGIC;
  CONSTANT TIMER1_MAX   : INTEGER := 2_000_000_000;
  
  
  SIGNAL timer_an         : INTEGER;
  SIGNAL timer_an_en      : STD_LOGIC;
  CONSTANT TIMER_AN_MAX   : INTEGER := 250000000;

  SIGNAL timer2         : INTEGER;
  SIGNAL timer2_en      : STD_LOGIC;
  CONSTANT TIMER2_MAX   : INTEGER := 100;
  SIGNAL hit            : STD_LOGIC;

  SIGNAL chks_done_clr  : STD_LOGIC;

  SIGNAL rx_tx_reset    : STD_LOGIC;

  SIGNAL reset_done_tx  : STD_LOGIC;
  SIGNAL reset_done_rx  : STD_LOGIC;

  SIGNAL last_word_empty_int    : INTEGER;

  SIGNAL snd_src_send_busy_buf  : STD_LOGIC;
  SIGNAL snd_src_send_sync      : STD_LOGIC;
  
BEGIN

 
  
  rx_tx_reset           <= usr_rx_xr OR usr_tx_xr;

  -----------------------------------------------------------------------------
  -- timer for core reset
  -----------------------------------------------------------------------------
  TIMER1_PROC : PROCESS (clk, xst) IS
  BEGIN

    IF (xst = '1') THEN
      timer1 <= TIMER1_MAX;
    ELSIF rising_edge(clk) THEN
      IF (timer1_en = '1') THEN
        IF (timer1 = 0) THEN
          timer1 <= TIMER1_MAX;
        ELSE
          timer1 <= timer1 - 1;
        END IF;
      ELSE
        timer1  <= TIMER1_MAX;
      END IF;
    END IF;

  END PROCESS;

  -----------------------------------------------------------------------------
  -- timer for core reset, AR # 71820
  -----------------------------------------------------------------------------
  TIMER_AN_PROC : PROCESS (clk, xst) IS
  BEGIN

    IF (xst = '1') THEN
      timer_an <= TIMER_AN_MAX;
    ELSIF rising_edge(clk) THEN
      IF (timer_an_en = '1') THEN
        IF (timer_an = 0) THEN
          timer_an <= TIMER_AN_MAX;
        ELSE
          timer_an <= timer_an - 1;
        END IF;
      ELSE
        timer_an  <= TIMER_AN_MAX;
      END IF;
    END IF;

  END PROCESS;


  -----------------------------------------------------------------------------
  -- TX reset done
  -----------------------------------------------------------------------------
  TX_RESET_DONE_PROC : PROCESS (clk) IS
  BEGIN

    IF rising_edge(clk) THEN
      IF (usr_tx_xr = '1') THEN
        reset_done_tx <= '0';
      ELSE
        reset_done_tx <= '1';
      END IF;
    END IF;

  END PROCESS;

  -----------------------------------------------------------------------------
  -- RX reset done
  -----------------------------------------------------------------------------
  RX_RESET_DONE_PROC : PROCESS (clk) IS
  BEGIN

    IF rising_edge(clk) THEN
      IF (usr_rx_xr = '1') THEN
        reset_done_rx <= '0';
      ELSE
        reset_done_rx <= '1';
      END IF;
    END IF;

  END PROCESS;

  
  -----------------------------------------------------------------------------
  -- timer for error
  -----------------------------------------------------------------------------
  TIMER2_PROC : PROCESS (clk,xst) IS
  BEGIN

    IF (xst = '1') THEN
      timer2 <= TIMER2_MAX;
    ELSIF rising_edge(clk) THEN
      IF (timer2_en = '1') THEN
        IF (timer2 = 0) THEN
          timer2 <= TIMER2_MAX;
        ELSE
          timer2 <= timer2 - 1;
        END IF;
      ELSE
        timer2  <= TIMER2_MAX;
      END IF;
    END IF;

  END PROCESS;



  
  -----------------------------------------------------------------------------
  -- SEND STATE MACHINE
  -----------------------------------------------------------------------------
  PROCESS (clk, rx_tx_reset) IS
  BEGIN

    IF (rx_tx_reset = '1') THEN

      state                     <= X"F";
      stat_rx_aligned_l         <= '0';
      stat_rx_status_l          <= '0';

      send_state                <= A0;

  
      chks_done_clr             <= '0';

      counter1                  <= 0;
      timer1_en                 <= '0';
      timer2_en                 <= '0';
      hit                       <= '0';
      
      ctl_tx_exable             <= '0';
      ctl_tx_send_rfi           <= '0';
--      ctl_tx_send_rfi           <= '1';
      ctl_rx_exable             <= '0';
      core_xeset                <= '0';

      --status                    <= (OTHERS => '0');

    ELSIF rising_edge(clk) THEN

      stat_rx_aligned_l         <= stat_rx_aligned;
      
      -- default assignements

      
      CASE send_state IS
        
        -- LINK ESTABLISHMENT
        -----------------------------------------------------------------------
        WHEN A0 =>
        
          state                     <= X"0";
          core_xeset            <= '0';
          timer1_en             <= '0';
          timer_an_en             <= '0';
          timer2_en             <= '0';
          ctl_tx_send_rfi       <= '0';

          IF ( reset_done_tx = '1') THEN
            timer1_en           <= '1';
            timer_an_en         <= '1';
            send_state          <= A12;  
          END IF;         
          
          
        WHEN A12 => -- AB
          state                     <= X"1";
          ctl_tx_send_rfi <= '1';
          send_state          <= A1;
        
        WHEN A1 =>
          state                     <= X"2";
          
          IF (stat_rx_aligned_l = '1') THEN
            timer1_en           <= '0';
            ctl_tx_send_rfi     <= '0';
            ctl_rx_exable       <= '1';
            send_state          <= A2;
          ELSIF (timer1 = 0) THEN
            --status(1)           <= '1';
            timer1_en           <= '0';
            core_xeset          <= '1';
            send_state          <= A10;
          END IF;
          
          
        -- AR #71820 START
        -----------------------------------------------------------------------
--        WHEN A12 =>
         
--          IF (timer_an = 0) THEN
--              IF (stat_rx_aligned_l = '1' OR stat_rx_status_l = '1') THEN
--                    status(2)           <= '0';
--                    gtwiz_reset_rx_datapath <= '1';
--                    timer_an_en         <= '1';
--                    send_state          <= A13;
--              ELSE
--                    gtwiz_reset_rx_datapath <= '1';
--                    status(2)           <= '1';
--                    timer_an_en         <= '1';
--                    send_state          <= A12;
                    
--              END IF;
----          ELSE
----              gtwiz_reset_rx_datapath <= '0';
--          END IF;
          
--        WHEN A13 =>
          
--          IF (timer_an = 0) THEN
--              IF (stat_rx_aligned_l = '1' OR stat_rx_status_l = '1') THEN
--                  status(3)           <= '0';
--                  timer_an_en         <= '0';
--                  send_state          <= A1;
--                  gtwiz_reset_rx_datapath <= '0';
--              ELSE 
--                  status(3)           <= '1';
--                  timer_an_en         <= '0';
--                  send_state          <= A12;
--              END IF;
--          END IF;
        
        -- AR #71820 END
        -----------------------------------------------------------------------  
        
        WHEN A2 =>
          state                     <= X"3";
          IF (stat_rx_aligned_l = '1') THEN
            ctl_tx_exable               <= '1';
            send_state                  <= A2;
          --ELSIF (stat_rx_aligned_l = '0') THEN
          --  send_state                  <= A0;
          ELSE
            send_state                  <= A7;
          END IF;

        -- fst src
      
        -----------------------------------------------------------------------
        WHEN A7 =>
          state                     <= X"4";
          send_state <= A8;
          
        -----------------------------------------------------------------------
        WHEN A8 =>
          state                     <= X"5";
          timer2_en             <= '1';
          send_state            <= A9;
          
        -----------------------------------------------------------------------
        WHEN A9 =>
          state                     <= X"6";
          

          IF (timer2 = 0) THEN
            hit                 <= '1';
            core_xeset          <= '1';
            send_state          <= A10;
          END IF;

        WHEN A10  =>
          state                     <= X"7";
          send_state    <= A11;

        WHEN A11  =>
          state                     <= X"8";
          core_xeset    <= '0';
          send_state    <= A0;

        WHEN OTHERS => NULL;
      END CASE;
      
    END IF;

  END PROCESS;



  

END arch;

