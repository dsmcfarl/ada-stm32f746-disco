--  This package is intended to set up and tear down  the test environment.
--  Once created by GNATtest, this package will never be overwritten
--  automatically. Contents of this package can be modified in any way
--  except for sections surrounded by a 'read only' marker.

with AUnit.Assertions;
with All_Test_Results;

package body Debug.Test_Data is

   procedure Set_Up (Gnattest_T : in out Test) is
      pragma Unreferenced (Gnattest_T);
   begin
      null;
   end Set_Up;

   procedure Tear_Down (Gnattest_T : in out Test) is
   begin
      if AUnit.Assertions.Has_Failures (AUnit.Assertions.Test (Gnattest_T))
      then
         All_Test_Results.Fail_Count := All_Test_Results.Fail_Count + 1;
      end if;
   end Tear_Down;
end Debug.Test_Data;
