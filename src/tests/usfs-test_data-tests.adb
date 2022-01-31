--  This package has been generated automatically by GNATtest.
--  You are allowed to add your code to the bodies of test routines.
--  Such changes will be kept during further regeneration of this file.
--  All code placed outside of test routine bodies will be lost. The
--  code intended to set up and tear down the test environment should be
--  placed into USFS.Test_Data.

with AUnit.Assertions; use AUnit.Assertions;
with System.Assertions;

--  begin read only
--  id:2.2/00/
--
--  This section can be used to add with clauses if necessary.
--
--  end read only

--  begin read only
--  end read only
package body USFS.Test_Data.Tests is

--  begin read only
--  id:2.2/01/
--
--  This section can be used to add global variables and other elements.
--
--  end read only

--  begin read only
--  end read only

--  begin read only
   procedure Test_Initialize (Gnattest_T : in out Test);
   procedure Test_Initialize_b0ff4a (Gnattest_T : in out Test) renames Test_Initialize;
--  id:2.2/b0ff4afbf3d6da35/Initialize/1/0/
   procedure Test_Initialize (Gnattest_T : in out Test) is
   --  usfs.ads:18:4:Initialize
--  end read only

      pragma Unreferenced (Gnattest_T);

   begin

      Initialize;
      -- TODO
      -- AUnit.Assertions.Assert
      --   (Gnattest_Generated.Default_Assert_Value,
      --    "Test not implemented.");

--  begin read only
   end Test_Initialize;
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
end USFS.Test_Data.Tests;
