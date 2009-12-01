library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity adc_config_mux is
  generic
    (
      INTERLEAVED : integer := 0
     );
   port (
    clk				: in std_logic := '0';
    rst				: in std_logic := '0';
    request			: in std_logic := '0';
    ddrb_i			: in std_logic := '0';

    config_start_i		: in std_logic := '0';
    config_busy_o		: out std_logic := '0';
    config_data_i		: in std_logic_vector(0 to 15);
    syns_done_o			: out std_logic;

    ddrb_o			: out std_logic;
    dcm_reset_o			: out std_logic;
    ctrl_clk_o			: out std_logic;
    ctrl_strb_o			: out std_logic;
    ctrl_data_o			: out std_logic
   );
end entity adc_config_mux;

architecture IMP of adc_config_mux is
  signal ddrb_int		: std_logic;
  signal config_start		: std_logic;
  signal config_data		: std_logic_vector(31 downto 0);
  signal config_data_reorder	: std_logic_vector(15 downto 0);
  signal ascii_data		: std_logic_vector(31 downto 0);

  signal config_start_int	: std_logic;
  signal config_data_int	: std_logic_vector(31 downto 0);

  signal ddrb_pre		: std_logic;


  signal clk_counter		: std_logic_vector(15 downto 0);
  signal shift_register		: std_logic_vector(71 downto 0);
  signal xfer_progress		: std_logic_vector(6 downto 0);

  type xfer_state_t is (STATE_IDLE,STATE_STRB0,STATE_CLK_RISE,STATE_CLK_FALL,STATE_STRB1,STATE_SWAIT);
  signal xfer_state		: xfer_state_t;

  type conf_state_t is (CONF_MODE_CLEAR, CONF_MODE_SET, CONF_LOAD, 
                        CONF_WAIT, CONF_RESET, CONF_DONE);
  signal conf_state		: conf_state_t;

  signal clear_wait		: std_logic_vector(9 downto 0);
  signal config_busy		: std_logic;
  
  signal dcm_reset_extend	: std_logic_vector(4 downto 0);
  signal ddrb_reg		: std_logic;
  signal syns_done		: std_logic;

begin
  ddrb_int         <= '1' when (conf_state = CONF_RESET) else
                      '0';
  config_start_int <= '1' when (conf_state = CONF_LOAD) else
                      '0';
  config_data_int  <= x"30313930";

 arbit_p : process(clk, rst)
 begin
   if(rst = '1') then
     ddrb_pre <= '0';
     config_start <= '0';
   elsif clk'event and clk = '1' then
     if request = '1' then
       ddrb_pre      <= ddrb_i;
     else
       ddrb_pre      <= ddrb_int;
     end if;
     if request = '1' then
       config_start  <= config_start_i;
     else
       config_start  <= config_start_int;
     end if;
   end if;
 end process;

--reorder_input_g : for i in 0 to 15 generate
--	config_data_reorder(i) <= config_data_i(i);
--end generate;
config_data_reorder <= config_data_i;

loop_g : for i in 0 to 3 generate
  ascii_data(i*8+7 downto i*8) <= x"30" when config_data_reorder(i*4+3 downto i*4) = x"0" else
                                  x"31" when config_data_reorder(i*4+3 downto i*4) = x"1" else 
                                  x"32" when config_data_reorder(i*4+3 downto i*4) = x"2" else 
                                  x"33" when config_data_reorder(i*4+3 downto i*4) = x"3" else 
                                  x"34" when config_data_reorder(i*4+3 downto i*4) = x"4" else 
                                  x"35" when config_data_reorder(i*4+3 downto i*4) = x"5" else 
                                  x"36" when config_data_reorder(i*4+3 downto i*4) = x"6" else 
                                  x"37" when config_data_reorder(i*4+3 downto i*4) = x"7" else 
                                  x"38" when config_data_reorder(i*4+3 downto i*4) = x"8" else 
                                  x"39" when config_data_reorder(i*4+3 downto i*4) = x"9" else 
                                  x"41" when config_data_reorder(i*4+3 downto i*4) = x"a" else 
                                  x"42" when config_data_reorder(i*4+3 downto i*4) = x"b" else 
                                  x"43" when config_data_reorder(i*4+3 downto i*4) = x"c" else 
                                  x"44" when config_data_reorder(i*4+3 downto i*4) = x"d" else 
                                  x"45" when config_data_reorder(i*4+3 downto i*4) = x"e" else 
                                  x"46";
end generate;

	   

 hex_to_ascii_p : process(clk, rst)
 begin
   if(rst = '1')then
     config_data <= (others => '0');
   elsif clk'event and clk = '1' then
     if request = '0' then
       config_data <= config_data_int;
     else
       config_data <= ascii_data;
     end if;
  end if;
