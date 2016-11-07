with Giza.Colors; use Giza.Colors;
with Giza.Bitmap_Fonts.FreeSansBold18pt7b;

package body Date_Widget is

   package Selected_Font renames Giza.Bitmap_Fonts.FreeSansBold18pt7b;

   function Image (Day_Of_Week : RTC_Day_Of_Week) return String;
   function Image (Month : RTC_Month) return String;
   function Image (Day : RTC_Day) return String;
   function Image (Year : RTC_Year) return String;

   ----------
   -- Next --
   ----------

   function Next (Day_Of_Week : RTC_Day_Of_Week) return RTC_Day_Of_Week is
   begin
      if Day_Of_Week = RTC_Day_Of_Week'Last then
         return RTC_Day_Of_Week'First;
      else
         return RTC_Day_Of_Week'Succ (Day_Of_Week);
      end if;
   end Next;

   ----------
   -- Prev --
   ----------

   function Prev (Day_Of_Week : RTC_Day_Of_Week) return RTC_Day_Of_Week is
   begin
      if Day_Of_Week = RTC_Day_Of_Week'First then
         return RTC_Day_Of_Week'Last;
      else
         return RTC_Day_Of_Week'Pred (Day_Of_Week);
      end if;
   end Prev;

   ----------
   -- Next --
   ----------

   function Next (Month : RTC_Month) return RTC_Month is
   begin
      if Month = RTC_Month'Last then
         return RTC_Month'First;
      else
         return RTC_Month'Succ (Month);
      end if;
   end Next;

   ----------
   -- Prev --
   ----------

   function Prev (Month : RTC_Month) return RTC_Month is
   begin
      if Month = RTC_Month'First then
         return RTC_Month'Last;
      else
         return RTC_Month'Pred (Month);
      end if;
   end Prev;

   ----------
   -- Next --
   ----------

   function Next (Day : RTC_Day) return RTC_Day is
   begin
      if Day = RTC_Day'Last then
         return RTC_Day'First;
      else
         return RTC_Day'Succ (Day);
      end if;
   end Next;

   ----------
   -- Prev --
   ----------

   function Prev (Day : RTC_Day) return RTC_Day is
   begin
      if Day = RTC_Day'First then
         return RTC_Day'Last;
      else
         return RTC_Day'Pred (Day);
      end if;
   end Prev;

   ----------
   -- Next --
   ----------

   function Next (Year : RTC_Year) return RTC_Year is
   begin
      if Year = RTC_Year'Last then
         return RTC_Year'First;
      else
         return RTC_Year'Succ (Year);
      end if;
   end Next;

   ----------
   -- Prev --
   ----------

   function Prev (Year : RTC_Year) return RTC_Year is
   begin
      if Year = RTC_Year'First then
         return RTC_Year'Last;
      else
         return RTC_Year'Pred (Year);
      end if;
   end Prev;

   -----------
   -- Image --
   -----------

   function Image (Day_Of_Week : RTC_Day_Of_Week) return String is
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

   function Image (Month : RTC_Month) return String is
     (case Month is
         when January   => "January",
         when February  => "February",
         when March     => "March",
         when April     => "April",
         when May       => "May",
         when June      => "June",
         when July      => "July",
         when August    => "August",
         when September => "September",
         when October   => "October",
         when November  => "November",
         when December  => "December");

   -----------
   -- Image --
   -----------

   function Image (Day : RTC_Day) return String is
   begin
      return Day'Img & (case Day is
                           when 1 | 21 | 31 => "st",
                           when 2 | 22 => "nd",
                           when 3 | 23 => "rd",
                           when others => "th");
   end Image;

   -----------
   -- Image --
   -----------

   function Image (Year : RTC_Year) return String is
      Str : constant String := Year'Img;
   begin
      --  Remove the whitespace prefix of Ada's 'Image...
      return (if Year < 10 then "200" else "20") &
        Str (Str'First + 1 .. Str'Last);
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
              Image (This.Date.Day_Of_Week) & ", "
         else "") &
           Image (This.Date.Month) &
           Image (This.Date.Day) & ", " &
           Image (This.Date.Year),
         ((0, 0), This.Get_Size));
   end Draw;

   --------------
   -- Set_Date --
   --------------

   procedure Set_Date
     (This : in out Instance;
      Date : HAL.Real_Time_Clock.RTC_Date)
   is
   begin
      This.Date := Date;
      This.Set_Dirty;
   end Set_Date;

   --------------
   -- Get_Date --
   --------------

   function Get_Date
     (This : Instance)
     return HAL.Real_Time_Clock.RTC_Date
   is (This.Date);

   -------------------
   -- Required_Size --
   -------------------

   function Required_Size (This : Instance) return Size_T is
      pragma Unreferenced (This);
   begin
      return (400, 100);
   end Required_Size;

end Date_Widget;
