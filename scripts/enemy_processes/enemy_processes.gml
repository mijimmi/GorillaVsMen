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
        // Destroy melee hitbox if it exists
        if (instance_exists(melee_hitbox)) {
            instance_destroy(melee_hitbox);
        }

        // Destroy sword instance if it exists
		if (variable_instance_exists(id, "sword_inst")) {
		    if (instance_exists(sword_inst)) {
		        instance_destroy(sword_inst);
		    }
		}
		if (variable_instance_exists(id, "spear_inst")) {
		    if (instance_exists(spear_inst)) {
		        instance_destroy(spear_inst);
		    }
		}
		if (variable_instance_exists(id, "bow_inst")) {
		    if (instance_exists(bow_inst)) {
		        instance_destroy(bow_inst);
		    }
		}

	 if (sprite_index != s_dead_selected) {
	    // Select death sprite
	    if (is_array(s_dead)) {
	        s_dead_selected = s_dead[irandom(array_length(s_dead) - 1)];
	    } else {
	        s_dead_selected = s_dead;
	    }
		with (OBJ_CameraController) {
		shake_timer = 2;
	    shake_magnitude = 1.5;
	    }
	    sprite_index = s_dead_selected;
	    image_index = 0;
	    image_speed = 1; // adjust as needed
		
			
	    // Blood burst effect
		var _dir = point_direction(x, y, OBJ_Gorilla.x, OBJ_Gorilla.y) + 180;
		var instance_blood = instance_create_depth(x, y, depth, obj_Particles);

		instance_blood.set_size(0.04, 0.05);
		instance_blood.set_sprite(SPR_Blood, false, false, true);
		instance_blood.set_orientation(0, 360);
		var dark_red = make_color_rgb(150, 0, 0);
		instance_blood.set_color(dark_red);
		instance_blood.set_alpha(1, 0);
		instance_blood.set_direction(_dir - 40, _dir + 40);
		instance_blood.set_speed(5, 10, -1);
		instance_blood.set_life(240, 360);
		instance_blood.burst(30);
		instance_blood.set_blend(false);

	    // Play random death sound with random pitch and reduced volume
	    var _snd = choose(SND_Flesh, SND_Flesh2);
	    var _snd_inst = audio_play_sound(_snd, 1, false);
	    audio_sound_pitch(_snd_inst, random_range(0.8, 1.2));
	    audio_sound_gain(_snd_inst, 0.5, 0); // volume: 0.0 (mute) to 1.0
		
	}

        if (image_index >= image_number - 1) {
            instance_destroy(); // or cleanup
        }

        return;
    }

		if (is_hurt) {
			sprite_index = s_hurt;
			image_speed = 0.05;

			if (!has_played_hurt_sound) {
			    var _snd_hrt = audio_play_sound(SND_Hit, 1, false);
			    audio_sound_pitch(_snd_hrt, random_range(0.8, 1.2));
			    audio_sound_gain(_snd_hrt, 0.3, 0);
			    has_played_hurt_sound = true;
			}
			
			with (OBJ_CameraController) {
			shake_timer = 2;
	        shake_magnitude = 1.5;
	        }
			
			return;
		} else {
			has_played_hurt_sound = false; // reset if not hurt anymore
		}

    switch (state) {
        case states.IDLE:
        case states.MOVE:
            sprite_index = s_moveORidle;
            image_speed = 1;
            break;
    }

    xp = x;
    yp = y;
}