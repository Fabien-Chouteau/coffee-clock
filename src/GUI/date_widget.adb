with Giza.Colors; use Giza.Colors;
with Giza.Bitmap_Fonts.FreeSansBold18pt7b;

package body Date_Widget is

   package Selected_Font renames Giza.Bitmap_Fonts.FreeSansBold18pt7b;

   function Image (Day_Of_Week : Day_Of_Week_T) return String;
   function Image (Month : Month_T) return String;
   function Image (Day : Day_T) return String;

   ----------
   -- Next --
   ----------

   function Next (Day_Of_Week : Day_Of_Week_T) return Day_Of_Week_T is
   begin
      if Day_Of_Week = Day_Of_Week_T'Last then
         return Day_Of_Week_T'First;
      else
         return Day_Of_Week_T'Succ (Day_Of_Week);
      end if;
   end Next;

   ----------
   -- Prev --
   ----------

   function Prev (Day_Of_Week : Day_Of_Week_T) return Day_Of_Week_T is
   begin
      if Day_Of_Week = Day_Of_Week_T'First then
         return Day_Of_Week_T'Last;
      else
         return Day_Of_Week_T'Pred (Day_Of_Week);
      end if;
   end Prev;

   ----------
   -- Next --
   ----------

   function Next (Month : Month_T) return Month_T is
   begin
      if Month = Month_T'Last then
         return Month_T'First;
      else
         return Month_T'Succ (Month);
      end if;
   end Next;

   ----------
   -- Prev --
   ----------

   function Prev (Month : Month_T) return Month_T is
   begin
      if Month = Month_T'First then
         return Month_T'Last;
      else
         return Month_T'Pred (Month);
      end if;
   end Prev;

   ----------
   -- Next --
   ----------

   function Next (Day : Day_T) return Day_T is
   begin
      if Day = Day_T'Last then
         return Day_T'First;
      else
         return Day_T'Succ (Day);
      end if;
   end Next;

   ----------
   -- Prev --
   ----------

   function Prev (Day : Day_T) return Day_T is
   begin
      if Day = Day_T'First then
         return Day_T'Last;
      else
         return Day_T'Pred (Day);
      end if;
   end Prev;

   ----------
   -- Next --
   ----------

   function Next (Year : Year_T) return Year_T is
   begin
      if Year = Year_T'Last then
         return Year_T'First;
      else
         return Year_T'Succ (Year);
      end if;
   end Next;

   ----------
   -- Prev --
   ----------

   function Prev (Year : Year_T) return Year_T is
   begin
      if Year = Year_T'First then
         return Year_T'Last;
      else
         return Year_T'Pred (Year);
      end if;
   end Prev;

   -----------
   -- Image --
   -----------

   function Image (Day_Of_Week : Day_Of_Week_T) return String is
     (case Day_Of_Week is
         when Monday    => "Monday",
         when Tuesday   => "Tuesday",
         when Wednesday => "Wednesday",
         when Thursday  => "Thursday",
         when Friday    => "Friday",
         when Saturday  => "Saturday",
         when Sunday    => "Sunday");

   -----------
   -- Image --
   -----------

   function Image (Month : Month_T) return String is
     (case Month is
         when January   => "Jan",
         when February  => "Feb",
         when March     => "Mar",
         when April     => "Apr",
         when May       => "May",
         when June      => "Jun",
         when July      => "Jul",
         when August    => "Aug",
         when September => "Sep",
         when October   => "Oct",
         when November  => "Nov",
         when December  => "Dec");

   -----------
   -- Image --
   -----------

   function Image (Day : Day_T) return String is
   begin
      return Day'Img & (case Day is
                           when 1 => "st",
                           when 2 => "nd",
                           when 3 => "rd",
                           when others => "th");
   end Image;

   ----------
   -- Draw --
   ----------

   overriding procedure Draw
     (This  : in out Instance;
      Ctx   : in out Giza.Context.Class;
      Force : Boolean := True)
   is
   begin
      if not This.Dirty and then not Force then
         return;
      end if;

      Ctx.Set_Color (Black);
      Ctx.Fill_Rectangle (((0, 0), This.Get_Size));

      Ctx.Set_Font (Selected_Font.Font);
      Ctx.Set_Color (Red);
      Ctx.Print_In_Rect
        ((if This.Show_Day_Of_Week then
              Image (This.Day_Of_Week) & ", "
         else "") &
           Image (This.Month) &
           Image (This.Day) & "," &
           This.Year'Img,
         ((0, 0), This.Get_Size));
   end Draw;

   --------------
   -- Set_Date --
   --------------

   procedure Set_Date
     (This        : in out Instance;
      Day         : Day_T;
      Day_Of_Week : Day_Of_Week_T;
      Month       : Month_T;
      Year        : Year_T)
   is
   begin
      This.Day         := Day;
      This.Day_Of_Week := Day_Of_Week;
      This.Month       := Month;
      This.Year        := Year;
      This.Set_Dirty;
   end Set_Date;

   --------------
   -- Get_Date --
   --------------

   procedure Get_Date
     (This        : in out Instance;
      Day         : out Day_T;
      Day_Of_Week : out Day_Of_Week_T;
      Month       : out Month_T;
      Year        : out Year_T)
   is
   begin
      Day         := This.Day;
      Day_Of_Week := This.Day_Of_Week;
      Month       := This.Month;
      Year        := This.Year;
   end Get_Date;

   -------------------
   -- Required_Size --
   -------------------

   function Required_Size (This : Instance) return Size_T is
      pragma Unreferenced (This);
   begin
      return (400, 100);
   end Required_Size;

end Date_Widget;
