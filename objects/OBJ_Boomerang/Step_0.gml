if (global.is_leveling_up) {
	exit
}

image_angle += 10

var dist = point_distance(x,y, start_x, start_y)

if (!returning && dist >= max_distance){
	returning = true;
}

if (returning) {
	if (instance_exists(OBJ_Gorilla)){
		var gor = OBJ_Gorilla
		direction = point_direction(x,y, gor.x, gor.y)
	}
	else {
		direction = direction
	}
}

if (returning && point_distance(x,y, owner_ID.x, owner_ID.y) < 10) {
	instance_destroy()
}

//changes speed depending on the state of the thing
if (returning) {
    speed = lerp(speed, 6, 0.05); // accelerate toward gorilla
} else {
    speed = lerp(speed, 4, 0.05); // normal outgoing speed
}