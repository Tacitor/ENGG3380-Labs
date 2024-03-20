LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY CPU_3380_Test IS
END ENTITY CPU_3380_Test;

ARCHITECTURE mixed OF CPU_3380_Test IS
    CONSTANT  tick          : TIME := 100 ns;
    SIGNAL    reset, clock  : STD_LOGIC;
    SIGNAL    instruction   : STD_LOGIC_VECTOR(15 downto 0);--switched from 0 to 15

BEGIN
    CPU_3380_Sim : ENTITY work.CPU_3380
        port map(
            clk		      => clock,
            clear	      => reset,
            instruction => instruction
        );

    driver : PROCESS IS
    BEGIN
        -- reset the system
        reset <= '0'; instruction <= x"0000"; WAIT FOR 50 ns;
        reset <= '1';

        -- ADD r2, r1, r1
        instruction <= x"0211"; WAIT FOR tick; --put a "2" into r2

        -- ADD r3, r2, r1
        instruction <= x"0321"; WAIT FOR tick; --put a "3" into r3

        -- Sub r4, r3, r1
        instruction <= x"1431"; WAIT FOR tick; --result of "2" put into r4

        -- Sub r1, r4, r2
        instruction <= x"1142"; WAIT FOR tick; --get a results of "0", try to store into r1. this won't work r1 will stay "1"

		  -- And r5, r3, r4
        instruction <= x"2534"; WAIT FOR tick; --put a value of "2" into r5

		  -- And r6, r5, r1
        instruction <= x"2651"; WAIT FOR tick; --put a value of "0" into r6
        
          -- ADDi r7, r0, "+7"
        instruction <= x"4707"; WAIT FOR tick; --put a value of "7" into r7
                
          -- ADDi r7, r7, "+7"
        instruction <= x"4777"; WAIT FOR tick; --put a value of "14"="000E" into r7
        
          -- SUBi r8, r7, "-8"
        instruction <= x"5878"; WAIT FOR tick; --put a value of "22"="0016" into r8
                
          -- SUBi r9, r8, "2"
        instruction <= x"5982"; WAIT FOR tick; --put a value of "20"="0014" into r9

 		  -- OR r6, r9, r2
        instruction <= x"3692"; WAIT FOR tick; --put a value of "22"="0016" into r6
        
           -- OR r10, r7, r1
        instruction <= x"3A71"; WAIT FOR tick; --put a value of "15"="000E" into r10
        WAIT;
    END PROCESS driver;

    clock_p : PROCESS IS
    BEGIN
        FOR i IN 0 TO 18 LOOP
            clock <= '1'; WAIT FOR  tick/2;
            clock <= '0'; WAIT FOR  tick/2;
        END LOOP;
        WAIT;
    END PROCESS clock_p;
END ARCHITECTURE mixed;
