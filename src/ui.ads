-------------------------------------------------------------------------------
-- UI
--
-- Subprograms to user interface.
-------------------------------------------------------------------------------
package UI is

   ----------------------------------------------------------------------------
   -- Initialize
   --
   -- Purpose:
   --    Initialize the user interface.
   --
   -- Effects:
   --    - initializes the LCD display layer 1 to use ARGB_8888
   --    - clears the LCD display
   --    - configures an 8x8 bitmap font
   ----------------------------------------------------------------------------
   procedure Initialize;

   ----------------------------------------------------------------------------
   -- Put_Line
   --
   -- Purpose:
   --    Write a line to the LCD display.
   ----------------------------------------------------------------------------
   procedure Put_Line (Msg : String);

end UI;