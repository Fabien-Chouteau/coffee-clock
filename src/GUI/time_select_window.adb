with ok_100x100;
with cancel_100x100;
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
      This.Up_Hours.Set_Image (up_200x100.Image'Access);
      This.Up_Hours.Set_Size ((200, 100));
      This.Add_Child (This.Up_Hours'Unchecked_Access, (75, 10));

      This.Up_Minutes.Disable_Frame;
      This.Up_Minutes.Disable_Background;
      This.Up_Minutes.Set_Image (up_200x100.Image'Access);
      This.Up_Minutes.Set_Size ((200, 100));
      This.Add_Child (This.Up_Minutes'Unchecked_Access, (450, 10));

      This.Down_Hours.Disable_Frame;
      This.Down_Hours.Disable_Background;
      This.Down_Hours.Set_Image (down_200x100.Image'Access);
      This.Down_Hours.Set_Size ((200, 100));
      This.Add_Child (This.Down_Hours'Unchecked_Access, (75, 370));

      This.Down_Minutes.Disable_Frame;
      This.Down_Minutes.Disable_Background;
      This.Down_Minutes.Set_Image (down_200x100.Image'Access);
      This.Down_Minutes.Set_Size ((200, 100));
      This.Add_Child (This.Down_Minutes'Unchecked_Access, (450, 370));

      This.Set_Top_Image (ok_100x100.Image'Access);
      This.Set_Icon_Image (This.Icon);
      This.Set_Bottom_Image (cancel_100x100.Image'Access);

      This.Clock.Set_Time (0, 0);
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
      use type Clock_Widget.Clock_Hour;
      use type Clock_Widget.Clock_Minute;
      Hours   : Clock_Widget.Clock_Hour;
      Minutes : Clock_Widget.Clock_Minute;
   begin
      if On_Position_Event (Parent (This), Evt, Pos) then
         This.Clock.Get_Time (Hours, Minutes);
         if This.Up_Hours.Active then
            This.Up_Hours.Set_Active (False);
            Hours := Hours + 1;
         elsif This.Down_Hours.Active then
            This.Down_Hours.Set_Active (False);
            Hours := Hours - 1;
         elsif This.Up_Minutes.Active then
            This.Up_Minutes.Set_Active (False);
            Minutes := Minutes + 1;
         elsif This.Down_Minutes.Active then
            This.Down_Minutes.Set_Active (False);
            Minutes := Minutes - 1;
         end if;
         This.Clock.Set_Time (Hours, Minutes);
         return True;
      else
         return False;
      end if;
   end On_Position_Event;

   --------------
   -- Set_Time --
   --------------

   procedure Set_Time (This    : in out Instance;
                       Hours   : Clock_Widget.Clock_Hour;
                       Minutes : Clock_Widget.Clock_Minute)
   is
   begin
      This.Clock.Set_Time (Hours, Minutes);
   end Set_Time;

   --------------
   -- Get_Time --
   --------------

   procedure Get_Time (This    : Instance;
                       Hours   : out Clock_Widget.Clock_Hour;
                       Minutes : out Clock_Widget.Clock_Minute)
   is
   begin
      This.Clock.Get_Time (Hours, Minutes);
   end Get_Time;

end Time_Select_Window;
