

// === Apply Knockback Over Time ===
if (knockback_timer > 0) {
    var kbx = knockback_x / knockback_timer;
    var kby = knockback_y / knockback_timer;

    var tilemap = layer_tilemap_get_id("WallLayer");
    
    // Apply knockback movement with tile collision checks
    if (tilemap_get_at_pixel(tilemap, x + kbx, y) == 0) {
        x += kbx;
    }
    if (tilemap_get_at_pixel(tilemap, x, y + kby) == 0) {
        y += kby;
    }

    knockback_timer--;
}

//if the level manager is currently onscreen, do NOT read player input.
if(instance_exists(OBJ_LevelManager)) {exit;}

// === Read Input Keys ===
var right_key = keyboard_check(vk_right) || keyboard_check(ord("D"));
var left_key  = keyboard_check(vk_left)  || keyboard_check(ord("A"));	
var up_key    = keyboard_check(vk_up)    || keyboard_check(ord("W"));
var down_key  = keyboard_check(vk_down)  || keyboard_check(ord("S"));

// === Calculate Intended Movement ===
var xdir = right_key - left_key;
var ydir = down_key - up_key;

// === Tutorial Logic ===
// Check if player has moved (WASD input)
if (show_move_tutorial && (right_key || left_key || up_key || down_key)) {
    show_move_tutorial = false;
}

// Check if player has attacked (left click)
if (show_attack_tutorial && mouse_check_button_pressed(mb_left)) {
    show_attack_tutorial = false;
}

// Fade out tutorials
if (!show_move_tutorial && move_tutorial_alpha > 0) {
    move_tutorial_alpha -= tutorial_fade_speed;
    if (move_tutorial_alpha < 0) move_tutorial_alpha = 0;
}

if (!show_attack_tutorial && attack_tutorial_alpha > 0) {
    attack_tutorial_alpha -= tutorial_fade_speed;
    if (attack_tutorial_alpha < 0) attack_tutorial_alpha = 0;
}
//pause logic
if (global.is_leveling_up) {
    exit;
}

// Normalize movement to prevent faster diagonal speed
var magnitude = point_distance(0, 0, xdir, ydir);
if (magnitude > 0) {
    xdir /= magnitude;
    ydir /= magnitude;
}

xspd = xdir * move_spd;
yspd = ydir * move_spd;

// === Cooldown Timer ===
if (smash_cooldown > 0) {
    smash_cooldown--;
}

// === Check for Smash Input with Cooldown ===
if (mouse_check_button_pressed(mb_left) && current_state != GorillaState.SMASH && smash_cooldown <= 0) {
    current_state = GorillaState.SMASH;
    image_index = 0; // Start animation from the beginning
}

// === Logic for i-frames ===
if (invincible) {
    invincibility_timer--;
    if (invincibility_timer <= 0) {
        invincible = false;
        image_alpha = 1; // Ensure visible after invincibility ends
    } else {
        // Flashing effect: toggle alpha every 3 frames
        if ((invincibility_timer mod 6) < 3) {
            image_alpha = 0;
        } else {
            image_alpha = 1;
        }
    }
} else {
    image_alpha = 1; // Make sure alpha is reset when not invincible
}

