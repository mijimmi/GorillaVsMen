/// @description dart burst



event_user(3)
dart_count += 1 

if (dart_count < global.dart_max){
	alarm[3] = global.dartTiming
}
else {
	dart_count = 0
	alarm[3] = global.dartAlarm
}

