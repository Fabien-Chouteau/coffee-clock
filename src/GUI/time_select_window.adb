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

with ok_80x80;
with cancel_80x80;
with up_200x100;
with down_200x100;
with Dialog_Window; use Dialog_Window;
with Giza.Colors; use Giza.Colors;

package body Time_Select_Window is

   -------------
   -- On_Init --
   -------------

   overriding procedure On_Init
     (This : in out Instance)
   is
      Size : constant Size_T := This.Get_Size;
   begin
      On_Init (Parent (This));
      This.Set_Background (Black);

      This.Up_Hours.Disable_Frame;
      This.Up_Hours.Disable_Background;
      This.Up_Hours.Set_Image (up_200x100.Image);
      This.Up_Hours.Set_Size ((200, 100));
      This.Add_Child (This.Up_Hours'Unchecked_Access, (75, 10));

      This.Up_Minutes.Disable_Frame;
      This.Up_Minutes.Disable_Background;
      This.Up_Minutes.Set_Image (up_200x100.Image);
      This.Up_Minutes.Set_Size ((200, 100));
      This.Add_Child (This.Up_Minutes'Unchecked_Access, (450, 10));

      This.Down_Hours.Disable_Frame;
      This.Down_Hours.Disable_Background;
      This.Down_Hours.Set_Image (down_200x100.Image);
      This.Down_Hours.Set_Size ((200, 100));
      This.Add_Child (This.Down_Hours'Unchecked_Access, (75, 370));

      This.Down_Minutes.Disable_Frame;
      This.Down_Minutes.Disable_Background;
      This.Down_Minutes.Set_Image (down_200x100.Image);
      This.Down_Minutes.Set_Size ((200, 100));
      This.Add_Child (This.Down_Minutes'Unchecked_Access, (450, 370));

      This.Set_Top_Image (ok_80x80.Image);
      This.Set_Icon_Image (This.Icon);
      This.Set_Bottom_Image (cancel_80x80.Image);

      This.Clock.Set_Size (This.Clock.Required_Size);
      This.Add_Child (This.Clock'Unchecked_Access,
                      ((Size.W - This.Clock.Get_Size.W) / 2,
                       (Size.H - This.Clock.Get_Size.H) / 2));
   end On_Init;

   ------------------
   -- On_Displayed --
   ------------------

   overriding procedure On_Displayed
     (This : in out Instance)
   is
      pragma Unreferenced (This);
   begin
      null;
   end On_Displayed;

   ---------------
   -- On_Hidden --
   ---------------

   overriding procedure On_Hidden
     (This : in out Instance)
   is
      pragma Unreferenced (This);
   begin
      null;
   end On_Hidden;

   -----------------------
   -- On_Position_Event --
   -----------------------

   overriding function On_Position_Event
     (This  : in out Instance;
      Evt   : Position_Event_Ref;
      Pos   : Point_T)
      return Boolean
   is
      use type HAL.Real_Time_Clock.RTC_Hour;
      use type HAL.Real_Time_Clock.RTC_Minute;
      Time : HAL.Real_Time_Clock.RTC_Time;
   begin
      if On_Position_Event (Parent (This), Evt, Pos) then
         Time := This.Clock.Get_Time;
         if This.Up_Hours.Active then
            This.Up_Hours.Set_Active (False);
            Time.Hour := Time.Hour + 1;
         elsif This.Down_Hours.Active then
            This.Down_Hours.Set_Active (False);
            Time.Hour := Time.Hour - 1;
         elsif This.Up_Minutes.Active then
            This.Up_Minutes.Set_Active (False);
            Time.Min := Time.Min + 1;
         elsif This.Down_Minutes.Active then
            This.Down_Minutes.Set_Active (False);
            Time.Min := Time.Min - 1;
         end if;
         This.Clock.Set_Time (Time);
         return True;
      else
         return False;
      end if;
   end On_Position_Event;

   --------------
   -- Set_Time --
   --------------

   procedure Set_Time (This : in out Instance;
                       Time : HAL.Real_Time_Clock.RTC_Time)
   is
   begin
      This.Clock.Set_Time (Time);
   end Set_Time;

   --------------
   -- Get_Time --
   --------------

   function Get_Time (This : Instance) return HAL.Real_Time_Clock.RTC_Time is
        (This.Clock.Get_Time);

end Time_Select_Window;
