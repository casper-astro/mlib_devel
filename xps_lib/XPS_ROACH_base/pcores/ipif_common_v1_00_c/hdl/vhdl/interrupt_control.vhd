-------------------------------------------------------------------------------
-- $Id: interrupt_control.vhd,v 1.1 2003/02/18 19:16:01 ostlerf Exp $
-------------------------------------------------------------------------------
--interrupt_control.vhd   version v1.00b
-------------------------------------------------------------------------------
--
--                  ****************************
--                  ** Copyright Xilinx, Inc. **
--                  ** All rights reserved.   **
--                  ****************************
--
-------------------------------------------------------------------------------
-- Filename:        interrupt_control.vhd
--
-- Description:     This VHDL design file is the parameterized interrupt control
--                  module for the ipif which permits parameterizing 1 or 2 levels
--                  of interrupt registers.
--
--
--
-------------------------------------------------------------------------------
-- Structure:   
--
--              interrupt_control.vhd
--                  
--
-------------------------------------------------------------------------------
-- Author:      Doug Thorpe
--
-- History:
--  Doug Thorpe  Aug 16, 2001      -- V1.00a (initial release)
--  Mike Lovejoy  Oct 9, 2001      -- V1.01a
--               Added parameter C_INCLUDE_DEV_ISC to remove Device ISC.
--               When one source of interrupts Device ISC is redundant and
--               can be eliminated to reduce LUT count. When 7 interrupts
--               are included, the LUT count is reduced from 49 to 17.
--               Also removed the "wrapper" which required redefining
--               ports and generics herein.
--                                           
-- det      Feb-19-02   
--              - Added additional selections of input processing on the IP
--                interrupt inputs. This was done by replacing the 
--                C_IP_IRPT_NUM Generic with an unconstrained input array  
--                of integers selecting the type of input processing for each
--                bit.
--
-- det      Mar-22-02
--              - Corrected a reset problem with pos edge detect interrupt
--                input processing (a high on the input when recovering from
--                reset caused an eroneous interrupt to be latched in the IP_
--                ISR reg.
--
-- blt      Nov-18-02               -- V1.01b
--              - Updated library and use statements to use ipif_common_v1_00_b
--
-------------------------------------------------------------------------------
-- Naming Conventions:
--      active low signals:                     "*_n"
--      clock signals:                          "clk", "clk_div#", "clk_#x" 
--      reset signals:                          "rst", "rst_n" 
--      generics:                               "C_*" 
--      user defined types:                     "*_TYPE" 
--      state machine next state:               "*_ns" 
--      state machine current state:            "*_cs" 
--      combinatorial signals:                  "*_com" 
--      pipelined or register delay signals:    "*_d#" 
--      counter signals:                        "*cnt*"
--      clock enable signals:                   "*_ce" 
--      internal version of output port         "*_i"
--      device pins:                            "*_pin" 
--      ports:                                  - Names begin with Uppercase 
--      processes:                              "*_PROCESS" 
--      component instantiations:               "<ENTITY_>I_<#|FUNC>
--
--
-------------------------------------------------------------------------------
-- Special information
--
--  The input Generic C_IP_INTR_MODE_ARRAY is an unconstrained array
--  of integers. The number of entries specifies how many IP interrupts
--  are to be processed. Each entry in the array specifies the type of input 
--  processing for each IP interrupt input. The following table
--  lists the defined values for entries in the array:
--
--          1   =   Level Pass through  (non-inverted input)
--          2   =   Level Pass through  (invert input)
--          3   =   Registered Level    (non-inverted input)
--          4   =   Registered Level    (inverted input)
--          5   =   Rising Edge Detect  (non-inverted input)
--          6   =   Falling Edge Detect (non-inverted input)
--
-------------------------------------------------------------------------------
-- Library definitions

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all; -- need 'conv_std_logic_vector' conversion function

library proc_common_v1_00_b;
Use proc_common_v1_00_b.proc_common_pkg.all;

library ipif_common_v1_00_c;
use ipif_common_v1_00_c.ipif_pkg.all;
use ipif_common_v1_00_c.all;


----------------------------------------------------------------------

entity interrupt_control is
   Generic(
      C_INTERRUPT_REG_NUM    : INTEGER := 16;
              -- Number of IPIF Interrupt sources (not including IP or the 
              -- two latched IPIF ISR inputs)
                       
      C_NUM_IPIF_IRPT_SRC    : INTEGER := 4;
      
      C_IP_INTR_MODE_ARRAY   : INTEGER_ARRAY_TYPE :=
                          (
                           1,  -- pass through (non-inverting)
                           2,  -- pass through (inverting)
                           3,  -- registered level (non-inverting)
                           4,  -- registered level (inverting)
                           5,  -- positive edge detect
                           6   -- negative edge detect
                          );
      
      C_INCLUDE_DEV_PENCODER : BOOLEAN := true;-- Specifies device Priority Encoder function
      
      C_INCLUDE_DEV_ISC      : Boolean := true; -- Specifies device ISC hierarchy
                             --Exclusion of Device ISC requires exclusion of Priority encoder
      C_IRPT_DBUS_WIDTH      : INTEGER := 32
      ); 
   port(
  
      -- Inputs From the IPIF Bus 
      Bus2IP_Clk_i        : In  std_logic;  -- Master timing clock from the IPIF
      Bus2IP_Data_sa      : In  std_logic_vector(0 to C_IRPT_DBUS_WIDTH-1);
      Bus2IP_RdReq_sa     : In  std_logic;
      Bus2IP_Reset_i      : In  std_logic;  -- Master Reset from the IPIF reset block
      Bus2IP_WrReq_sa     : In  std_logic;
      Interrupt_RdCE      : In  std_logic_vector(0 to C_INTERRUPT_REG_NUM-1);
      Interrupt_WrCE      : In  std_logic_vector(0 to C_INTERRUPT_REG_NUM-1);
      IPIF_Reg_Interrupts : In  std_logic_vector(0 to 1);
      -- Interrupt inputs from the IPIF sources that will get registered in this design
      IPIF_Lvl_Interrupts : In  std_logic_vector(0 to C_NUM_IPIF_IRPT_SRC-1);
                          -- Level Interrupt inputs from the IPIF sources
    
      -- Inputs from the IP Interface  
      IP2Bus_IntrEvent    : In  std_logic_vector(0 to C_IP_INTR_MODE_ARRAY'length-1);
                          -- Interrupt inputs from the IP 
     -- Final Device Interrupt Output
     Intr2Bus_DevIntr     : Out std_logic;
                          -- Device interrupt output to the Master Interrupt Controller
    
     -- Status Reply Outputs to the Bus 
     Intr2Bus_DBus        : Out std_logic_vector(0 to C_IRPT_DBUS_WIDTH-1);
     Intr2Bus_WrAck       : Out std_logic;
     Intr2Bus_RdAck       : Out std_logic;
     Intr2Bus_Error       : Out std_logic;
     Intr2Bus_Retry       : Out std_logic;
     Intr2Bus_ToutSup     : Out std_logic
     );
  end interrupt_control ;

-------------------------------------------------------------------------------

architecture implementation of interrupt_control is





   --TYPES
       
   -- no Types  
     
   -- CONSTANTS
    
       -- general use constants 
        Constant LOGIC_LOW      : std_logic := '0';
        Constant LOGIC_HIGH     : std_logic := '1';
        
        
       -- Chip Enable Selection mapping (applies to RdCE and WrCE inputs)
        Constant DEVICE_ISR            : integer range 0 to 15 := 0;
        Constant DEVICE_IPR            : integer range 0 to 15 := 1;
        Constant DEVICE_IER            : integer range 0 to 15 := 2;
        Constant DEVICE_IAR            : integer range 0 to 15 := 3;
        Constant DEVICE_SIE            : integer range 0 to 15 := 4;
        Constant DEVICE_CIE            : integer range 0 to 15 := 5;
        Constant DEVICE_IIR            : integer range 0 to 15 := 6;
        Constant DEVICE_GIE            : integer range 0 to 15 := 7;
        Constant IP_ISR                : integer range 0 to 15 := 8;
        Constant IP_IPR                : integer range 0 to 15 := 9;
        Constant IP_IER                : integer range 0 to 15 := 10;
        Constant IP_IAR                : integer range 0 to 15 := 11;
        Constant IP_SIE                : integer range 0 to 15 := 12;
        Constant IP_CIE                : integer range 0 to 15 := 13;
        Constant IP_IIR                : integer range 0 to 15 := 14;
        Constant IP_GIE                : integer range 0 to 15 := 15;
        
       -- Generic to constant mapping
        Constant IRPT_DBUS_WIDTH            : Integer := C_IRPT_DBUS_WIDTH - 1;
        Constant IP_IRPT_HIGH_INDEX         : Integer := C_IP_INTR_MODE_ARRAY'length - 1;
        Constant IPIF_IRPT_HIGH_INDEX       : Integer := C_NUM_IPIF_IRPT_SRC + 2;
                              -- (2 level + 1 IP + Number of latched inputs) - 1
        Constant IPIF_LVL_IRPT_HIGH_INDEX   : Integer := C_NUM_IPIF_IRPT_SRC - 1; 
        
       -- Priority encoder support constants
        Constant PRIORITY_ENC_WIDTH    : Integer := 8; -- bits
        Constant NO_INTR_VALUE         : Integer := 128;
                                        -- no interrupt pending code = "10000000"
   
   --INTERNAL SIGNALS
        Signal  trans_reg_irpts            : std_logic_vector(1 downto 0);
        Signal  trans_lvl_irpts            : std_logic_vector(IPIF_LVL_IRPT_HIGH_INDEX downto 0);
        Signal  trans_ip_irpts             : std_logic_vector(IP_IRPT_HIGH_INDEX downto 0);
        Signal  edgedtct_ip_irpts          : std_logic_vector(0 to IP_IRPT_HIGH_INDEX);
        
        signal  irpt_read_data             : std_logic_vector(IRPT_DBUS_WIDTH downto 0);
        Signal  irpt_rdack                 : std_logic;
        Signal  irpt_wrack                 : std_logic;
        signal  ip_irpt_status_reg         : std_logic_vector(IP_IRPT_HIGH_INDEX downto 0);
        signal  ip_irpt_enable_reg         : std_logic_vector(IP_IRPT_HIGH_INDEX downto 0);
        signal  ip_irpt_pending_value      : std_logic_vector(IP_IRPT_HIGH_INDEX downto 0);
        Signal  ip_interrupt_or            : std_logic;
        signal  ipif_irpt_status_reg       : std_logic_vector(1 downto 0);
        signal  ipif_irpt_status_value     : std_logic_vector(IPIF_IRPT_HIGH_INDEX downto 0);
        signal  ipif_irpt_enable_reg       : std_logic_vector(IPIF_IRPT_HIGH_INDEX downto 0);
        signal  ipif_irpt_pending_value    : std_logic_vector(IPIF_IRPT_HIGH_INDEX downto 0);
        Signal  ipif_glbl_irpt_enable_reg  : std_logic;
        Signal  ipif_interrupt             : std_logic;
        Signal  ipif_interrupt_or          : std_logic;
        Signal  ipif_pri_encode_present    : std_logic;
        Signal  ipif_priority_encode_value : std_logic_vector(PRIORITY_ENC_WIDTH-1 downto 0);
   
    

--------------------------------------------------------------------------------------------------------------
-------------------------------------- start architecture logic -------------------------------------------------
  
begin
      
 -- Misc I/O and Signal assignments 
 
    Intr2Bus_DevIntr <= ipif_interrupt;
 
 
    Intr2Bus_RdAck   <= irpt_rdack;
    Intr2Bus_WrAck   <= irpt_wrack;
    Intr2Bus_Error   <= LOGIC_LOW;
    Intr2Bus_Retry   <= LOGIC_LOW;
    Intr2Bus_ToutSup <= LOGIC_LOW;
  
   
       
----------------------------------------------------------------------------------------------------------------
---  IP Interrupt processing start  
  

  ------------------------------------------------------------------------------------------
  -- Convert Little endian register to big endian data bus
  ------------------------------------------------------------------------------------------
  LITTLE_TO_BIG : process (irpt_read_data)
   Begin
     
      for k in 0 to IRPT_DBUS_WIDTH loop
        Intr2Bus_DBus(IRPT_DBUS_WIDTH-k) <= irpt_read_data(k); -- Convert to Big-Endian Data Bus
      End loop; 
       
   End process; -- LITTLE_TO_BIG



 ------------------------------------------------------------------------------------------
 -- Convert big endian interrupt inputs to Little endian registers
 ------------------------------------------------------------------------------------------
 BIG_TO_LITTLE : process (IPIF_Reg_Interrupts, IPIF_Lvl_Interrupts, edgedtct_ip_irpts)
   Begin                  
    
      for i in 0 to 1 loop
        trans_reg_irpts(i) <= IPIF_Reg_Interrupts(i); -- Convert to Little-Endian format
      End loop; 
       
      for j in 0 to IPIF_LVL_IRPT_HIGH_INDEX loop
        trans_lvl_irpts(j) <= IPIF_Lvl_Interrupts(j); -- Convert to Little-Endian format
      End loop; 
       
      for k in 0 to IP_IRPT_HIGH_INDEX loop
        trans_ip_irpts(k) <= edgedtct_ip_irpts(k);     -- Convert to Little-Endian format
      End loop;                                                                           
  
   End process; -- BIG_TO_LITTLE

  
        
        
  ------------------------------------------------------------------------------------------
  -- Implement the IP Interrupt Input Processing 
  ------------------------------------------------------------------------------------------
  DO_IRPT_INPUT: for irpt_index in 0 to IP_IRPT_HIGH_INDEX generate
    
     
     
     GEN_NON_INVERT_PASS_THROUGH : if (C_IP_INTR_MODE_ARRAY(irpt_index) = 1 or
                                       C_IP_INTR_MODE_ARRAY(irpt_index) = 3) generate
  
        edgedtct_ip_irpts(irpt_index) <= IP2Bus_IntrEvent(irpt_index);
  
     end generate GEN_NON_INVERT_PASS_THROUGH;  
  
      
     
     GEN_INVERT_PASS_THROUGH : if (C_IP_INTR_MODE_ARRAY(irpt_index) = 2 or
                                   C_IP_INTR_MODE_ARRAY(irpt_index) = 4) generate
     
        edgedtct_ip_irpts(irpt_index) <= not(IP2Bus_IntrEvent(irpt_index));
     
     end generate GEN_INVERT_PASS_THROUGH;  
      
     
     
     
     GEN_POS_EDGE_DETECT : if (C_IP_INTR_MODE_ARRAY(irpt_index) = 5) generate
          
          Signal irpt_dly1 : std_logic;
          Signal irpt_dly2 : std_logic;
          
        
     begin   
        
        REG_THE_IRPTS : process (Bus2IP_Clk_i)
          begin   
             
             If (Bus2IP_Clk_i'EVENT and Bus2IP_Clk_i = '1') Then
     
                If (Bus2IP_Reset_i = '1') Then 

                   irpt_dly1     <= '1'; -- setting to '1' protects reset transition
                   irpt_dly2     <= '1'; -- where interrupt inputs are preset high
                   
                Else

                   irpt_dly1     <= IP2Bus_IntrEvent(irpt_index);
                   irpt_dly2     <= irpt_dly1;
                    
                End if;
               
             else
                 null;
             End if;
     
          End process; -- REG_THE_IRPTS
        
        -- now detect rising edge 
        edgedtct_ip_irpts(irpt_index) <= irpt_dly1 and not(irpt_dly2);
                  
     end generate GEN_POS_EDGE_DETECT;  
       
                                    
                                    
                                    
                                    
     GEN_NEG_EDGE_DETECT : if (C_IP_INTR_MODE_ARRAY(irpt_index) = 6) generate
          
          Signal irpt_dly1 : std_logic;
          Signal irpt_dly2 : std_logic;
        
     begin   
        
        REG_THE_IRPTS : process (Bus2IP_Clk_i)
          begin   
             
             If (Bus2IP_Clk_i'EVENT and Bus2IP_Clk_i = '1') Then
     
                If (Bus2IP_Reset_i = '1') Then  
              
                   irpt_dly1     <= '0';
                   irpt_dly2     <= '0';
                   
                Else 
     
                   irpt_dly1     <= IP2Bus_IntrEvent(irpt_index);
                   irpt_dly2     <= irpt_dly1;
                    
                End if;
               
             else
                 null;
             End if;
     
          End process; -- REG_THE_IRPTS
        
        edgedtct_ip_irpts(irpt_index) <= not(irpt_dly1) and irpt_dly2;
     
     end generate GEN_NEG_EDGE_DETECT;  
  
       
     
     GEN_INVALID_TYPE : if (C_IP_INTR_MODE_ARRAY(irpt_index) > 6 ) generate
     
        edgedtct_ip_irpts(irpt_index) <= '0'; -- Don't use input
        
     end generate GEN_INVALID_TYPE;  
  
     
  End generate DO_IRPT_INPUT; 
 
 
  
  
 -- Generate the IP Interrupt Status register                  
 GEN_IP_IRPT_STATUS_REG : for irpt_index in 0 to IP_IRPT_HIGH_INDEX generate
   
 
      GEN_REG_STATUS : if (C_IP_INTR_MODE_ARRAY(irpt_index) > 2) generate
      
         DO_STATUS_BIT : process (Bus2IP_Clk_i)
          Begin
      
            if (Bus2IP_Clk_i'event and Bus2IP_Clk_i = '1') Then
            
               If (Bus2IP_Reset_i = '1') Then
          
                  ip_irpt_status_reg(irpt_index) <= '0'; 
          
               elsif (Interrupt_WrCE(IP_ISR) = '1') Then -- toggle selected ISR bits from the DBus inputs
          
                  ip_irpt_status_reg(irpt_index) <= 
                   (Bus2IP_Data_sa(IRPT_DBUS_WIDTH-irpt_index) xor  -- toggle bits on write of '1'
                    ip_irpt_status_reg(irpt_index)) or       -- but don't miss interrupts coming
                    trans_ip_irpts(irpt_index);              -- in on non-cleared interrupt bits
                                                                                                                    
               else
                  ip_irpt_status_reg(irpt_index) <= 
                           ip_irpt_status_reg(irpt_index) or 
                           trans_ip_irpts(irpt_index); -- latch and hold input interrupt bits
                    
               End if;
               
            Else
               null;
            End if;
        
         End process; -- DO_STATUS_BIT
      
      End generate GEN_REG_STATUS;
 
 
 
 
      GEN_PASS_THROUGH_STATUS : if (C_IP_INTR_MODE_ARRAY(irpt_index) = 1 or
                                    C_IP_INTR_MODE_ARRAY(irpt_index) = 2) generate
 
         ip_irpt_status_reg(irpt_index) <= trans_ip_irpts(irpt_index);
 
      End generate GEN_PASS_THROUGH_STATUS;
 
 
 End generate GEN_IP_IRPT_STATUS_REG;
                   
                   
                   
    
  ------------------------------------------------------------------------------------------
  -- Implement the IP Interrupt Enable Register Write and Clear Functions
  ------------------------------------------------------------------------------------------
  DO_IP_IRPT_ENABLE_REG : process (Bus2IP_Clk_i)
    Begin
    

       if (Bus2IP_Clk_i'event and Bus2IP_Clk_i = '1') Then

         If (Bus2IP_Reset_i = '1') Then

            ip_irpt_enable_reg <= (others => '0'); 
           
         elsif (Interrupt_WrCE(IP_IER) = '1') Then -- load input data from the DBus inputs

            ip_irpt_enable_reg <= Bus2IP_Data_sa(IRPT_DBUS_WIDTH-IP_IRPT_HIGH_INDEX 
                                                 to IRPT_DBUS_WIDTH);
            
         else
            null; -- no change
         End if;
          
       Else
          null;
       End if;
      
    End process; -- DO_IP_IRPT_ENABLE_REG
    
  

  ------------------------------------------------------------------------------------------
  -- Implement the IP Interrupt Enable/Masking function
  ------------------------------------------------------------------------------------------
  DO_IP_INTR_ENABLE : process (ip_irpt_status_reg, ip_irpt_enable_reg)
    Begin

      for i in 0 to IP_IRPT_HIGH_INDEX loop
        ip_irpt_pending_value(i) <= ip_irpt_status_reg(i) and 
                                    ip_irpt_enable_reg(i); -- enable/mask interrupt bits
      End loop;
            
    End process; -- DO_IP_INTR_ENABLE
    
    
  ------------------------------------------------------------------------------------------
  -- Implement the IP Interrupt 'OR' Functions
  ------------------------------------------------------------------------------------------
  DO_IP_INTR_OR : process (ip_irpt_pending_value)
  
    Variable ip_loop_or : std_logic;
  
    Begin

      ip_loop_or := '0';
        
      for i in 0 to IP_IRPT_HIGH_INDEX loop
          ip_loop_or := ip_loop_or or ip_irpt_pending_value(i);
      End loop;
     
      ip_interrupt_or <= ip_loop_or;
     
            
    End process; -- DO_IP_INTR_OR
  

--------------------------------------------------------------------------------------------
---  IP Interrupt processing end  
--------------------------------------------------------------------------------------------
 
 
--==========================================================================================



Include_Device_ISC_generate: if(C_INCLUDE_DEV_ISC) generate
begin
--------------------------------------------------------------------------------------------
---  IPIF Interrupt processing Start  
--------------------------------------------------------------------------------------------
 
 
  ------------------------------------------------------------------------------------------
  -- Implement the IPIF Interrupt Status Register Write and Clear Functions
  -- This is only 2 bits wide (the only inputs latched at this level...the others just flow
  -- through)
  ------------------------------------------------------------------------------------------
  DO_IPIF_IRPT_STATUS_REG : process (Bus2IP_Clk_i)
    Begin
    

       if (Bus2IP_Clk_i'event and Bus2IP_Clk_i = '1') Then

         If (Bus2IP_Reset_i = '1') Then

            ipif_irpt_status_reg <= (others => '0'); 
           
         elsif (Interrupt_WrCE(DEVICE_ISR) = '1') Then -- load input data from the DBus inputs

            for i in 0 to 1 loop                                                            
              ipif_irpt_status_reg(i) <= (Bus2IP_Data_sa(IRPT_DBUS_WIDTH-i) xor  -- toggle bits on write of '1'     
                                          ipif_irpt_status_reg(i)) or     -- but don't miss interrupts coming
                                          trans_reg_irpts(i);             -- in on non-cleared interrupt bits
            End loop;                                                                       
                                                                                          
         else

            for i in 0 to 1 loop
              ipif_irpt_status_reg(i) <= ipif_irpt_status_reg(i) or trans_reg_irpts(i);
                                                              -- latch and hold asserted interrupts        
            End loop;                                                                         
                                                                                              
         End if;
          
       Else
          null;
       End if;
      
    End process; -- DO_IPIF_IRPT_STATUS_REG
    

  
  DO_IPIF_IRPT_STATUS_VALUE : process (ipif_irpt_status_reg, trans_lvl_irpts, ip_interrupt_or)
    Begin

       ipif_irpt_status_value(1 downto 0) <=  ipif_irpt_status_reg;
       ipif_irpt_status_value(2)          <=  ip_interrupt_or;
       
       for i in 3 to IPIF_IRPT_HIGH_INDEX loop
         ipif_irpt_status_value(i) <= trans_lvl_irpts(i-3); 
       End loop;                                                
                                                                
    
    End process; -- DO_IPIF_IRPT_STATUS_VALUE
  
  

    
    
  ------------------------------------------------------------------------------------------
  -- Implement the IPIF Interrupt Enable Register Write and Clear Functions
  ------------------------------------------------------------------------------------------
  DO_IPIF_IRPT_ENABLE_REG : process (Bus2IP_Clk_i)
    Begin
    
       if (Bus2IP_Clk_i'event and Bus2IP_Clk_i = '1') Then

          If (Bus2IP_Reset_i = '1') Then

             ipif_irpt_enable_reg <= (others => '0'); 

          elsif (Interrupt_WrCE(DEVICE_IER) = '1') Then -- load input data from the DBus inputs
          
             ipif_irpt_enable_reg <= Bus2IP_Data_sa(IRPT_DBUS_WIDTH-IPIF_IRPT_HIGH_INDEX to IRPT_DBUS_WIDTH);
            
         else
            null; -- no change
         End if;
          
       Else
          null;
       End if;
      
    End process; -- DO_IPIF_IRPT_ENABLE_REG
    
    

  ------------------------------------------------------------------------------------------
  -- Implement the IPIF Interrupt Enable/Masking function
  ------------------------------------------------------------------------------------------
  DO_IPIF_INTR_ENABLE : process (ipif_irpt_status_value, ipif_irpt_enable_reg)
    Begin

      for i in 0 to IPIF_IRPT_HIGH_INDEX loop
        ipif_irpt_pending_value(i) <= ipif_irpt_status_value(i) and ipif_irpt_enable_reg(i); -- enable/mask interrupt bits
      End loop;
            
    End process; -- DO_IPIF_INTR_ENABLE
    
    
    
end generate Include_Device_ISC_generate;
 
Initialize_when_not_include_Device_ISC_generate: if(not(C_INCLUDE_DEV_ISC)) generate
begin
   ipif_irpt_status_reg <= (others => '0'); 
   ipif_irpt_status_value <= (others => '0'); 
   ipif_irpt_enable_reg <= (others => '0'); 
   ipif_irpt_pending_value <= (others => '0');
end generate Initialize_when_not_include_Device_ISC_generate;
  

 ------------------------------------------------------------------------------------------
 -- Implement the IPIF Interrupt Master Enable Register Write and Clear Functions
 ------------------------------------------------------------------------------------------
 DO_IPIF_IRPT_MASTER_ENABLE : process (Bus2IP_Clk_i)
   Begin
   
      if (Bus2IP_Clk_i'event and Bus2IP_Clk_i = '1') Then

        If (Bus2IP_Reset_i = '1') Then
   
           ipif_glbl_irpt_enable_reg <= '0'; 
   
        elsif (Interrupt_WrCE(DEVICE_GIE) = '1') Then -- load input data from the DBus inputs
 
           ipif_glbl_irpt_enable_reg <= Bus2IP_Data_sa(0);
                                                 -- Enable bit is loaded from the DBus MSB
                                                 --Placed at bit-0 MSB by Glenn Baxter
           
        else
           null; -- no change
        End if;
         
      Else
         null;
      End if;
     
   End process; -- DO_IPIF_IRPT_MASTER_ENABLE
   
   

 
   
  INCLUDE_DEV_PRIORITY_ENCODER : if (C_INCLUDE_DEV_PENCODER = True) generate
    ------------------------------------------------------------------------------------------
    -- Implement the IPIF Interrupt Priority Encoder Function on the Interrupt Pending Value
    -- Loop from Interrupt LSB to MSB, retaining the position of the last interrupt detected. 
    -- This method implies a positional priority of MSB to LSB.
    ------------------------------------------------------------------------------------------
    
    
     ipif_pri_encode_present <= '1';
    
    
    
  DO_PRIORITY_ENCODER : process (ipif_irpt_pending_value)
  
    Variable irpt_position : Integer;
    Variable irpt_detected : Boolean;
    Variable loop_count    : integer;
    
    Begin
      
        loop_count    := IPIF_IRPT_HIGH_INDEX + 1;
        irpt_position := 0;
        irpt_detected := FALSE;
      
       -- Search through the pending interrupt values starting with the MSB 
        while (loop_count > 0) loop
           
           If (ipif_irpt_pending_value(loop_count-1) = '1') Then
              irpt_detected := TRUE;
              irpt_position := loop_count-1;
           else
              null; -- do nothing
           End if;
          
           loop_count := loop_count - 1;
  
        End loop;
        
       -- now assign the encoder output value to the bit position of the last interrupt encountered 
        If (irpt_detected) Then
           ipif_priority_encode_value <= conv_std_logic_vector(irpt_position, PRIORITY_ENC_WIDTH);
           ipif_interrupt_or          <= '1';  -- piggy-back off of this function for the "OR" function
        else
           ipif_priority_encode_value <= conv_std_logic_vector(NO_INTR_VALUE, PRIORITY_ENC_WIDTH); 
           ipif_interrupt_or          <= '0';
        End if;
      
         
      
    End process; -- DO_PRIORITY_ENCODER
   

end generate INCLUDE_DEV_PRIORITY_ENCODER; 



 
 
   
DELETE_DEV_PRIORITY_ENCODER : if (C_INCLUDE_DEV_PENCODER = False) generate
      
    
    
    ipif_pri_encode_present <= '0';
    
    
        
    ipif_priority_encode_value <= (others => '0'); 
        
        
    ------------------------------------------------------------------------------------------
    -- Implement the IPIF Interrupt 'OR' Functions (used if priority encoder removed)
    ------------------------------------------------------------------------------------------
    DO_IPIF_INTR_OR : process (ipif_irpt_pending_value)
    
      Variable ipif_loop_or : std_logic;
      
      Begin
    
        ipif_loop_or := '0';  
    
        for i in 0 to IPIF_IRPT_HIGH_INDEX loop
            ipif_loop_or := ipif_loop_or or ipif_irpt_pending_value(i);
        End loop;
              
        ipif_interrupt_or <= ipif_loop_or;         
                  
      End process; -- DO_IPIF_INTR_OR
        

end generate DELETE_DEV_PRIORITY_ENCODER;  
                                        
                                        
                                        
   
 -------------------------------------------------------------------------------------------
 -- Perform the final Master enable function on the 'ORed' interrupts
OR_operation_with_Dev_ISC_generate: if(C_INCLUDE_DEV_ISC) generate
   begin
      ipif_interrupt_PROCESS: process(ipif_interrupt_or, ipif_glbl_irpt_enable_reg)
         begin
            ipif_interrupt  <=  ipif_interrupt_or and ipif_glbl_irpt_enable_reg;
      end process ipif_interrupt_PROCESS;
end generate OR_operation_with_Dev_ISC_generate;

OR_operation_withOUT_Dev_ISC_generate: if(not(C_INCLUDE_DEV_ISC)) generate
   begin
      ipif_interrupt_PROCESS: process(ip_interrupt_or, ipif_glbl_irpt_enable_reg)
         begin
            ipif_interrupt  <=  ip_interrupt_or and ipif_glbl_irpt_enable_reg;
      end process ipif_interrupt_PROCESS;
end generate OR_operation_withOUT_Dev_ISC_generate;

   
   
 
 
-----------------------------------------------------------------------------------------------------------
---  IPIF Interrupt processing end  
----------------------------------------------------------------------------------------------------------------




Include_Dev_ISC_WrAck_OR_generate: if(C_INCLUDE_DEV_ISC) generate
begin
  GEN_WRITE_ACKNOWLEGDGE : process (Interrupt_WrCE)
    Begin
      
       irpt_wrack <= Interrupt_WrCE(DEVICE_ISR) or
                     Interrupt_WrCE(DEVICE_IER) or
                     Interrupt_WrCE(DEVICE_GIE) or
                     Interrupt_WrCE(IP_ISR)     or
                     Interrupt_WrCE(IP_IER);
      
      
    End process; -- GEN_WRITE_ACKNOWLEGDGE
end generate Include_Dev_ISC_WrAck_OR_generate;

Exclude_Dev_ISC_WrAck_OR_generate: if(not(C_INCLUDE_DEV_ISC)) generate
begin
  GEN_WRITE_ACKNOWLEGDGE : process (Interrupt_WrCE)
    Begin
      
       irpt_wrack <= Interrupt_WrCE(DEVICE_GIE) or
                     Interrupt_WrCE(IP_ISR)     or
                     Interrupt_WrCE(IP_IER);
      
      
    End process; -- GEN_WRITE_ACKNOWLEGDGE
end generate Exclude_Dev_ISC_WrAck_OR_generate;
    
  
 
   -----------------------------------------------------------------------------------------------------------
   ---  IPIF Bus Data Read Mux and Read Acknowledge generation 
   ----------------------------------------------------------------------------------------------------------------
Include_Dev_ISC_RdAck_OR_generate: if(C_INCLUDE_DEV_ISC) generate
begin
    GET_READ_DATA : process (Interrupt_RdCE, ip_irpt_status_reg, ip_irpt_enable_reg,
                             ipif_irpt_pending_value,
                 ipif_irpt_enable_reg,
               ipif_pri_encode_present,
                             ipif_priority_encode_value, 
                             ipif_irpt_status_value,
                             ipif_glbl_irpt_enable_reg)
      Begin

         irpt_read_data <= (others => '0'); -- default to driving zeroes   
          
          
       
         If (Interrupt_RdCE(IP_ISR) = '1') Then
   
            for i in 0 to IP_IRPT_HIGH_INDEX loop
              irpt_read_data(i) <= ip_irpt_status_reg(i); -- output IP interrupt status register values
            End loop;
           
            irpt_rdack <= '1';   -- set the acknowledge handshake
            
         Elsif (Interrupt_RdCE(IP_IER) = '1') Then
   
            for i in 0 to IP_IRPT_HIGH_INDEX loop
              irpt_read_data(i) <= ip_irpt_enable_reg(i); -- output IP interrupt enable register values
            End loop;
           
            irpt_rdack <= '1';   -- set the acknowledge handshake
         
            
         Elsif (Interrupt_RdCE(DEVICE_ISR) = '1') Then
   
            for i in 0 to IPIF_IRPT_HIGH_INDEX loop
              irpt_read_data(i) <= ipif_irpt_status_value(i); -- output IPIF status interrupt values
            End loop;
           
            irpt_rdack <= '1';   -- set the acknowledge handshake
            
         Elsif (Interrupt_RdCE(DEVICE_IPR) = '1') Then
        
            for i in 0 to IPIF_IRPT_HIGH_INDEX loop
              irpt_read_data(i) <= ipif_irpt_pending_value(i); -- output IPIF pending interrupt values
            End loop;
           
            irpt_rdack <= '1';   -- set the acknowledge handshake
            
         Elsif (Interrupt_RdCE(DEVICE_IER) = '1') Then
   
            for i in 0 to IPIF_IRPT_HIGH_INDEX loop
              irpt_read_data(i) <= ipif_irpt_enable_reg(i); -- output IPIF pending interrupt values
            End loop;
           
            irpt_rdack <= '1';   -- set the acknowledge handshake
            
         Elsif (Interrupt_RdCE(DEVICE_IIR) = '1') Then
         
            irpt_read_data(PRIORITY_ENC_WIDTH-1 downto 0) <= ipif_priority_encode_value; -- output IPIF pending interrupt values
            
            
            irpt_rdack <= ipif_pri_encode_present;   -- set the acknowledge handshake depending on 
                                                     -- priority encoder presence
            
         Elsif (Interrupt_RdCE(DEVICE_GIE) = '1') Then
             
            irpt_read_data(IRPT_DBUS_WIDTH) <= ipif_glbl_irpt_enable_reg; -- output Global Enable Register value  
                                                                                                         
                
            irpt_rdack <= '1';   -- set the acknowledge handshake                                    
          
         else
   
            irpt_rdack      <= '0';             -- don't set the acknowledge handshake
            
         End if;
      
      
      End process; -- GET_READ_DATA
end generate Include_Dev_ISC_RdAck_OR_generate;


Exclude_Dev_ISC_RdAck_OR_generate: if(not(C_INCLUDE_DEV_ISC)) generate
begin
    GET_READ_DATA : process (Interrupt_RdCE, ip_irpt_status_reg, ip_irpt_enable_reg,
                             ipif_glbl_irpt_enable_reg)
      Begin

         irpt_read_data <= (others => '0'); -- default to driving zeroes   
          
          
       
         If (Interrupt_RdCE(IP_ISR) = '1') Then
   
            for i in 0 to IP_IRPT_HIGH_INDEX loop
              irpt_read_data(i) <= ip_irpt_status_reg(i); -- output IP interrupt status register values
            End loop;
           
            irpt_rdack <= '1';   -- set the acknowledge handshake
            
         Elsif (Interrupt_RdCE(IP_IER) = '1') Then
   
            for i in 0 to IP_IRPT_HIGH_INDEX loop
              irpt_read_data(i) <= ip_irpt_enable_reg(i); -- output IP interrupt enable register values
            End loop;
           
            irpt_rdack <= '1';   -- set the acknowledge handshake
         
         Elsif (Interrupt_RdCE(DEVICE_GIE) = '1') Then
             
            irpt_read_data(IRPT_DBUS_WIDTH) <= ipif_glbl_irpt_enable_reg; -- output Global Enable Register value  
                                                                                                         
                
            irpt_rdack <= '1';   -- set the acknowledge handshake                                    
          
         else
   
            irpt_rdack      <= '0';             -- don't set the acknowledge handshake
            
         End if;
      
      
      End process; -- GET_READ_DATA

end generate Exclude_Dev_ISC_RdAck_OR_generate;



end implementation;


 






