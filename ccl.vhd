library ieee;
use ieee.std_logic_1164.all;

entity CCL is
    port (
        A: in std_logic_vector(7 downto 0);
        Y: out std_logic_vector(15 downto 0)
    );
end entity;

architecture bhv of CCL is
begin
process(A)
    variable res: std_logic_vector(15 downto 0) := (others => '0');
begin	 
    concat: for i in 7 downto 0 loop
        res(i) := A(i);
    end loop concat;

    fill: for i in 15 downto 8 loop
        res(i) := '0';
    end loop fill;

    Y <= res;
end process;
end architecture;
