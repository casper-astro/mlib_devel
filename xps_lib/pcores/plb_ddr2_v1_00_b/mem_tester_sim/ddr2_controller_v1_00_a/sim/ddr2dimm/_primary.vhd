library verilog;
use verilog.vl_types.all;
entity ddr2dimm is
    generic(
        bawidth         : integer := 3;
        awidth          : integer := 14
    );
    port(
        ClockPos        : in     vl_logic_vector(2 downto 0);
        ClockNeg        : in     vl_logic_vector(2 downto 0);
        ODT             : in     vl_logic_vector(1 downto 0);
        CKE             : in     vl_logic_vector(1 downto 0);
        CS_N            : in     vl_logic_vector(1 downto 0);
        RAS_N           : in     vl_logic;
        CAS_N           : in     vl_logic;
        WE_N            : in     vl_logic;
        BA              : in     vl_logic_vector;
        A               : in     vl_logic_vector;
        DM              : in     vl_logic_vector(8 downto 0);
        DQ              : inout  vl_logic_vector(71 downto 0);
        DQS             : inout  vl_logic_vector(8 downto 0);
        DQS_N           : inout  vl_logic_vector(8 downto 0)
    );
end ddr2dimm;
