if (global.is_leveling_up) {
    exit;
}

if (!instance_exists(OBJ_Gorilla)){
	instance_destroy()
	exit
}

image_angle += 10