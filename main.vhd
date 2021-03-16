----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/07/2020 01:47:41 PM
-- Design Name: 
-- Module Name: main - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_signed.all;
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity main is
    Port ( clk : in STD_LOGIC;
           btn : in STD_LOGIC_VECTOR (4 downto 0);
           sw : in STD_LOGIC_VECTOR (15 downto 0);
           led : out STD_LOGIC_VECTOR (15 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0);
           cat : out STD_LOGIC_VECTOR (6 downto 0));
end main;

architecture Behavioral of main is

component mpg is
    Port ( btn : in STD_LOGIC_VECTOR (4 downto 0);
           clk : in STD_LOGIC;
           step : out STD_LOGIC_VECTOR (4 downto 0));
end component;

component ssd is
    Port ( digit0 : in STD_LOGIC_VECTOR (3 downto 0);
           digit1 : in STD_LOGIC_VECTOR (3 downto 0);
           digit2 : in STD_LOGIC_VECTOR (3 downto 0);
           digit3 : in STD_LOGIC_VECTOR (3 downto 0);
           clk : in STD_LOGIC;
           cat : out STD_LOGIC_VECTOR (6 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0));
end component;

component multiplier is -- b * q = a
    generic (size : natural := 8);
    Port ( b_port : in STD_LOGIC_VECTOR (size - 1 downto 0); 
           a_port : out STD_LOGIC_VECTOR (2 * size - 1 downto 0);
           q_multiplier : in STD_LOGIC_VECTOR (size - 1 downto 0)
    );
end component;

component divider is -- q : m = q rest a
    generic (size : natural := 8);
    Port ( q_divident : in STD_LOGIC_VECTOR (size - 1 downto 0);
           m_divisor : in STD_LOGIC_VECTOR (size - 1 downto 0);
           a_reminder : out STD_LOGIC_VECTOR (size - 1 downto 0);
           q_quotient : out STD_LOGIC_VECTOR (size - 1 downto 0)
     );
end component;

signal step : std_logic_vector(4 downto 0); -- buttons
signal cnt : std_logic_vector(15 downto 0);
signal display_output : std_logic_vector(15 downto 0);

signal data_1 : std_logic_vector(7 downto 0);
signal data_2 : std_logic_vector(7 downto 0);
signal result : std_logic_vector(15 downto 0);

signal data_1_mul : std_logic_vector(7 downto 0);
signal data_2_mul : std_logic_vector(7 downto 0);
signal mul_result : std_logic_vector(15 downto 0);

signal data_1_div : std_logic_vector(7 downto 0);
signal data_2_div : std_logic_vector(7 downto 0);
signal div_quotient : std_logic_vector(7 downto 0);
signal div_reminder : std_logic_vector(7 downto 0);

begin

    MPGU: mpg
    Port map(
        btn => btn,
        clk => clk,
        step => step
    );
    
    SSDU: ssd 
    Port map(
        display_output(3 downto 0), 
        display_output(7 downto 4), 
        display_output(11 downto 8), 
        display_output(15 downto 12), 
        clk, 
        cat, 
        an 
    );

    mul : multiplier generic map (8)
                     port map (data_1_mul, mul_result, data_2_mul);
     
    div : divider generic map (8)
                    port map (data_1_div, data_2_div, div_reminder, div_quotient);

    process(clk)
    begin
        if rising_edge(clk) then
            --if enable = '1' then
                --cnt <= x"0";
            --else
                cnt <= cnt + 1;
            --end if;
        end if;
    end process;

    process(clk)
    begin
        if rising_edge(clk) then
            data_1 <= std_logic_vector(resize(signed(sw(3 downto 0)), data_1'length));
            data_2 <= std_logic_vector(resize(signed(sw(7 downto 4)), data_2'length));
            display_output(3 downto 0) <= result(3 downto 0);
            display_output(7 downto 4) <= result(7 downto 4);
            display_output(11 downto 8) <= result(11 downto 8);
            display_output(15 downto 12) <= result(15 downto 12);
        end if;
    end process;
    
    process(sw, mul_result, div_quotient, div_reminder)
        variable data_1_extended, data_2_extended : std_logic_vector(15 downto 0);
    begin
        data_1_mul <= std_logic_vector(resize(signed(sw(3 downto 0)), data_1'length));
        data_2_mul <= std_logic_vector(resize(signed(sw(7 downto 4)), data_2'length));
        data_1_div <= std_logic_vector(resize(signed(sw(3 downto 0)), data_1'length));
        data_2_div <= std_logic_vector(resize(signed(sw(7 downto 4)), data_2'length));
        data_1_extended := std_logic_vector(resize(signed(data_1), data_1_extended'length));
        data_2_extended := std_logic_vector(resize(signed(data_2), data_2_extended'length));
        case sw(12 downto 8) is
            when "00000" => result <= data_1_extended + data_2_extended; -- addition
            when "00001" => result <= data_1_extended - data_2_extended; -- subtraction
            when "00010" => result <= data_1_extended + x"01"; -- increment first number
            when "00011" => result <= data_2_extended + x"01"; -- increment second number
            when "00100" => result <= data_1_extended - x"01"; -- decrement first number
            when "00101" => result <= data_2_extended - x"01"; -- decrement second number
            when "00110" => result <= data_1_extended and data_2_extended; -- AND
            when "00111" => result <= data_1_extended or data_2_extended; -- OR
            when "01000" => result <= not data_1_extended; -- NOT first number
            when "01001" => result <= not data_2_extended; -- NOT second number
            when "01010" => result <= (not data_1_extended) + x"01"; -- negate first number
            when "01011" => result <= (not data_2_extended) + x"01"; -- negate second number
            when "01100" => result <= std_logic_vector(resize(signed((data_1(0) & data_1(7 downto 1))), 16)); -- right rotate of first number
            when "01101" => result <= std_logic_vector(resize(signed((data_2(0) & data_2(7 downto 1))), 16)); -- right rotate of second number
            when "01110" => result <= std_logic_vector(resize(signed((data_1(6 downto 0) & data_1(7))), 16)); -- left rotate of first number
            when "01111" => result <= std_logic_vector(resize(signed((data_2(6 downto 0) & data_2(7))), 16)); -- left rotate of second number
            when "10000" => result <= mul_result; -- first number * second number
            when "10001" => result <= div_quotient & div_reminder; -- first number / second number = quotient & reminder
            when others => result <= (others => '0'); 
        end case;
    end process;

end Behavioral;
