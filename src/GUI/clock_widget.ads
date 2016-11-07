with Giza.Widget;
with Giza.Context;
with Giza.Types; use Giza.Types;
with HAL.Real_Time_Clock;

package Clock_Widget is

   subtype Parent is Giza.Widget.Instance;
   type Instance is new Parent with private;
   subtype Class is Instance'Class;
   type Ref is access all Class;

   overriding
   procedure Draw (This  : in out Instance;
                   Ctx   : in out Giza.Context.Class;
                   Force : Boolean := True);

   procedure Set_Time (This : in out Instance;
                       Time : HAL.Real_Time_Clock.RTC_Time);

   function Get_Time (This : Instance) return HAL.Real_Time_Clock.RTC_Time;

   function Required_Size (This : Instance) return Size_T;
private

   type Instance is new Parent with record
      Time : HAL.Real_Time_Clock.RTC_Time;
   end record;

end Clock_Widget;
