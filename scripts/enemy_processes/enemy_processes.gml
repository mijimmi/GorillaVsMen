function check_facing(){
	var _facing = sign(x - xp);
	if _facing != 0 facing = _facing;
	
}

function check_for_player(){
// check if player is close to start chasing
	var _dis = distance_to_object(OBJ_Gorilla);
	if ((_dis <= alert_dis) or alert)and _dis > attack_dis {
		alert = true;
		
	
		if calc_path_timer-- <= 0 {
			//reset timer
			calc_path_timer = calc_path_delay;
			//path TO the player
			var _found_player = mp_grid_path(global.mp_grid, path, x, y , OBJ_Gorilla.x, OBJ_Gorilla.y, choose(0,1));
			//start path if enemy reaches player
			if _found_player{
					path_start(path, move_spd, path_action_stop, false);
			}
		}
	} else {
		if _dis <= attack_dis {
			path_end();
		}
	}
}

function enemy_anim() {
    if (state == states.DEAD) {
    if (sprite_index != s_dead_selected) {
        if (is_array(s_dead)) {
            s_dead_selected = s_dead[irandom(array_length(s_dead) - 1)];
        } else {
            s_dead_selected = s_dead;
        }
        sprite_index = s_dead_selected;
        image_index = 0;
        image_speed = 1; // adjust as needed
    }

    if (image_index >= image_number - 1) {
        instance_destroy(); // or cleanup
    }

    return;
}

    if (is_hurt) {
        sprite_index = s_hurt;
        image_speed = 0.3;
        return;
    }

    switch (state) {
        case states.IDLE:
        case states.MOVE:
            sprite_index = s_moveORidle;
            break;
    }

    xp = x;
    yp = y;
}

