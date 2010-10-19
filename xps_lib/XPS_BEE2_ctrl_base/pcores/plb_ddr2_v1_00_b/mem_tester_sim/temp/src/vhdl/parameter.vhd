library ieee;
use ieee.std_logic_1164.all;
--library synplify;
--use synplify.attributes.all;
-- pragma translate_off
library UNISIM; 
 use UNISIM.VCOMPONENTS.ALL;
 -- pragma translate_on
package parameter is
  constant row_address_p   : INTEGER   := 14;
  constant column_address_p: INTEGER   := 10;
  constant bank_address_p  : INTEGER   :=  2;
end parameter;
