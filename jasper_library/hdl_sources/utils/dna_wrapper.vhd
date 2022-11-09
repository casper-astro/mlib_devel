--======================================================================
-- Wrapper for the Xilinx device DNA primitive. A 1->0 transition of
-- the reset triggers a read of the DNA value, which is then exposed
-- as a 96-bit parallel value.
--
-- Details about the DNA_PORTE2 primitive itself can be found in UG974
-- and UG570.
--======================================================================

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

library unisim;
use unisim.vcomponents.all;

entity device_dna is
  port (
    clk : in std_logic;
    rst : in std_logic;
    dna : out std_logic_vector(95 downto 0)
  );
end device_dna;

architecture rtl of device_dna is

  constant C_DNA_LENGTH : natural := 96;

  signal dna_dout : std_logic;
  signal dna_read : std_logic;
  signal dna_shift : std_logic;

  signal dna_val : std_logic_vector(C_DNA_LENGTH - 1 downto 0);
  signal dna_bits_left : std_logic_vector(7 downto 0);

  type STATE is (STATE_IDLE, STATE_READ, STATE_SHIFT, STATE_DONE);
  signal fsm_state : STATE;

begin

  -- The actual Xilinx UltraScale(+) device DNA primitive.
  dna_port : DNA_PORTE2
    generic map (
      -- SIM_DNA_VALUE => x"000000000000000000000000"
      SIM_DNA_VALUE => x"e1e1e1e1f1f1f1f1c1c1c1c1"
    )
    port map (
      clk => clk,
      din => '0',
      dout => dna_dout,
      read => dna_read,
      shift => dna_shift
    );

  -- The process to trigger a DNA read and turn the serial result into
  -- a bit vector.
  read_dna : process (clk) is
  begin
    if rising_edge(clk) then
      if rst = '1' then
        fsm_state <= STATE_IDLE;
      else
        case fsm_state is
          when STATE_IDLE =>
            dna_read <= '0';
            dna_shift <= '0';
            dna_val <= (others => '0');
            dna_bits_left <= (others => '0');
            -- Move on.
            fsm_state <= STATE_READ;
          when STATE_READ =>
            -- Trigger a DNA read.
            dna_read <= '1';
            dna_shift <= '0';
            dna_val <= (others => '0');
            dna_bits_left <= std_logic_vector(to_unsigned(C_DNA_LENGTH, dna_bits_left'length));
            -- Move on.
            fsm_state <= STATE_SHIFT;
          when STATE_SHIFT =>
            dna_read <= '0';
            dna_shift <= '1';
            -- Add the latest bit read to our running value.
            -- NOTE: Shift direction is from LSB to MSB.
            dna_val <= dna_dout & dna_val(dna_val'length - 1 downto 1);
            dna_bits_left <= dna_bits_left - '1';
            -- Once the whole DNA has been read, move on.
            if dna_bits_left = (dna_bits_left'range => '0') then
              fsm_state <= STATE_DONE;
            else
              fsm_state <= fsm_state;
            end if;
          when STATE_DONE =>
            -- Nothing to do, really.
            dna_read <= dna_read;
            dna_shift <= '0';
            dna_val <= dna_val;
            dna_bits_left <= dna_bits_left;
            fsm_state <= fsm_state;
        end case;
      end if;
    end if;
  end process read_dna;

  dna <= dna_val;

end rtl;