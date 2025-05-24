// Knockback handling
if (knockback_timer > 0) {
    knockback_timer--;
    x += knockback_x;
    y += knockback_y;

    // Clamp to room bounds (center origin version)
    var half_w = sprite_width * 0.5;
    var half_h = sprite_height * 0.5;
    x = clamp(x, half_w, room_width - half_w);
    y = clamp(y, half_h, room_height - half_h);

    path_end();
    exit;
}

// Check distance to nearest gorilla
if (instance_exists(OBJ_Gorilla)) {
    var gor = instance_nearest(x, y, OBJ_Gorilla);
    var dist = point_distance(x, y, gor.x, gor.y);
    var safe_dist = 64; // minimum distance to keep from gorilla (adjust as needed)
    var move_away_spd = 0.4; // speed to move away when too close (can be same or different from move_spd)

    if (dist < safe_dist) {
        // Calculate direction away from gorilla
        var dir_away = point_direction(gor.x, gor.y, x, y);
        // Move away slightly
        x += lengthdir_x(move_away_spd, dir_away);
        y += lengthdir_y(move_away_spd, dir_away);

		// Face the gorilla even while backing off
		facing = (gor.x > x) ? 1 : -1;
	
        // Optional: clamp position inside room
        var half_w = sprite_width * 0.5;
        var half_h = sprite_height * 0.5;
        x = clamp(x, half_w, room_width - half_w);
        y = clamp(y, half_h, room_height - half_h);


        // Early exit so they don’t also chase while backing off
        exit;
    }
}

switch(state){
	case states.IDLE:
		check_for_player();
		if path_index != 1 state = states.MOVE;
		check_facing();
		enemy_anim();
	break;
	case states.MOVE:
		check_for_player();
		check_facing();
		if path_index == 1 state = states.IDLE;
		enemy_anim();
	break;
	case states.DEAD:
	
	break;
}


if (global.is_leveling_up) {
    path_end();
}