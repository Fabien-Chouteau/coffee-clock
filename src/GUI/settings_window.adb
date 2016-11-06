with Giza.Window; use Giza.Window;
with calandar_80x80;
with ok_80x80;
with Giza.GUI;
with Dialog_Window; use Dialog_Window;
with Ada.Text_IO; use Ada.Text_IO;

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
   begin
      if This.Select_Alarm.Get_Answer = Answer_Top then
         Put_Line ("We have a new alarm");
         This.Select_Alarm.Clear_Answer;
      end if;
      if This.Select_Clock.Get_Answer = Answer_Top then
         Put_Line ("We have a new Clock");
         This.Select_Clock.Clear_Answer;
      end if;
      if This.Select_Date.Get_Answer = Answer_Top then
         Put_Line ("We have a new Date");
         This.Select_Date.Clear_Answer;
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
            Giza.GUI.Push (This.Select_Alarm'Unchecked_Access);
         elsif This.Clock.Active then
            This.Clock.Set_Active (False);
            Giza.GUI.Push (This.Select_Clock'Unchecked_Access);
         elsif This.Calandar.Active then
            This.Calandar.Set_Active (False);
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
