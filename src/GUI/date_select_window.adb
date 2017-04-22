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

with Giza.Colors; use Giza.Colors;
with Dialog_Window; use Dialog_Window;

with ok_80x80;
with cancel_80x80;
with calandar_80x80;
with up_200x100;
with down_200x100;
with Date_Widget; use Date_Widget;

package body Date_Select_Window is

   package Up_Bmp renames up_200x100;
   package Down_Bmp renames down_200x100;

   -------------
   -- On_Init --
   -------------

   overriding procedure On_Init
     (This : in out Instance)
   is
      Size : constant Size_T := This.Get_Size;
   begin
      On_Init (Parent (This));

      This.Up_M.Disable_Frame;
      This.Up_M.Disable_Background;
      This.Up_M.Set_Image (Up_Bmp.Image);
      This.Up_M.Set_Size ((Up_Bmp.Image.Size.W, Up_Bmp.Image.Size.H));
      This.Add_Child (This.Up_M'Unchecked_Access, (50, 10));

      This.Up_D.Disable_Frame;
      This.Up_D.Disable_Background;
      This.Up_D.Set_Image (Up_Bmp.Image);
      This.Up_D.Set_Size ((Up_Bmp.Image.Size.W, Up_Bmp.Image.Size.H));
      This.Add_Child (This.Up_D'Unchecked_Access, (250, 10));

      This.Up_Y.Disable_Frame;
      This.Up_Y.Disable_Background;
      This.Up_Y.Set_Image (Up_Bmp.Image);
      This.Up_Y.Set_Size ((Up_Bmp.Image.Size.W, Up_Bmp.Image.Size.H));
      This.Add_Child (This.Up_Y'Unchecked_Access, (450, 10));

      This.Down_M.Disable_Frame;
      This.Down_M.Disable_Background;
      This.Down_M.Set_Image (Down_Bmp.Image);
      This.Down_M.Set_Size ((Up_Bmp.Image.Size.W, Up_Bmp.Image.Size.H));
      This.Add_Child (This.Down_M'Unchecked_Access, (50, 370));

      This.Down_D.Disable_Frame;
      This.Down_D.Disable_Background;
      This.Down_D.Set_Image (Down_Bmp.Image);
      This.Down_D.Set_Size ((Up_Bmp.Image.Size.W, Up_Bmp.Image.Size.H));
      This.Add_Child (This.Down_D'Unchecked_Access, (250, 370));

      This.Down_Y.Disable_Frame;
      This.Down_Y.Disable_Background;
      This.Down_Y.Set_Image (Down_Bmp.Image);
      This.Down_Y.Set_Size ((Up_Bmp.Image.Size.W, Up_Bmp.Image.Size.H));
      This.Add_Child (This.Down_Y'Unchecked_Access, (450, 370));

      This.Set_Top_Image (ok_80x80.Image);
      This.Set_Icon_Image (calandar_80x80.Image);
      This.Set_Bottom_Image (cancel_80x80.Image);

      This.Set_Background (Black);
      This.Date.Set_Size (This.Date.Required_Size);
      This.Add_Child (This.Date'Unchecked_Access,
                      ((Size.W - This.Date.Get_Size.W) / 2,
                         (Size.H - This.Date.Get_Size.H) / 2));
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
      Date : HAL.Real_Time_Clock.RTC_Date;
   begin
      if On_Position_Event (Parent (This), Evt, Pos) then
         Date := This.Date.Get_Date;
         if This.Up_M.Active then
            This.Up_M.Set_Active (False);
            Date.Month := Next (Date.Month);
         elsif This.Down_M.Active then
            This.Down_M.Set_Active (False);
            Date.Month := Prev (Date.Month);
         elsif This.Up_D.Active then
            This.Up_D.Set_Active (False);
            Date.Day := Next (Date.Day);
         elsif This.Down_D.Active then
            This.Down_D.Set_Active (False);
            Date.Day := Prev (Date.Day);
         elsif This.Up_Y.Active then
            This.Up_Y.Set_Active (False);
            Date.Year := Next (Date.Year);
         elsif This.Down_Y.Active then
            This.Down_Y.Set_Active (False);
            Date.Year := Prev (Date.Year);
         end if;
         This.Date.Set_Date (Date);
         return True;
      else
         return False;
      end if;
   end On_Position_Event;

   --------------
   -- Set_Date --
   --------------

   procedure Set_Date
     (This : in out Instance;
      Date : HAL.Real_Time_Clock.RTC_Date)
   is
   begin
      This.Date.Set_Date (Date);
   end Set_Date;

   --------------
   -- Get_Date --
   --------------

   function Get_Date (This : Instance) return HAL.Real_Time_Clock.RTC_Date
   is (This.Date.Get_Date);

end Date_Select_Window;
