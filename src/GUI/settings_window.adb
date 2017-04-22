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

with Giza.Window; use Giza.Window;
with calandar_80x80;
with ok_80x80;
with Giza.GUI;
with Dialog_Window; use Dialog_Window;
with Ada.Text_IO; use Ada.Text_IO;
with HAL.Real_Time_Clock;
with Real_Time_Clock;
with Alarm_Handling;

package body Settings_Window is

   -------------
   -- On_Init --
   -------------

   overriding procedure On_Init
     (This : in out Instance)
   is
   begin
      This.Alarm.Set_Image (alarm_80x80.Image);
      This.Alarm.Disable_Frame;

      This.Clock.Set_Image (clock_80x80.Image);
      This.Clock.Disable_Frame;

      This.Calandar.Set_Image (calandar_80x80.Image);
      This.Calandar.Disable_Frame;

      This.Back.Set_Image (ok_80x80.Image);
      This.Back.Disable_Frame;

      This.Tile.Set_Size (This.Get_Size);
      This.Tile.Set_Child (1, This.Alarm'Unchecked_Access);
      This.Tile.Set_Child (2, This.Clock'Unchecked_Access);
      This.Tile.Set_Child (3, This.Calandar'Unchecked_Access);
      This.Tile.Set_Child (4, This.Back'Unchecked_Access);
      This.Add_Child (This.Tile'Unchecked_Access, (0, 0));

   end On_Init;

   ------------------
   -- On_Displayed --
   ------------------

   overriding
   procedure On_Displayed (This : in out Instance) is
      Date : HAL.Real_Time_Clock.RTC_Date;
      Time : HAL.Real_Time_Clock.RTC_Time;
   begin
      if This.Select_Alarm.Get_Answer = Answer_Top then
         Put_Line ("We have a new alarm");
         This.Select_Alarm.Clear_Answer;
         Alarm_Handling.Set_Alarm_Time (This.Select_Alarm.Get_Time);
      end if;
      if This.Select_Clock.Get_Answer = Answer_Top then
         Put_Line ("We have a new Clock");
         This.Select_Clock.Clear_Answer;
         Date := Real_Time_Clock.Get_Date;
         Real_Time_Clock.Set (This.Select_Clock.Get_Time, Date);
      end if;
      if This.Select_Date.Get_Answer = Answer_Top then
         Put_Line ("We have a new Date");
         This.Select_Date.Clear_Answer;
         Time := Real_Time_Clock.Get_Time;
         Real_Time_Clock.Set (Time, This.Select_Date.Get_Date);
      end if;
   end On_Displayed;

   -----------------------
   -- On_Position_Event --
   -----------------------

   overriding function On_Position_Event
     (This  : in out Instance;
      Evt   : Position_Event_Ref;
      Pos   : Point_T)
      return Boolean
   is
   begin
      if On_Position_Event (Parent (This), Evt, Pos) then
         if This.Alarm.Active then
            This.Alarm.Set_Active (False);
            This.Select_Alarm.Set_Time (Alarm_Handling.Get_Alarm_Time);
            Giza.GUI.Push (This.Select_Alarm'Unchecked_Access);
         elsif This.Clock.Active then
            This.Clock.Set_Active (False);
            This.Select_Clock.Set_Time (Real_Time_Clock.Get_Time);
            Giza.GUI.Push (This.Select_Clock'Unchecked_Access);
         elsif This.Calandar.Active then
            This.Calandar.Set_Active (False);
            This.Select_Date.Set_Date (Real_Time_Clock.Get_Date);
            Giza.GUI.Push (This.Select_Date'Unchecked_Access);
         elsif This.Back.Active then
            This.Back.Set_Active (False);
            Giza.GUI.Pop;
         end if;
         return True;
      else
         return False;
      end if;
   end On_Position_Event;

end Settings_Window;