end process;

     
-- slow down clock counter
 count_p : process(clk, rst)
 begin
   if(rst = '1') then
     clk_counter <= (others => '0');
   elsif clk'event and clk = '1' then
     if(clk_counter = x"3ff") then
       clk_counter <= (others => '0');
     else
       clk_counter <= clk_counter + '1';
     end if;
   end if;
 end process;
     
 state_machine_p : process(clk, rst)
 begin
   if(rst = '1') then
     shift_register <= (others => '0');
     xfer_state     <= STATE_IDLE;
     xfer_progress  <= (others => '0');
   elsif clk'event and clk = '1' then
     if(config_start = '1' and xfer_state = STATE_IDLE) then
        shift_register(71 downto 32) <= x"4d30303030";
	shift_register(31 downto 0) <= config_data;
        xfer_state     <= STATE_STRB0;
	xfer_progress <= (others => '0');
     end if;

     if (clk_counter = x"3ff") then
       case (xfer_state) is
         when STATE_IDLE =>

	 when STATE_STRB0 =>
           xfer_state <= STATE_CLK_RISE;

	 when STATE_CLK_RISE =>
           xfer_progress  <= xfer_progress + '1';
           xfer_state <= STATE_CLK_FALL;
            shift_register(71 downto 1) <= shift_register(70 downto 0);
            shift_register(0) <= '0';
	 when STATE_CLK_FALL =>
            if (xfer_progress = x"48") then
              xfer_state <= STATE_STRB1;
            else
	      xfer_state <= STATE_CLK_RISE;
	    end if;
          when STATE_STRB1 =>
            xfer_state <= STATE_SWAIT;
          when STATE_SWAIT =>
            xfer_state <= STATE_IDLE;
	end case;
      end if;
    end if;
end process;       

config_busy_o <= config_busy;

output_p : process(clk, rst)
begin
  if(rst = '1') then
    config_busy <= '0';
    ctrl_clk_o <= '0';
    ctrl_strb_o <= '0';
    ctrl_data_o <= '0';
  elsif clk'event and clk = '1' then
    if xfer_state /= STATE_IDLE then
      config_busy <= '1';
    else
      config_busy <= '0';
    end if;
    if xfer_state = STATE_CLK_RISE then  
      ctrl_clk_o  <= '1';
    else
      ctrl_clk_o  <= '0';
    end if;
    if (xfer_state = STATE_STRB0 or xfer_state = STATE_CLK_RISE or xfer_state = STATE_CLK_FALL or xfer_state = STATE_STRB1) then
      ctrl_strb_o <= '0';
    else
      ctrl_strb_o <= '1';
    end if;
    ctrl_data_o <= shift_register(71);
  end if;
end process;
    
config_p : process(clk, rst)
begin
  if(rst = '1') then
    conf_state <= CONF_MODE_CLEAR;
    clear_wait <= b"1111111111";
  elsif clk'event and clk = '1' then
    case conf_state is
      when CONF_MODE_CLEAR => 
        if (clear_wait = b"0000000000") then
          conf_state <= CONF_MODE_SET;
        else
          clear_wait <= clear_wait - '1';
        end if;
      when CONF_MODE_SET =>
        conf_state <= CONF_LOAD;
      when CONF_LOAD =>
        conf_state <= CONF_WAIT;
      when CONF_WAIT =>
        if (config_busy = '0') then
            conf_state <= CONF_RESET;
        end if;
      when CONF_RESET =>
          conf_state <= CONF_DONE;
      when CONF_DONE =>
    end case;
  end if;
end process;

cmd_reset_p : process(clk, rst)
begin
  if rst = '1' then
    dcm_reset_extend <= (others => '0');
    ddrb_reg <= '0';
  elsif clk'event and clk = '1' then
    ddrb_reg <= ddrb_pre;
    if ddrb_pre = '1' then
      dcm_reset_extend <= (others => '1');
    else
      dcm_reset_extend(4 downto 1) <= dcm_reset_extend(3 downto 0);
      dcm_reset_extend(0) <= '0';
    end if;
  end if;
end process;
      
ddrb_o      <= ddrb_reg;
dcm_reset_o <= '1' when (conf_state /= CONF_DONE) else
               dcm_reset_extend(4);

syns_done_o <= syns_done;

syn_done_p : process(clk, rst)
begin
  if rst = '1' then
    syns_done <= '0';
  elsif clk'event and clk = '1' then
    if conf_state = CONF_DONE then
      syns_done <= '1';
    else
      syns_done <= '0';
    end if;
  end if;
end process;
      

end IMP;
