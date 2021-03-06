-------------------------------------------------------------------------------
--                                                                           --
--                               Coffee Clock                                --
--                                                                           --
--                  Copyright (C) 2016-2017 Fabien Chouteau                  --
--                                                                           --
--    Coffee Clock is free software: you can redistribute it and/or          --
--    modify it under the terms of the GNU General Public License as         --
--    published by the Free Software Foundation, either version 3 of the     --
--    License, or (at your option) any later version.                        --
--                                                                           --
--    Coffee Clock is distributed in the hope that it will be useful,        --
--    but WITHOUT ANY WARRANTY; without even the implied warranty of         --
--    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU       --
--    General Public License for more details.                               --
--                                                                           --
--    You should have received a copy of the GNU General Public License      --
--    along with We Noise Maker. If not, see <http://www.gnu.org/licenses/>. --
--                                                                           --
-------------------------------------------------------------------------------

with Ada.Real_Time; use Ada.Real_Time;
with STM32.Device;  use STM32.Device;
with STM32.GPIO;    use STM32.GPIO;
with STM32.Board;   use STM32.Board;

package body Coffee_Maker is

   Trigger_Pin : GPIO_Point renames PD3;

   ----------------
   -- Initialize --
   ----------------

   procedure Initialize is
   begin
      Enable_Clock (Trigger_Pin);

      Trigger_Pin.Configure_IO ((Mode        => Mode_Out,
                                 Output_Type => Push_Pull,
                                 Speed       => Speed_25MHz,
                                 Resistors   => Floating));
      Trigger_Pin.Clear;

      Initialize_LEDs;
   end Initialize;

   -----------------
   -- Make_Coffee --
   -----------------

   procedure Make_Coffee is
      procedure Pulse;

      -----------
      -- Pulse --
      -----------

      procedure Pulse is
      begin
         Trigger_Pin.Set;
         delay until Clock + Milliseconds (1000);
         Trigger_Pin.Clear;
      end Pulse;
   begin

      --  Turning the machine on
      Pulse;

      --  Waiting for warmup (assuming cold start)
      delay until Clock + Seconds (7);

      --  Start coffee
      Pulse;

      for Cnt in 1 .. 10 loop
         All_LEDs_On;
         delay until Clock + Milliseconds (500);
         All_LEDs_Off;
         delay until Clock + Milliseconds (500);
      end loop;
   end Make_Coffee;

end Coffee_Maker;
