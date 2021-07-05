--  This package has been generated automatically by GNATtest.
--  You are allowed to add your code to the bodies of test routines.
--  Such changes will be kept during further regeneration of this file.
--  All code placed outside of test routine bodies will be lost. The
--  code intended to set up and tear down the test environment should be
--  placed into Debug.Test_Data.

with AUnit.Assertions; use AUnit.Assertions;
with System.Assertions;

--  begin read only
--  id:2.2/00/
--
--  This section can be used to add with clauses if necessary.
--
--  end read only
with STM32.GPIO;
with STM32.Device;
--  begin read only
--  end read only
package body Debug.Test_Data.Tests is

--  begin read only
--  id:2.2/01/
--
--  This section can be used to add global variables and other elements.
--
--  end read only

--  begin read only
--  end read only

--  begin read only
   procedure Test_Output_PLL_DIV5_To_PA8 (Gnattest_T : in out Test);
   procedure Test_Output_PLL_DIV5_To_PA8_5e4dea (Gnattest_T : in out Test) renames Test_Output_PLL_DIV5_To_PA8;
--  id:2.2/5e4dea8be1a120af/Output_PLL_DIV5_To_PA8/1/0/
   procedure Test_Output_PLL_DIV5_To_PA8 (Gnattest_T : in out Test) is
   --  debug.ads:18:4:Output_PLL_DIV5_To_PA8
--  end read only

      pragma Unreferenced (Gnattest_T);
      use type STM32.GPIO.Pin_IO_Modes;

   begin

      Output_PLL_DIV5_To_PA8;

      AUnit.Assertions.Assert
        (STM32.GPIO.Pin_IO_Mode (STM32.Device.PA8) = STM32.GPIO.Mode_AF,
         "PA8 IO mode is not Mode_AF");

--  begin read only
   end Test_Output_PLL_DIV5_To_PA8;
--  end read only

--  begin read only
--  id:2.2/02/
--
--  This section can be used to add elaboration code for the global state.
--
begin
--  end read only
   null;
--  begin read only
--  end read only
end Debug.Test_Data.Tests;
