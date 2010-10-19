library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
--
-- pragma translate_off
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
-- pragma translate_on

entity cal_ctl is
port(
     clk            : in std_logic;
     dcmlocked      : in std_logic;
     psDone         : in std_logic;
     reset          : in std_logic;
     hxSamp1        : in std_logic;
     phSamp1        : in std_logic;
     okToSelTap     : in std_logic;
     locReset       : out std_logic;
     psEn           : out std_logic := '0';
     psInc          : out std_logic;
     selTap         : out std_logic_vector(4 downto 0);
     tapForDqs      : out std_logic_vector(4 downto 0)
     );
end cal_ctl;

architecture arc_cal_ctl of cal_ctl is


---------
attribute syn_keep : boolean;
constant idleSetup : std_logic_vector(3 downto 0) := "0000";
constant idleD0    : std_logic_vector(3 downto 0) := "0001";
constant idleD1    : std_logic_vector(3 downto 0) := "0010";
constant idleD2    : std_logic_vector(3 downto 0) := "0011";
constant idleD3    : std_logic_vector(3 downto 0) := "0100";
constant idleD4    : std_logic_vector(3 downto 0) := "0101";
constant idleD5    : std_logic_vector(3 downto 0) := "0110";

---------

constant waitSetup : std_logic_vector(3 downto 0) := "0111";
constant waitDcmD0 : std_logic_vector(3 downto 0) := "1000";
constant waitDcmD1 : std_logic_vector(3 downto 0) := "1001";
constant waitDcmD2 : std_logic_vector(3 downto 0) := "1010";
constant waitDcmD3 : std_logic_vector(3 downto 0) := "1011";
constant waitDcmD4 : std_logic_vector(3 downto 0) := "1100";
constant waitDcmD5 : std_logic_vector(3 downto 0) := "1101";

---------

constant idleDone  : std_logic_vector(3 downto 0) := "1110";

---------

constant idleReset : std_logic := '1';
constant waitReset : std_logic := '0';
!TCL! if $synthesize {
constant lBound    : std_logic_vector(7 downto 0) := "00110010";
constant uBound    : std_logic_vector(7 downto 0) := "01010000";
!TCL! } else {
constant lBound    : std_logic_vector(7 downto 0) := "00010100";
constant uBound    : std_logic_vector(7 downto 0) := "00100000";
!TCL! }
constant slipCnt   : std_logic_vector(3 downto 0) := "1100";

----------

constant tap1   : std_logic_vector(4 downto 0) := "00000";
constant tap2   : std_logic_vector(4 downto 0) := "10000";
constant tap3   : std_logic_vector(4 downto 0) := "11000";
constant tap4   : std_logic_vector(4 downto 0) := "11100";
constant tap5   : std_logic_vector(4 downto 0) := "11110";
constant tap6   : std_logic_vector(4 downto 0) := "11111";
---- constant defaultTap : tap3;
constant defaultTap : std_logic_vector(4 downto 0) := "11000";


signal  state  : std_logic_vector(3 downto 0) := "0000";
signal  posPhShft  : std_logic_vector(7 downto 0) := "00000000";
signal  negPhShft  : std_logic_vector(7 downto 0) := "00000000";
signal 	prevSamp   : std_logic := '0';

signal d0Shft  : std_logic_vector(7 downto 0) := "00000000";
signal d1Shft  : std_logic_vector(7 downto 0) := "00000000";
signal d2Shft  : std_logic_vector(7 downto 0) := "00000000";
signal d3Shft  : std_logic_vector(7 downto 0) := "00000000";
signal d4Shft  : std_logic_vector(7 downto 0) := "00000000";
signal d5Shft  : std_logic_vector(7 downto 0) := "00000000";
signal suShft  : std_logic_vector(7 downto 0) := "00000000";
   

