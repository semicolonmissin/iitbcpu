library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;  -- Use numeric_std for arithmetic operations

entity ALU_RISC is
    Port (
        A, B       : in  std_logic_vector(15 downto 0);
        Operator   : in  std_logic_vector(2 downto 0);
        Result     : out std_logic_vector(15 downto 0);
        Cout       : out std_logic; -- Carry flag
        Z          : out std_logic  -- Zero flag
    );
end entity;

architecture Behavioral of ALU_RISC is
    signal sum_result, diff_result : std_logic_vector(16 downto 0); -- Extended for carry
    signal mult_result             : std_logic_vector(7 downto 0);  
    signal A_4bit, B_4bit          : std_logic_vector(3 downto 0);  -- 4-bit inputs for multiplication
begin
    process(A, B, Operator)
    begin
        -- Extract the 4 LSBs of A and B
        A_4bit <= A(3 downto 0);
        B_4bit <= B(3 downto 0);

        case Operator is
            when "000" => -- Addition
                sum_result <= std_logic_vector(unsigned(A) + unsigned(B));  -- Convert to unsigned and add
                Result <= sum_result(15 downto 0);
                Cout <= sum_result(16);

            when "100" => -- Subtraction
                diff_result <= std_logic_vector(unsigned(A) - unsigned(B));  -- Convert to unsigned and subtract
                Result <= diff_result(15 downto 0);
                Cout <= diff_result(16);

            when "001" => -- AND Operator
                Result <= A and B;
                Cout <= '0';

            when "010" => -- OR Operator
                Result <= A or B;
                Cout <= '0';

            when "011" => -- NOT Operator
                Result <= not A;
                Cout <= '0';

            when "101" => -- 4-bit Multiplication
                mult_result <= std_logic_vector(unsigned(A_4bit) * unsigned(B_4bit));  -- Convert to unsigned for multiplication
                Result <= (others => '0');         
                Result(7 downto 0) <= mult_result; 
                Cout <= '0';                      -- No carry for 4-bit multiplication

            when "110" => -- Logical Implication 
                Result <= not A or B;
                Cout <= '0';

            when others => 
                Result <= (others => '0');
                Cout <= '0';
        end case;

        -- Zero flag
        if diff_result = (others => '0') then
            Z <= '1';
        else
            Z <= '0';
        end if;
    end process;
end architecture;
