with Giza.Widget.Button;
use Giza.Widget;

with Giza.Image;
with Giza.Events; use Giza.Events;
with Giza.Types; use Giza.Types;
with Dialog_Window;
with Clock_Widget;
with HAL.Real_Time_Clock;

package Time_Select_Window is

   subtype Parent is Dialog_Window.Instance;
   type Instance (Icon : Giza.Image.Ref) is new Parent (Panel_Size => 90)
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

   procedure Set_Time (This : in out Instance;
                       Time : HAL.Real_Time_Clock.RTC_Time);

   function Get_Time (This : Instance) return HAL.Real_Time_Clock.RTC_Time;

private

   type Instance (Icon : Giza.Image.Ref) is new Parent (Panel_Size => 90)
   with record
      Up_Hours, Down_Hours, Up_Minutes, Down_Minutes : aliased Button.Instance;
      Clock        : aliased Clock_Widget.Instance;
   end record;
end Time_Select_Window;
