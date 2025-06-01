/// @description poop alarm

event_user(4)
poop_count += 1

if (poop_count < global.poop_max){
	alarm[4] = global.poopTiming
}
else {
	poop_count = 0
	alarm[4] = global.poopAlarm
}
