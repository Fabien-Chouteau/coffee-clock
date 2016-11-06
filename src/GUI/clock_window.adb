with Giza.GUI;
with Giza.Colors; use Giza.Colors;
with Giza.Window; use Giza.Window;
with Giza.Image.Procedural;

package body Clock_Window is

   procedure Draw_Menu_Icon (Ctx  : in out Giza.Context.Class;
                             Size : Size_T);

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
   end On_Init;

   ------------------
   -- On_Displayed --
   ------------------

   overriding procedure On_Displayed
     (This : in out Instance)
   is
   begin
      null;
   end On_Displayed;

   ---------------
   -- On_Hidden --
   ---------------

   overriding procedure On_Hidden
     (This : in out Instance)
   is
   begin
      null;
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

   procedure Set_Time (This    : in out Instance;
                       Hours   : Clock_Widget.Clock_Hour;
                       Minutes : Clock_Widget.Clock_Minute)
   is
   begin
      This.Clock.Set_Time (Hours, Minutes);
   end Set_Time;

   --------------
   -- Set_Date --
   --------------

   procedure Set_Date (This        : in out Instance;
                       Day         : Date_Widget.Day_T;
                       Day_Of_Week : Date_Widget.Day_Of_Week_T;
                       Month       : Date_Widget.Month_T;
                       Year        : Date_Widget.Year_T)
   is
   begin
      This.Date.Set_Date (Day, Day_Of_Week, Month, Year);
   end Set_Date;
end Clock_Window;
