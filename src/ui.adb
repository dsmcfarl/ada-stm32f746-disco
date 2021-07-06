with STM32.Board;
with HAL.Bitmap;
-- with HAL.Touch_Panel;   use HAL.Touch_Panel;
-- with STM32.User_Button; use STM32;
with BMP_Fonts;
with LCD_Std_Out;

-------------------------------------------------------------------------------
-- UI
-------------------------------------------------------------------------------
package body UI is

   ----------------------------------------------------------------------------
   -- Initialize
   --
   -- Implementation Notes:
   --    - Adapted from Ada_Driver_Library/repo/examples/shared/draw/src/draw.adb
   ----------------------------------------------------------------------------
   procedure Initialize is
      -- BG : constant HAL.Bitmap.Bitmap_Color := (Alpha => 255, others => 64);
   begin
      STM32.Board.Display.Initialize;
      STM32.Board.Display.Initialize_Layer (1, HAL.Bitmap.ARGB_8888);
      STM32.Board.Display.Hidden_Buffer (1).Set_Source (LCD_Std_Out.Black);
      STM32.Board.Display.Hidden_Buffer (1).Fill;
      LCD_Std_Out.Set_Font (BMP_Fonts.Font8x8);
      LCD_Std_Out.Current_Background_Color := LCD_Std_Out.Black;
      LCD_Std_Out.Clear_Screen;
   end Initialize;

   ----------------------------------------------------------------------------
   -- Put_Line
   ----------------------------------------------------------------------------
   procedure Put_Line (Msg : String) is
   begin
      LCD_Std_Out.Put_Line (Msg);
   end Put_Line;

   ----------------------------------------------------------------------------
   -- Draw_UI
   ----------------------------------------------------------------------------
   procedure Draw_UI is
      package BMP renames HAL.Bitmap;
      Buffer : constant BMP.Any_Bitmap_Buffer :=
        (STM32.Board.Display.Hidden_Buffer (1));
      Main_Rect   : constant BMP.Rect := ((20, 20), 100, 200);
      Main_Radius : constant Natural  := 10;
   begin
      Buffer.Set_Source (BMP.Dim_Grey);
      BMP.Fill_Rounded_Rect (Buffer.all, Main_Rect, Main_Radius);
      STM32.Board.Display.Update_Layer (1, True);
   end Draw_UI;

end UI;
