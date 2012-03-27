library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity adc10d1000_attn is
port (
	clk		   : in  std_logic;
	rst                : in  std_logic;
	request_i          : in  std_logic;
	adc_attn_i_start   : in  std_logic;
	adc_attn_i	   : in  std_logic_vector(0 to 4);
	adc_attn_q_start   : in  std_logic;
	adc_attn_q	   : in  std_logic_vector(0 to 4);
	adc_attn_i_le	   : out std_logic;
	adc_attn_i_data	   : out std_logic;
	adc_attn_i_clk     : out std_logic;
	adc_attn_q_le	   : out std_logic;
	adc_attn_q_data	   : out std_logic;
	adc_attn_q_clk	   : out std_logic
	);
end entity adc10d1000_attn;

architecture IMP of adc10d1000_attn is

	signal shift_register_i	: std_logic_vector(0 to 5);
	signal shift_register_q	: std_logic_vector(0 to 5);
	type xfer_state_t is (STATE_IDLE,STATE_WAIT, STATE_RISE,STATE_FALL,STATE_END);
	signal xfer_state_i	: xfer_state_t;
	signal xfer_state_q	: xfer_state_t;
	signal xfer_progress_i	: std_logic_vector(0 to 4);
	signal xfer_progress_q	: std_logic_vector(0 to 4);
	signal clk_counter	: std_logic_vector(15 downto 0);
	signal i_le_s		: std_logic;
	signal q_le_s		: std_logic;
	signal i_clk		: std_logic;
	signal q_clk		: std_logic;
	signal i_data		: std_logic;
	signal q_data		: std_logic;

begin

-- slow down clock counter
 count_p : process(clk, rst)
 begin
   if(rst = '1') then
     clk_counter <= (others => '0');
   elsif clk'event and clk = '1' then
     if(clk_counter = x"3ff") then
       clk_counter <= (others => '0');
     elsif xfer_state_i = STATE_IDLE then
       clk_counter <= (others => '0');
     else
       clk_counter <= clk_counter + '1';
     end if;
   end if;
 end process;


 state_machine_i_p : process(clk, rst)
 begin
   if(rst = '1') then
     shift_register_i <= (others => '0');
     xfer_state_i   <= STATE_IDLE;
     xfer_progress_i  <= (others => '0');
   elsif clk'event and clk = '1' then
     if(adc_attn_i_start = '1' and xfer_state_i = STATE_IDLE) then
        shift_register_i(0) <= '0';
	shift_register_i(1 to 5) <= adc_attn_i;
        xfer_state_i     <= STATE_WAIT;
	xfer_progress_i <= (others => '0');
     end if;

     if (clk_counter = x"3ff") then
       case (xfer_state_i) is
         when STATE_IDLE =>

	 when STATE_WAIT =>
	   xfer_state_i <= STATE_RISE;
	 when STATE_RISE =>
           xfer_progress_i  <= xfer_progress_i + '1';
           xfer_state_i <= STATE_FALL;
           shift_register_i(0 to 4) <= shift_register_i(1 to 5);
	   shift_register_i(5) <= '0';
	 when STATE_FALL =>
            if (xfer_progress_i = x"6") then
              xfer_state_i <= STATE_END;
            else
	      xfer_state_i <= STATE_RISE;
	    end if;
         when STATE_END =>
            xfer_state_i <= STATE_IDLE;
	end case;
      end if;
    end if;
end process;       

 state_machine_q_p : process(clk, rst)
 begin
   if(rst = '1') then
     shift_register_q <= (others => '0');
     xfer_state_q   <= STATE_IDLE;
     xfer_progress_q  <= (others => '0');
   elsif clk'event and clk = '1' then
     if(adc_attn_q_start = '1' and xfer_state_q = STATE_IDLE) then
        shift_register_q(0) <= '0';
	shift_register_q(1 to 5) <= adc_attn_q;
        xfer_state_q     <= STATE_WAIT;
	xfer_progress_q <= (others => '0');
     end if;

     if (clk_counter = x"3ff") then
       case (xfer_state_q) is
         when STATE_IDLE =>

	 when STATE_WAIT =>
	   xfer_state_q <= STATE_RISE;
	 when STATE_RISE =>
           xfer_progress_q  <= xfer_progress_q + '1';
           xfer_state_q <= STATE_FALL;
           shift_register_q(0 to 4) <= shift_register_q(1 to 5);
	   shift_register_q(5) <= '0';
	 when STATE_FALL =>
            if (xfer_progress_i = x"6") then
              xfer_state_q <= STATE_END;
            else
	      xfer_state_q <= STATE_RISE;
	    end if;
         when STATE_END =>
            xfer_state_q <= STATE_IDLE;
	end case;
      end if;
    end if;
end process;       

output_p : process(clk, rst)
begin
  if(rst = '1') then
     i_le_s	    <= '1';
     q_le_s	    <= '1';
     i_clk	    <= '0';
     q_clk	    <= '0';
     i_data	    <= '0';
     q_data	    <= '0';
  elsif clk'event and clk = '1' then
    if xfer_state_i /= STATE_IDLE then
      i_le_s <= '0';
    else
      i_le_s <= '1';
    end if;
    if (xfer_state_i = STATE_RISE)then  
      i_clk  <= '1';
    else
      i_clk  <= '0';
    end if;
    i_data <= shift_register_i(0);

    if xfer_state_q /= STATE_IDLE then
      q_le_s <= '0';
    else
      q_le_s <= '1';
    end if;
    if (xfer_state_q = STATE_RISE)then  
      q_clk  <= '1';
    else
      q_clk  <= '0';
    end if;
    q_data <= shift_register_q(0);

  end if;
end process;

adc_attn_i_le		<= i_le_s;	   
adc_attn_i_data		<= i_data;
adc_attn_i_clk		<= i_clk;
adc_attn_q_le		<= q_le_s;
adc_attn_q_data		<= q_data;
adc_attn_q_clk		<= q_clk;


end IMP;

