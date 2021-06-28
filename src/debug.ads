-------------------------------------------------------------------------------
-- Debug
--
-- Subprograms to aid debugging.
-------------------------------------------------------------------------------
package Debug is

   ----------------------------------------------------------------------------
   -- Output_PLL_DIV5_To_PA8
   --
   -- Purpose:
   --    Send the PLL clock divided by five to GPIO port A pin 8 to verify the
   --    system clock is setup correctly. Should be 40 MHz.
   --
   -- Effects:
   --    - Enables the clock for Timer_11 and GPIO_A.
   ----------------------------------------------------------------------------
   procedure Output_PLL_DIV5_To_PA8;

end Debug;
