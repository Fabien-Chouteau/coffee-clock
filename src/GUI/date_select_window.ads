with Giza.Widget.Button;
use Giza.Widget;

with Giza.Events; use Giza.Events;
with Giza.Types; use Giza.Types;
with Dialog_Window;
with Date_Widget;
with HAL.Real_Time_Clock;

package Date_Select_Window is

   subtype Parent is Dialog_Window.Instance;
   type Instance is new Parent (Panel_Size => 90)
   with private;

   subtype Class is Instance'Class;
   type Ref is access all Class;

   overriding
   procedure On_Init (This : in out Instance);
   overriding
   procedure On_Displayed (This : in out Instance);
   overriding
   procedure On_Hidden (This : in out Instance);

   overriding
   function On_Position_Event
     (This  : in out Instance;
      Evt   : Position_Event_Ref;
      Pos   : Point_T)
      return Boolean;

   procedure Set_Date (This : in out Instance;
                       Date : HAL.Real_Time_Clock.RTC_Date);

   function Get_Date (This : Instance) return HAL.Real_Time_Clock.RTC_Date;

private

   type Instance is new Parent (Panel_Size => 90)
   with record
      Up_M, Down_M, Up_D, Down_D, Up_Y, Down_Y : aliased Button.Instance;
      Date : aliased Date_Widget.Instance (Show_Day_Of_Week => False);
   end record;
end Date_Select_Window;
