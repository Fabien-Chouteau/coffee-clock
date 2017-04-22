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

with Ada.Synchronous_Task_Control;
with Real_Time_Clock;
with HAL.Real_Time_Clock; use HAL.Real_Time_Clock;
with Ada.Real_Time; use Ada.Real_Time;

package body Alarm_Handling is

   procedure Do_Nothing;

   Sync       : Ada.Synchronous_Task_Control.Suspension_Object;
   Alarm_Time : RTC_Time;
   Action     : Alarm_Action := Do_Nothing'Access;

   ----------------
   -- Do_Nothing --
   ----------------

   procedure Do_Nothing is null;

   task Touch_Screen is
   end Touch_Screen;

   task body Touch_Screen is
      Now : HAL.Real_Time_Clock.RTC_Time;
      Trigger_Time : Time;
   begin
      Ada.Synchronous_Task_Control.Suspend_Until_True (Sync);

      loop

         Now := Real_Time_Clock.Get_Time;

         if Now.Hour = Alarm_Time.Hour and then Now.Min = Alarm_Time.Min then
            --  Trigger alarm

            Trigger_Time := Clock;

            --  Call the action procedure
            Action.all;

            --  Sleep for at least two minutes to make sure we don't trigger
            --  the alarm twice.
            delay until Trigger_Time + Minutes (2);
         end if;

         delay until Clock + Milliseconds (500);
      end loop;
   end Touch_Screen;

   -----------
   -- Start --
   -----------

   procedure Start is
   begin
      Ada.Synchronous_Task_Control.Set_True (Sync);
   end Start;

   ----------------------
   -- Set_Alarm_Action --
   ----------------------

   procedure Set_Alarm_Action (Action : Alarm_Action) is
   begin
      Alarm_Handling.Action := Set_Alarm_Action.Action;
   end Set_Alarm_Action;

   --------------------
   -- Set_Alarm_Time --
   --------------------

   procedure Set_Alarm_Time (Time : HAL.Real_Time_Clock.RTC_Time) is
   begin
      Alarm_Time := Time;
   end Set_Alarm_Time;

   --------------------
   -- Get_Alarm_Time --
   --------------------

   function Get_Alarm_Time return HAL.Real_Time_Clock.RTC_Time is
      (Alarm_Time);

end Alarm_Handling;