signal waitOneCycle : std_logic := '1';
signal waitTwoCycle  : std_logic := '0';
signal wait3Cycle : std_logic := '0';
signal wait4Cycle : std_logic := '0';
signal psDoneReg  : std_logic := '0';
signal wait5Cycle : std_logic := '0';
signal decPosSh  : std_logic_vector( 7 downto 0) := "00000000";
signal decNegSh  : std_logic_vector( 7 downto 0) := "00000000";
signal rstate   : std_logic := '1';
signal resetDcm : std_logic := '0';
signal inTapForDqs : std_logic_vector(4 downto 0) := "11000";
signal selCnt : std_logic_vector(3 downto 0) := "0000";
signal newTap : std_logic_vector(4 downto 0) := "11000";
signal okSelCnt : std_logic := '0';
signal midPt  : std_logic_vector(3 downto 0) := "0011";
signal uPtr   : std_logic_vector(3 downto 0) := "0101";
signal lPtr   : std_logic_vector(3 downto 0) := "0000";
signal ozShft : std_logic_vector(7 downto 0) := "00000000";
signal zoShft : std_logic_vector(7 downto 0) := "00000000";
signal psinc_val : std_logic := '0'; 

signal selTap_val    : std_logic_vector(4 downto 0) := "00000";
signal tapForDqs_val : std_logic_vector(4 downto 0):= "11000";


attribute syn_keep of tapForDqs_val : signal is true;
attribute syn_keep of selTap_val    : signal is true;
begin

locReset <= '0' when (dcmlocked = '1' and ( not reset = '1')) else
            '1';

psinc <= psinc_val;

selTap     <= selTap_val;
tapForDqs  <= tapForDqs_val;

process(clk)
begin
 if clk'event and clk = '1' then
  if reset = '1' then
    ozShft <= (others => '0');
    zoShft <= (others => '0');
  else
    zoShft <= suShft - posPhShft;
    ozShft <= negPhShft + suShft;
  end if;
 end if;
end process;



-----   statemachine