// === State Machine ===
switch (current_state) {
    case GorillaState.IDLE:
        if (xspd != 0 || yspd != 0) {
            current_state = GorillaState.MOVING;
        }
        sprite_index = SPR_Gorilla_Idle;
        image_speed = 1;
        image_xscale = (facing == "right") ? 1 : -1;
        break;

    case GorillaState.MOVING:
        if (xspd == 0 && yspd == 0) {
            current_state = GorillaState.IDLE;
        }

        if (xspd > 0) {
            facing = "right";
            sprite_index = SPR_Gorilla_Right;
            image_xscale = 1;
        } else if (xspd < 0) {
            facing = "left";
            sprite_index = SPR_Gorilla_Right;
            image_xscale = -1;
        } else if (yspd != 0) {
            sprite_index = SPR_Gorilla_Right;
            image_xscale = (facing == "right") ? 1 : -1;
        }

        image_speed = 1;

        // === Footstep Sound Logic ===
        footstep_timer -= 1;
        if (footstep_timer <= 0) {
			var step_sound = choose(SND_Footstep1, SND_Footstep2, SND_Footstep3);
			var snd_step_inst = audio_play_sound(step_sound, 1, false);
			if (snd_step_inst != -1) {
			    audio_sound_pitch(snd_step_inst, random_range(0.95, 1.05));
			}
			audio_sound_gain(snd_step_inst, 0.15, 0);
            footstep_timer = footstep_interval; // Reset timer
        }
        break;

	case GorillaState.SMASH:
	    sprite_index = SPR_Gorilla_Smash;
	    image_speed = 1.1;
	    image_xscale = (facing == "right") ? 1 : -1;

	    // Stop animation at the last frame, then switch state
	    if (image_index >= image_number - 1) {
	        image_speed = 0; // Freeze at last frame to avoid looping
			
			var smash_sound = choose(SND_Smash, SND_Smash2, SND_Smash3);
			var snd_inst = audio_play_sound(smash_sound, 1, false);
			audio_sound_gain(snd_inst, 0.6, 0);
			audio_sound_pitch(snd_inst, random_range(0.95, 1.05)); // slight pitch variation

	        // === Spawn smash effect at correct position ===
	        var fx_x = x + (facing == "right" ? 16 : -16);
	        var fx_y = y;
	        instance_create_layer(fx_x, fx_y, "Effects", OBJ_FX_Smash);
			instance_create_layer(fx_x, fx_y, "Effects", OBJ_FX_Smash2);
			
			for (var i = 0; i < 8; i++) {
			var debris = instance_create_layer(fx_x, fx_y, "Effects", OBJ_SmashDebris);
}
			
			// === Spawn smash hitbox at correct position ===
			var hitbox_x = x + (facing == "right" ? 16 : -16);
			var hitbox_y = y;
			instance_create_layer(hitbox_x, hitbox_y, "Hitboxes", OBJ_Gorilla_Hitbox_Smash);

	        // === Trigger camera shake ===
	        with (OBJ_CameraController) {
	            shake_timer = 12;
	            shake_magnitude = 5;
	        }
			
			smash_cooldown = 20;

	        current_state = GorillaState.IDLE;
	        image_index = 0;
	    }

	    // Disable movement
	    xspd = 0;
	    yspd = 0;
	    break;
}
// === Wall Collisions & Apply Movement ===
var tilemap = layer_tilemap_get_id("WallLayer");
// === Dash Logic ===
if (global.has_dash) {
    if (dash_cooldown > 0) dash_cooldown--;

    if (dash_timer > 0) {
        dash_timer--;

        if (!dash_sound_played) {
            var pitch = random_range(0.9, 1.1);
            var snd_inst = audio_play_sound(SND_Dash, 0.5, false);
            audio_sound_pitch(snd_inst, pitch);
            dash_sound_played = true;
        }
        invincible = true;

        // Use current movement direction for dash
        var dash_dir_x = xdir;
        var dash_dir_y = ydir;

        // If no input direction, fallback to facing direction (left/right)
        if (dash_dir_x == 0 && dash_dir_y == 0) {
            dash_dir_x = (facing == "right") ? 1 : -1;
            dash_dir_y = 0;
        }

        // Normalize dash direction just in case
        var dash_length = point_distance(0, 0, dash_dir_x, dash_dir_y);
        if (dash_length > 0) {
            dash_dir_x /= dash_length;
            dash_dir_y /= dash_length;
        }

        // Calculate proposed new position
        var new_x = x + dash_dir_x * dash_speed;
        var new_y = y + dash_dir_y * dash_speed;

        // Check collisions separately and move accordingly
        if (!place_meeting(new_x, y, tilemap)) {
            x = new_x;
        }
        if (!place_meeting(x, new_y, tilemap)) {
            y = new_y;
        }

        // Create dash trail effect
        var trail = instance_create_layer(x, y, "Effects", OBJ_DashTrail);
        trail.image_xscale = image_xscale;
        trail.image_yscale = image_yscale;
        trail.image_index = image_index;
        trail.image_speed = 0;

        if (dash_timer <= 0) {
            invincible = false;
            invincibility_timer = 0;
            dash_cooldown = 480; // 8 seconds cooldown
        }
    } else if (keyboard_check_pressed(vk_space) && dash_cooldown <= 0 && current_state != GorillaState.SMASH) {
        dash_timer = dash_duration;
        dash_sound_played = false; // reset sound flag
    }
}
// UI Logic
if (global.has_dash && !first_dash_used) {
    show_dash_prompt = true;
}

