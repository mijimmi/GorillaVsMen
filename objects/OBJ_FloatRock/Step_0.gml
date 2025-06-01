if (global.is_leveling_up == true) {
	exit}
	
if (!instance_exists(OBJ_Gorilla)){
	instance_destroy()
	exit
}


if (!instance_exists(owner)) {
	instance_destroy()
}

angle += orbit_speed
x = owner.x + lengthdir_x(radius, angle)
y = owner.y + lengthdir_y(radius, angle)