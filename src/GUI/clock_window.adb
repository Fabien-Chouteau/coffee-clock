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

with Giza.GUI;
with Giza.Colors; use Giza.Colors;
with Giza.Window; use Giza.Window;
with Giza.Image.Procedural;
with Giza.Timers;
with Ada.Real_Time; use Ada.Real_Time;
with Real_Time_Clock;

package body Clock_Window is

   type Repeat_Event is new Timer_Event with record
      Repeat_Time : Time_Span := Milliseconds (500);
      Redraw      : aliased Giza.Events.Redraw_Event;
      Enabled     : Boolean := False;
   end record;

   overriding
   function Triggered (This : Repeat_Event) return Boolean;

   procedure Draw_Menu_Icon (Ctx  : in out Giza.Context.Class;
                             Size : Size_T);

   Redraw_Timer : aliased Repeat_Event;

   ---------------
   -- Triggered --
   ---------------

   overriding
   function Triggered (This : Repeat_Event) return Boolean is
   begin
      if This.Enabled then
         Giza.GUI.Emit (This.Redraw'Unchecked_Access);
      end if;

      Giza.Timers.Set_Timer (This'Unchecked_Access,
                             Clock + This.Repeat_Time);
      return True;
   end Triggered;

   --------------------
   -- Draw_Menu_Icon --
   --------------------

   procedure Draw_Menu_Icon (Ctx  : in out Giza.Context.Class;
                             Size : Size_T) is
      pragma Unreferenced (Size);

      Rect_Size : constant Size_T := (40, 6);
   begin
      Ctx.Set_Color (White);
      Ctx.Fill_Rectangle (((5, 5), Rect_Size));
      Ctx.Fill_Rectangle (((5, 20), Rect_Size));
      Ctx.Fill_Rectangle (((5, 35), Rect_Size));
   end Draw_Menu_Icon;

   -------------
   -- On_Init --
   -------------

   overriding procedure On_Init
     (This : in out Instance)
   is
      Size : constant Size_T := This.Get_Size;
   begin
      This.Set_Background (Black);

      This.Settings_Btn.Set_Size ((100, 100));
      This.Settings_Btn.Set_Image (new Giza.Image.Procedural.Instance
                                   (Draw_Menu_Icon'Access, 50, 50));
      This.Settings_Btn.Disable_Frame;
      This.Settings_Btn.Disable_Background;

      This.Add_Child (This.Settings_Btn'Unchecked_Access,
                      (Size.W - 125, 25));

      This.Clock.Set_Size (This.Clock.Required_Size);
      This.Add_Child (This.Clock'Unchecked_Access,
                      ((Size.W - This.Clock.Get_Size.W) / 2,
                       (Size.H - This.Clock.Get_Size.H) / 2));

      This.Date.Set_Size (This.Date.Required_Size);
      This.Add_Child (This.Date'Unchecked_Access,
                      ((Size.W - This.Date.Get_Size.W) / 2,
                       (Size.H - This.Date.Get_Size.H)));

      --  Start the redraw timer
      Giza.Timers.Set_Timer (Redraw_Timer'Unchecked_Access,
                             Clock + Redraw_Timer.Repeat_Time);
   end On_Init;

   ------------------
   -- On_Displayed --
   ------------------

   overriding procedure On_Displayed
     (This : in out Instance)
   is
      pragma Unreferenced (This);
   begin
      Redraw_Timer.Enabled := True;
   end On_Displayed;

   ---------------
   -- On_Hidden --
   ---------------

   overriding procedure On_Hidden
     (This : in out Instance)
   is
      pragma Unreferenced (This);
   begin
      Redraw_Timer.Enabled := False;
   end On_Hidden;

   ----------
   -- Draw --
   ----------

   overriding
   procedure Draw (This  : in out Instance;
                   Ctx   : in out Giza.Context.Class;
                   Force : Boolean := False)
   is
   begin
      This.Clock.Set_Time (Real_Time_Clock.Get_Time);
      This.Date.Set_Date (Real_Time_Clock.Get_Date);
      Draw (Parent (This), Ctx, Force);
   end Draw;

   -----------------------
   -- On_Position_Event --
   -----------------------

   overriding
   function On_Position_Event
     (This  : in out Instance;
      Evt   : Position_Event_Ref;
      Pos   : Point_T)
      return Boolean
   is
   begin
      if On_Position_Event (Parent (This), Evt, Pos)
        and then
          This.Settings_Btn.Active
      then
         This.Settings_Btn.Set_Active (False);
         Giza.GUI.Push (This.Settings'Unchecked_Access);
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
   -- Set_Date --
   --------------

   procedure Set_Date (This : in out Instance;
                       Date : HAL.Real_Time_Clock.RTC_Date)
   is
   begin
      This.Date.Set_Date (Date);
   end Set_Date;
end Clock_Window;
