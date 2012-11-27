library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity adc10d1000_temp is
port (
	clk		   : in  std_logic;
	rst                : in  std_logic;
	request_i          : in  std_logic;
	adc_temp_start     : in  std_logic;
	adc_temp_cs	   : out std_logic;
	adc_temp_sck       : out std_logic;
	adc_temp_sdo       : in  std_logic;
	adc_temp_data	   : out std_logic_vector(12 downto 0)
	);
end entity adc10d1000_temp;

architecture IMP of adc10d1000_temp is

	signal shift_register	: std_logic_vector(0 to 15);
	type xfer_state_t is (STATE_IDLE,STATE_WAIT, STATE_RISE,STATE_FALL,STATE_END);
	signal xfer_state	: xfer_state_t;
	signal xfer_progress	: std_logic_vector(0 to 4);
	signal clk_counter	: std_logic_vector(15 downto 0);
	signal cs_s		: std_logic;
	signal sck_s		: std_logic;
	signal adc_temp_data_s	: std_logic_vector(12 downto 0);

begin

-- slow down clock counter
 count_p : process(clk, rst)
 begin
   if(rst = '1') then
     clk_counter <= (others => '0');
   elsif clk'event and clk = '1' then
     if(clk_counter = x"3ff") then
       clk_counter <= (others => '0');
     elsif xfer_state = STATE_IDLE then
       clk_counter <= (others => '0');
     else
       clk_counter <= clk_counter + '1';
     end if;
   end if;
 end process;


 state_machine_i_p : process(clk, rst)
 begin
   if(rst = '1') then
     xfer_state     <= STATE_IDLE;
     xfer_progress  <= (others => '0');
   elsif clk'event and clk = '1' then
     if(adc_temp_start = '1' and xfer_state = STATE_IDLE) then
        xfer_state     <= STATE_WAIT;
	xfer_progress  <= (others => '0');
     end if;

     if (clk_counter = x"3ff") then
       case (xfer_state) is
         when STATE_IDLE =>

	 when STATE_WAIT =>
	   xfer_state <= STATE_RISE;
	 when STATE_RISE =>
           xfer_progress  <= xfer_progress + '1';
           xfer_state <= STATE_FALL;
	 when STATE_FALL =>
            if (xfer_progress = x"10") then
              xfer_state <= STATE_END;
            else
	      xfer_state <= STATE_RISE;
	    end if;
         when STATE_END =>
            xfer_state <= STATE_IDLE;
	end case;
      end if;
    end if;
end process;       

adc_temp_data <= adc_temp_data_s;
adc_temp_cs   <= cs_s;
adc_temp_sck  <= sck_s;

input_p : process(clk, rst)
begin
  if(rst = '1') then
      cs_s	    <= '1';
      sck_s	    <= '0';
      shift_register <= (others => '0');
      adc_temp_data_s <= (others => '0');
  elsif clk'event and clk = '1' then
    adc_temp_data_s <= shift_register(0 to 12);
    if xfer_state /= STATE_IDLE then
      cs_s <= '0';
    else
      cs_s <= '1';
    end if;

    if xfer_state = STATE_WAIT then
      shift_register <= (others => '0');
    end if;

    if (xfer_state = STATE_RISE)then  
      sck_s  <= '1';
    else
      sck_s  <= '0';
    end if;
    if (xfer_state = STATE_FALL and clk_counter = x"3ff" and xfer_progress /= x"10")then  
      shift_register(15) <= adc_temp_sdo;
      shift_register(0 to 14) <= shift_register(1 to 15);
    end if;
  end if;
end process;

end IMP;

