with Basic_Test_Window; use Basic_Test_Window;
with Giza.Widget.Button;
with Giza.Widget.Tiles;
use Giza.Widget;
with Giza.Events; use Giza.Events;
with Giza.Types; use Giza.Types;
with Time_Select_Window;
with Date_Select_Window;
with alarm_80x80;
with clock_80x80;

package Settings_Window is

   subtype Parent is Basic_Test_Window.Test_Window;
   type Instance is new Parent with private;
   subtype Class is Instance'Class;
   type Ref is access all Class;

   overriding
   procedure On_Init (This : in out Instance);

   overriding
   procedure On_Displayed (This : in out Instance);

   overriding
   procedure On_Hidden (This : in out Instance) is null;

   overriding
   function On_Position_Event
     (This  : in out Instance;
      Evt   : Position_Event_Ref;
      Pos   : Point_T)
      return Boolean;

private

   type Instance is new Parent with record
      Alarm, Clock, Calandar, Back : aliased Button.Instance;
      Tile : aliased Tiles.Instance (4, Tiles.Left_Right);
      Select_Alarm : aliased Time_Select_Window.Instance
        (alarm_80x80.Image'Access);
      Select_Clock : aliased Time_Select_Window.Instance
        (clock_80x80.Image'Access);
      Select_Date  : aliased Date_Select_Window.Instance;
   end record;
end Settings_Window;
