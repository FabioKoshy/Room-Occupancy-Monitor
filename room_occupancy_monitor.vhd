----------------------------------------------------------------------------------
-- COEN313 Digital Design Project
-- room_occupancy_monitor.vhd
-- Student Name: Fabio BInu Koshy
-- ID : 40231803
-- Date: Winter 2025
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity room_occupancy_monitor is
    Port ( 
        clk               : in  STD_LOGIC;                      
        reset             : in  STD_LOGIC;                      
        entrance_photocell: in  STD_LOGIC;                      
        exit_photocell    : in  STD_LOGIC;                     
        max_threshold     : in  STD_LOGIC_VECTOR(7 downto 0);   
        max_capacity      : out STD_LOGIC;                      
        occupancy         : out STD_LOGIC_VECTOR(7 downto 0)    
    );
end room_occupancy_monitor;

architecture Behavioral of room_occupancy_monitor is
    
    signal entrance_delay  : STD_LOGIC := '0';                    
    signal exit_delay      : STD_LOGIC := '0';                     
    signal entrance_pulse  : STD_LOGIC;                            
    signal exit_pulse      : STD_LOGIC;                            
    signal current_count   : UNSIGNED(7 downto 0) := (others => '0'); 
    signal max_count       : UNSIGNED(7 downto 0);                   
    
begin
    
    max_count <= UNSIGNED(max_threshold);
    
    entrance_edge_detect: process(clk, reset)
    begin
        if reset = '1' then
            entrance_delay <= '0';
            entrance_pulse <= '0';
        elsif rising_edge(clk) then
            entrance_delay <= entrance_photocell;
            entrance_pulse <= '0';  
            if entrance_delay = '1' and entrance_photocell = '0' then
                entrance_pulse <= '1';  
            end if;
        end if;
    end process;
    
    exit_edge_detect: process(clk, reset)
    begin
        if reset = '1' then
            exit_delay <= '0';
            exit_pulse <= '0';
        elsif rising_edge(clk) then
            exit_delay <= exit_photocell;
            exit_pulse <= '0';  
            if exit_delay = '1' and exit_photocell = '0' then
                exit_pulse <= '1';  
            end if;
        end if;
    end process;
    
    counter: process(clk, reset)
    begin
        if reset = '1' then
            current_count <= (others => '0');  
        elsif rising_edge(clk) then
            if entrance_pulse = '1' and current_count < max_count then
                current_count <= current_count + 1;
            elsif exit_pulse = '1' and current_count > 0 then
                current_count <= current_count - 1;
            end if;
        end if;
    end process;
  
    max_capacity <= '1' when current_count >= max_count else '0';
    occupancy <= STD_LOGIC_VECTOR(current_count);
    
end Behavioral;