// Hide prompt after first dash
if (dash_timer > 0 || dash_cooldown > 0) {
    first_dash_used = true;
    show_dash_prompt = false;
}



if (current_state != GorillaState.SMASH) {
    // check horizontal movement
    if (tilemap_get_at_pixel(tilemap, x + xspd, y) != 0) {
        xspd = 0;
    }
    // check vertical movement
    if (tilemap_get_at_pixel(tilemap, x, y + yspd) != 0) {
        yspd = 0;
    }
    
    x += xspd;
    y += yspd;
}

// === Gorilla Damage Function ===
function gorilla_take_damage(amount, source_x, source_y) {
    // === Prevent damage while dashing ===
    if (dash_timer > 0) {
        return;
    }
	
	if (!global.finalboss_alive) {
		return;
	}

    hp -= amount;

    if (hp <= 0) {
        // Play death animation, effects, etc.
        // death logic here
    } else {
        var knockback_strength = 6;

        var dx = x - source_x;
        var dy = y - source_y;
        var dist = point_distance(0, 0, dx, dy);
        if (dist > 0) {
            dx /= dist;
            dy /= dist;
        }

        // Apply knockback gradually over time
        knockback_x = dx * knockback_strength;
        knockback_y = dy * knockback_strength;
        knockback_timer = 6;

        invincible = true;
        invincibility_timer = 90;

        // === Trigger camera shake ===
        with (OBJ_CameraController) {
            shake_timer = 10;
            shake_magnitude = 4;

            flash_timer = 30;
            flash_color = c_red;
        }

        // === Play grunt sound with random pitch and volume ===
        var snd_grunt_inst = audio_play_sound(SND_Grunt, 1, false);
        audio_sound_pitch(snd_grunt_inst, random_range(0.95, 1.05));
        audio_sound_gain(snd_grunt_inst, 0.7, 0);
    }
	if (hp <= 0) {
	    if (!global.game_over) {
	        global.game_over = true;

	        var random_index = irandom_range(1, 4);
	        global.chosen_game_over_sprite = choose(
	            SPR_YouDied1,
	            SPR_YouDied2,
	            SPR_YouDied3,
	            SPR_YouDied4,
				SPR_YouDied5
	        );

	        global.game_over_alpha = 0;

	        with (OBJ_GameOverController) {
	            visible = true;
	        }
	    }

	    instance_create_layer(x, y, "Effects", OBJ_Blood_1); 
	    instance_destroy();
	}
}

// == FLOATING ROCK ATTACK ==
switch(float_current_state){
	case floatState.IDLE:
		if (global.float_level > 0) {float_current_state = floatState.COOLDOWN}
		break
		
	case floatState.COOLDOWN:
		if (floatRockCooldown > 0) {
			floatRockCooldown -= 1
		}
		else {
			float_current_state = floatState.ORBITTING
			if (global.float_level == 1) {
				floatRockTimer = 300 //edit this to change how long the rocks stay out for
				spawnFloatRock()
				}
			else if (global.float_level == 2) {
				floatRockTimer = 500
				spawnFloatRock(5)
				}
			else {float_current_state = floatState.CONSTANT}
		}
		break
		
	case floatState.ORBITTING:
		if (floatRockTimer > 0) {
			floatRockTimer -= 1
		}
		else  {
			float_current_state = floatState.COOLDOWN
			floatRockCooldown = 420 //edit this to increase cooldown
			
			
			//destroy the rocks
			for (var i = 0; i < array_length(global.floatRocks); i++){
				if (instance_exists(global.floatRocks[i])) {
					with (global.floatRocks[i]) {instance_destroy()
					}
				}
			}
			global.floatRocks = []
			
		}
		break
		
	case floatState.CONSTANT:
		spawnFloatRock(6)
		float_current_state = floatState.DEAD
		break
		
	case floatState.DEAD:
		break
}

