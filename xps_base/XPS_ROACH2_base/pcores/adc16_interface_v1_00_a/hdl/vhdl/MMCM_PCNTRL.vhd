----------------------------------------------------------------------------
-- Import useful libraries
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;

-- entity declaraction
entity  MMCM_PCNTRL  is

    port (
               sysclk       :  in  std_logic;
               reset        :  in  std_logic;
               mode         :  in  std_logic;
               shift        :  in  std_logic;
               shift_val    :  in  std_logic_vector(7 downto 0);-- max 56
               ready        :  out std_logic;
               o_psdone     :  out std_logic;

               -- DCM inputs/outputs
               MMCM_PSCLK    :  out std_logic;
               MMCM_PSEN     :  out std_logic;
               MMCM_PSINCDEC :  out std_logic;
               MMCM_PSDONE   :  in  std_logic;
               MMCM_LOCKED   :  in  std_logic
    );

end  MMCM_PCNTRL;

architecture MMCM_PCNTRL_arc of MMCM_PCNTRL is

     -- state list
     type t_state is ( s_RESET,
                       s_READY,
                       s_SETUP,
                       s_HOLD,
                       s_LOOP1,
                       s_LOOP2,
                       s_DONE
                             );

     -- State signals
     signal CurState: t_state;
     signal NextState: t_state;

     -- System signals
     signal r_psdone: std_logic := '1';
     signal reset_psdone: std_logic := '0';
     signal ticks: std_logic_vector(7 downto 0);
     signal next_ticks: std_logic_vector(7 downto 0);
     signal shift_dir: std_logic;

     signal shift_d1 : std_logic;
     signal shift_d2 : std_logic;
     signal shift_d3 : std_logic;
     signal shift_d4 : std_logic;

     begin

     -- Line mapping
     shift_dir <= mode;
     MMCM_PSCLK <= sysclk;
     MMCM_PSINCDEC <= shift_dir;
     --o_psdone <= r_psdone;

     process (sysclk)
     begin
         if rising_edge(sysclk) then
             shift_d1 <= shift;
             shift_d2 <= shift_d1;
             shift_d3 <= shift_d2;
             shift_d4 <= (not shift_d3 and shift_d2);
         end if;
     end process;

     -- State control (next state logic)
     process (CurState, shift_d4, ticks, r_psdone, MMCM_LOCKED)
     begin
            case CurState is

               when s_RESET =>
                   NextState <= s_RESET;

                   if (MMCM_LOCKED = '1') then
                       NextState <= s_READY;
                   end if;

               when s_READY =>
                   NextState <= s_READY; -- Default

                   if (shift_d4 = '1') then
                       NextState <= s_SETUP;
                   end if;

               when s_SETUP =>
                   NextState <= s_HOLD;

               when s_HOLD =>
                   NextState <= s_HOLD;

                   if r_psdone='1' then
                       NextState <= s_LOOP1;
                   end if;

               when s_LOOP1 =>
                   NextState <= s_LOOP2;

               when s_LOOP2 =>
                   NextState <= s_HOLD;

                   if ticks=std_logic_vector(to_unsigned(0,ticks'length)) then
                       NextState <= s_DONE;
                   end if;

               when s_DONE =>
                   NextState <= s_READY;

               when others =>
                   NextState <= s_RESET; -- If we're in any other state, reset
            end case;
     end process;

     -- Update state logic
     process (sysclk)
     begin
         -- Store pending values into their DFFs on the rising edge
         if rising_edge(sysclk) then
            CurState <= NextState;
            ticks <= next_ticks;

            r_psdone <= (r_psdone or (MMCM_PSDONE and MMCM_LOCKED));

            if reset_psdone='1' then
                r_psdone <= '0';
            end if;

            if (reset = '1') then
                CurState <= s_RESET;
                r_psdone <= '1';
            end if;
         end if;
     end process;

     -- Register/output control logic
     process (CurState, ticks, shift_val)
     begin
            case CurState is

               when s_RESET =>
                   ready <= '0';
                   MMCM_PSEN <= '0';
                   next_ticks <= ticks;
                   reset_psdone <= '0';
                   o_psdone <= '0';

               when s_READY =>
                   ready <= '1';
                   MMCM_PSEN <= '0';
                   next_ticks <= ticks;
                   reset_psdone <= '0';
                   o_psdone <= '1';

               when s_SETUP =>
                   ready <= '0';
                   MMCM_PSEN <= '0';
                   next_ticks <= shift_val;
                   reset_psdone <= '0';
                   o_psdone <= '0';

               when s_HOLD =>
                   ready <= '0';
                   MMCM_PSEN <= '0';
                   next_ticks <= ticks;
                   reset_psdone <= '0';
                   o_psdone <= '0';

               when s_LOOP1 =>
                   ready <= '0';
                   MMCM_PSEN <= '1';
                   next_ticks <= ticks-1;
                   reset_psdone <= '1';
                   o_psdone <= '0';

               when s_LOOP2 =>
                   ready <= '0';
                   MMCM_PSEN <= '0';
                   next_ticks <= ticks;
                   reset_psdone <= '0';
                   o_psdone <= '0';

               when s_DONE =>
                   ready <= '0';
                   MMCM_PSEN <= '0';
                   next_ticks <= ticks;
                   reset_psdone <= '0';
                   o_psdone <= '0';

               when others =>
                   null;
            end case;
     end process;

end MMCM_PCNTRL_arc;

