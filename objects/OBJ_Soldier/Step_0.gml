if (is_hurt) {
    hurt_timer--;
    if (hurt_timer <= 0) {
        is_hurt = false;
        hurt_timer = 0;
    }
}

switch(state){
	case states.IDLE:
		check_for_player();
		if path_index != 1 state = states.MOVE;
		enemy_anim();
	break;
	case states.MOVE:
		check_for_player();
		check_facing();
		if path_index == 1 state = states.IDLE;
		enemy_anim();
	break;
	case states.DEAD:
	    death_timer++;
	    path_end();
	    speed = 0;

	    enemy_anim(); // <- Add this to apply the dead sprite

	    if (death_timer > death_duration) {
	        instance_destroy();
	    }
	break;
}



if (global.is_leveling_up) {
    path_end();
}



if (global.is_leveling_up) {
    path_end();
}

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
