with GUI; use GUI;
with STM32.Device;
with Alarm_Handling;

procedure Main is
begin
   STM32.Device.RTC.Enable;
   GUI.Initialize;
   --  Alarm_Handling.Set_Alarm_Action ();
   Alarm_Handling.Start;
   GUI.Start;
end Main;
