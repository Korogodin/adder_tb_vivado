-- Author: Jim Wu (jim.wu@xilinx.com)

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;

entity heartbeat_gen is
    generic (
        CLK_CNT_MAX : unsigned(31 downto 0));
    port (
        reset_i   : in  std_logic;
        clk_i     : in  std_logic;

        heartbeat_o : out std_logic);
end heartbeat_gen;

architecture rtl of heartbeat_gen is

signal heartbeat    : std_logic;
signal clk_cycle_cnt : unsigned(31 downto 0);

begin

heartbeat_proc : process (reset_i, clk_i)
begin
    if reset_i = '1' then
        clk_cycle_cnt <= (others => '0');
        heartbeat <= '0';
    elsif clk_i'event and clk_i = '1' then
        if clk_cycle_cnt = CLK_CNT_MAX then 
            clk_cycle_cnt <= (others => '0');
            heartbeat <= not heartbeat;
        else
            clk_cycle_cnt <= clk_cycle_cnt + 1;
        end if;
    end if;
end process heartbeat_proc;

heartbeat_o <= heartbeat;
   
end rtl;


