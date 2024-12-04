library ieee;
use ieee.std_logic_1164.all;

package MUX_Package is
    component MUX_16bit_8x1 is
        port(a, b, c, d, e, f, g, h: in std_logic_vector(15 downto 0);
             I1, I2, I3: in std_logic;
             y: out std_logic_vector(15 downto 0));
    end component;

    component MUX_3bit_8x1 is
        port(a, b, c, d, e, f, g, h: in std_logic_vector(2 downto 0);
             I1, I2, I3: in std_logic;
             y: out std_logic_vector(2 downto 0));
    end component;

    component MUX_16bit_4x1 is
        port(a, b, c, d: in std_logic_vector(15 downto 0);
             I1, I2: in std_logic;
             y: out std_logic_vector(15 downto 0));
    end component;

    component MUX_3bit_4x1 is
        port(a, b, c, d: in std_logic_vector(2 downto 0);
             I1, I2: in std_logic;
             y: out std_logic_vector(2 downto 0));
    end component;

    component MUX_16bit_2x1 is
        port(a, b: in std_logic_vector(15 downto 0);
             I: in std_logic;
             y: out std_logic_vector(15 downto 0));
    end component;

    component MUX_3bit_2x1 is
        port(a, b: in std_logic_vector(2 downto 0);
             I: in std_logic;
             y: out std_logic_vector(2 downto 0));
    end component;

    component MUX_3bit_5x1 is
        port(a, b, c, d, e: in std_logic_vector(2 downto 0);
             I1, I2, I3: in std_logic;
             y: out std_logic_vector(2 downto 0));
    end component;
end package;

library ieee;
use ieee.std_logic_1164.all;

entity MUX_16bit_8x1 is
    port(a, b, c, d, e, f, g, h: in std_logic_vector(15 downto 0);
         I1, I2, I3: in std_logic;
         y: out std_logic_vector(15 downto 0));
end entity;

architecture Behavioral of MUX_16bit_8x1 is
begin
    process(a, b, c, d, e, f, g, h, I1, I2, I3)
    variable sel : std_logic_vector(2 downto 0);
    begin
        sel := I1 & I2 & I3;
        case sel is
            when "000" => y <= a;
            when "001" => y <= b;
            when "010" => y <= c;
            when "011" => y <= d;
            when "100" => y <= e;
            when "101" => y <= f;
            when "110" => y <= g;
            when "111" => y <= h;
            when others => y <= (others => '0');
        end case;
    end process;
end architecture;

library ieee;
use ieee.std_logic_1164.all;

entity MUX_3bit_8x1 is
    port(a, b, c, d, e, f, g, h: in std_logic_vector(2 downto 0);
         I1, I2, I3: in std_logic;
         y: out std_logic_vector(2 downto 0));
end entity;

architecture Behavioral of MUX_3bit_8x1 is
begin
    process(a, b, c, d, e, f, g, h, I1, I2, I3)
    variable sel : std_logic_vector(2 downto 0);
    begin
        sel := I1 & I2 & I3;
        case sel is
            when "000" => y <= a;
            when "001" => y <= b;
            when "010" => y <= c;
            when "011" => y <= d;
            when "100" => y <= e;
            when "101" => y <= f;
            when "110" => y <= g;
            when "111" => y <= h;
            when others => y <= (others => '0');
        end case;
    end process;
end architecture;

library ieee;
use ieee.std_logic_1164.all;

entity MUX_16bit_4x1 is
    port(a, b, c, d: in std_logic_vector(15 downto 0);
         I1, I2: in std_logic;
         y: out std_logic_vector(15 downto 0));
end entity;

architecture Behavioral of MUX_16bit_4x1 is
begin
    process(a, b, c, d, I1, I2)
    variable sel : std_logic_vector(1 downto 0);
    begin
        sel := I1 & I2;
        case sel is
            when "00" => y <= a;
            when "01" => y <= b;
            when "10" => y <= c;
            when "11" => y <= d;
            when others => y <= (others => '0');
        end case;
    end process;
end architecture;

library ieee;
use ieee.std_logic_1164.all;

entity MUX_3bit_4x1 is
    port(a, b, c, d: in std_logic_vector(2 downto 0);
         I1, I2: in std_logic;
         y: out std_logic_vector(2 downto 0));
end entity;

architecture Behavioral of MUX_3bit_4x1 is
begin
    process(a, b, c, d, I1, I2)
    variable sel : std_logic_vector(1 downto 0);
    begin
        sel := I1 & I2;
        case sel is
            when "00" => y <= a;
            when "01" => y <= b;
            when "10" => y <= c;
            when "11" => y <= d;
            when others => y <= (others => '0');
        end case;
    end process;
end architecture;

library ieee;
use ieee.std_logic_1164.all;

entity MUX_16bit_2x1 is
    port(a, b: in std_logic_vector(15 downto 0);
         I: in std_logic;
         y: out std_logic_vector(15 downto 0));
end entity;

architecture Behavioral of MUX_16bit_2x1 is
begin
    process(a, b, I)
    begin
        if I = '0' then
            y <= a;
        else
            y <= b;
        end if;
    end process;
end architecture;

library ieee;
use ieee.std_logic_1164.all;

entity MUX_3bit_2x1 is
    port(a, b: in std_logic_vector(2 downto 0);
         I: in std_logic;
         y: out std_logic_vector(2 downto 0));
end entity;

architecture Behavioral of MUX_3bit_2x1 is
begin
    process(a, b, I)
    begin
        if I = '0' then
            y <= a;
        else
            y <= b;
        end if;
    end process;
end architecture;

library ieee;
use ieee.std_logic_1164.all;

entity MUX_3bit_5x1 is
    port(a, b, c, d, e: in std_logic_vector(2 downto 0);
         I1, I2, I3: in std_logic;
         y: out std_logic_vector(2 downto 0));
end entity;

architecture Behavioral of MUX_3bit_5x1 is
begin
    process(a, b, c, d, e, I1, I2, I3)
    variable sel : std_logic_vector(2 downto 0);
    begin
        sel := I1 & I2 & I3;
        case sel is
            when "000" => y <= a;
            when "001" => y <= b;
            when "010" => y <= c;
            when "011" => y <= d;
            when "100" => y <= e;
            when others => y <= (others => '0');
        end case;
    end process;
end architecture;
