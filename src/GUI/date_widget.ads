with Giza.Widget;
with Giza.Context;
with Giza.Types; use Giza.Types;

package Date_Widget is

   type Month_T is (January, February, March, April, May, June, July, August,
                    September, October, November, December);
   type Day_Of_Week_T is (Monday, Tuesday, Wednesday, Thursday, Friday,
                          Saturday, Sunday);
   type Day_T is range 1 .. 31;
   type Year_T is new Integer;

   function Next (Day_Of_Week : Day_Of_Week_T) return Day_Of_Week_T;
   function Prev (Day_Of_Week : Day_Of_Week_T) return Day_Of_Week_T;

   function Next (Month : Month_T) return Month_T;
   function Prev (Month : Month_T) return Month_T;

   function Next (Day : Day_T) return Day_T;
   function Prev (Day : Day_T) return Day_T;

   function Next (Year : Year_T) return Year_T;
   function Prev (Year : Year_T) return Year_T;

   subtype Parent is Giza.Widget.Instance;
   type Instance (Show_Day_Of_Week : Boolean) is new Parent with private;
   subtype Class is Instance'Class;
   type Ref is access all Class;

   overriding
   procedure Draw (This  : in out Instance;
                   Ctx   : in out Giza.Context.Class;
                   Force : Boolean := True);

   procedure Set_Date (This        : in out Instance;
                       Day         : Day_T;
                       Day_Of_Week : Day_Of_Week_T;
                       Month       : Month_T;
                       Year        : Year_T);

   procedure Get_Date (This        : in out Instance;
                       Day         : out Day_T;
                       Day_Of_Week : out Day_Of_Week_T;
                       Month       : out Month_T;
                       Year        : out Year_T);

   function Required_Size (This : Instance) return Size_T;
private

   type Instance (Show_Day_Of_Week : Boolean) is new Parent with record
      Day         : Day_T := 1;
      Day_Of_Week : Day_Of_Week_T := Monday;
      Month       : Month_T := January;
      Year        : Year_T := 1987;
   end record;

end Date_Widget;
