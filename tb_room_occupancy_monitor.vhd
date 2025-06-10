----------------------------------------------------------------------------------
-- COEN313 Digital Design Project
-- tb_room_occupancy_moitor.vhd
-- Student Name: Fabio Binu Koshy
-- ID : 40231803
-- Date: Winter 2025
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_room_occupancy_monitor is
end tb_room_occupancy_monitor;

architecture Behavioral of tb_room_occupancy_monitor is
    component room_occupancy_monitor
        Port ( 
            clk               : in  STD_LOGIC;
            reset             : in  STD_LOGIC;
            entrance_photocell: in  STD_LOGIC;
            exit_photocell    : in  STD_LOGIC;
            max_threshold     : in  STD_LOGIC_VECTOR(7 downto 0);
            max_capacity      : out STD_LOGIC;
            occupancy         : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;
    
    signal clk               : STD_LOGIC := '0';
    signal reset             : STD_LOGIC := '0';
    signal entrance_photocell: STD_LOGIC := '1'; 
    signal exit_photocell    : STD_LOGIC := '1';  
    signal max_threshold     : STD_LOGIC_VECTOR(7 downto 0) := "00000101";  
    
    signal max_capacity      : STD_LOGIC;
    signal occupancy         : STD_LOGIC_VECTOR(7 downto 0);
    
    constant clk_period      : time := 10 ns;
    
begin
    uut: room_occupancy_monitor
        Port map (
            clk                => clk,
            reset              => reset,
            entrance_photocell => entrance_photocell,
            exit_photocell     => exit_photocell,
            max_threshold      => max_threshold,
            max_capacity       => max_capacity,
            occupancy          => occupancy
        );
        
    clk_process: process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;
    
    stim_proc: process
    

        procedure person_enters is
        begin
            entrance_photocell <= '0'; 
            wait for 30 ns;            
            entrance_photocell <= '1';  
            wait for 30 ns;             
        end procedure;
        
        procedure person_exits is
        begin
            exit_photocell <= '0'; 
            wait for 30 ns;         
            exit_photocell <= '1';  
            wait for 30 ns;         
        end procedure;
        
    begin
        report "Test Case 0: Initial reset";
        reset <= '1';
        wait for 100 ns;
        reset <= '0';
        wait for 100 ns;
        
        -- Test Case 1: People entering the room one by one until max capacity
        report "Test Case 1: People entering the room until max capacity";
        
        -- Person 1 enters
        person_enters;
        wait for 20 ns;
        assert unsigned(occupancy) = 1 
            report "Failed: Count should be 1 after first person enters" 
            severity note;
        
        -- Person 2 enters
        person_enters;
        wait for 20 ns;
        assert unsigned(occupancy) = 2 
            report "Failed: Count should be 2 after second person enters" 
            severity note;
        
        -- Person 3 enters
        person_enters;
        wait for 20 ns;
        assert unsigned(occupancy) = 3 
            report "Failed: Count should be 3 after third person enters" 
            severity note;
        
        -- Person 4 enters
        person_enters;
        wait for 20 ns;
        assert unsigned(occupancy) = 4 
            report "Failed: Count should be 4 after fourth person enters" 
            severity note;
        
        -- Person 5 enters (should reach max capacity)
        person_enters;
        wait for 20 ns;
        assert unsigned(occupancy) = 5 
            report "Failed: Count should be 5 after fifth person enters" 
            severity note;
        assert max_capacity = '1' 
            report "Failed: Max capacity signal should be asserted" 
            severity note;
        
        -- Test Case 2: Attempt to enter when full
        report "Test Case 2: Attempt to enter when full";
        person_enters;
        wait for 20 ns;
        assert unsigned(occupancy) = 5 
            report "Failed: Count should remain 5 when full" 
            severity note;
        
        -- Test Case 3: People exiting the room one by one
        report "Test Case 3: People exiting the room one by one";
        
        -- Person 1 exits
        person_exits;
        wait for 20 ns;
        assert unsigned(occupancy) = 4 
            report "Failed: Count should be 4 after one person exits" 
            severity note;
        assert max_capacity = '0' 
            report "Failed: Max capacity signal should be deasserted" 
            severity note;
        
        -- Person 2 exits
        person_exits;
        wait for 20 ns;
        assert unsigned(occupancy) = 3 
            report "Failed: Count should be 3 after second person exits" 
            severity note;
        
        -- Test Case 4: Simultaneous entry and exit (should cancel out)
        report "Test Case 4: Simultaneous entry and exit";
        entrance_photocell <= '0';
        exit_photocell <= '0';
        wait for 30 ns;
        entrance_photocell <= '1';
        exit_photocell <= '1';
        wait for 30 ns;
        assert unsigned(occupancy) = 3 
            report "Failed: Count should remain 3 after simultaneous entry/exit" 
            severity note;
        
        -- Test Case 5: Multiple entries followed by reset
        report "Test Case 5: Multiple entries followed by reset";
        for i in 1 to 2 loop
            person_enters;
            wait for 20 ns;
        end loop;
        assert unsigned(occupancy) = 5 
            report "Failed: Count should be 5 after two more people enter" 
            severity note;
        assert max_capacity = '1' 
            report "Failed: Max capacity signal should be asserted again" 
            severity note;
        
        reset <= '1';
        wait for 50 ns;
        reset <= '0';
        wait for 50 ns;
        assert unsigned(occupancy) = 0 
            report "Failed: Count should be 0 after reset" 
            severity note;
        assert max_capacity = '0' 
            report "Failed: Max capacity signal should be deasserted after reset" 
            severity note;
        
        -- Test Case 6: Testing with different max threshold
        report "Test Case 6: Testing with different max threshold";
        
        -- Add 2 people
        for i in 1 to 2 loop
            person_enters;
            wait for 20 ns;
        end loop;
        
        -- Change threshold to 2
        max_threshold <= "00000010"; -- Change max to 2
        wait for 50 ns;
        
        -- Should now be at max capacity with 2 people
        assert max_capacity = '1' 
            report "Failed: Max capacity should be asserted with new threshold of 2" 
            severity note;
        
        -- Test Case 7: Try to decrement below zero
        report "Test Case 7: Try to decrement below zero";
        reset <= '1';
        wait for 50 ns;
        reset <= '0';
        wait for 50 ns;
        
        -- Try exiting when count is already zero
        person_exits;
        wait for 20 ns;
        assert unsigned(occupancy) = 0 
            report "Failed: Count should remain 0 when trying to go below zero" 
            severity note;
        
        -- Test Case 8: Rapid succession of entries and exits
        report "Test Case 8: Rapid succession of entries and exits";
        
        -- Quick succession of 3 entries
        for i in 1 to 3 loop
            entrance_photocell <= '0';
            wait for 20 ns;
            entrance_photocell <= '1';
            wait for 20 ns;
        end loop;
        
        wait for 20 ns;
        assert unsigned(occupancy) = 3 
            report "Failed: Count should be 3 after rapid entries" 
            severity note;
        assert max_capacity = '1' 
            report "Failed: Max capacity should be asserted (3 > 2)" 
            severity note;
        
        -- Change max threshold to higher value
        report "Test Case 9: Change threshold to higher value";
        max_threshold <= "00001000"; -- Change max to 8
        wait for 50 ns;
        
        assert max_capacity = '0' 
            report "Failed: Max capacity should be deasserted with new threshold of 8" 
            severity note;
        
        report "Test completed successfully";
        wait;
    end process;
end Behavioral;
