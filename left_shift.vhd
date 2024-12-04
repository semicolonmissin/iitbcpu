library ieee;
use ieee.std_logic_1164.all;

entity n1_bit_left is
    port (a: in std_logic_vector(15 downto 0);  
          o: out std_logic_vector(15 downto 0)); 
end entity;

architecture Behavioral of n1_bit_left is
begin
    o(15 downto 1) <= a(14 downto 0);  
    o(0) <= '0';  
end architecture;
