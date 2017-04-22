with GUI; use GUI;
with STM32.Device;
with Alarm_Handling;
with Coffee_Maker;
procedure Main is

begin
   Coffee_Maker.Initialize;
   STM32.Device.RTC.Enable;
   GUI.Initialize;
   Alarm_Handling.Set_Alarm_Action (Coffee_Maker.Make_Coffee'Access);
   Alarm_Handling.Start;
   GUI.Start;
end Main;
