with Ada.Real_Time; use Ada.Real_Time;
with STM32.I2C;
with HAL;
with I2C;
with UI;
with HAL.I2C;
with Ada.Unchecked_Conversion;
with Log;

-------------------------------------------------------------------------------
-- USFS
-- References:
--    1. docs/EMSentral_EM7180_Technical_Datasheet_v1_3.pdf
-------------------------------------------------------------------------------
package body USFS is
   use type HAL.UInt10;
   subtype EM7180_Register_Address is HAL.UInt16;

   EM7180_I2C_Address : constant STM32.I2C.I2C_Address := 16#28# * 2;
   -- [1:p14]  must shift i2c address over 1 for 7 bit mode

   type EM7180_Register_Read_Status is (Ok, Err_Max_Retries_Exceeded);

   ----------------------------------------------------------------------------
   -- Read_EM7180_Register
   --
   -- Purpose:
   --    This procedure reads one byte from a EM7180 register, retrying up to
   --    10 times with 1 second delay if there is an I2C error (logs the error)
   --    and reports Ok on success or Err_Max_Retries_Exceeded on failure.
   ----------------------------------------------------------------------------
   procedure Read_EM7180_Register
     (Register_Address :     EM7180_Register_Address; Value : out HAL.UInt8;
      Read_Status      : out EM7180_Register_Read_Status)
   is
      Timeout : Time               := Clock;
      Cycle   : constant Time_Span := Seconds (1);
      Data    : HAL.I2C.I2C_Data (1 .. 1);
      use type HAL.I2C.I2C_Status;
      I2C_Status : HAL.I2C.I2C_Status;
      type Mem_Read_Retries is range 1 .. 10;
   begin
      for I in Mem_Read_Retries loop
         HAL.I2C.Mem_Read
           (I2C.Controller.all, EM7180_I2C_Address, Register_Address,
            HAL.I2C.Memory_Size_8b, Data, I2C_Status);
         case I2C_Status is
            when HAL.I2C.Ok =>
               Value       := Data (1);
               Read_Status := Ok;
               return;
            when HAL.I2C.Err_Error =>
               Log.Warning ("Read_EM7180_Register: I2C Err_Error");
            when HAL.I2C.Busy =>
               Log.Warning ("Read_EM7180_Register: I2C Busy");
            when HAL.I2C.Err_Timeout =>
               Log.Warning ("Read_EM7180_Register: I2C Err_Timeout");
         end case;
         delay until Timeout;
         Timeout := Timeout + Cycle;
      end loop;
      Read_Status := Err_Max_Retries_Exceeded;
   end Read_EM7180_Register;

   type EEPROM_Upload_Status is (Done, Error);
   procedure Wait_For_EEPROM_Upload
     (Max_Retries : Integer; Status : out EEPROM_Upload_Status)
   is
      type Sentral_Status is record
         EEPROM          : Boolean;
         EE_Upload_Done  : Boolean;
         EE_Upload_Error : Boolean;
         Idle            : Boolean;
         No_EEPROM       : Boolean;
         Unused          : HAL.UInt3;
      end record with
         Pack;
      function As_Sentral_Status is new Ada.Unchecked_Conversion
        (Source => HAL.UInt8, Target => Sentral_Status);
      SS                              : Sentral_Status;
      Value                           : HAL.UInt8                        := 0;
      Sentral_Status_Register_Address : constant EM7180_Register_Address :=
        16#37#; -- [1:p19]
      Read_Status : EM7180_Register_Read_Status;

   begin
      Read_EM7180_Register
        (Sentral_Status_Register_Address, Value, Read_Status);
      case Read_Status is
         when Err_Max_Retries_Exceeded =>
            Log.Warning
              ("read EM7180 SentralStatus register: max retries exceeded");
            Status := Error;
            return;
         when Ok =>
            null;
      end case;
      for I in 1 .. Max_Retries loop
         SS := As_Sentral_Status (Value);
         UI.Put_Line (Value'Image);
         if SS.EE_Upload_Done then
            UI.Put_Line ("upload done");
         end if;
         Status := Done;
         return;
      end loop;
      Status := Error;
      return;
   end Wait_For_EEPROM_Upload;

   ----------------------------------------------------------------------------
   -- Initialize
   ----------------------------------------------------------------------------
   procedure Initialize is
      Status : EEPROM_Upload_Status;
   begin
      I2C.Initialize (400_000);
      Wait_For_EEPROM_Upload (5, Status);
      UI.Put_Line (Status'Image);
      -- if Get_Ready_Status then
      --    UI.Put_Line ("ready");
      -- end if;
   end Initialize;
end USFS;
