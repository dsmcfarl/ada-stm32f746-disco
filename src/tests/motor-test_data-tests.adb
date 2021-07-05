--  This package has been generated automatically by GNATtest.
--  You are allowed to add your code to the bodies of test routines.
--  Such changes will be kept during further regeneration of this file.
--  All code placed outside of test routine bodies will be lost. The
--  code intended to set up and tear down the test environment should be
--  placed into Motor.Test_Data.

with AUnit.Assertions; use AUnit.Assertions;
with System.Assertions;

--  begin read only
--  id:2.2/00/
--
--  This section can be used to add with clauses if necessary.
--
--  end read only

with STM32.Device;

--  begin read only
--  end read only
package body Motor.Test_Data.Tests is

--  begin read only
--  id:2.2/01/
--
--  This section can be used to add global variables and other elements.
--
--  end read only

--  begin read only
--  end read only

--  begin read only
   procedure Test_Configure (Gnattest_T : in out Test);
   procedure Test_Configure_9f540a (Gnattest_T : in out Test) renames Test_Configure;
--  id:2.2/9f540afdd1fd068e/Configure/1/0/
   procedure Test_Configure (Gnattest_T : in out Test) is
   --  motor.ads:25:4:Configure
--  end read only

      pragma Unreferenced (Gnattest_T);
      My_Motor : Motor;

   begin

      Configure (My_Motor, STM32.Device.PB4);

      AUnit.Assertions.Assert
        (STM32.PWM.Output_Enabled (My_Motor.Power_Control),
         "My_Motor not enabled after configure");

      AUnit.Assertions.Assert
        (STM32.PWM.Current_Duty_Cycle (My_Motor.Power_Control) =
         STM32.PWM.Percentage (7.5),
         "My_Motor duty cycle not set to 7.5%");

--  begin read only
   end Test_Configure;
--  end read only


--  begin read only
   procedure Test_Set (Gnattest_T : in out Test);
   procedure Test_Set_63cccd (Gnattest_T : in out Test) renames Test_Set;
--  id:2.2/63cccdfcd08c3ed5/Set/1/0/
   procedure Test_Set (Gnattest_T : in out Test) is
   --  motor.ads:36:4:Set
--  end read only

      pragma Unreferenced (Gnattest_T);
      My_Motor : Motor;

   begin

      Configure (My_Motor, STM32.Device.PB4);
      Set (My_Motor, 0.5);

      AUnit.Assertions.Assert
        (STM32.PWM.Current_Duty_Cycle (My_Motor.Power_Control) =
         STM32.PWM.Percentage (8.75),
         "My_Motor duty cycle not set to 8.75% after Set (0.5)");

--  begin read only
   end Test_Set;
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
end Motor.Test_Data.Tests;
