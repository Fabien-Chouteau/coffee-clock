with Giza.Colors; use Giza.Colors;
with Dialog_Window; use Dialog_Window;

with ok_100x100;
with cancel_100x100;
with calandar_100x100;
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
      This.Up_M.Set_Image (Up_Bmp.Image'Access);
      This.Up_M.Set_Size ((Up_Bmp.Data.W, Up_Bmp.Data.H));
      This.Add_Child (This.Up_M'Unchecked_Access, (50, 10));

      This.Up_D.Disable_Frame;
      This.Up_D.Disable_Background;
      This.Up_D.Set_Image (Up_Bmp.Image'Access);
      This.Up_D.Set_Size ((Up_Bmp.Data.W, Up_Bmp.Data.H));
      This.Add_Child (This.Up_D'Unchecked_Access, (250, 10));

      This.Up_Y.Disable_Frame;
      This.Up_Y.Disable_Background;
      This.Up_Y.Set_Image (Up_Bmp.Image'Access);
      This.Up_Y.Set_Size ((Up_Bmp.Data.W, Up_Bmp.Data.H));
      This.Add_Child (This.Up_Y'Unchecked_Access, (450, 10));

      This.Down_M.Disable_Frame;
      This.Down_M.Disable_Background;
      This.Down_M.Set_Image (Down_Bmp.Image'Access);
      This.Down_M.Set_Size ((Up_Bmp.Data.W, Up_Bmp.Data.H));
      This.Add_Child (This.Down_M'Unchecked_Access, (50, 370));

      This.Down_D.Disable_Frame;
      This.Down_D.Disable_Background;
      This.Down_D.Set_Image (Down_Bmp.Image'Access);
      This.Down_D.Set_Size ((Up_Bmp.Data.W, Up_Bmp.Data.H));
      This.Add_Child (This.Down_D'Unchecked_Access, (250, 370));

      This.Down_Y.Disable_Frame;
      This.Down_Y.Disable_Background;
      This.Down_Y.Set_Image (Down_Bmp.Image'Access);
      This.Down_Y.Set_Size ((Up_Bmp.Data.W, Up_Bmp.Data.H));
      This.Add_Child (This.Down_Y'Unchecked_Access, (450, 370));

      This.Set_Top_Image (ok_100x100.Image'Access);
      This.Set_Icon_Image (calandar_100x100.Image'Access);
      This.Set_Bottom_Image (cancel_100x100.Image'Access);

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
      Day         : Date_Widget.Day_T;
      Day_Of_Week : Date_Widget.Day_Of_Week_T;
      Month       : Date_Widget.Month_T;
      Year        : Date_Widget.Year_T;
   begin
      if On_Position_Event (Parent (This), Evt, Pos) then
         This.Date.Get_Date (Day, Day_Of_Week, Month, Year);
         if This.Up_M.Active then
            This.Up_M.Set_Active (False);
            Month := Next (Month);
         elsif This.Down_M.Active then
            This.Down_M.Set_Active (False);
            Month := Prev (Month);
         elsif This.Up_D.Active then
            This.Up_D.Set_Active (False);
            Day := Next (Day);
         elsif This.Down_D.Active then
            This.Down_D.Set_Active (False);
            Day := Prev (Day);
         elsif This.Up_Y.Active then
            This.Up_Y.Set_Active (False);
            Year := Next (Year);
         elsif This.Down_Y.Active then
            This.Down_Y.Set_Active (False);
            Year := Prev (Year);
         end if;
         This.Date.Set_Date (Day, Day_Of_Week, Month, Year);
         return True;
      else
         return False;
      end if;
   end On_Position_Event;

   --------------
   -- Set_Date --
   --------------

   procedure Set_Date
     (This        : in out Instance;
      Day         : Date_Widget.Day_T;
      Day_Of_Week : Date_Widget.Day_Of_Week_T;
      Month       : Date_Widget.Month_T;
      Year        : Date_Widget.Year_T)
   is
   begin
      This.Date.Set_Date (Day, Day_Of_Week, Month, Year);
   end Set_Date;

   --------------
   -- Get_Date --
   --------------

   procedure Get_Date
     (This        : in out Instance;
      Day         : out Date_Widget.Day_T;
      Day_Of_Week : out Date_Widget.Day_Of_Week_T;
      Month       : out Date_Widget.Month_T;
      Year        : out Date_Widget.Year_T)
   is
   begin
      This.Date.Get_Date (Day, Day_Of_Week, Month, Year);
   end Get_Date;

end Date_Select_Window;