process(clk)
begin
   if clk'event and clk = '1' then
      if reset = '1' then
         psEn    <=  '0';
         psinc_val   <=  '0';
         state   <=  idleSetup;
         prevSamp <= '0';
         posPhShft <= "00000000";
         negPhShft <= "00000000";

         d0Shft <= "00000000";
         d1Shft <= "00000000";
         d2Shft <= "00000000";
         d3Shft <= "00000000";
         d4Shft <= "00000000";
         d5Shft <= "00000000";
         suShft <= "00000000";

         selTap_val <= tap1;
         waitOneCycle <= '1';
         waitTwoCycle <= '0';
         wait3Cycle <= '0';
         wait4Cycle <= '0';
         wait5Cycle <= '0';
         psDoneReg <= '0';
         decPosSh <= "00000000";
         decNegSh <= "00000000";
         resetDcm <= '0';
         rstate <= idleReset;
      else
         psDoneReg <= psDone;
         if (dcmlocked = '1') then
            if ( resetDcm = '1') then
               if ( rstate = idleReset) then
                  if (posPhShft /= decPosSh) then
                     psEn <= '1';
                     psinc_val <= '0';
                     decPosSh <= decPosSh + 1;
                     rstate <= waitReset;
                  elsif ( negPhShft /= decNegSh) then
                     psEn <= '1';
                     psinc_val <= '1';
                     decNegSh <= decNegSh + 1;
                     rstate <= waitReset;
                  else 
                     resetDcm <= '0';
                     posPhShft <= "00000000";
                     negPhShft <= "00000000";
                     decNegSh  <= "00000000";
                     decPosSh  <= "00000000";
                  end if; ---if (posPhShft /= decPosSh)
               elsif ( rstate = waitReset) then
                  psEn <= '0';
                  if (psDoneReg = '1') then
                     rstate <= idleReset;
                  else
                     rstate <= waitReset;
                  end if; ----if (psDoneReg = '1')
                end if; ---- if ( rstate = idleReset)
            else --- if (resetDcm = 0)
               if (waitOneCycle = '1') then
                  waitOneCycle <= '0';
		  waitTwoCycle <= '1';
               elsif (waitTwoCycle = '1') then
                  waitTwoCycle <= '0';
		  wait3Cycle   <= '1';
               elsif (wait3Cycle = '1') then
                  wait3Cycle <= '0';
		  wait4Cycle <= '1';
               elsif (wait4Cycle = '1') then
                  wait4Cycle <= '0';
		  wait5Cycle <= '1';
               elsif (wait5Cycle = '1') then
                  wait5Cycle <= '0';
                  if (state = idleSetup) then
                     prevSamp <= phSamp1;
                  else
                     prevSamp <= hxSamp1;
                   end if;
                else
                   if (state = idleSetup) then
                        if (phSamp1 = '1' and prevSamp = '0') then
                           suShft <= posPhShft;
			   state <= idleD0;
			   rstate <= idleReset;
			   resetDcm <= '1';
			   waitOneCycle <= '1';
                        elsif ( phSamp1 = '0' and prevSamp = '1') then
                           suShft <= negPhShft;
		           state <= idleD0;
			   rstate <= idleReset;
			   resetDcm <= '1';
			   waitOneCycle <= '1';
                        elsif ( phSamp1 = '0' and prevSamp = '0') then
                           psEn <= '1';
			   psinc_val <= '1';
			   state <= waitSetup;
			   prevSamp <= '0';
                        elsif (phSamp1 = '1' and prevSamp = '1') then
                           psEn <= '1';
			   psinc_val <= '0';
			   prevSamp <= '1';
			   state <= waitSetup;
		        end if;
                   elsif (state = waitSetup) then
                      psEn <= '0';
                      if (psDoneReg = '1') then
                         state <= idleSetup;
                       end if;
                   elsif (state = idleD0) then
                       if (hxSamp1 = '1' and prevSamp = '0') then
                          d0Shft <= zoShft;
                          selTap_val <= tap2;
                          waitOneCycle <= '1';
                          state <= idleD1;
                          rstate <= idleReset;
                          resetDcm <= '1';
                       elsif (hxSamp1 = '0' and prevSamp = '1' ) then
			  d0Shft <= ozShft;
			  selTap_val <= tap2;
			  waitOneCycle <= '1';
			  state <= idleD1;
			  rstate <= idleReset;
			  resetDcm <= '1';
		       elsif (hxSamp1 = '0' and prevSamp = '0') then
			--- increment phase shift delay
			  psEn <= '1';
			  psinc_val <= '1';
			  state <= waitDcmD0;
			  prevSamp <= '0';
		       elsif (hxSamp1 = '1' and prevSamp = '1')  then
			---- decrement variable delay
			  psEn <= '1';
			  psinc_val <= '0';
			  state <= waitDcmD0;
			  prevSamp <= '1';
		       end if;
 		  elsif (state = waitDcmD0) then
		     psEn <= '0';
		     if (psDoneReg = '1') then
			state <= idleD0;
		     end if;
                  elsif (state = idleD1) then
		     if (hxSamp1 = '1' and prevSamp = '0') then
			d1Shft <= zoShft;
			selTap_val <= tap3;
			waitOneCycle <= '1';
			state <= idleD2;
			rstate <= idleReset;
			resetDcm <= '1';
		     elsif (hxSamp1 = '0' and prevSamp = '1') then
			d1Shft <= ozShft;
			selTap_val <= tap3;
			waitOneCycle <= '1';
			state <= idleD2;
			rstate <= idleReset;
			resetDcm <= '1';
		     elsif (hxSamp1 = '0' and prevSamp = '0') then
			--- increment phase shift delay
			psEn <= '1';
                        psinc_val <= '1';
			state <= waitDcmD1;
			prevSamp <= '0';
		     elsif (hxSamp1 = '1' and prevSamp = '1') then
			--- decrement variable delay
			psEn <= '1';
			psinc_val <= '0';
			state <= waitDcmD1;
			prevSamp <= '1';
		       end if;
 		  elsif (state = waitDcmD1) then
		     psEn <= '0';
		     if (psDoneReg = '1') then
			state <= idleD1;
		     end if;
                  elsif (state = idleD2) then
		     if (hxSamp1 = '1' and  prevSamp = '0') then
			d2Shft <= zoShft;
			selTap_val <= tap4;
			waitOneCycle <= '1';
			state <= idleD3;
			rstate <= idleReset;
			resetDcm <= '1';
		     elsif (hxSamp1 = '0' and prevSamp = '1') then
			d2Shft <= ozShft;
			selTap_val <= tap4;
			waitOneCycle <= '1';
			state <= idleD3;
			rstate <= idleReset;
			resetDcm <= '1';
		     elsif (hxSamp1 = '0' and prevSamp = '0') then
			--- increment phase shift delay
			psEn <= '1';
			psinc_val <= '1';
			state <= waitDcmD2;
			prevSamp <= '0';
		    elsif (hxSamp1 = '1' and prevSamp = '1') then
			--- decrement variable delay
			psEn <= '1';
			psinc_val <= '0';
			state <= waitDcmD2;
			prevSamp <= '1';
		     end if;
 		  elsif (state = waitDcmD2) then
		     psEn <= '0';
		     if (psDoneReg = '1') then
			state <= idleD2;
		     end if;
                  elsif (state = idleD3) then
		     if (hxSamp1 = '1' and  prevSamp = '0') then
			d3Shft <= zoShft;
			selTap_val <= tap5;
			waitOneCycle <= '1';
			state <= idleD4;
			rstate <= idleReset;
			resetDcm <= '1';
		     elsif (hxSamp1 = '0' and prevSamp = '1' ) then
			d3Shft <= ozShft;
			selTap_val <= tap5;
			waitOneCycle <= '1';
			state <= idleD4;
			rstate <= idleReset;
			resetDcm <= '1';
		     elsif (hxSamp1 = '0'and prevSamp = '0') then
			--- increment phase shift delay
			psEn <= '1';
			psinc_val <= '1';
			state <= waitDcmD3;
			prevSamp <= '0';
                     elsif (hxSamp1 = '1' and prevSamp = '1') then
			--- decrement variable delay
			psEn <= '1';
			psinc_val <= '0';
			state <= waitDcmD3;
			prevSamp <= '1';
		        end if;
 		  elsif (state = waitDcmD3) then
		     psEn <= '0';
		     if (psDoneReg = '1') then
			state <= idleD3;
		     end if;
		  elsif (state = idleD4) then
		     if (hxSamp1 = '1' and prevSamp = '0') then
			d4Shft <= zoShft;
			selTap_val <= tap6;
			waitOneCycle <= '1';
			state <= idleD5;
			rstate <= idleReset;
			resetDcm <= '1';
		     elsif (hxSamp1 = '0' and prevSamp = '1' ) then
			d4Shft <= ozShft;
			selTap_val <= tap6;
			waitOneCycle <= '1';
			state <= idleD5;
			rstate <= idleReset;
			resetDcm <= '1';
		     elsif (hxSamp1 = '0' and prevSamp = '0') then
			--- increment phase shift delay
			psEn <= '1';
			psinc_val <= '1';
			state <= waitDcmD4;
			prevSamp <= '0';
		     elsif (hxSamp1 = '1'and prevSamp = '1') then
			--- decrement variable delay
			psEn <= '1';
			psinc_val <= '0';
			state <= waitDcmD4;
			prevSamp <= '1';
		     end if;
                  elsif (state = waitDcmD4) then
		     psEn <= '0';
		     if (psDoneReg = '1') then
			state <= idleD4;
		     end if;
		  elsif (state = idleD5) then
		     if (hxSamp1 = '1' and prevSamp = '0') then
			d5Shft <= zoShft;
			selTap_val <= tap1;
			waitOneCycle <= '1';
			state <= idleD0;
			rstate <= idleReset;
			resetDcm <= '1';
		     elsif (hxSamp1 = '0' and prevSamp = '1' ) then
			d5Shft <= ozShft;
			selTap_val <= tap1;
			waitOneCycle <= '1';
			state <= idleD0;
			rstate <= idleReset;
			resetDcm <= '1';
		     elsif (hxSamp1 = '0' and prevSamp = '0') then
                        ---  increment phase shift delay
			psEn <= '1';
			psinc_val <= '1';
			state <= waitDcmD5;
			prevSamp <= '0';
		     elsif (hxSamp1 = '1' and prevSamp = '1') then
			---- decrement variable delay
			psEn <= '1';
			psinc_val <= '0';
			state <= waitDcmD5;
			prevSamp <= '1';
		     end if;
 		 elsif (state = waitDcmD5) then
		     psEn <= '0';
		     if (psDoneReg = '1' ) then
			state <= idleD5;
		     end if;
		     --- end else if (state == `idleDone) begin
		  end if;
	       end if; --- else: !if(wait4Cycle)
	       
	    end if; ----  else: !if(resetDcm)

           if (psDoneReg = '1' and rstate /= waitReset) then
	      if (psinc_val = '1') then
                   posPhShft <= posPhShft + 1;
	      else 
                  negPhShft <= negPhShft + 1;
	       end if;
            end if;

	 end if;---- // if (dcmlocked)
	 
      end if;--- // else: !if(reset)
      end if;
  
end process;      
   

--- Logic to figure out the number of tap delays to use for dqs
 ---  generate the output tapForDqs
 
 process(clk)
 begin            
     if clk'event and clk = '1' then
        if reset = '1' then
             lPtr <= "0000";
             uPtr <= "0101";
             tapForDqs_val <= defaultTap;
             inTapForDqs <= defaultTap;
             newTap  <= defaultTap;
             midPt <= "0011";
             okSelCnt <= '0';
         else
            if (d0Shft > lBound) then
               lPtr <= "0000";
            elsif (d1Shft > lBound) then
               lPtr <= "0001";
            elsif (d2Shft > lBound) then
               lPtr <= "0010";
	    elsif (d3Shft > lBound) then
               lPtr <= "0011";
	    elsif (d4Shft > lBound) then
               lPtr <= "0100";
	    else 
               lPtr <= "0101";
            end if;
             
             if (d5Shft < uBound) then
                uPtr <= "0101";
	     elsif (d4Shft < uBound) then
                uPtr <= "0100";
	     elsif (d3Shft < uBound) then
                uPtr <= "0011";
	     elsif (d2Shft < uBound) then
                uPtr <= "0010";
	     elsif (d1Shft < uBound) then
                uPtr <= "0001";
	     else 
                uPtr <= "0000";
             end if;

           midPt(3 downto 0) <= ( uPtr(3 downto 0) + lPtr(3 downto 0) );

  --------------------
            
           case midPt(3 downto 1) is

               when "000" =>
                     inTapForDqs <= tap1;
	       when "001" =>
                     inTapForDqs <= tap2;
	       when "010" =>
                     inTapForDqs <= tap3;
	       when "011" =>
                     inTapForDqs <= tap4;              
	       when "100" =>
                     inTapForDqs <= tap5;
	       when "101" =>
                     inTapForDqs <= tap6;
	       when others =>
                     inTapForDqs <= inTapForDqs;
	 end case;  --- case(midPt[2:0])
        
         ---  tap output shouldn't change unless the same tap value is selected n number of times.

	 newTap <= inTapForDqs;

	 if (inTapForDqs = newTap) then
	    
	    if (wait4Cycle = '1') then
              selCnt <= selCnt + 1;
             end if;
	    if (selCnt = slipCnt) then
               okSelCnt <= '1';
	    else okSelCnt <= '0';
             end if;
	  else 
	    selCnt <= "0000";
	    okSelCnt <= '0';
	 end if;
	    	 
	 if (okToSelTap ='1' and okSelCnt = '1') then
               tapForDqs_val <= newTap;
         end if;
        end if;
       end if;
      end process;
     


	
end arc_cal_ctl;
