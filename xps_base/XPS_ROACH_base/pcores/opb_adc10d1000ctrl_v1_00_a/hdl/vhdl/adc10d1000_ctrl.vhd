library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity adc10d1000_ctrl is
port (
	clk		   : in  std_logic;
	rst                : in  std_logic;
	request_i          : in  std_logic;
	syns_done_i	   : in  std_logic;
	adc_start_i	   : in  std_logic;
	adc_rw_i	   : in  std_logic;
	adc_addr_i	   : in  std_logic_vector(0 to 6);
	adc_data_i	   : in  std_logic_vector(0 to 15);
	adc_ece_i	   : in  std_logic;
	adc_busy_o	   : out std_logic;
	adc_data_o         : out std_logic_vector(0 to 15);
	adc_scsb_o	   : out std_logic;
	adc_sclk_o	   : out std_logic;
	adc_sdi		   : in  std_logic;
	adc_sdo		   : out std_logic;
	adc_ece_o	   : out std_logic;
	adc_calrun_i       : in  std_logic
	);
end entity adc10d1000_ctrl;

architecture IMP of adc10d1000_ctrl is

	signal adc_ece		: std_logic;
	signal shift_register	: std_logic_vector(0 to 23);
	signal shift_input	: std_logic_vector(0 to 15);
	signal sdo_input_reg	: std_logic;
	type xfer_state_t is (STATE_IDLE,STATE_READ,STATE_WRITE,STATE_WRITE_RISE,STATE_WRITE_FALL,STATE_WRITE_END,
				STATE_READ_WAITE,STATE_ADDR_READ_RISE,STATE_ADDR_READ_FALL,STATE_DATA_READ_RISE,
				STATE_DATA_READ_FALL,STATE_READ_END);
	signal xfer_state	: xfer_state_t;
	signal xfer_progress	: std_logic_vector(0 to 4);
	signal clk_counter	: std_logic_vector(15 downto 0);

begin

adc_ece_o<= adc_ece;

ECE_mode_p : process(clk, rst)
begin
  if(rst = '1') then
    adc_ece <= '1';
  elsif clk'event and clk = '1' then
    if (syns_done_i = '1' and request_i = '0') then
      adc_ece <= '0';
    elsif (syns_done_i = '1' and request_i = '1') then
      adc_ece <= adc_ece_i;
    else
      adc_ece <= adc_ece;
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


adc_data_o <= shift_input;

 state_machine_p : process(clk, rst)
 begin
   if(rst = '1') then
     shift_register <= (others => '0');
     xfer_state     <= STATE_IDLE;
     xfer_progress  <= (others => '0');
     shift_input    <= (others => '0');
     sdo_input_reg  <= '0';
   elsif clk'event and clk = '1' then
     if(adc_start_i = '1' and xfer_state = STATE_IDLE) then
        shift_register(0) <= adc_rw_i;
	shift_register(1 to 7) <= adc_addr_i;
	shift_register(8 to 23) <= adc_data_i;
	if adc_rw_i = '1' then
          xfer_state     <= STATE_READ;
	else
          xfer_state     <= STATE_WRITE;
	end if;
	xfer_progress <= (others => '0');
     end if;

     if (clk_counter = x"3ff") then
       case (xfer_state) is
         when STATE_IDLE =>

	 when STATE_WRITE =>
           xfer_state <= STATE_WRITE_RISE;
	 when STATE_WRITE_RISE =>
           xfer_progress  <= xfer_progress + '1';
           xfer_state <= STATE_WRITE_FALL;
            shift_register(0 to 22) <= shift_register(1 to 23);
	    shift_register(23) <= '0';
	 when STATE_WRITE_FALL =>
            if (xfer_progress = x"18") then
              xfer_state <= STATE_WRITE_END;
            else
	      xfer_state <= STATE_WRITE_RISE;
	    end if;
         when STATE_WRITE_END =>
            xfer_state <= STATE_IDLE;
	 when STATE_READ =>
           xfer_state <= STATE_READ_WAITE;
	 when STATE_READ_WAITE =>
           xfer_state <= STATE_ADDR_READ_RISE;
	 when STATE_ADDR_READ_RISE =>
           xfer_progress  <= xfer_progress + '1';
           shift_register(0 to 22) <= shift_register(1 to 23);
	   shift_register(23) <= '0';
           xfer_state <= STATE_ADDR_READ_FALL;
	 when STATE_ADDR_READ_FALL =>
	   if(xfer_progress = x"8") then
             xfer_state <= STATE_DATA_READ_RISE;
	   else
             xfer_state <= STATE_ADDR_READ_RISE;
	   end if;
	 when STATE_DATA_READ_RISE =>
           xfer_progress  <= xfer_progress + '1';
           xfer_state <= STATE_DATA_READ_FALL;
	 when STATE_DATA_READ_FALL =>
	   if(xfer_progress = x"18") then
             xfer_state <= STATE_READ_END;
	   else
             xfer_state <= STATE_DATA_READ_RISE;
	   end if;
	   sdo_input_reg <= adc_sdi;
	   shift_input(0 to 14) <= shift_input(1 to 15);
	   shift_input(15) <= sdo_input_reg;
         when STATE_READ_END =>
            xfer_state <= STATE_IDLE;
	end case;
      end if;
    end if;
end process;       

output_p : process(clk, rst)
begin
  if(rst = '1') then
    adc_busy_o <= '0';
    adc_scsb_o <= '0';
    adc_sclk_o <= '0';
    adc_sdo <= '0';
  elsif clk'event and clk = '1' then
    if xfer_state /= STATE_IDLE then
      adc_busy_o <= '1';
    else
      adc_busy_o <= '0';
    end if;
    if (xfer_state = STATE_WRITE_RISE or xfer_state = STATE_READ or xfer_state = STATE_ADDR_READ_RISE or xfer_state = STATE_DATA_READ_RISE )then  
      adc_sclk_o  <= '1';
    else
      adc_sclk_o  <= '0';
    end if;
    if (xfer_state = STATE_READ or xfer_state = STATE_READ_END or xfer_state = STATE_WRITE_END or xfer_state = STATE_IDLE) then
      adc_scsb_o <= '1';
    else
      adc_scsb_o <= '0';
    end if;
    adc_sdo <= shift_register(0);
  end if;
end process;


end IMP;

