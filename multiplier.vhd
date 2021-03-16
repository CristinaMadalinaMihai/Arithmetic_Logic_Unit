----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/05/2020 01:32:37 PM
-- Design Name: 
-- Module Name: multiplier - Behavioral
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

entity multiplier is -- b * q = a
    generic (size : natural := 8);
    Port ( b_port : in STD_LOGIC_VECTOR (size - 1 downto 0);
           a_port : out STD_LOGIC_VECTOR (2 * size - 1 downto 0);
           q_multiplier : in STD_LOGIC_VECTOR (size - 1 downto 0)
    );
end multiplier;

architecture Behavioral of multiplier is

begin
    process (b_port, q_multiplier)
        variable a, b : std_logic_vector (2 * size - 1 downto 0);
        variable q : std_logic_vector (size - 1 downto 0);
        variable n : natural := size;
    begin
        if (b_port(size - 1) = '1' and q_multiplier(size - 1) = '1') then
            b := std_logic_vector(resize(signed((not b_port) + x"01"), b'length));
            q := (not q_multiplier) + x"01";
        else
            b := std_logic_vector(resize(signed(b_port), b'length));
            q := q_multiplier;
        end if;
        a := (others => '0');
        for i in 0 to (n - 1) loop
            if q(0) = '1' then
                a := a + b;
            end if;
            b := b(2 * n - 2 downto 0) & '0';
            q := '0' & q(n - 1 downto 1);
        end loop;
        a_port <= a;
    end process;

end Behavioral;
