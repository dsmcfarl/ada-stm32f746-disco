with Ada.Text_IO;

package body Log is
   procedure Warning (Msg : String) is
   begin
      Ada.Text_IO.Put_Line ("WARN: " & Msg);
   end Warning;
end Log;
