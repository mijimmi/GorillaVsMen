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
        sprite_index = s_dead;
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

    // Update previous position for facing etc.
    xp = x;
    yp = y;
}


