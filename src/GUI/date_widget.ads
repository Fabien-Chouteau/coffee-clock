with Giza.Widget;
with Giza.Context;
with Giza.Types; use Giza.Types;
with HAL.Real_Time_Clock; use HAL.Real_Time_Clock;

package Date_Widget is

   function Next (Day_Of_Week : RTC_Day_Of_Week) return RTC_Day_Of_Week;
   function Prev (Day_Of_Week : RTC_Day_Of_Week) return RTC_Day_Of_Week;

   function Next (Month : RTC_Month) return RTC_Month;
   function Prev (Month : RTC_Month) return RTC_Month;

   function Next (Day : RTC_Day) return RTC_Day;
   function Prev (Day : RTC_Day) return RTC_Day;

   function Next (Year : RTC_Year) return RTC_Year;
   function Prev (Year : RTC_Year) return RTC_Year;

   subtype Parent is Giza.Widget.Instance;
   type Instance (Show_Day_Of_Week : Boolean) is new Parent with private;
   subtype Class is Instance'Class;
   type Ref is access all Class;

   overriding
   procedure Draw (This  : in out Instance;
                   Ctx   : in out Giza.Context.Class;
                   Force : Boolean := True);

   procedure Set_Date (This : in out Instance;
                       Date : HAL.Real_Time_Clock.RTC_Date);

   function Get_Date (This : Instance)
                       return HAL.Real_Time_Clock.RTC_Date;

   function Required_Size (This : Instance) return Size_T;
private

   type Instance (Show_Day_Of_Week : Boolean) is new Parent with record
      Date : HAL.Real_Time_Clock.RTC_Date;
   end record;

end Date_Widget;
