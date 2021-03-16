----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/28/2020 05:18:12 PM
-- Design Name: 
-- Module Name: mpg - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Lab 1
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mpg is
    Port ( btn : in STD_LOGIC_VECTOR (4 downto 0);
           clk : in STD_LOGIC;
           step : out STD_LOGIC_VECTOR (4 downto 0));
end mpg;

architecture Behavioral of mpg is

signal q1 : std_logic_vector(4 downto 0);
signal q2 : std_logic_vector(4 downto 0);
signal cnt : std_logic_vector(15 downto 0);

begin

    -- counter
    process(clk)
    begin
        if rising_edge(clk) then
            cnt <= cnt + 1;
        end if;
    end process;
    
    process(clk)
    begin
        if rising_edge(clk) then
            if cnt = x"FFFF" then
                q1 <= btn;
            end if;
        end if;
    end process;
    
    process(clk)
    begin
        if rising_edge(clk) then
            q2 <= q1;
        end if;
    end process;
    
    step <= q1 and not q2;

end Behavioral;
